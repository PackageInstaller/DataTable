using System;
using System.Threading;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class CollectionPointData : StateWorldAssetData, IMiniGameData
{
	public string[] abilities;

	public bool useMiniGame;

	[SerializeField]
	private bool _showAttackTip;

	[SerializeField]
	[Header("tip显示区域")]
	private MixedBox _tipFiled;

	[SerializeField]
	[Header("tip出现位置")]
	private Pos _tipPos;

	[SerializeField]
	private SeparateSegmentConfigs.Difficulty _difficulty;

	public bool showUnlockTimeline;

	[SerializeField]
	private int m_initialStateId;

	public int collectionPointId;

	[SerializeField]
	[Header("是否自动拾取掉落奖励")]
	[Tooltip("能掉奖励时都会有左侧获得道具提示，自动拾取没有飞的表现")]
	private bool _directGet;

	public bool ShowAttackTip => _showAttackTip;

	public MixedBox TipFiled => _tipFiled;

	public Pos TipPos => _tipPos;

	public bool UseMiniGame => useMiniGame;

	public SeparateSegmentConfigs.Difficulty Difficulty => _difficulty;

	public override YooAssetReference addressAssetID => GetCollectionAsset();

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.Collection;

	public override int initialStateId => m_initialStateId;

	public bool DirectGet => _directGet;

	public override (StateWorldAsset, UniTask) OnLoad(CancellationToken syncInit)
	{
		(CollectionPointAsset, UniTask) tuple = StateWorldAsset.Load<CollectionPointAsset>(this, syncInit);
		return (tuple.Item1, tuple.Item2);
	}

	public override void OnRelease()
	{
		StateWorldAsset.Release<CollectionPointAsset>(this);
	}

	private YooAssetReference GetCollectionAsset()
	{
		int id = RuntimeConfigs.data.collectionPoints[collectionPointId].collectionId[0].id;
		if (RuntimeConfigs.data.collections[id].collectionType == 1)
		{
			return GameLoader.meta.collectionGemReferenceAssetID;
		}
		return GameLoader.meta.collectionPointReferenceAssetID;
	}

	public override bool IsServiceSaveState(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 4;
		}
		return false;
	}

	public override void Bake(object assetComp)
	{
	}
}
