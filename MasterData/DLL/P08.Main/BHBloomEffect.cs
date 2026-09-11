using System;
using UnityEngine;

[ExecuteInEditMode]
public class BHBloomEffect : MonoBehaviour
{
	private static class Uniforms
	{
		internal static readonly int _BHBloom_Threshold = Shader.PropertyToID("_BHBloom_Threshold");

		internal static readonly int _BHBloom_Scaler = Shader.PropertyToID("_BHBloom_Scaler");

		internal static readonly int _BHBloom_Coeff = Shader.PropertyToID("_BHBloom_Coeff");

		internal static readonly int _BHBloom_Exposure = Shader.PropertyToID("_BHBloom_Exposure");

		internal static readonly int _BHBloom_Constrast = Shader.PropertyToID("_BHBloom_Constrast");
	}

	private Material _materialLow;

	private Material _materialHigh;

	public bool highQuality;

	public float threshold = 0.65f;

	public float exposure = 13f;

	public float constrast = 2f;

	protected void PrepareMaterial()
	{
		if (!(null != _materialLow) || !(null != _materialHigh))
		{
			Shader shader = Shader.Find("Post/Low BHBloom");
			Shader shader2 = Shader.Find("Post/High BHBloom");
			if (null == shader || null == shader2)
			{
				throw new ArgumentException("Shader not found (Post/BHBloom)");
			}
			_materialLow = new Material(shader);
			_materialHigh = new Material(shader2);
		}
	}

	protected void DisposeMaterial()
	{
		if (!(null == _materialLow) || !(null == _materialHigh))
		{
			UnityEngine.Object.Destroy(_materialLow);
			UnityEngine.Object.Destroy(_materialHigh);
			_materialLow = null;
			_materialHigh = null;
		}
	}

	private void OnEnable()
	{
		PrepareMaterial();
	}

	private void OnDisable()
	{
		DisposeMaterial();
	}

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		Material material = (highQuality ? _materialHigh : _materialLow);
		if (null == material)
		{
			Graphics.Blit(source, destination);
			return;
		}
		int width = source.width >> 2;
		int height = source.height >> 2;
		RenderTexture temporary = RenderTexture.GetTemporary(width, height, 0, source.format);
		RenderTexture temporary2;
		RenderTexture temporary3;
		RenderTexture temporary4;
		RenderTexture temporary5;
		RenderTexture temporary6;
		RenderTexture temporary7;
		RenderTexture temporary8;
		RenderTexture temporary9;
		RenderTexture temporary10;
		if (highQuality)
		{
			temporary2 = RenderTexture.GetTemporary(256, 256, 0, source.format);
			temporary3 = RenderTexture.GetTemporary(128, 128, 0, source.format);
			temporary4 = RenderTexture.GetTemporary(64, 64, 0, source.format);
			temporary5 = RenderTexture.GetTemporary(32, 32, 0, source.format);
			temporary6 = RenderTexture.GetTemporary(256, 256, 0, source.format);
			temporary7 = RenderTexture.GetTemporary(128, 128, 0, source.format);
			temporary8 = RenderTexture.GetTemporary(64, 64, 0, source.format);
			temporary9 = RenderTexture.GetTemporary(32, 32, 0, source.format);
			temporary10 = RenderTexture.GetTemporary(256, 256, 0, source.format);
		}
		else
		{
			temporary2 = RenderTexture.GetTemporary(128, 128, 0, source.format);
			temporary3 = RenderTexture.GetTemporary(64, 64, 0, source.format);
			temporary4 = RenderTexture.GetTemporary(32, 32, 0, source.format);
			temporary5 = RenderTexture.GetTemporary(16, 16, 0, source.format);
			temporary6 = RenderTexture.GetTemporary(128, 128, 0, source.format);
			temporary7 = RenderTexture.GetTemporary(64, 64, 0, source.format);
			temporary8 = RenderTexture.GetTemporary(32, 32, 0, source.format);
			temporary9 = RenderTexture.GetTemporary(16, 16, 0, source.format);
			temporary10 = RenderTexture.GetTemporary(128, 128, 0, source.format);
		}
		RenderTexture renderTexture = temporary2;
		RenderTexture renderTexture2 = temporary3;
		RenderTexture renderTexture3 = temporary4;
		FilterMode filterMode = (temporary5.filterMode = FilterMode.Bilinear);
		FilterMode filterMode3 = (renderTexture3.filterMode = filterMode);
		FilterMode filterMode5 = (renderTexture2.filterMode = filterMode3);
		renderTexture.filterMode = filterMode5;
		RenderTexture renderTexture4 = temporary9;
		RenderTexture renderTexture5 = temporary8;
		RenderTexture renderTexture6 = temporary7;
		filterMode = (temporary6.filterMode = FilterMode.Bilinear);
		filterMode3 = (renderTexture6.filterMode = filterMode);
		filterMode5 = (renderTexture5.filterMode = filterMode3);
		renderTexture4.filterMode = filterMode5;
		filterMode5 = (temporary10.filterMode = FilterMode.Bilinear);
		temporary.filterMode = filterMode5;
		Graphics.Blit(source, temporary);
		Graphics.Blit(temporary, temporary6);
		material.SetFloat(Uniforms._BHBloom_Threshold, threshold);
		Graphics.Blit(temporary6, temporary2, material, 0);
		Graphics.Blit(temporary2, temporary3);
		Graphics.Blit(temporary3, temporary4);
		Graphics.Blit(temporary4, temporary5);
		material.SetVector(Uniforms._BHBloom_Scaler, new Vector2(0.5625f, 0f));
		Graphics.Blit(temporary2, temporary6, material, 1);
		Graphics.Blit(temporary3, temporary7, material, 2);
		Graphics.Blit(temporary4, temporary8, material, 3);
		Graphics.Blit(temporary5, temporary9, material, 4);
		material.SetVector(Uniforms._BHBloom_Scaler, new Vector2(0f, 1f));
		Graphics.Blit(temporary6, temporary2, material, 1);
		Graphics.Blit(temporary7, temporary3, material, 2);
		Graphics.Blit(temporary8, temporary4, material, 3);
		Graphics.Blit(temporary9, temporary5, material, 4);
		if (highQuality)
		{
			material.SetVector(Uniforms._BHBloom_Coeff, new Vector4(0.3f, 0.3f, 0.26f, 0.15f));
		}
		else
		{
			material.SetVector(Uniforms._BHBloom_Coeff, new Vector4(0.24f, 0.24f, 0.28f, 0.225f));
		}
		material.SetTexture("_Bloom3x", temporary3);
		material.SetTexture("_Bloom2x", temporary4);
		material.SetTexture("_Bloom1x", temporary5);
		Graphics.Blit(temporary2, temporary10, material, 5);
		material.SetFloat(Uniforms._BHBloom_Exposure, exposure);
		material.SetFloat(Uniforms._BHBloom_Constrast, constrast);
		material.SetTexture("_BloomMix", temporary10);
		Graphics.Blit(source, destination, material, 6);
		RenderTexture.ReleaseTemporary(temporary);
		RenderTexture.ReleaseTemporary(temporary2);
		RenderTexture.ReleaseTemporary(temporary3);
		RenderTexture.ReleaseTemporary(temporary4);
		RenderTexture.ReleaseTemporary(temporary5);
		RenderTexture.ReleaseTemporary(temporary6);
		RenderTexture.ReleaseTemporary(temporary7);
		RenderTexture.ReleaseTemporary(temporary8);
		RenderTexture.ReleaseTemporary(temporary9);
		RenderTexture.ReleaseTemporary(temporary10);
	}
}
