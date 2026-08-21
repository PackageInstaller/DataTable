using System;
using Sirenix.OdinInspector;
using UnityEngine;

public class MapMaskTest : SerializedMonoBehaviour
{
	[SerializeField]
	private float durationDefault = 0.5f;

	[SerializeField]
	private int[,] data = new int[8, 8];

	[SerializeField]
	private Material renderMaterial;

	[SerializeField]
	private string shaderMaskTexName = "";

	[SerializeField]
	private string shaderPropertyName = "_BaseMap";

	[SerializeField]
	private Material maskMaterial;

	[SerializeField]
	private string maskPropertyName = "_BaseMap";

	private Texture2D resultTexture;

	private RenderTexture renderTexture;

	private Color[] colors;

	private Color[] tempColors;

	private float lerpTime = 1f;

	[SerializeField]
	private float lerpElapsed;

	[SerializeField]
	private float lerpDuration;

	private bool initialized;

	[SerializeField]
	private int areaId;

	public void Init()
	{
		int num = data.GetLength(0) * data.GetLength(1);
		resultTexture = new Texture2D(num * 4, 1, TextureFormat.R8, mipChain: false);
		resultTexture.filterMode = FilterMode.Point;
		resultTexture.hideFlags = HideFlags.HideAndDontSave;
		renderTexture = new RenderTexture(128, 128, 0);
		renderTexture.hideFlags = HideFlags.HideAndDontSave;
		colors = new Color[num * 4];
		tempColors = new Color[colors.Length];
		int num2 = 0;
		for (int i = 0; i < data.GetLength(0); i++)
		{
			for (int j = 0; j < data.GetLength(1); j++)
			{
				float r = data[i, j];
				for (int k = 0; k < 4; k++)
				{
					colors[num2] = new Color(r, 0f, 0f, 1f);
					num2++;
				}
			}
		}
		resultTexture.SetPixels(colors);
		resultTexture.Apply();
		renderMaterial.SetTexture(shaderPropertyName, resultTexture);
	}

	private void SetActiveState()
	{
		int num = areaId / data.GetLength(1);
		int num2 = areaId % data.GetLength(0);
		data[num, num2] = 1 - data[num, num2];
		Array.Copy(colors, tempColors, colors.Length);
		lerpElapsed = lerpDuration;
	}

	private void UpdateMaskTexture()
	{
		Graphics.Blit(null, renderTexture, renderMaterial);
		maskMaterial.SetTexture(maskPropertyName, renderTexture);
	}

	private void Update()
	{
		if (lerpElapsed <= 0f)
		{
			return;
		}
		int num = 0;
		if (!initialized)
		{
			for (int i = 0; i < data.GetLength(0); i++)
			{
				for (int j = 0; j < data.GetLength(1); j++)
				{
					for (int k = 0; k < 4; k++)
					{
						if (Math.Abs(colors[num].r - (float)data[i, j]) > 0.001f)
						{
							colors[num].r = data[i, j];
						}
						num++;
					}
				}
			}
			resultTexture.SetPixels(colors);
			resultTexture.Apply();
			UpdateMaskTexture();
			initialized = true;
			lerpElapsed = 0f;
			return;
		}
		lerpElapsed = Mathf.Clamp(lerpElapsed - Time.deltaTime, 0f, lerpDuration);
		lerpTime = 1f - lerpElapsed / lerpDuration;
		for (int l = 0; l < data.GetLength(0); l++)
		{
			for (int m = 0; m < data.GetLength(1); m++)
			{
				for (int n = 0; n < 4; n++)
				{
					if (Math.Abs(colors[num].r - (float)data[l, m]) > 0.001f)
					{
						colors[num].r = Mathf.Lerp(tempColors[num].r, data[l, m], lerpTime);
					}
					num++;
				}
			}
		}
		resultTexture.SetPixels(colors);
		resultTexture.Apply();
		UpdateMaskTexture();
	}

	public void SetMaskData(int[,] newData)
	{
		data = newData;
		Array.Copy(colors, tempColors, colors.Length);
		lerpDuration = durationDefault;
		lerpElapsed = lerpDuration;
	}

	public void SetMaskDataImmediate(int[,] newData)
	{
		data = newData;
		int num = 0;
		for (int i = 0; i < data.GetLength(0); i++)
		{
			for (int j = 0; j < data.GetLength(1); j++)
			{
				for (int k = 0; k < 4; k++)
				{
					if (Math.Abs(colors[num].r - (float)data[i, j]) > 0.001f)
					{
						colors[num].r = data[i, j];
					}
					num++;
				}
			}
		}
		resultTexture.SetPixels(colors);
		resultTexture.Apply();
		UpdateMaskTexture();
		lerpElapsed = 0f;
	}

	public void SetMaskTexture(Texture maskTex)
	{
		renderMaterial.SetTexture(shaderMaskTexName, maskTex);
	}

	public void SetMatTexelSize(Vector4 size)
	{
		maskMaterial.SetVector("_TexelSize", size);
	}

	private void OnDestroy()
	{
		if (maskMaterial != null)
		{
			maskMaterial.SetTexture(maskPropertyName, null);
		}
		if (renderTexture != null)
		{
			renderTexture.Release();
			UnityEngine.Object.Destroy(renderTexture);
			renderTexture = null;
		}
		if (resultTexture != null)
		{
			UnityEngine.Object.Destroy(resultTexture);
			resultTexture = null;
		}
	}
}
