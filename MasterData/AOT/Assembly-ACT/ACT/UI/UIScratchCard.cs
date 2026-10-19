using System;
using System.Collections;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(RectTransform))]
public class UIScratchCard : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	private const string RuntimeVisualName = "UIScratchCardVisual";

	[SerializeField]
	private Image coverImage;

	private float brushDiameter = 72f;

	private float brushHardness = 1f;

	private float goldLightAreaPercent = 0.35f;

	private float forceEndAreaPercent = 0.65f;

	[SerializeField]
	private int maskWidth = 512;

	[SerializeField]
	private int maskHeight = 256;

	[SerializeField]
	private float autoRevealDuration = 0.45f;

	[SerializeField]
	[Range(0.1f, 0.8f)]
	private float brushStepRatio = 0.35f;

	private RectTransform _rectTransform;

	private Texture2D _maskTexture;

	private Sprite _maskSprite;

	private Color32[] _maskPixels;

	private Mask _uiMask;

	private Image _visualImage;

	private Sprite _originSprite;

	private Color _originColor;

	private Image.Type _originType;

	private bool _originPreserveAspect;

	private bool _originRaycastTarget;

	private bool _originImageCached;

	private bool _maskComponentAdded;

	private bool _dragging;

	private bool _hasLastStamp;

	private Vector2 _lastStampLocal;

	private Vector2 _gamepadScratchLocal;

	private bool _gamepadScratchInitialized;

	private bool _gamepadScratchActive;

	private bool _goldTriggered;

	private bool _forceEndTriggered;

	private bool _forceEnding;

	private bool _completed;

	private int _scratchedPixelCount;

	private int _totalPixelCount;

	private Coroutine _autoRevealCoroutine;

	private bool _initialized;

	public float BrushDiameter
	{
		get
		{
			return brushDiameter;
		}
		set
		{
			brushDiameter = Mathf.Max(1f, value);
		}
	}

	public float GoldLightAreaPercent
	{
		get
		{
			return goldLightAreaPercent;
		}
		set
		{
			goldLightAreaPercent = Mathf.Clamp01(value);
		}
	}

	public float ForceEndAreaPercent
	{
		get
		{
			return forceEndAreaPercent;
		}
		set
		{
			forceEndAreaPercent = Mathf.Clamp01(value);
		}
	}

	public float RevealedPercent { get; private set; }

	public bool Interactable { get; set; } = true;

	public bool EnableGoldLight { get; set; }

	public float BrushHardness
	{
		get
		{
			return brushHardness;
		}
		set
		{
			brushHardness = Mathf.Clamp(value, 0.1f, 1f);
		}
	}

	public event Action<float> RevealedPercentChanged;

	public event Action GoldLightTriggered;

	public event Action ForceEndCompleted;

	private void Awake()
	{
		EnsureInitialized();
	}

	private void OnDestroy()
	{
		ReleaseRuntimeResources(restoreMaterial: true);
	}

	private void OnDisable()
	{
		StopAutoRevealCoroutine();
		_dragging = false;
		_hasLastStamp = false;
		_gamepadScratchInitialized = false;
		_gamepadScratchActive = false;
	}

	public void Setup(Image targetImage)
	{
		coverImage = targetImage;
		EnsureInitialized();
		ResetScratch();
	}

	public void ResetScratch()
	{
		EnsureInitialized();
		StopAutoRevealCoroutine();
		_dragging = false;
		_hasLastStamp = false;
		_goldTriggered = false;
		_forceEndTriggered = false;
		_forceEnding = false;
		_completed = false;
		Interactable = true;
		RevealedPercent = 0f;
		if (_maskPixels != null)
		{
			FillMaskCovered(apply: true);
		}
		ResetGamepadScratchCursorToCenter();
		RevealedPercentChanged?.Invoke(RevealedPercent);
	}

	public void RevealAllImmediate()
	{
		EnsureInitialized();
		StopAutoRevealCoroutine();
		ClearAllMaskPixels();
		_completed = true;
		_forceEnding = false;
		Interactable = false;
		SetRevealedPercent(1f);
	}

	public void RevealAllAnimated(Action onCompleted = null)
	{
		EnsureInitialized();
		if (_completed)
		{
			onCompleted?.Invoke();
			return;
		}
		RevealAllImmediate();
		onCompleted?.Invoke();
	}

	public void RevealByPercent(float percentDelta)
	{
		if (!CanScratch())
		{
			return;
		}
		EnsureInitialized();
		percentDelta = Mathf.Clamp01(percentDelta);
		if (!(percentDelta <= 0f))
		{
			float num = Mathf.Clamp01(RevealedPercent + percentDelta);
			int num2 = 64;
			while (RevealedPercent < num - 0.001f && num2-- > 0)
			{
				float x = UnityEngine.Random.Range(-0.5f, 0.5f) * _rectTransform.rect.width;
				float y = UnityEngine.Random.Range(-0.5f, 0.5f) * _rectTransform.rect.height;
				StampBrush(new Vector2(x, y), interpolateFromLast: false);
			}
			EvaluateThresholds();
		}
	}

	public void ResetGamepadScratchCursorToCenter()
	{
		EnsureInitialized();
		if (!(_rectTransform == null))
		{
			_gamepadScratchLocal = _rectTransform.rect.center;
			_gamepadScratchInitialized = true;
			_gamepadScratchActive = false;
			_hasLastStamp = false;
		}
	}

	public void ScratchByGamepad(Vector2 stickInput, float moveSpeed, float deadZone)
	{
		if (!CanScratch())
		{
			return;
		}
		EnsureInitialized();
		if (_rectTransform == null)
		{
			return;
		}
		if (!_gamepadScratchInitialized)
		{
			ResetGamepadScratchCursorToCenter();
		}
		deadZone = Mathf.Clamp01(deadZone);
		float magnitude = stickInput.magnitude;
		if (magnitude <= deadZone)
		{
			return;
		}
		float num = (magnitude - deadZone) / Mathf.Max(0.001f, 1f - deadZone);
		Vector2 vector = stickInput / magnitude * num * Mathf.Max(0f, moveSpeed) * Time.unscaledDeltaTime;
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return;
		}
		Rect rect = _rectTransform.rect;
		Vector2 vector2 = _gamepadScratchLocal + vector;
		vector2.x = Mathf.Clamp(vector2.x, rect.xMin, rect.xMax);
		vector2.y = Mathf.Clamp(vector2.y, rect.yMin, rect.yMax);
		if (!((vector2 - _gamepadScratchLocal).sqrMagnitude <= 0.0001f))
		{
			if (!_gamepadScratchActive)
			{
				_lastStampLocal = _gamepadScratchLocal;
				_hasLastStamp = true;
				_gamepadScratchActive = true;
			}
			_gamepadScratchLocal = vector2;
			StampBrush(_gamepadScratchLocal, interpolateFromLast: true);
			EvaluateThresholds();
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (CanScratch() && eventData != null)
		{
			EnsureInitialized();
			if (TryGetLocalPoint(eventData, out var localPoint))
			{
				_dragging = true;
				_gamepadScratchActive = false;
				_hasLastStamp = false;
				StampBrush(localPoint, interpolateFromLast: true);
				EvaluateThresholds();
			}
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_dragging && CanScratch() && eventData != null && TryGetLocalPoint(eventData, out var localPoint))
		{
			StampBrush(localPoint, interpolateFromLast: true);
			EvaluateThresholds();
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (CanScratch() && eventData != null && TryGetLocalPoint(eventData, out var localPoint))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/IchibanKuji/Card_Scratch");
			_dragging = true;
			_gamepadScratchActive = false;
			_hasLastStamp = false;
			StampBrush(localPoint, interpolateFromLast: true);
			EvaluateThresholds();
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		_dragging = false;
		_hasLastStamp = false;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_dragging = false;
		_hasLastStamp = false;
	}

	private void EnsureInitialized()
	{
		if (_initialized && _maskTexture != null && _maskSprite != null && _visualImage != null)
		{
			return;
		}
		_rectTransform = transform as RectTransform;
		if (coverImage == null)
		{
			coverImage = GetComponent<Image>();
		}
		if (!(coverImage == null) && !(_rectTransform == null))
		{
			if (!_originImageCached)
			{
				_originSprite = coverImage.sprite;
				_originColor = coverImage.color;
				_originType = coverImage.type;
				_originPreserveAspect = coverImage.preserveAspect;
				_originRaycastTarget = coverImage.raycastTarget;
				_originImageCached = true;
			}
			CreateMaskTextureIfNeeded();
			CreateMaskHierarchyIfNeeded();
			_initialized = _maskTexture != null && _maskSprite != null && _visualImage != null;
		}
	}

	private void CreateMaskTextureIfNeeded()
	{
		int num = Mathf.Max(16, maskWidth);
		int num2 = Mathf.Max(16, maskHeight);
		if (_maskTexture != null && (_maskTexture.width != num || _maskTexture.height != num2))
		{
			DestroySprite(ref _maskSprite);
			DestroyTexture(ref _maskTexture);
			_maskPixels = null;
		}
		if (_maskTexture == null)
		{
			_maskTexture = new Texture2D(num, num2, TextureFormat.RGBA32, mipChain: false)
			{
				name = "UIScratchCardMask",
				filterMode = FilterMode.Point,
				wrapMode = TextureWrapMode.Clamp
			};
			_maskSprite = Sprite.Create(_maskTexture, new Rect(0f, 0f, num, num2), new Vector2(0.5f, 0.5f), 100f, 0u, SpriteMeshType.FullRect);
			_maskSprite.name = "UIScratchCardMaskSprite";
			_maskPixels = new Color32[num * num2];
			_totalPixelCount = _maskPixels.Length;
			FillMaskCovered(apply: true);
		}
		else if (_maskPixels == null || _maskPixels.Length != num * num2)
		{
			_maskPixels = new Color32[num * num2];
			_totalPixelCount = _maskPixels.Length;
			FillMaskCovered(apply: true);
		}
	}

	private void CreateMaskHierarchyIfNeeded()
	{
		if (_uiMask == null)
		{
			_uiMask = GetComponent<Mask>();
			if (_uiMask == null)
			{
				_uiMask = base.gameObject.AddComponent<Mask>();
				_maskComponentAdded = true;
			}
		}
		_uiMask.showMaskGraphic = false;
		coverImage.material = null;
		coverImage.sprite = _maskSprite;
		coverImage.type = Image.Type.Simple;
		coverImage.preserveAspect = false;
		coverImage.color = Color.white;
		coverImage.raycastTarget = _originRaycastTarget;
		if (_visualImage == null)
		{
			Transform transform = base.transform.Find("UIScratchCardVisual");
			if (transform != null)
			{
				_visualImage = transform.GetComponent<Image>();
			}
			if (_visualImage == null)
			{
				GameObject gameObject = new GameObject("UIScratchCardVisual", typeof(RectTransform), typeof(CanvasRenderer), typeof(Image));
				gameObject.transform.SetParent(base.transform, worldPositionStays: false);
				_visualImage = gameObject.GetComponent<Image>();
			}
		}
		RectTransform rectTransform = _visualImage.rectTransform;
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.anchoredPosition = Vector2.zero;
		rectTransform.sizeDelta = Vector2.zero;
		rectTransform.localScale = Vector3.one;
		_visualImage.material = null;
		_visualImage.sprite = _originSprite;
		_visualImage.color = _originColor;
		_visualImage.type = _originType;
		_visualImage.preserveAspect = _originPreserveAspect;
		_visualImage.raycastTarget = false;
		_visualImage.maskable = true;
	}

	private void FillMaskCovered(bool apply)
	{
		if (_maskPixels != null)
		{
			Color32 color = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			for (int i = 0; i < _maskPixels.Length; i++)
			{
				_maskPixels[i] = color;
			}
			_scratchedPixelCount = 0;
			if (apply)
			{
				ApplyMaskPixels();
			}
		}
	}

	private bool CanScratch()
	{
		if (Interactable && !_completed && !_forceEnding)
		{
			return isActiveAndEnabled;
		}
		return false;
	}

	private bool TryGetLocalPoint(PointerEventData eventData, out Vector2 localPoint)
	{
		Camera pressEventCamera = eventData.pressEventCamera;
		return RectTransformUtility.ScreenPointToLocalPointInRectangle(_rectTransform, eventData.position, pressEventCamera, out localPoint);
	}

	private void StampBrush(Vector2 localPoint, bool interpolateFromLast)
	{
		if (_maskPixels == null || _maskTexture == null)
		{
			return;
		}
		Rect rect = _rectTransform.rect;
		if (rect.width <= 0.01f || rect.height <= 0.01f)
		{
			return;
		}
		if (interpolateFromLast && _hasLastStamp)
		{
			float num = Vector2.Distance(_lastStampLocal, localPoint);
			float num2 = Mathf.Max(1f, brushDiameter * brushStepRatio);
			int num3 = Mathf.Max(1, Mathf.CeilToInt(num / num2));
			for (int i = 1; i <= num3; i++)
			{
				float t = (float)i / (float)num3;
				Vector2 localPoint2 = Vector2.Lerp(_lastStampLocal, localPoint, t);
				StampBrushOnce(localPoint2, rect);
			}
		}
		else
		{
			StampBrushOnce(localPoint, rect);
		}
		_lastStampLocal = localPoint;
		_hasLastStamp = true;
		ApplyMaskPixels();
		RefreshRevealedPercent();
	}

	private void StampBrushOnce(Vector2 localPoint, Rect rect)
	{
		float num = localPoint.x + rect.width * _rectTransform.pivot.x;
		float num2 = localPoint.y + rect.height * _rectTransform.pivot.y;
		float num3 = num / rect.width;
		float num4 = num2 / rect.height;
		if (num3 < -0.2f || num3 > 1.2f || num4 < -0.2f || num4 > 1.2f)
		{
			return;
		}
		int width = _maskTexture.width;
		int height = _maskTexture.height;
		float num5 = num3 * (float)(width - 1);
		float num6 = num4 * (float)(height - 1);
		float num7 = Mathf.Lerp(0.25f, 0.5f, brushHardness);
		float b = brushDiameter * num7 / rect.width * (float)width;
		float b2 = brushDiameter * num7 / rect.height * (float)height;
		b = Mathf.Max(1f, b);
		b2 = Mathf.Max(1f, b2);
		int num8 = Mathf.Clamp(Mathf.FloorToInt(num5 - b), 0, width - 1);
		int num9 = Mathf.Clamp(Mathf.CeilToInt(num5 + b), 0, width - 1);
		int num10 = Mathf.Clamp(Mathf.FloorToInt(num6 - b2), 0, height - 1);
		int num11 = Mathf.Clamp(Mathf.CeilToInt(num6 + b2), 0, height - 1);
		float num12 = 1f / b;
		float num13 = 1f / b2;
		for (int i = num10; i <= num11; i++)
		{
			float num14 = ((float)i - num6) * num13;
			int num15 = i * width;
			for (int j = num8; j <= num9; j++)
			{
				float num16 = ((float)j - num5) * num12;
				if (num16 * num16 + num14 * num14 > 1f)
				{
					continue;
				}
				int num17 = num15 + j;
				Color32 color = _maskPixels[num17];
				byte r = color.r;
				byte b3 = 0;
				if (b3 != r)
				{
					bool flag = r >= 128;
					bool flag2 = b3 < 128;
					if (flag & flag2)
					{
						_scratchedPixelCount++;
					}
					color.r = b3;
					color.g = b3;
					color.b = b3;
					color.a = b3;
					_maskPixels[num17] = color;
				}
			}
		}
	}

	private void ApplyMaskPixels()
	{
		if (!(_maskTexture == null) && _maskPixels != null)
		{
			_maskTexture.SetPixels32(_maskPixels);
			_maskTexture.Apply(updateMipmaps: false, makeNoLongerReadable: false);
		}
	}

	private void ClearAllMaskPixels()
	{
		if (_maskPixels != null)
		{
			Color32 color = new Color32(0, 0, 0, 0);
			for (int i = 0; i < _maskPixels.Length; i++)
			{
				_maskPixels[i] = color;
			}
			_scratchedPixelCount = _totalPixelCount;
			ApplyMaskPixels();
			RefreshRevealedPercent();
		}
	}

	private void RefreshRevealedPercent()
	{
		float revealedPercent = ((_totalPixelCount <= 0) ? 0f : ((float)_scratchedPixelCount / (float)_totalPixelCount));
		SetRevealedPercent(revealedPercent);
	}

	private void SetRevealedPercent(float percent)
	{
		percent = Mathf.Clamp01(percent);
		if (!(Mathf.Abs(percent - RevealedPercent) < 0.0001f))
		{
			RevealedPercent = percent;
			RevealedPercentChanged?.Invoke(RevealedPercent);
		}
	}

	private void EvaluateThresholds()
	{
		if (!_completed && !_forceEnding)
		{
			if (!_goldTriggered && EnableGoldLight && RevealedPercent >= goldLightAreaPercent)
			{
				_goldTriggered = true;
				GoldLightTriggered?.Invoke();
			}
			if (!_forceEndTriggered && RevealedPercent >= forceEndAreaPercent)
			{
				_forceEndTriggered = true;
				Interactable = false;
				_forceEnding = false;
				_completed = true;
				ForceEndCompleted?.Invoke();
			}
		}
	}

	private IEnumerator CoAutoReveal(Action onCompleted)
	{
		float duration = Mathf.Max(0.05f, autoRevealDuration);
		float time = 0f;
		float startPainted = RevealedPercent;
		while (time < duration)
		{
			time += Time.unscaledDeltaTime;
			float num = Mathf.Clamp01(time / duration);
			num = num * num * (3f - 2f * num);
			float num2 = 1f - (1f - startPainted) * (1f - num);
			RevealMaskToPercent(num2);
			if (!_goldTriggered && EnableGoldLight && num2 >= goldLightAreaPercent)
			{
				_goldTriggered = true;
				GoldLightTriggered?.Invoke();
			}
			yield return null;
		}
		ClearAllMaskPixels();
		_completed = true;
		_forceEnding = false;
		Interactable = false;
		SetRevealedPercent(1f);
		_autoRevealCoroutine = null;
		onCompleted?.Invoke();
	}

	private void StopAutoRevealCoroutine()
	{
		if (_autoRevealCoroutine != null)
		{
			StopCoroutine(_autoRevealCoroutine);
			_autoRevealCoroutine = null;
		}
	}

	private void RevealMaskToPercent(float targetPercent)
	{
		if (_maskPixels == null || _totalPixelCount <= 0)
		{
			return;
		}
		int num = Mathf.CeilToInt(Mathf.Clamp01(targetPercent) * (float)_totalPixelCount);
		if (num <= _scratchedPixelCount)
		{
			return;
		}
		for (int i = 0; i < _maskPixels.Length; i++)
		{
			if (_scratchedPixelCount >= num)
			{
				break;
			}
			if (_maskPixels[i].r >= 128)
			{
				_maskPixels[i] = new Color32(0, 0, 0, 0);
				_scratchedPixelCount++;
			}
		}
		ApplyMaskPixels();
		RefreshRevealedPercent();
	}

	private void ReleaseRuntimeResources(bool restoreMaterial)
	{
		StopAutoRevealCoroutine();
		if (restoreMaterial && coverImage != null && _originImageCached)
		{
			coverImage.material = null;
			coverImage.sprite = _originSprite;
			coverImage.color = _originColor;
			coverImage.type = _originType;
			coverImage.preserveAspect = _originPreserveAspect;
			coverImage.raycastTarget = _originRaycastTarget;
		}
		if (_visualImage != null)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(_visualImage.gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(_visualImage.gameObject);
			}
			_visualImage = null;
		}
		if (_maskComponentAdded && _uiMask != null)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(_uiMask);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(_uiMask);
			}
		}
		DestroySprite(ref _maskSprite);
		DestroyTexture(ref _maskTexture);
		_maskPixels = null;
		_initialized = false;
	}

	private static void DestroyTexture(ref Texture2D texture)
	{
		if (!(texture == null))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(texture);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(texture);
			}
			texture = null;
		}
	}

	private static void DestroySprite(ref Sprite sprite)
	{
		if (!(sprite == null))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(sprite);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(sprite);
			}
			sprite = null;
		}
	}
}
