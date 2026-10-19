using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("播放、刷新或释放特效", "Action", new string[] { "effect", "fx", "particle" })]
public class ActionFireEffect : ConfigAction
{
	public YooAssetReference effectReferenceAssetID;

	public YooAssetReference effectReference1AssetID;

	public bool extraHitMaterialEffect;

	public HitMaterialEffectSheet extraEffectSheet;

	public bool playEffectConsiderDirection;

	public bool useNoOwnerEffect;

	public bool removeWhenMotionExit = true;

	public bool removeWhenConfigMotionExit;

	public bool removeWhenStop = true;

	[Tooltip("随不随TimeScale变化而变化， Owner跟随， NoScale 不跟随")]
	public TimeScale timeScale;

	public bool isChangeWithEntity;

	internal MotionState motionState;

	internal string configMotionName;

	public ConfigFunction<Quaternion> initRotation;

	[HideInInspector]
	public ConfigFunction<Vector3> noOwnerEffectRotation = new FunctionConstVector3();

	[Space]
	[Space]
	public SystemEffect.EffectPlaySpace playSpace;

	[Tooltip("Line暂时没人用， 默认point就行")]
	public EffectDataType type;

	public EffectPoint point1;

	public EffectPoint point2;

	public EffectPoint point3;

	public EffectRangeEnum effectRangeEnum;

	public ConfigFunction<float> warningEffectTime;

	[HideInInspector]
	public Vector3 transScaleMulBase = new Vector3(1f, 1f, 1f);

	public Vector3 rangeScale;

	public Vector2 circleScale = new Vector2(1f, 1f);

	public bool needChangeScale;

	[HideInInspector]
	public EffectModelType modelType;

	public bool useCapsuleCast;

	public float capsuleCastRadius = 1f;

	public float capsuleCastHeight = 1f;

	public SystemEffect.UIEffectAnchor uiAnchor = SystemEffect.UIEffectAnchor.TopRight;

	public Vector2 uiAnchoredOffset;

	[HideInInspector]
	public bool uiRespectSafeArea = true;

	public Vector2 uiCustomAnchorPos = new Vector2(0.5f, 0.5f);

	public int uiSiblingOrder = -1;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	internal static void RemapEffectReferences(ActionMemory memory, ref YooAssetReference effectRef, ref YooAssetReference effectRef1)
	{
		if (TryGetBattleMapping(memory, out var battleMapping))
		{
			if (effectRef != null && battleMapping.effects.TryGetValue(effectRef, out var value) && value != null && value.IsValid())
			{
				effectRef = value;
			}
			if (effectRef1 != null && battleMapping.effects.TryGetValue(effectRef1, out var value2) && value2 != null && value2.IsValid())
			{
				effectRef1 = value2;
			}
		}
	}

	private static bool TryGetBattleMapping(ActionMemory memory, out ConfigSkinBattleMapping battleMapping)
	{
		if (TryGetBattleMapping(memory.owner, out battleMapping) || TryGetBattleMapping(memory.caster, out battleMapping))
		{
			return true;
		}
		if (memory.owner != default(Entity) && TryGetBattleMapping(memory.owner.GetCaster(), out battleMapping))
		{
			return true;
		}
		if (memory.caster != default(Entity) && TryGetBattleMapping(memory.caster.GetCaster(), out battleMapping))
		{
			return true;
		}
		if (TryGetBattleMapping(memory.target.entity, out battleMapping))
		{
			return true;
		}
		if (memory.target.entity != default(Entity))
		{
			return TryGetBattleMapping(memory.target.entity.GetCaster(), out battleMapping);
		}
		return false;
	}

	private static bool TryGetBattleMapping(Entity entity, out ConfigSkinBattleMapping battleMapping)
	{
		battleMapping = ((!(entity != default(Entity))) ? null : entity.GetCompBehave()?.ConfigSkinBattleMapping);
		return battleMapping?.effects != null;
	}

