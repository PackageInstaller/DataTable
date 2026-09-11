using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.EnvironmentHelper;

public class TimelineDynamicFogEffectHelper : TimelineSceneSettingHelperBase
{
	private SceneSettingFogConfig _fogConfig;

	private Color _originColor = Color.magenta;

	private float _originIntensity;

	protected override void InitOriginData(SceneSetting pSceneSetting)
	{
		_fogConfig = U3DUtil.Get<SceneSettingFogConfig>(pSceneSetting.gameObject);
		_originColor = pSceneSetting.dynamicFogColor;
		_originIntensity = pSceneSetting.dynamicFogIntensity;
	}

	protected override void OnResetData()
	{
		_sceneSetting.dynamicFogColor = _originColor;
		_sceneSetting.dynamicFogIntensity = _originIntensity;
	}

	protected override void OnObsoleting(ClipBase pClipBase)
	{
	}

	protected override void OnUpdateClip(List<ClipBase> pRuntimeClip)
	{
		float num = -1f;
		for (int i = 0; i < _runtimeClip.Count; i++)
		{
			if (_runtimeClip[i] is DynamicFogEffectClip { IntensityValue: not -1f } dynamicFogEffectClip && dynamicFogEffectClip.IntensityValue > num)
			{
				num = dynamicFogEffectClip.IntensityValue;
			}
		}
		Color dynamicFogColor = Color.magenta;
		if (_runtimeClip[_runtimeClip.Count - 1] is DynamicFogEffectClip dynamicFogEffectClip2)
		{
			dynamicFogColor = dynamicFogEffectClip2.GradientColor.Evaluate(dynamicFogEffectClip2.Normalized);
		}
		num = Mathf.Clamp01(num);
		_sceneSetting.dynamicFogIntensity = num;
		_sceneSetting.dynamicFogColor = dynamicFogColor;
	}

	public void Play(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float intensityValue, float length, float normalized, Color color, AnimationCurve curve = null)
	{
		switch (memberPosition)
		{
		case EnMemberPositionOfFog.Monster:
		case EnMemberPositionOfFog.Player:
		case EnMemberPositionOfFog.First:
		case EnMemberPositionOfFog.Second:
		case EnMemberPositionOfFog.Third:
			AddClipByIndex(creationIndex, memberPosition, key, intensityValue, length, normalized, color, curve);
			break;
		case EnMemberPositionOfFog.UltimateAvoid:
		case EnMemberPositionOfFog.SourceSpace:
			AddClipByMemberPosition(creationIndex, memberPosition, key, intensityValue, length, normalized, color, curve);
			break;
		}
	}

	private void AddClipByIndex(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float intensityValue, float length, float normalized, Color color, AnimationCurve curve)
	{
		AddClipWithCondition(creationIndex, memberPosition, key, intensityValue, length, normalized, color, curve, IsEqualOfCreationIndex);
	}

	private bool IsEqualOfCreationIndex(DynamicFogEffectClip clip, int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		if (clip.CreationIndex == creationIndex && clip.Key == key)
		{
			return !clip.IsAuto;
		}
		return false;
	}

	private void AddClipByMemberPosition(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float intensityValue, float length, float normalized, Color color, AnimationCurve curve)
	{
		AddClipWithCondition(creationIndex, memberPosition, key, intensityValue, length, normalized, color, curve, IsEqualOfMemeberPosition);
	}

	private bool IsEqualOfMemeberPosition(DynamicFogEffectClip clip, int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		if (clip.MemberPosition == memberPosition && clip.Key == key)
		{
			return !clip.IsAuto;
		}
		return false;
	}

