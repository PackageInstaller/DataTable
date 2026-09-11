using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class InkCoverPureGameManager : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	private float operateTimer;

	private bool isCompleted;

	private bool isDraging;

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

	[Header("游戏参数")]
	public float requiredEraseRatio = 0.7f;

	private RenderTexture inkRenderTex;

	[Header("图片资源")]
	public RawImage inkImage;

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

	public Action OnBeginDragFun;

	public Action OnDragFun;

	public Action OnEndDragFun;

	public Action OnCompletedFun;

	public Action<bool> OnValueChangedFun;

	private bool isInit;

	private void Start()
	{
		InitializeMaskTexture();
	}

	private void InitializeMaskTexture()
	{
		originalTex = (Texture2D)inkImage.mainTexture;
		inkRenderTex = new RenderTexture(originalTex.width, originalTex.height, 0, RenderTextureFormat.ARGB32);
		brushTexture = GenerateFeatheredBrush(brushSize, brushHardness);
		eraseMat = new Material(eraseShader);
		eraseMat.SetTexture("_BrushTex", brushTexture);
		eraseMat.SetColor("_Color", Color.black);
		inkImage.texture = inkRenderTex;
		isInit = true;
		Reset();
	}

	public void Reset()
	{
		if (isInit)
		{
			Graphics.Blit(originalTex, inkRenderTex);
			totalArea = inkRenderTex.width * inkRenderTex.height;
			readbackTex = new Texture2D(inkRenderTex.width, inkRenderTex.height, TextureFormat.ARGB32, mipChain: false);
			StartCoroutine(CalcInitialTransparentArea());
			erasedArea = 0f;
			isEndEraser = false;
			isFirstPoint = true;
			isCompleted = false;
		}
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
		if (!(erasedArea >= totalArea))
		{
			isFirstPoint = true;
			EraseGPU(eventData.position);
			isDraging = true;
			OnBeginDragFun?.Invoke();
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		isDraging = false;
		OnEndDragFun?.Invoke();
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!(erasedArea >= totalArea))
		{
			operateTimer = 0f;
			EraseGPU(eventData.position);
			OnDragFun?.Invoke();
			if (isCompleted)
			{
				ExecuteEvents.Execute(base.gameObject, eventData, ExecuteEvents.pointerUpHandler);
			}
		}
	}

	private void EraseGPU(Vector2 screenPos)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(inkImage.rectTransform, screenPos, CanvasManager.Instance.uiCamera, out var localPoint);
		Rect rect = inkImage.rectTransform.rect;
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
		if (erasedArea < totalArea)
		{
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
		float num2 = (float)num - initialTransparentPixels;
		bool obj = num2 != erasedArea;
		erasedArea = num2;
		OnValueChangedFun?.Invoke(obj);
		if (erasedArea / totalArea >= requiredEraseRatio && !isCompleted)
		{
			isCompleted = true;
			isEndEraser = true;
			OnCompletedFun?.Invoke();
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
				float a = 0f;
				if (num5 < num2)
				{
					a = 1f;
				}
				texture2D.SetPixel(j, i, new Color(1f, 1f, 1f, a));
			}
		}
		texture2D.Apply();
		return texture2D;
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