	public override void Do(ActionMemory memory)
	{
		if (playSpace == SystemEffect.EffectPlaySpace.UI)
		{
			useNoOwnerEffect = false;
		}
		string removeWhenConfigMotionExitName = GetRemoveWhenConfigMotionExitName(memory);
		YooAssetReference effectRef = effectReferenceAssetID;
		YooAssetReference effectRef2 = effectReference1AssetID;
		RemapEffectReferences(memory, ref effectRef, ref effectRef2);
		Vector3 transformScaleMulBase = transScaleMulBase;
		if (effectRangeEnum != EffectRangeEnum.none)
		{
			switch (effectRangeEnum)
			{
			case EffectRangeEnum.circle:
				transformScaleMulBase = new Vector3(circleScale.x, circleScale.y, circleScale.x);
				break;
			case EffectRangeEnum.range:
				transformScaleMulBase = rangeScale;
				break;
			}
		}
		if (useNoOwnerEffect)
		{
			Vector3 vector = memory.target.entity.GetCompTransform().physicsPosition;
			switch (point1.type)
			{
			case EffectPoint.EffectPointType.AttachPoint:
			{
				AttachPoint attachPointAll = memory.target.entity.GetMono().GetAttachPointAll(point1.attachPoint);
				if (attachPointAll.forward != null)
				{
					attachPointAll.forward.position = attachPointAll.GetPos();
				}
				vector = ((attachPointAll.forward != null) ? attachPointAll.forward.position : attachPointAll.transform.position);
				break;
			}
			case EffectPoint.EffectPointType.curCamera:
				vector = MonoECS.instance.entityLocal.compCamera.mainCamera.transform.position;
				break;
			case EffectPoint.EffectPointType.ConstPoint:
				vector = point1.constPointPos.Return(memory);
				break;
			case EffectPoint.EffectPointType.TargetGroundPos:
			{
				Vector3 down = Vector3.down;
				if (useCapsuleCast)
				{
					Vector3 vector2 = vector + memory.target.entity.GetCompTransform().rotation * (capsuleCastHeight * Vector3.up);
					if (Physics.CapsuleCast(vector, vector2, capsuleCastRadius, down, out var hitInfo, 20f, BattleConsts.enviromentMask))
					{
						vector = hitInfo.point;
					}
					break;
				}
				float maxDistance = ((point1.groundPosCheckLength != 0f) ? point1.groundPosCheckLength : 20f);
				Vector3 point;
				if (Physics.Raycast(new Ray(vector + Vector3.up * 0.2f, down), out var hitInfo2, maxDistance, BattleConsts.enviromentMask))
				{
					vector = hitInfo2.point;
				}
				else if (TryGetEnvironmentHitPoint(memory, out point))
				{
					vector = point;
				}
				break;
			}
			}
			Quaternion quaternion;
			if (initRotation != null)
			{
				quaternion = initRotation.Return(memory);
			}
			else
			{
				CompPhysics compPhysics = memory.owner.GetCompPhysics();
				if (compPhysics == null || point1.rotateNotFollow)
				{
					quaternion = Quaternion.identity;
				}
				else
				{
					quaternion = ((!point1.rotateFollowLogicDir && (!playEffectConsiderDirection || !point3.rotateFollowLogicDir)) ? (memory.owner.GetModelTrans().rotation * Quaternion.Euler(0f, -90f, 0f)) : (compPhysics.faceDirRot * Quaternion.Euler(0f, -90f, 0f)));
				}
			}
			vector = ((playEffectConsiderDirection && memory.caster.IsFaceLeft()) ? (vector + quaternion * point3.offset) : (vector + quaternion * point1.offset));
			if (point1.useInitRotation || (playEffectConsiderDirection && point3.useInitRotation))
			{
				quaternion = Quaternion.Euler(quaternion.eulerAngles + new Vector3(point1.oriRotX, point1.oriRotY, point1.oriRotZ));
			}
			if (point1.rotatationRandom)
			{
				Vector3 euler = new Vector3(Random.Range(point1.rotatationRandomMin.x, point1.rotatationandomMax.x), Random.Range(point1.rotatationRandomMin.y, point1.rotatationandomMax.y), Random.Range(point1.rotatationRandomMin.z, point1.rotatationandomMax.z));
				quaternion *= Quaternion.Euler(euler);
			}
			float num = -1f;
			if (effectRangeEnum != EffectRangeEnum.none && warningEffectTime != null)
			{
				num = warningEffectTime.Return(memory);
			}
			if (playEffectConsiderDirection && memory.caster.IsFaceLeft())
			{
				FireMainEffect(effectRef2, vector, quaternion, num, point1.type);
			}
			else
			{
				FireMainEffect(effectRef, vector, quaternion, num, point1.type);
			}
			FireExtraEffect(memory, vector, quaternion);
			return;
		}
		Quaternion quaternion2 = ((playSpace != SystemEffect.EffectPlaySpace.UI) ? (initRotation?.Return(memory) ?? memory.owner.GetCompPhysics()?.faceDirRot ?? (Quaternion.identity * Quaternion.Euler(0f, -90f, 0f))) : (initRotation?.Return(memory) ?? Quaternion.identity));
		if (playEffectConsiderDirection && memory.target.entity.GetFaceDir() == FaceDir.Left)
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
				transformScaleMulBase = transformScaleMulBase,
				modelType = modelType,
				isChangeWithEntity = isChangeWithEntity,
				initRotation = quaternion2,
				isAttach = false,
				motioState = motionState,
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
			float num2 = -1f;
			if (effectRangeEnum != EffectRangeEnum.none && warningEffectTime != null)
			{
				num2 = warningEffectTime.Return(memory);
			}
			effectParams.warningEffectTime = num2;
			FireMainEffect(in effectParams);
			FireExtraEffect(memory, effectParams);
		}
		else
		{
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
				transformScaleMulBase = transformScaleMulBase,
				modelType = modelType,
				isChangeWithEntity = isChangeWithEntity,
				initRotation = quaternion2,
				isAttach = false,
				motioState = motionState,
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
			float num3 = -1f;
			if (effectRangeEnum != EffectRangeEnum.none && warningEffectTime != null)
			{
				num3 = warningEffectTime.Return(memory);
			}
			effectParams2.warningEffectTime = num3;
			FireMainEffect(in effectParams2);
			FireExtraEffect(memory, effectParams2);
		}
	}

	private static bool TryGetEnvironmentHitPoint(ActionMemory memory, out Vector3 point)
	{
		point = default;
		if (!memory.target.entity.IsValid || !memory.target.entity.TryGetCompTrajectory(out CompTrajectory component) || !(component.trajectory is RuntimeGeneralTrajectory runtimeGeneralTrajectory))
		{
			return false;
		}
		return runtimeGeneralTrajectory.TryGetEnvironmentHitPoint(out point);
	}

	private void FireMainEffect(YooAssetReference effectReference, Vector3 playPosition, Quaternion rotation, float warningEffectTime, EffectPoint.EffectPointType selectedPointType)
	{
		if (CanPlayMainHitEffect(effectReference, selectedPointType, new Vector2(playPosition.x, playPosition.y)))
		{
			GameManager.effectSystem.FireEffect(effectReference, playPosition, rotation, warningEffectTime);
		}
	}

	private void FireMainEffect(in SystemEffect.EffectParams effectParams)
	{
		Vector3 touchPos = effectParams.target.TouchPos;
		if (CanPlayMainHitEffect(effectParams.patternAssetID, effectParams.point1.type, new Vector2(touchPos.x, touchPos.y)))
		{
			GameManager.effectSystem.FireEffect(effectParams);
		}
	}

	private bool CanPlayMainHitEffect(YooAssetReference effectReference, EffectPoint.EffectPointType selectedPointType, Vector2 playPosition)
	{
		if (playSpace != SystemEffect.EffectPlaySpace.World || effectRangeEnum != EffectRangeEnum.none || type != EffectDataType.Point || selectedPointType != EffectPoint.EffectPointType.HitPoint)
		{
			return true;
		}
		return GameManager.effectSystem.TryAdmitLegacySpatialEffect(effectReference, playPosition);
	}

	protected string GetRemoveWhenConfigMotionExitName(ActionMemory memory)
	{
		if (!removeWhenConfigMotionExit)
		{
			return null;
		}
		if (!string.IsNullOrEmpty(configMotionName))
		{
			return configMotionName;
		}
		if (memory.target.entity.IsValid && memory.target.entity.TryGetCompMotion(out CompMotion component) && component.layer0PeakConfig != null)
		{
			return component.layer0PeakConfig.name;
		}
		return null;
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		if (effectReferenceAssetID != null && effectReferenceAssetID.RuntimeKeyIsValid())
		{
			addlist.Add(effectReferenceAssetID);
		}
		if (effectReference1AssetID != null && effectReference1AssetID.RuntimeKeyIsValid())
		{
			addlist.Add(effectReference1AssetID);
		}
		if (!extraHitMaterialEffect || !GameLoader.meta.hitEffectComparisonTable.tableAssetID.TryGetValue(extraEffectSheet, out var value))
		{
			return;
		}
		foreach (YooAssetReference value2 in value.Values)
		{
			addlist.Add(value2);
		}
	}

	public override void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		if (collector != null)
		{
			collector.Add(effectReferenceAssetID, mapping, "ActionFireEffect");
			if (playEffectConsiderDirection)
			{
				collector.Add(effectReference1AssetID, mapping, "ActionFireEffect");
			}
		}
	}

	private void FireExtraEffect(ActionMemory memory, Vector3 pos, Quaternion rotate)
	{
		if (!extraHitMaterialEffect)
		{
			return;
		}
		YooAssetReference yooAssetReference = null;
		if (memory.target.entity.IsValid && GameLoader.meta.hitEffectComparisonTable.tableAssetID.TryGetValue(extraEffectSheet, out var value))
		{
			bool flag = ((memory.target.entity.GetConfig().postureType == PostureType.Multi) ? (!memory.target.entity.GetCompAbility().IsWeak) : (memory.target.entity.GetCompAbility().posture > 0));
			if (memory.target.entity.GetHitMaterial() < HitMaterial.Erosion_Red && flag)
			{
				return;
			}
			if (value.TryGetValue(memory.target.entity.GetHitMaterial(), out var value2))
			{
				yooAssetReference = value2;
			}
		}
		if (yooAssetReference != null)
		{
			GameManager.effectSystem.FireEffect(yooAssetReference, pos, rotate);
		}
	}

	protected void FireExtraEffect(ActionMemory memory, SystemEffect.EffectParams effectParams)
	{
		if (!extraHitMaterialEffect)
		{
			return;
		}
		YooAssetReference yooAssetReference = null;
		if (memory.target.entity != null && GameLoader.meta.hitEffectComparisonTable.tableAssetID.TryGetValue(extraEffectSheet, out var value))
		{
			bool flag = ((memory.target.entity.GetConfig().postureType == PostureType.Multi) ? (!memory.target.entity.GetCompAbility().IsWeak) : (memory.target.entity.GetCompAbility().posture > 0));
			if (memory.target.entity.GetHitMaterial() < HitMaterial.Erosion_Red && flag)
			{
				return;
			}
			if (value.TryGetValue(memory.target.entity.GetHitMaterial(), out var value2))
			{
				yooAssetReference = value2;
			}
		}
		if (yooAssetReference != null)
		{
			effectParams.patternAssetID = yooAssetReference;
			GameManager.effectSystem.FireEffect(effectParams);
		}
	}
}
