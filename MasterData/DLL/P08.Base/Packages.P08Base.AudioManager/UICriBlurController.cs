using System;
using UnityEngine;

namespace Packages.P08Base.AudioManager;

[ExecuteAlways]
[RequireComponent(typeof(CriManaMovieControllerForUI))]
public class UICriBlurController : MonoBehaviour
{
	private class ShaderID
	{
		public static readonly int _OverrideColor = Shader.PropertyToID("_OverrideColor");

		public static readonly int _OverrideIntensity = Shader.PropertyToID("_OverrideIntensity");

		public static readonly int _Gray = Shader.PropertyToID("_Gray");

		public static readonly int _Noise = Shader.PropertyToID("_Noise");

		public static readonly int _BlurIntensity = Shader.PropertyToID("_BlurIntensity");
	}

	public Color overrideColor = Color.white;

	[Range(0f, 1f)]
	public float overrideIntensity;

	[Range(0f, 1f)]
	public float noise;

	[Range(0f, 1f)]
	public float gray = 1f;

	[Range(0f, 0.01f)]
	public float blurIntensity;

	private Color lastOverrideColor;

	private float lastOverrideIntensity;

	private float lastNoise;

	private float lastGray;

	private float lastBlurIntensity;

	private bool forceUpdate = true;

	private CriManaMovieControllerForUI criController;

	private bool MainDirty()
	{
		if (lastOverrideColor != overrideColor || Math.Abs(lastOverrideIntensity - overrideIntensity) > 0f || Math.Abs(lastNoise - noise) > 0f || Math.Abs(lastGray - gray) > 0f || Math.Abs(lastBlurIntensity - blurIntensity) > 0f)
		{
			lastOverrideIntensity = overrideIntensity;
			lastNoise = noise;
			lastGray = gray;
			lastBlurIntensity = blurIntensity;
			return true;
		}
		return forceUpdate;
	}

	public virtual void OnEnable()
	{
		criController = GetComponent<CriManaMovieControllerForUI>();
	}

	private void LateUpdate()
	{
		if (MainDirty() && (bool)criController)
		{
			Material material = criController.material;
			if ((bool)material)
			{
				material.SetColor(ShaderID._OverrideColor, overrideColor);
				material.SetFloat(ShaderID._OverrideIntensity, overrideIntensity);
				material.SetFloat(ShaderID._Gray, gray);
				material.SetFloat(ShaderID._Noise, noise);
				material.SetFloat(ShaderID._BlurIntensity, blurIntensity);
				SetKeyword(material, "CRI_BLUR", blurIntensity > 0f);
				forceUpdate = false;
			}
		}
	}

	protected void SetKeyword(Material m, string keyword, bool state)
	{
		if (state)
		{
			m.EnableKeyword(keyword);
		}
		else
		{
			m.DisableKeyword(keyword);
		}
	}
}
