using System;
using ACT.World.Asset;
using ACT.World.Data.Audios;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.SceneChunks;

[Serializable]
public class SceneBlock : SceneOverrideAudioData, IDataToBake
{
	[SerializeReference]
	[HideInInspector]
	private ILoadCondition _loadCondition;

	[FormerlySerializedAs("_sceneAssetReference")]
	[SerializeField]
	[HideInInspector]
	private YooAssetReference _sceneAssetRef;

	[FormerlySerializedAs("_sceneBgAssetReference")]
	[SerializeField]
	[HideInInspector]
	private YooAssetReference _backgroundSceneAssetRef;

	[FormerlySerializedAs("_stateBlueprintAssetRef")]
	[SerializeField]
	[HideInInspector]
	private YooAssetReference _levelBlueprintAssetRef;

	[SerializeField]
	[HideInInspector]
	private YooAssetReference _levelDesignAssetRef;

	[SerializeField]
	[HideInInspector]
	private string _debugSceneName;

	[SerializeReference]
	[OdinSerialize]
	private StateWorldAssetData[] _stateWorldAssetDatas;

	[SerializeReference]
	private SceneAudioOverrideProbeData[] _soundOverrideProbes;

	internal YooAssetReference SceneAssetRef => _sceneAssetRef;

	internal YooAssetReference BackgroundSceneAssetRef => _backgroundSceneAssetRef;

	internal YooAssetReference LevelBlueprintAssetRef => _levelBlueprintAssetRef;

	internal YooAssetReference LevelDesignAssetRef => GetLevelDesignAssetRef();

	private ILoadCondition StateLoadCondition => _loadCondition;

	public string DebugSceneName => _debugSceneName;

	public StateWorldAssetData[] StateWorldAssetDatas => _stateWorldAssetDatas;

	public SceneAudioOverrideProbeData[] SoundOverrideProbes => _soundOverrideProbes;

	internal bool ConditionPassed()
	{
		if (_loadCondition != null)
		{
			return _loadCondition.Return();
		}
		return true;
	}

	private YooAssetReference GetLevelDesignAssetRef()
	{
		return _levelDesignAssetRef;
	}
}
