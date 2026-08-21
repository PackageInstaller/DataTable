using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.EnvironmentHelper;

public class TimelineTintEffectHelper : TimelineSceneSettingHelperBase
{
	private SceneSettingFogConfig _fogConfig;

	private Color _originTintColor = Color.magenta;

	protected override void InitOriginData(SceneSetting pSceneSetting)
	{
		_fogConfig = U3DUtil.Get<SceneSettingFogConfig>(pSceneSetting.gameObject);
		_originTintColor = pSceneSetting.tint;
	}

	protected override void OnResetData()
	{
		_sceneSetting.tint = _originTintColor;
	}

	protected override void OnObsoleting(ClipBase pClipBase)
	{
	}

	protected override void OnUpdateClip(List<ClipBase> pRuntimeClip)
	{
		Color tint = Color.magenta;
		if (_runtimeClip[_runtimeClip.Count - 1] is TintEffectClip tintEffectClip)
		{
			tint = tintEffectClip.GradientColor.Evaluate(tintEffectClip.Normalized);
		}
		_sceneSetting.tint = tint;
	}

	public void Play(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float length, float normalized, Color color)
	{
		switch (memberPosition)
		{
		case EnMemberPositionOfFog.Monster:
		case EnMemberPositionOfFog.Player:
		case EnMemberPositionOfFog.First:
		case EnMemberPositionOfFog.Second:
		case EnMemberPositionOfFog.Third:
			AddClipByIndex(creationIndex, memberPosition, key, length, normalized, color);
			break;
		case EnMemberPositionOfFog.UltimateAvoid:
		case EnMemberPositionOfFog.SourceSpace:
			AddClipByMemberPosition(creationIndex, memberPosition, key, length, normalized, color);
			break;
		}
	}

	private void AddClipByIndex(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float length, float normalized, Color color)
	{
		AddClipWithCondition(creationIndex, memberPosition, key, length, normalized, color, IsEqualOfCreationIndex);
	}

	private bool IsEqualOfCreationIndex(TintEffectClip clip, int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		if (clip.CreationIndex == creationIndex && clip.Key == key)
		{
			return !clip.IsAuto;
		}
		return false;
	}

	private void AddClipByMemberPosition(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float length, float normalized, Color color)
	{
		AddClipWithCondition(creationIndex, memberPosition, key, length, normalized, color, IsEqualOfMemeberPosition);
	}

	private bool IsEqualOfMemeberPosition(TintEffectClip clip, int creationIndex, EnMemberPositionOfFog memberPosition, int key)
	{
		if (clip.MemberPosition == memberPosition && clip.Key == key)
		{
			return !clip.IsAuto;
		}
		return false;
	}

