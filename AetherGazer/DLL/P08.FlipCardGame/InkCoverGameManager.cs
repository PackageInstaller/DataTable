using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class InkCoverGameManager : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	private InkCoverStep step;

	private float operateTimer;

	private bool isCompleted;

	private bool isDraging;

	private bool isDuringAnimation;

	[Header("笔刷相关参数")]
	public int brushSize = 80;

	[Range(0.1f, 1f)]
	public float brushHardness = 1f;

	private Texture2D brushTexture;

	public Shader eraseShader;

	[Header("平滑参数")]
	public float spacingFactor = 0.3f;

	private Vector2 prevUV;

	private bool isFirstPoint = true;

	[Header("对话元素")]
	public RectTransform dialogAvatar;

	public RectTransform firstText;

	public RectTransform secondText;

	public RectTransform textBg;

	private RenderTexture inkRenderTex;

	private Texture2D originalTex;

	private Material eraseMat;

	private float erasedArea;

	private float totalArea;

	private float initialTransparentPixels;

	private float readbackInterval = 0.5f;

	private float readbackTimer;

	private bool isEndEraser;

	private Texture2D readbackTex;

	private int checkFrameCounter;

	private const int CHECK_INTERVAL = 30;

	public void Initialize()
	{
		step = GetComponent<InkCoverStep>();
		InitializeMaskTexture();
		StartCoroutine(PlayEnterAnimationSequence());
	}

	private IEnumerator PlayEnterAnimationSequence()
	{
		isDuringAnimation = true;
		dialogAvatar.gameObject.SetActive(value: false);
		firstText.gameObject.SetActive(value: false);
		secondText.gameObject.SetActive(value: false);
		step.inkImage.gameObject.SetActive(value: false);
		textBg.gameObject.SetActive(value: false);
		dialogAvatar.gameObject.SetActive(value: true);
		textBg.gameObject.SetActive(value: true);
		firstText.gameObject.SetActive(value: true);
		dialogAvatar.localScale = Vector3.zero;
		textBg.localScale = Vector3.zero;
		LeanTween.scale(dialogAvatar, Vector3.one, 0.3f).setEase(LeanTweenType.easeOutBack);
		LeanTween.scale(textBg, Vector3.one, 0.3f).setEase(LeanTweenType.easeOutSine);
		yield return new WaitForSeconds(2f);
		firstText.gameObject.SetActive(value: false);
		secondText.gameObject.SetActive(value: true);
		yield return new WaitForSeconds(2f);
		dialogAvatar.gameObject.SetActive(value: false);
		yield return new WaitForSeconds(0.2f);
		step.inkImage.gameObject.SetActive(value: true);
		step.inkImage.transform.localScale = Vector3.zero;
		LeanTween.scale(step.inkImage.gameObject, Vector3.one, 0.5f).setEase(LeanTweenType.easeOutBack);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_ink", useStream: true);
		yield return new WaitForSeconds(0.5f);
		isDuringAnimation = false;
	}

	private void InitializeMaskTexture()
	{
		originalTex = (Texture2D)step.inkImage.mainTexture;
		inkRenderTex = new RenderTexture(originalTex.width, originalTex.height, 0, RenderTextureFormat.ARGB32);
		Graphics.Blit(originalTex, inkRenderTex);
		brushTexture = GenerateFeatheredBrush(brushSize, brushHardness);
		eraseMat = new Material(eraseShader);
		eraseMat.SetTexture("_BrushTex", brushTexture);
		eraseMat.SetColor("_Color", Color.black);
		step.inkImage.texture = inkRenderTex;
		totalArea = inkRenderTex.width * inkRenderTex.height;
		readbackTex = new Texture2D(inkRenderTex.width, inkRenderTex.height, TextureFormat.ARGB32, mipChain: false);
		StartCoroutine(CalcInitialTransparentArea());
		erasedArea = 0f;
		isEndEraser = false;
		isFirstPoint = true;
	}

	private IEnumerator CalcInitialTransparentArea()
	{
		yield return new WaitForEndOfFrame();
		RenderTexture.active = inkRenderTex;
		readbackTex.ReadPixels(new Rect(0f, 0f, inkRenderTex.width, inkRenderTex.height), 0, 0);
		readbackTex.Apply();
		RenderTexture.active = null;
		Color32[] pixels = readbackTex.GetPixels32();
		initialTransparentPixels = 0f;
		Color32[] array = pixels;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].a <= 20)
			{
				initialTransparentPixels++;
			}
		}
		totalArea -= initialTransparentPixels;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!isCompleted && !isDuringAnimation)
		{
			isFirstPoint = true;
			EraseGPU(eventData.position);
			isDraging = true;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_whip", useStream: true);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		isDraging = false;
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_whip_action_pause", useStream: true);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!isCompleted && !isDuringAnimation)
		{
			operateTimer = 0f;
			HideGuide();
			EraseGPU(eventData.position);
		}
	}

	private void EraseGPU(Vector2 screenPos)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(step.inkImage.rectTransform, screenPos, CanvasManager.Instance.uiCamera, out var localPoint);
		Rect rect = step.inkImage.rectTransform.rect;
		float x = (localPoint.x + rect.width * 0.5f) / rect.width;
		float y = (localPoint.y + rect.height * 0.5f) / rect.height;
		if (!isFirstPoint)
		{
			float num = Vector2.Distance(prevUV, new Vector2(x, y));
			float num2 = (float)brushSize / (float)inkRenderTex.width * spacingFactor;
			int num3 = Mathf.Max(1, Mathf.CeilToInt(num / num2));
			for (int i = 0; i <= num3; i++)
			{
				float t = (float)i / (float)num3;
				Vector2 uv = Vector2.Lerp(prevUV, new Vector2(x, y), t);
				DrawBrushAtUV(uv);
			}
		}
		else
		{
			DrawBrushAtUV(new Vector2(x, y));
			isFirstPoint = false;
		}
		if (rect.Contains(localPoint))
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_whip_action_resume", useStream: true);
		}
		else
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_whip_action_pause", useStream: true);
		}
		prevUV = new Vector2(x, y);
	}

	private void DrawBrushAtUV(Vector2 uv)
	{
		RenderTexture.active = inkRenderTex;
		GL.PushMatrix();
		GL.LoadOrtho();
		eraseMat.SetPass(0);
		GL.Begin(7);
		float num = (float)brushSize / (float)inkRenderTex.width;
		GL.TexCoord2(0f, 0f);
		GL.Vertex3(uv.x - num, uv.y - num, 0f);
		GL.TexCoord2(1f, 0f);
		GL.Vertex3(uv.x + num, uv.y - num, 0f);
		GL.TexCoord2(1f, 1f);
		GL.Vertex3(uv.x + num, uv.y + num, 0f);
		GL.TexCoord2(0f, 1f);
		GL.Vertex3(uv.x - num, uv.y + num, 0f);
		GL.End();
		GL.PopMatrix();
		RenderTexture.active = null;
	}

	public void Update()
	{
		if (step != null && !isCompleted && !isDuringAnimation)
		{
			operateTimer += Time.deltaTime;
			if (operateTimer >= step.guideTime)
			{
				ShowGuide();
				operateTimer = 0f;
			}
			checkFrameCounter++;
			if (checkFrameCounter >= 30)
			{
				checkFrameCounter = 0;
				StartCoroutine(CheckEraseProgress());
			}
		}
	}

	private IEnumerator CheckEraseProgress()
	{
		yield return new WaitForEndOfFrame();
		RenderTexture.active = inkRenderTex;
		readbackTex.ReadPixels(new Rect(0f, 0f, inkRenderTex.width, inkRenderTex.height), 0, 0);
		readbackTex.Apply();
		RenderTexture.active = null;
		Color32[] pixels = readbackTex.GetPixels32();
		int num = 0;
		Color32[] array = pixels;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].a <= 20)
			{
				num++;
			}
		}
		erasedArea = (float)num - initialTransparentPixels;
		if (erasedArea / totalArea >= step.requiredEraseRatio && !isCompleted)
		{
			isCompleted = true;
			isEndEraser = true;
			CompleteStep();
		}
	}

	public static Texture2D GenerateFeatheredBrush(int size, float hardness = 0.8f)
	{
		Texture2D texture2D = new Texture2D(size, size, TextureFormat.Alpha8, mipChain: false);
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.filterMode = FilterMode.Bilinear;
		float num = (float)size / 2f;
		float num2 = num;
		for (int i = 0; i < size; i++)
		{
			for (int j = 0; j < size; j++)
			{
				float num3 = (float)j - num + 0.5f;
				float num4 = (float)i - num + 0.5f;
				float num5 = Mathf.Sqrt(num3 * num3 + num4 * num4);
				float a = Mathf.Clamp01(1f - Mathf.Pow(num5 / num2, hardness));
				texture2D.SetPixel(j, i, new Color(1f, 1f, 1f, a));
			}
		}
		texture2D.Apply();
		return texture2D;
	}

	private void CompleteStep()
	{
		CookingGameManager.Instance.AddStepSuccess(step.config.stepID);
		LeanTween.alpha(step.inkImage.rectTransform, 0f, 0.8f).setOnComplete((Action)delegate
		{
			step.OnStepEnd();
		});
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
		CookingGameManager.Instance.ShowGuideText(flag: false, "");
	}

	public bool IsCompleted()
	{
		return isCompleted;
	}

	public float GetCurrentProgress()
	{
		return erasedArea / totalArea;
	}

	public void OnDisable()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_whip_action_stop", useStream: true);
	}
}