	public void AddClipWithCondition(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float intensityValue, float length, float normalized, Color color, AnimationCurve curve, Func<DynamicFogEffectClip, int, EnMemberPositionOfFog, int, bool> conditionFunc)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			DynamicFogEffectClip dynamicFogEffectClip = _runtimeClip[num] as DynamicFogEffectClip;
			if (conditionFunc(dynamicFogEffectClip, creationIndex, memberPosition, key))
			{
				dynamicFogEffectClip.IntensityValue = intensityValue;
				dynamicFogEffectClip.Normalized = normalized;
				dynamicFogEffectClip.Length = length;
				return;
			}
		}
		DynamicFogEffectClip dynamicFogEffectClip2 = FrameObjectPool<DynamicFogEffectClip>.Claim();
		dynamicFogEffectClip2.CreationIndex = creationIndex;
		dynamicFogEffectClip2.MemberPosition = memberPosition;
		dynamicFogEffectClip2.Key = key;
		dynamicFogEffectClip2.FogColor = _fogConfig.GetColorOfMemberPosition(memberPosition, color);
		dynamicFogEffectClip2.FogIntensityCurve = curve;
		dynamicFogEffectClip2.IntensityValue = intensityValue;
		dynamicFogEffectClip2.Normalized = normalized;
		dynamicFogEffectClip2.Length = length;
		dynamicFogEffectClip2.IsAuto = false;
		dynamicFogEffectClip2.IsObsolete = false;
		int pIndex = 0;
		for (int num2 = _runtimeClip.Count - 1; num2 >= 0; num2--)
		{
			DynamicFogEffectClip dynamicFogEffectClip3 = _runtimeClip[num2] as DynamicFogEffectClip;
			if (memberPosition >= dynamicFogEffectClip3.MemberPosition)
			{
				pIndex = num2 + 1;
			}
		}
		AddClip(dynamicFogEffectClip2, pIndex);
	}

	protected override void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex)
	{
		UpdateGradientColor(pRuntimeClip, pIndex);
	}

	private void UpdateGradientColor(List<ClipBase> runtimeClip, int pStartIndex)
	{
		for (int i = pStartIndex; i < runtimeClip.Count; i++)
		{
			if (runtimeClip[i] is DynamicFogEffectClip)
			{
				UpdateGradientColorItem(runtimeClip, pStartIndex);
			}
		}
	}

	public void UpdateGradientColorItem(List<ClipBase> pRuntimeClip, int pStartIndex)
	{
		DynamicFogEffectClip dynamicFogEffectClip = pRuntimeClip[pStartIndex] as DynamicFogEffectClip;
		GradientColorKey[] colorKeys = dynamicFogEffectClip.GradientColor.colorKeys;
		GradientAlphaKey[] alphaKeys = dynamicFogEffectClip.GradientColor.alphaKeys;
		if (pStartIndex <= 0)
		{
			for (int i = 0; i < colorKeys.Length; i++)
			{
				colorKeys[i].color = dynamicFogEffectClip.FogColor;
				alphaKeys[i].alpha = dynamicFogEffectClip.FogColor.a;
			}
		}
		else
		{
			DynamicFogEffectClip dynamicFogEffectClip2 = pRuntimeClip[pStartIndex - 1] as DynamicFogEffectClip;
			Color color = dynamicFogEffectClip2.GradientColor.Evaluate(dynamicFogEffectClip2.Normalized);
			colorKeys[0].color = color;
			alphaKeys[0].alpha = color.a;
			colorKeys[1].color = dynamicFogEffectClip.FogColor;
			alphaKeys[1].alpha = dynamicFogEffectClip.FogColor.a;
			colorKeys[2].color = dynamicFogEffectClip.FogColor;
			alphaKeys[2].alpha = dynamicFogEffectClip.FogColor.a;
			if (dynamicFogEffectClip.Length < _fogConfig.EnterTime + _fogConfig.ExitTime)
			{
				colorKeys[1].time = 0.5f;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = 0.5f;
				alphaKeys[2].time = colorKeys[2].time;
			}
			else
			{
				colorKeys[1].time = _fogConfig.EnterTime / dynamicFogEffectClip.Length;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = (dynamicFogEffectClip.Length - _fogConfig.ExitTime) / dynamicFogEffectClip.Length;
				alphaKeys[2].time = colorKeys[2].time;
			}
			bool flag = false;
			for (int num = pStartIndex - 1; num >= 0; num--)
			{
				float num2 = pRuntimeClip[num].Normalized + (dynamicFogEffectClip.Length - dynamicFogEffectClip.Length * dynamicFogEffectClip.Normalized) / pRuntimeClip[num].Length;
				if (!(num2 >= 1f))
				{
					flag = true;
					Color color2 = (pRuntimeClip[num] as DynamicFogEffectClip).GradientColor.Evaluate(num2);
					colorKeys[3].color = color2;
					alphaKeys[3].alpha = color2.a;
					break;
				}
			}
			if (!flag)
			{
				colorKeys[3].color = dynamicFogEffectClip.FogColor;
				alphaKeys[3].alpha = dynamicFogEffectClip.FogColor.a;
			}
		}
		dynamicFogEffectClip.GradientColor.SetKeys(colorKeys, alphaKeys);
	}

	public void Stop(int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		ForeachClipWithMemberPosition(creationIndex, memberPosition, key, SetObsolete);
	}

	private void SetObsolete(ClipBase pClip)
	{
		pClip.IsObsolete = true;
	}

	public void StopByAuto(int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		ForeachClipWithMemberPosition(creationIndex, memberPosition, key, SetAutoToEnd);
	}

	private void SetAutoToEnd(ClipBase pClip)
	{
		pClip.IsAuto = true;
	}

	protected override void OnRemovingClip(ClipBase pClipBase)
	{
		if (pClipBase is DynamicFogEffectClip obj)
		{
			FrameObjectPool<DynamicFogEffectClip>.Release(obj);
		}
	}

	protected override void OnRemovedClip(List<ClipBase> pRuntimeClip, int pLastestRemoveIndex)
	{
		UpdateGradientColor(pRuntimeClip, pLastestRemoveIndex);
	}

	public void ForeachClipWithMemberPosition(int creationIndex, EnMemberPositionOfFog memberPosition, int key, Action<ClipBase> action)
	{
		switch (memberPosition)
		{
		case EnMemberPositionOfFog.Monster:
		case EnMemberPositionOfFog.Player:
		case EnMemberPositionOfFog.First:
		case EnMemberPositionOfFog.Second:
		case EnMemberPositionOfFog.Third:
		{
			for (int num2 = _runtimeClip.Count - 1; num2 >= 0; num2--)
			{
				DynamicFogEffectClip dynamicFogEffectClip2 = _runtimeClip[num2] as DynamicFogEffectClip;
				if (dynamicFogEffectClip2.CreationIndex == creationIndex && (key == 0 || dynamicFogEffectClip2.Key == key))
				{
					action(dynamicFogEffectClip2);
				}
			}
			break;
		}
		case EnMemberPositionOfFog.UltimateAvoid:
		case EnMemberPositionOfFog.SourceSpace:
		{
			for (int num = _runtimeClip.Count - 1; num >= 0; num--)
			{
				DynamicFogEffectClip dynamicFogEffectClip = _runtimeClip[num] as DynamicFogEffectClip;
				if (dynamicFogEffectClip.MemberPosition == memberPosition && (key == 0 || dynamicFogEffectClip.Key == key))
				{
					action(dynamicFogEffectClip);
				}
			}
			break;
		}
		}
	}
}
