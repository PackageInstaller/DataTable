using System.Collections.Generic;

namespace P08.EnvironmentHelper;

public class TimelinePostEffectHelper : TimelineSceneSettingHelperBase
{
	private bool _originTonemapping;

	private float _originExposure;

	private float _originContrast;

	private bool _originInvert;

	private float _originGraness;

	private float _originDarkness;

	protected override void InitOriginData(SceneSetting pSceneSetting)
	{
		_originTonemapping = pSceneSetting.tonemapping;
		_originExposure = pSceneSetting.exposure;
		_originContrast = pSceneSetting.contrast;
		_originInvert = pSceneSetting.invert;
		_originGraness = pSceneSetting.grayness;
		_originDarkness = pSceneSetting.darkness;
	}

	protected override void OnResetData()
	{
		_sceneSetting.tonemapping = _originTonemapping;
		_sceneSetting.exposure = _originExposure;
		_sceneSetting.contrast = _originContrast;
		_sceneSetting.invert = _originInvert;
		_sceneSetting.grayness = _originGraness;
		_sceneSetting.darkness = _originDarkness;
	}

	public void AddPostEffectClip(int pCreationIndex, SceneSettingPostEffectClip pSceneSettingPostEffectClip)
	{
		PostEffectTimelineClip postEffectTimelineClip = FrameObjectPool<PostEffectTimelineClip>.Claim();
		postEffectTimelineClip.InitBaseData(pIsAuto: false, pSceneSettingPostEffectClip.Length);
		postEffectTimelineClip.CreationIndex = pCreationIndex;
		postEffectTimelineClip.Key = pSceneSettingPostEffectClip.Key;
		postEffectTimelineClip.SceneSettingPostEffectClip = pSceneSettingPostEffectClip;
		AddClip(postEffectTimelineClip);
	}

	protected override void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex)
	{
	}

	public void RemovePostEffectClip(int pCreationIndex, int pKey = 0)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			PostEffectTimelineClip postEffectTimelineClip = _runtimeClip[num] as PostEffectTimelineClip;
			if (postEffectTimelineClip.CreationIndex == pCreationIndex)
			{
				if (pKey == 0)
				{
					postEffectTimelineClip.IsObsolete = true;
				}
				else if (postEffectTimelineClip.Key == pKey && !postEffectTimelineClip.IsObsolete)
				{
					postEffectTimelineClip.IsObsolete = true;
				}
			}
		}
	}

	protected override void OnObsoleting(ClipBase pClipBase)
	{
	}

	protected override void OnRemovingClip(ClipBase pClipBase)
	{
		if (pClipBase is PostEffectTimelineClip obj)
		{
			FrameObjectPool<PostEffectTimelineClip>.Release(obj);
		}
	}

	protected override void OnRemovedClip(List<ClipBase> pRuntimeClip, int pLastestRemoveIndex)
	{
	}

	public void UpdatePostEffect(int pCreationIndex, SceneSettingPostEffectClip pSceneSettingPostEffectClip, float pNormalized)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			PostEffectTimelineClip postEffectTimelineClip = _runtimeClip[num] as PostEffectTimelineClip;
			if (postEffectTimelineClip.CreationIndex == pCreationIndex && postEffectTimelineClip.Key == pSceneSettingPostEffectClip.Key)
			{
				postEffectTimelineClip.Normalized = pNormalized;
				break;
			}
		}
	}

	protected override void OnUpdateClip(List<ClipBase> pRuntimeClip)
	{
		PostEffectTimelineClip obj = pRuntimeClip[pRuntimeClip.Count - 1] as PostEffectTimelineClip;
		float normalized = obj.Normalized;
		SceneSettingPostEffectClip sceneSettingPostEffectClip = obj.SceneSettingPostEffectClip;
		_sceneSetting.exposure = sceneSettingPostEffectClip.ExposureCurve.Evaluate(normalized);
		_sceneSetting.contrast = sceneSettingPostEffectClip.ContrastCurve.Evaluate(normalized);
		_sceneSetting.invert = sceneSettingPostEffectClip.Invert;
		_sceneSetting.grayness = sceneSettingPostEffectClip.GraynessCurve.Evaluate(normalized);
		_sceneSetting.darkness = sceneSettingPostEffectClip.DarknessCurve.Evaluate(normalized);
	}
}
