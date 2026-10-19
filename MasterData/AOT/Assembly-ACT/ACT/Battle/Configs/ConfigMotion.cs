using System;
using System.Collections.Generic;
using ACT.MultiPlayer;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle.Configs;

public class ConfigMotion : LuminSerializedScriptableObject
{
	public struct CurveTimeRange(float startTime, float endTime)
	{
		public readonly float startTime = startTime;

		public readonly float endTime = endTime;
	}

	[Tooltip("enemy的state要填一个ID,行为树调用状态机的时候会用到")]
	public int continueousSkillMark;

	[Tooltip("技能数值表ID")]
	public int skillDetailId;

	public AnimationClip clip;

	public float speed = 1f;

	public AnimationSchema schema;

	public FaceDir changFaceDir;

	[Tooltip("一般填none")]
	public FaceDir dir;

	[Range(0f, 1f)]
	public float changeFaceDirTiming;

	[FormerlySerializedAs("useRootMotion")]
	public bool _useRootMotion;

	[FormerlySerializedAs("rootMotion")]
	public AnimationCurve forwardCurve;

	public AnimationCurve rightCurve;

	[FormerlySerializedAs("useYMotion")]
	public bool _useYMotion;

	[FormerlySerializedAs("yMotion")]
	public AnimationCurve upCurve;

	[Header("Root Rotation")]
	[FormerlySerializedAs("useYRotation")]
	public bool _useYRotation;

	public AnimationCurve yEulerCurve;

	public bool _useDynamicYScale;

	public bool _useEnvCompensation;

	[HideInInspector]
	public List<CurveTimeRange> upRanges = new List<CurveTimeRange>();

	[Tooltip("勾选时动作不可以出悬崖")]
	[FormerlySerializedAs("canOffCliff")]
	public bool cantOffCliff = true;

	[Tooltip("勾选时该动作是第一个技能")]
	public bool isFirstMotion;

	[Tooltip("由策划配置动作的大类；与二级类型共同描述业务归属")]
	public MotionPrimaryTypeTag motionPrimaryTypeTag;

	[Tooltip("由策划配置动作的细分类型；不再由程序推导父子归属")]
	public MotionTypeTag motionTypeTag;

	public bool enableInputMotion;

	public AnimationCurve inputMotionScale;

	public ConfigMotionTag[] motionTags;

	[HideInInspector]
	[Tooltip("实际动作值")]
	public EndureType endureLevel = EndureType.Light;

	public ConfigEndureLevel[] endureLevels;

	[HideInInspector]
	public ConfigFunction<float> recoverUltimateEnergyValue;

	public ConfigFunction<float> normalEnergyValue;

	public ConfigFunction<float> assistValue;

	public ConfigFunction<float> specialEnergyValue;

	[Space(20f)]
	public ConfigAttachPointCurve attachPointCurve;

	public AttackPattern[] attacks;

	[Space(20f)]
	public CompensationPattern[] compensations;

	[Space(20f)]
	public PerformanceItem[] performances;

	[FormerlySerializedAs("changeDirFrames")]
	[Space(20f)]
	public ConfigTriggerAbility[] triggerAbilities;

	[Space(20f)]
	public PhysicsOverride[] physicsOverrides;

	public ECM2Override[] ecm2Overrides;

	public VolumeLayerItem[] volumeClips;

	public bool RootMotionXZ => _useRootMotion;

	public bool RootMotionY => _useYMotion;

	public bool RootRotation => _useYRotation;

	public void Precache(List<YooAssetReference> list)
	{
		try
		{
			if (attacks != null)
			{
				AttackPattern[] array = attacks;
				for (int i = 0; i < array.Length; i++)
				{
					array[i]?.Precache(list);
				}
			}
			if (compensations != null)
			{
				CompensationPattern[] array2 = compensations;
				for (int i = 0; i < array2.Length; i++)
				{
					array2[i]?.Precache(list);
				}
			}
			if (performances != null)
			{
				PerformanceItem[] array3 = performances;
				for (int i = 0; i < array3.Length; i++)
				{
					array3[i]?.Precache(list);
				}
			}
			if (triggerAbilities != null)
			{
				ConfigTriggerAbility[] array4 = triggerAbilities;
				for (int i = 0; i < array4.Length; i++)
				{
					array4[i]?.Precache(list);
				}
			}
			if (volumeClips != null)
			{
				VolumeLayerItem[] array5 = volumeClips;
				for (int i = 0; i < array5.Length; i++)
				{
					array5[i]?.Precache(list);
				}
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"预加载动作{this}时出错！");
			}
		}
	}

	public void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		if (collector == null)
		{
			return;
		}
		if (attacks != null)
		{
			for (int i = 0; i < attacks.Length; i++)
			{
				attacks[i]?.CollectEffectPrewarm(collector, mapping);
			}
		}
		if (performances == null)
		{
			return;
		}
		for (int j = 0; j < performances.Length; j++)
		{
			if (performances[j] is EffectItem effectItem)
			{
				effectItem.CollectEffectPrewarm(collector, mapping);
			}
		}
	}

	protected override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		if (attacks == null)
		{
			return;
		}
		AttackPattern[] array = attacks;
		foreach (AttackPattern attackPattern in array)
		{
			if (attackPattern.filterEntityType == FilterEntityType.Null)
			{
				attackPattern.filterEntityType = GameUtility.defaultFilterEntityType;
			}
		}
	}

	public List<ConfigAction[]> GenerateActionList()
	{
		List<ConfigAction[]> list = new List<ConfigAction[]>();
		if (attacks != null)
		{
			AttackPattern[] array = attacks;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].CacheActionList(list, null);
			}
		}
		return list;
	}
}
