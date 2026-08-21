using Sirenix.OdinInspector;
using UnityEngine;

namespace P08Main.T0World.HorusNewData.BandLive.GameView;

public class LiveGlowStickControlView : SerializedMonoBehaviour
{
	[ColorUsage(true, true)]
	public Color[] colorPreset;

	public Material glowStickMat;

	public string glowStickMatPath;

	public const string GLOW_COLOR_FIELD_NAME = "_Fresnel_Color";

	private void Awake()
	{
		if (!glowStickMat && !string.IsNullOrEmpty(glowStickMatPath))
		{
			glowStickMat = Asset.Load<Material>(glowStickMatPath);
		}
	}

	public void SetGlowStickColor(Color color)
	{
		if ((bool)glowStickMat)
		{
			glowStickMat.SetColor("_Fresnel_Color", color);
		}
	}

	public void SetGlowStickColor(int presetIdx)
	{
		if (colorPreset != null && presetIdx >= 0 && presetIdx < colorPreset.Length)
		{
			SetGlowStickColor(colorPreset[presetIdx]);
		}
	}
}
