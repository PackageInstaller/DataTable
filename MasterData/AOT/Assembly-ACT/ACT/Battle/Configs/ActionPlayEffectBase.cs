using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class ActionPlayEffectBase : ConfigAction
{
	public YooAssetReference effectReferenceAssetID;

	public bool useDirectionVariant;

	public MemoryEntityRef directionEntity;

	public YooAssetReference leftEffectReferenceAssetID;

	public bool useSkinBattleMapping = true;

	public bool extraHitMaterialEffect;

	public HitMaterialEffectSheet extraEffectSheet;

	public EffectPlayPointType playPointType;

	public MemoryEntityRef anchorEntity = MemoryEntityRef.Target;

	public string attachPoint;

	public ConfigFunction<Vector3> positionFunction;

	public ConfigFunction<Transform> transformFunction;

	public EffectUIPlayPoint uiAnchor = EffectUIPlayPoint.Center;

	public Vector2 uiCustomAnchorPosition = new Vector2(0.5f, 0.5f);

	public Vector2 uiAnchoredOffset;

	public bool uiRespectSafeArea = true;

	public int uiSiblingOrder = -1;

	public Vector3 positionOffset;

	public EffectPositionUpdateRule positionUpdateRule;

	public float positionFollowSpeed = 12f;

	public EffectInvalidAnchorRule invalidAnchorRule;

	public EffectInitialRotationRule initialRotationRule = EffectInitialRotationRule.PlayPointRotation;

	public MemoryEntityRef logicDirectionEntity;

	public ConfigFunction<Quaternion> initialRotationFunction;

	public Vector3 rotationOffset;

	public bool useRandomRotation;

	public Vector3 randomRotationMin;

	public Vector3 randomRotationMax;

	public EffectRotationUpdateRule rotationUpdateRule;

	public ConfigFunction<Quaternion> rotationFunction;

	public Vector3 baseScale = Vector3.one;

	public EffectScaleRule scaleRule;

	public TimeScale timeScale;

	public bool changeWithAnchorVisibility;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		GameManager.effectSystem?.PlayNewEffect(this, memory);
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		if (effectReferenceAssetID != null && effectReferenceAssetID.RuntimeKeyIsValid())
		{
			addlist.Add(effectReferenceAssetID);
		}
		if (leftEffectReferenceAssetID != null && leftEffectReferenceAssetID.RuntimeKeyIsValid())
		{
			addlist.Add(leftEffectReferenceAssetID);
		}
		if (!extraHitMaterialEffect || !GameLoader.meta.hitEffectComparisonTable.tableAssetID.TryGetValue(extraEffectSheet, out var value))
		{
			return;
		}
		foreach (YooAssetReference value2 in value.Values)
		{
			if (value2 != null && value2.RuntimeKeyIsValid())
			{
				addlist.Add(value2);
			}
		}
	}

	public override void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		if (collector != null)
		{
			ConfigSkinBattleMapping mapping2 = (useSkinBattleMapping ? mapping : null);
			collector.Add(effectReferenceAssetID, mapping2, "ActionPlayEffectBase");
			if (useDirectionVariant)
			{
				collector.Add(leftEffectReferenceAssetID, mapping2, "ActionPlayEffectBase");
			}
		}
	}
}
