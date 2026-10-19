using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行挂点特效", "Action", new string[] { "attach", "effect", "fx", "particle" })]
public class ActionAttachEffect : ActionFireEffect
{
	public bool exclusivePriority;

	public int priority;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		string removeWhenConfigMotionExitName = GetRemoveWhenConfigMotionExitName(memory);
		YooAssetReference effectRef = effectReferenceAssetID;
		YooAssetReference effectRef2 = effectReference1AssetID;
		ActionFireEffect.RemapEffectReferences(memory, ref effectRef, ref effectRef2);
		Quaternion quaternion = initRotation?.Return(memory) ?? Quaternion.identity;
		if (playEffectConsiderDirection && memory.target.entity.IsFaceLeft())
		{
			SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
			{
				target = memory.target,
				patternAssetID = effectRef2,
				removeWhenMotionExit = removeWhenMotionExit,
				removeWhenConfigMotionExit = removeWhenConfigMotionExit,
				configMotionName = removeWhenConfigMotionExitName,
				timescale = timeScale,
				type = type,
				point1 = point3,
				point2 = point2,
				removeWhenStop = removeWhenStop,
				changeScale = needChangeScale,
				effectRangeEnum = effectRangeEnum,
				transformScaleMulBase = transScaleMulBase,
				modelType = modelType,
				isChangeWithEntity = isChangeWithEntity,
				initRotation = quaternion,
				isAttach = true,
				exclusivePriority = false,
				priority = -1,
				playSpace = playSpace,
				uiAnchor = uiAnchor,
				uiAnchoredOffset = uiAnchoredOffset,
				uiRespectSafeArea = uiRespectSafeArea,
				uiCustomAnchorPos = uiCustomAnchorPos,
				uiSiblingOrder = uiSiblingOrder
			};
			if (point3.type == EffectPoint.EffectPointType.ConstPoint && point3.constPointPos != null)
			{
				effectParams.constPointPos = point3.constPointPos.Return(memory);
			}
			float num = 99f;
			if (effectRangeEnum != EffectRangeEnum.none)
			{
				effectParams.transformScaleMulBase = ((effectRangeEnum == EffectRangeEnum.circle) ? new Vector3(circleScale.x, circleScale.y, circleScale.x) : rangeScale);
				if (warningEffectTime != null)
				{
					num = warningEffectTime.Return(memory);
				}
			}
			effectParams.warningEffectTime = num;
			effectParams.exclusivePriority = exclusivePriority;
			effectParams.priority = priority;
			effectParams.ignoreOwnerVisible = useNoOwnerEffect;
			EffectRuntimeItem effectRuntimeItem = GameManager.effectSystem.FireEffect(effectParams);
			effectRuntimeItem.attachAbility = memory.ability;
			memory.ability.attachEffects.Add(effectRuntimeItem);
			FireExtraEffect(memory, effectParams);
			return;
		}
		SystemEffect.EffectParams effectParams2 = new SystemEffect.EffectParams
		{
			target = memory.target,
			patternAssetID = effectRef,
			removeWhenMotionExit = removeWhenMotionExit,
			removeWhenConfigMotionExit = removeWhenConfigMotionExit,
			configMotionName = removeWhenConfigMotionExitName,
			timescale = timeScale,
			type = type,
			point1 = point1,
			point2 = point2,
			removeWhenStop = removeWhenStop,
			changeScale = needChangeScale,
			effectRangeEnum = effectRangeEnum,
			transformScaleMulBase = transScaleMulBase,
			modelType = modelType,
			isChangeWithEntity = isChangeWithEntity,
			initRotation = quaternion,
			isAttach = true,
			exclusivePriority = false,
			priority = -1,
			playSpace = playSpace,
			uiAnchor = uiAnchor,
			uiAnchoredOffset = uiAnchoredOffset,
			uiRespectSafeArea = uiRespectSafeArea,
			uiCustomAnchorPos = uiCustomAnchorPos,
			uiSiblingOrder = uiSiblingOrder
		};
		if (point1.type == EffectPoint.EffectPointType.ConstPoint && point1.constPointPos != null)
		{
			effectParams2.constPointPos = point1.constPointPos.Return(memory);
		}
		float num2 = 99f;
		if (effectRangeEnum != EffectRangeEnum.none)
		{
			effectParams2.transformScaleMulBase = ((effectRangeEnum == EffectRangeEnum.circle) ? new Vector3(circleScale.x, circleScale.y, circleScale.x) : rangeScale);
			if (warningEffectTime != null)
			{
				num2 = warningEffectTime.Return(memory);
			}
		}
		effectParams2.warningEffectTime = num2;
		effectParams2.exclusivePriority = exclusivePriority;
		effectParams2.priority = priority;
		effectParams2.ignoreOwnerVisible = useNoOwnerEffect;
		EffectRuntimeItem effectRuntimeItem2 = GameManager.effectSystem.FireEffect(effectParams2);
		effectRuntimeItem2.attachAbility = memory.ability;
		memory.ability.attachEffects.Add(effectRuntimeItem2);
		FireExtraEffect(memory, effectParams2);
	}
}
