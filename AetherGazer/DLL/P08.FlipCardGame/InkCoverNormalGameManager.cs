using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class InkCoverNormalGameManager : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	private InkNormalStep step;

	private float operateTimer;

	private bool isCompleted;

	private Texture2D maskTexture;

	private float erasedArea;

	private float totalArea;

	private bool isDraging;

	[Header("笔刷相关参数")]
	public int brushSize = 50;

	[Range(0.1f, 1f)]
	public float brushHardness = 0.8f;

	[Header("平滑参数")]
	[Tooltip("点间距系数（建议0.3-0.5）")]
	public float spacingFactor = 0.4f;

	public Transform brushTrs;

	public Animator brushAni;

	public GameObject startAniGo;

	private const int MIN_SEGMENTS = 5;

	private List<Vector2> erasePositions = new List<Vector2>();

	private const int SMOOTH_SAMPLES = 5;

	private bool isStartEraser;

	private Vector2 lastPos;

	private Vector2 penultPos;

	private bool twoPoints;

	private float smoothDistance = 1f;

	private bool isEndEraser;

	private Camera uiCamera;

	private Texture2D tex;

	public void Initialize()
	{
		step = GetComponent<InkNormalStep>();
		InitializeMaskTexture();
		PlayEnterAnimation();
		startAniGo.SetActive(value: false);
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
	}

	private void InitializeMaskTexture()
	{
		if (step.inkImage.mainTexture == null)
		{
			Debug.LogError("InkImage main texture is not assigned");
			return;
		}
		tex = (Texture2D)step.inkImage.mainTexture;
		maskTexture = new Texture2D(tex.width, tex.height, TextureFormat.ARGB32, mipChain: false);
		Color[] pixels = tex.GetPixels();
		maskTexture.SetPixels(pixels);
		maskTexture.Apply();
		totalArea = maskTexture.width * maskTexture.height;
		step.inkImage.texture = maskTexture;
		isEndEraser = false;
		isStartEraser = false;
	}

	private void PlayEnterAnimation()
	{
		step.inkImage.transform.localScale = Vector3.zero;
		LeanTween.scale(step.inkImage.gameObject, Vector3.one, 0.5f).setEase(LeanTweenType.easeOutBack);
	}

	public void Update()
	{
		if (step != null)
		{
			operateTimer += Time.deltaTime;
			if (operateTimer >= step.guideTime && !isCompleted)
			{
				ShowGuide();
				operateTimer = 0f;
			}
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (step != null)
		{
			isDraging = true;
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isDraging = false;
		brushTrs.localPosition = new Vector2(708f, 82f);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!isCompleted)
		{
			if (IsPointerInInkImage(eventData.position))
			{
				brushAni.Play("brush");
			}
			erasePositions.Clear();
			isDraging = true;
			penultPos = eventData.position;
			EraseArea(penultPos);
			erasePositions.Add(penultPos);
		}
	}

	private bool IsPointerInInkImage(Vector2 screenPos)
	{
		return RectTransformUtility.RectangleContainsScreenPoint(step.inkImage.rectTransform, screenPos, uiCamera);
	}

	public void OnDrag(PointerEventData data)
	{
		if (!IsPointerInInkImage(data.position))
		{
			brushAni.Play("default");
			AudioManager.Instance.Stop("effect");
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_brush_action_pause", useStream: true);
		}
		else
		{
			brushAni.Play("brush");
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_brush", useStream: true);
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(brushTrs.parent as RectTransform, Input.mousePosition, uiCamera, out var localPoint);
		brushTrs.localPosition = new Vector2(localPoint.x, localPoint.y + 100f);
		isDraging = true;
		operateTimer = 0f;
		HideGuide();
		erasePositions.Add(data.position);
		if (erasePositions.Count > 5)
		{
			erasePositions.RemoveAt(0);
		}
		Vector2 zero = Vector2.zero;
		foreach (Vector2 erasePosition in erasePositions)
		{
			zero += erasePosition;
		}
		zero /= (float)erasePositions.Count;
		if (twoPoints && Vector2.Distance(zero, lastPos) > smoothDistance)
		{
			Vector2 vector = zero;
			float num = Vector2.Distance(lastPos, vector);
			int segments = Mathf.Max(5, Mathf.CeilToInt(num / ((float)brushSize * spacingFactor)));
			Vector2[] interpolatedPoints = GetInterpolatedPoints(lastPos, vector, segments);
			_ = lastPos;
			Vector2[] array = interpolatedPoints;
			foreach (Vector2 position in array)
			{
				EraseArea(position);
			}
			lastPos = vector;
			Vector2 vector2;
			if (interpolatedPoints.Length <= 1)
			{
				vector2 = vector;
			}
			else
			{
				vector2 = interpolatedPoints[interpolatedPoints.Length - 2];
			}
			penultPos = vector2;
		}
		else
		{
			twoPoints = true;
			lastPos = zero;
			EraseArea(zero);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		brushAni.Play("default");
		brushTrs.localPosition = new Vector2(708f, 82f);
		isDraging = false;
		twoPoints = false;
		erasePositions.Clear();
	}

	private Vector2[] GetInterpolatedPoints(Vector2 from, Vector2 to, int segments)
	{
		List<Vector2> list = new List<Vector2>();
		float num = 1f / (float)segments;
		if (Vector2.Distance(penultPos, from) < (float)(brushSize * 2))
		{
			list.Add(penultPos);
		}
		list.Add(from);
		for (int i = 1; i <= segments; i++)
		{
			float t = num * (float)i;
			Vector2 vector = Vector2.Lerp(from, to, t);
			if (i > 1)
			{
				if (Vector2.Distance(vector, list[list.Count - 1]) > (float)brushSize * 0.8f)
				{
					list.Add(Vector2.Lerp(list[list.Count - 1], vector, 0.5f));
				}
			}
			list.Add(vector);
		}
		return list.ToArray();
	}

	private void EraseArea(Vector2 position)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(step.inkImage.rectTransform, position, CanvasManager.Instance.uiCamera, out var localPoint);
		Rect rect = step.inkImage.rectTransform.rect;
		float num = (localPoint.x + rect.width * 0.5f) / rect.width * (float)maskTexture.width;
		float num2 = (localPoint.y + rect.height * 0.5f) / rect.height * (float)maskTexture.height;
		float num3 = 0f;
		for (int i = -brushSize; i <= brushSize; i++)
		{
			for (int j = -brushSize; j <= brushSize; j++)
			{
				float num4 = Mathf.Sqrt(j * j + i * i);
				if (num4 > (float)brushSize)
				{
					continue;
				}
				int num5 = (int)num + j;
				int num6 = (int)num2 + i;
				if (num5 < 0 || num5 >= maskTexture.width || num6 < 0 || num6 >= maskTexture.height)
				{
					continue;
				}
				Color pixel = maskTexture.GetPixel(num5, num6);
				if (pixel.a > 0f)
				{
					float t = 1f - Mathf.Pow(num4 / (float)brushSize, brushHardness);
					float a = pixel.a;
					pixel.a = Mathf.Lerp(pixel.a, 0f, t);
					num3 += a - pixel.a;
					maskTexture.SetPixel(num5, num6, pixel);
					if (!isStartEraser)
					{
						isStartEraser = true;
					}
				}
			}
		}
		erasedArea += num3;
		maskTexture.Apply();
		if (erasedArea / totalArea >= step.requiredEraseRatio && !isCompleted)
		{
			isCompleted = true;
			isEndEraser = true;
			CompleteStep();
		}
	}

	private void CompleteStep()
	{
		CookingGameManager.Instance.UpdateProgress(step.GetProgress());
		CookingGameManager.Instance.AddStepSuccess(step.config.stepID);
		brushTrs.localPosition = new Vector2(708f, 82f);
		LeanTween.alpha(step.inkImage.rectTransform, 0f, 0.8f).setOnComplete((Action)delegate
		{
			float animClipLength = GetAnimClipLength("inkImg_exit");
			CookingGameManager.Instance.PlayStepPanelFinishAni();
			startAniGo.SetActive(value: true);
			LeanTween.delayedCall(base.gameObject, animClipLength + step.imgKeepTime, (Action)delegate
			{
				step.StepFinish();
			});
		});
	}

	private float GetAnimClipLength(string clipName)
	{
		Animator component = step.inkImage.GetComponent<Animator>();
		if (component != null && component.runtimeAnimatorController != null)
		{
			component.Play(clipName, 0, 0f);
			AnimationClip[] animationClips = component.runtimeAnimatorController.animationClips;
			foreach (AnimationClip animationClip in animationClips)
			{
				if (animationClip.name == clipName)
				{
					return animationClip.length;
				}
			}
		}
		return 0f;
	}

	private void ShowGuide()
	{
		step.guideHand.SetActive(value: true);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: true, step.guideText);
		}
	}

	private void HideGuide()
	{
		step.guideHand.SetActive(value: false);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: false, "");
		}
	}

	public bool IsCompleted()
	{
		return isCompleted;
	}

	public float GetCurrentProgress()
	{
		return erasedArea / totalArea;
	}
}
