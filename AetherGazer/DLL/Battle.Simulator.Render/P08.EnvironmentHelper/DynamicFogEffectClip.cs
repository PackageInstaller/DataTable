using UnityEngine;

namespace P08.EnvironmentHelper;

public class DynamicFogEffectClip : ClipBase, IFramePooledObject
{
	public int CreationIndex;

	public EnMemberPositionOfFog MemberPosition;

	public int Key;

	public Color FogColor = Color.magenta;

	public float IntensityValue;

	public AnimationCurve FogIntensityCurve;

	public Gradient GradientColor;

	public void ResetGradient(Gradient pGradient)
	{
		GradientColorKey[] array = new GradientColorKey[4];
		array[0].color = Color.magenta;
		array[0].time = 0f;
		array[1].color = Color.magenta;
		array[1].time = 0.25f;
		array[2].color = Color.magenta;
		array[2].time = 0.75f;
		array[3].color = Color.magenta;
		array[3].time = 1f;
		GradientAlphaKey[] array2 = new GradientAlphaKey[4];
		array2[0].alpha = 1f;
		array2[0].time = 0f;
		array2[1].alpha = 1f;
		array2[1].time = 0.25f;
		array2[2].alpha = 1f;
		array2[2].time = 0.75f;
		array2[3].alpha = 1f;
		array2[3].time = 1f;
		pGradient.SetKeys(array, array2);
	}

	public DynamicFogEffectClip()
	{
		CreationIndex = 0;
		MemberPosition = EnMemberPositionOfFog.None;
		Key = 0;
		FogColor = Color.magenta;
		IntensityValue = -1f;
		FogIntensityCurve = null;
		GradientColor = new Gradient();
		ResetGradient(GradientColor);
	}

	public void OnEnterPool()
	{
		CreationIndex = 0;
		MemberPosition = EnMemberPositionOfFog.None;
		Key = 0;
		FogColor = Color.magenta;
		IntensityValue = 0f;
		FogIntensityCurve = null;
		if (GradientColor == null)
		{
			GradientColor = new Gradient();
		}
		ResetGradient(GradientColor);
	}
}