	public void AddClipWithCondition(int creationIndex, EnMemberPositionOfFog memberPosition, int key, float length, float normalized, Color color, Func<TintEffectClip, int, EnMemberPositionOfFog, int, bool> conditionFunc)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			if (_runtimeClip[num] is TintEffectClip tintEffectClip && conditionFunc(tintEffectClip, creationIndex, memberPosition, key))
			{
				tintEffectClip.Normalized = normalized;
				tintEffectClip.Length = length;
				return;
			}
		}
		TintEffectClip tintEffectClip2 = FrameObjectPool<TintEffectClip>.Claim();
		tintEffectClip2.CreationIndex = creationIndex;
		tintEffectClip2.MemberPosition = memberPosition;
		tintEffectClip2.Key = key;
		tintEffectClip2.TintColor = _fogConfig.GetTinitColorOfMemberPosition(memberPosition, color);
		tintEffectClip2.Normalized = normalized;
		tintEffectClip2.Length = length;
		tintEffectClip2.IsAuto = false;
		tintEffectClip2.IsObsolete = false;
		int pIndex = 0;
		for (int num2 = _runtimeClip.Count - 1; num2 >= 0; num2--)
		{
			TintEffectClip tintEffectClip3 = _runtimeClip[num2] as TintEffectClip;
			if (memberPosition >= tintEffectClip3.MemberPosition)
			{
				pIndex = num2 + 1;
			}
		}
		AddClip(tintEffectClip2, pIndex);
	}

	protected override void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex)
	{
		UpdateGradientColor(pRuntimeClip, pIndex);
	}

	private void UpdateGradientColor(List<ClipBase> runtimeClip, int pStartIndex)
	{
		for (int i = pStartIndex; i < runtimeClip.Count; i++)
		{
			if (runtimeClip[i] is TintEffectClip)
			{
				UpdateGradientColorItem(runtimeClip, pStartIndex);
			}
		}
	}

	public void UpdateGradientColorItem(List<ClipBase> pRuntimeClip, int pStartIndex)
	{
		TintEffectClip tintEffectClip = pRuntimeClip[pStartIndex] as TintEffectClip;
		GradientColorKey[] colorKeys = tintEffectClip.GradientColor.colorKeys;
		GradientAlphaKey[] alphaKeys = tintEffectClip.GradientColor.alphaKeys;
		if (pStartIndex <= 0)
		{
			colorKeys[0].color = _originTintColor;
			alphaKeys[0].alpha = _originTintColor.a;
			colorKeys[1].color = tintEffectClip.TintColor;
			alphaKeys[1].alpha = tintEffectClip.TintColor.a;
			colorKeys[2].color = tintEffectClip.TintColor;
			alphaKeys[2].alpha = tintEffectClip.TintColor.a;
			if (tintEffectClip.Length < _fogConfig.EnterTime + _fogConfig.ExitTime)
			{
				colorKeys[1].time = 0.5f;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = 0.5f;
				alphaKeys[2].time = colorKeys[2].time;
			}
			else
			{
				colorKeys[1].time = _fogConfig.EnterTime / tintEffectClip.Length;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = (tintEffectClip.Length - _fogConfig.ExitTime) / tintEffectClip.Length;
				alphaKeys[2].time = colorKeys[2].time;
			}
			colorKeys[3].color = _originTintColor;
			alphaKeys[3].alpha = _originTintColor.a;
		}
		else
		{
			TintEffectClip tintEffectClip2 = pRuntimeClip[pStartIndex - 1] as TintEffectClip;
			Color color = tintEffectClip2.GradientColor.Evaluate(tintEffectClip2.Normalized);
			colorKeys[0].color = color;
			alphaKeys[0].alpha = color.a;
			colorKeys[1].color = tintEffectClip.TintColor;
			alphaKeys[1].alpha = tintEffectClip.TintColor.a;
			colorKeys[2].color = tintEffectClip.TintColor;
			alphaKeys[2].alpha = tintEffectClip.TintColor.a;
			if (tintEffectClip.Length < _fogConfig.EnterTime + _fogConfig.ExitTime)
			{
				colorKeys[1].time = 0.5f;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = 0.5f;
				alphaKeys[2].time = colorKeys[2].time;
			}
			else
			{
				colorKeys[1].time = _fogConfig.EnterTime / tintEffectClip.Length;
				alphaKeys[1].time = colorKeys[1].time;
				colorKeys[2].time = (tintEffectClip.Length - _fogConfig.ExitTime) / tintEffectClip.Length;
				alphaKeys[2].time = colorKeys[2].time;
			}
			bool flag = false;
			for (int num = pStartIndex - 1; num >= 0; num--)
			{
				float num2 = pRuntimeClip[num].Normalized + (tintEffectClip.Length - tintEffectClip.Length * tintEffectClip.Normalized) / pRuntimeClip[num].Length;
				if (!(num2 >= 1f))
				{
					flag = true;
					Color color2 = (pRuntimeClip[num] as TintEffectClip).GradientColor.Evaluate(num2);
					colorKeys[3].color = color2;
					alphaKeys[3].alpha = color2.a;
					break;
				}
			}
			if (!flag)
			{
				colorKeys[3].color = tintEffectClip.TintColor;
				alphaKeys[3].alpha = tintEffectClip.TintColor.a;
			}
		}
		tintEffectClip.GradientColor.SetKeys(colorKeys, alphaKeys);
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
		TintEffectClip obj = pClip as TintEffectClip;
		obj.IsAuto = true;
		obj.Normalized = 0f;
		obj.Length = _fogConfig.ExitTime;
		GradientColorKey[] colorKeys = obj.GradientColor.colorKeys;
		GradientAlphaKey[] alphaKeys = obj.GradientColor.alphaKeys;
		colorKeys[1].time = 0f;
		alphaKeys[1].time = 0f;
		colorKeys[2].time = 0f;
		alphaKeys[2].time = 0f;
		obj.GradientColor.SetKeys(colorKeys, alphaKeys);
	}

	protected override void OnRemovingClip(ClipBase pClipBase)
	{
		if (pClipBase is TintEffectClip obj)
		{
			FrameObjectPool<TintEffectClip>.Release(obj);
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
				TintEffectClip tintEffectClip2 = _runtimeClip[num2] as TintEffectClip;
				if (tintEffectClip2.CreationIndex == creationIndex && (key == 0 || tintEffectClip2.Key == key))
				{
					action(tintEffectClip2);
				}
			}
			break;
		}
		case EnMemberPositionOfFog.UltimateAvoid:
		case EnMemberPositionOfFog.SourceSpace:
		{
			for (int num = _runtimeClip.Count - 1; num >= 0; num--)
			{
				TintEffectClip tintEffectClip = _runtimeClip[num] as TintEffectClip;
				if (tintEffectClip.MemberPosition == memberPosition && (key == 0 || tintEffectClip.Key == key))
				{
					action(tintEffectClip);
				}
			}
			break;
		}
		}
	}
}
