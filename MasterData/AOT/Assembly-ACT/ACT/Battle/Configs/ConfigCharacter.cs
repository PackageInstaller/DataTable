using System;
using System.Collections.Generic;
using ACT.Sound;
using Cinemachine;
using FMODUnity;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Battle.Configs;

public class ConfigCharacter : ScriptableObject
{
	public ConfigMotionStateMachine moveFSM;

	public ConfigAttackStateMachine attackFSM;

	public AttackFSMVariant[] attackFSMVariants;

	public OverrideMotion[] moveMotions;

	public OverrideMotion[] attackMotions;

	[Tooltip("用于不同骨骼结构的角色覆盖状态机的AvatarMask（如分层受击动画层）")]
	public OverrideLayer[] moveLayerOverrides;

	public ConfigCustomStateChange stateChangeActions;

	public GameObject prefab;

	public AbilitiyBinding[] abilitiyBindings;

	[Tooltip("和数值养成无关的技能")]
	public string[] abilities = Array.Empty<string>();

	public SkillConfig[] skills;

	public AssistSkillConfig[] assistSkills;

	public int[] rogueSkillGroup;

	[Tooltip("武器配置，只有角色才用")]
	public ConfigWeapon weapon;

	public CharacterWeightType characterWeightType;

	public int endureLevel;

	public int assistValue = 100;

	public int assistCost = 100;

	public int beHitAssistValue = 5;

	public float beHitAssistCD = 1f;

	public int perfectDodgeAssistRecover;

	[HideInInspector]
	[Tooltip("下落时间<=土狼时间时，角色还是可以进行一段跳")]
	public float coyoteTime = 0.1f;

	public int jumpInAirCount = 1;

	public int jumpOffWallInAirCount = 1;

	public int dogeInAirCount = 999;

	public int airAttackCount = 1;

	[FormerlySerializedAs("switchOffset")]
	[FormerlySerializedAs("surpportOffest")]
	public Vector2 switchSkillOffset;

	public Vector2 switchOffset;

	[SerializeField]
	private bool _useAirOffset;

	[SerializeField]
	private Vector2 _airSwitchSkillOffset;

	[SerializeField]
	private Vector2 _airSwitchOffset;

	public TargetBounds switchSkillForwardBounds;

	public TargetBounds switchSkillBackBounds;

	public TargetBounds forwardBounds;

	public TargetBounds backBounds;

	[SerializeField]
	private bool _useBattleCharacterOffset;

	[SerializeField]
	private Vector2 _battlecharacterOffset;

	[SerializeField]
	private bool _useAirBattleCharacterOffset;

	[SerializeField]
	private Vector2 _airBattlecharacterOffset;

	[SerializeField]
	private bool _useSwitchSkillCharacterOffset;

	[SerializeField]
	private Vector2 _switchSkillharacterOffset;

	[SerializeField]
	private bool _useAirSwitchSkillCharacterOffset;

	[SerializeField]
	private Vector2 _airSwitchSkillharacterOffset;

	public bool canTransInAir;

	public YooAssetReference ultimetaTimelineAssetID;

	[Tooltip("表示是否是怪物,给策划方便看配置用的")]
	public bool IsMonster;

	[Tooltip("这个怪物会有哪些AI，就直接加到这里")]
	public AIConfig[] AIConfig;

	public List<AIBornBehaviorClass> aiBornBehavior;

	public MonsterAttackType MonsterAttackType;

	[Tooltip("只能地面移动和下落：不能走跳跃边。能跳跃和下落：可以走跳跃边到墙顶再落下。")]
	public MonsterNavigationMoveAbility navigationMoveAbility;

	[HideInInspector]
	public ConfigGroundLightDiePara configGroundLightDiePara;

	public YooAssetReference monsterUltimetaTimelineAssetID;

	public MonsterWeigtType monsterWeigtType;

	[Tooltip("仅普通/风格受击跳字生效；本次没有有效BodyPart时自动回退实体位置。")]
	public bool damageNumberUseHitBodyPartPosition;

	public float dieForcceZoom = 1f;

	public AnimationSchema animationSchema;

	public EnemyRace enemyRace;

	public float enemyPostureEffectScale = 1f;

	public float weakTime = 1f;

	[Obsolete]
	public float postureDmgIncrease;

	[Obsolete]
	public float postureDmgResistance;

	public bool defaultActivePosture = true;

	[HideInInspector]
	[Obsolete]
	public float postureDmgAnorm;

	[FormerlySerializedAs("potureType")]
	public PostureType postureType;

	public float[] posturePercent = new float[2] { 0.5f, 1f };

	public WeakEndMode weakEndMode;

	public bool enterWeakWhenBreakPosture = true;

	public HitMaterial hitMaterial;

	[HideInInspector]
	[Obsolete]
	public ConfigGlobalSpeed hitGlobalSpeed;

	[HideInInspector]
	public anomalyConfig[] anomalyConfig;

	[Tooltip("实际血条位置= 小怪、精英怪的脚底位置+ 小怪、精英怪的血条偏移位置")]
	public Vector3 MonsterUIPosOffset = new Vector3(0f, 0.2f, 0f);

	public YooAssetReference bornEffectAssetID;

	public EventReference battleMusic;

	public AudioEventReference audioBattleMusic;

	public List<YooAssetReference> fmodBanksAssetID = new List<YooAssetReference>();

	public EMaterial eMaterial;

	public CharacterAudioConfig audioConfig;

	[Tooltip("这个角色/怪物的cinemachine相机")]
	public GameObject cameras;

	[Tooltip("cinemachine")]
	public CameraConfig cameraConfig;

	public CinemachineBlenderSettings cinemachineSettings;

	public ConfigPhysics physics;

	public MotionType motionType;

	public bool enableRootMotionWhenPhysicsNone;

	public float mass = 50f;

	[Tooltip("推动其他人物的动量，角色默认0即可，敌人默认1000（暂时）")]
	[FormerlySerializedAs("defaultPushImpetus")]
	public float pushImpetusBase;

	public uint pushImpetusCurve;

	public bool UseAirOffset => _useAirOffset;

	public Vector2 AirSwitchSkillOffset => _airSwitchSkillOffset;

	public Vector2 AirSwitchOffset => _airSwitchOffset;

	public bool UseBattleCharacterOffset => _useBattleCharacterOffset;

	public Vector2 BattleCharacterOffset => _battlecharacterOffset;

	public bool UseAirBattleCharacterOffset => _useAirBattleCharacterOffset;

	public Vector2 AirBattleCharacterOffset => _airBattlecharacterOffset;

	public bool UseSwitchSkillCharacterOffset => _useSwitchSkillCharacterOffset;

	public Vector2 SwitchSkillCharacterOffset => _switchSkillharacterOffset;

	public bool UseAirSwitchSkillCharacterOffset => _useAirSwitchSkillCharacterOffset;

	public Vector2 AirSwitchSkillCharacterOffset => _airSwitchSkillharacterOffset;

	public bool TryGetAttackFSMSwitchTarget(string id, out ConfigAttackStateMachine fsm, out ConfigAttackFSMOverlay overlay)
	{
		if (string.IsNullOrEmpty(id) || id == "default")
		{
			fsm = attackFSM;
			overlay = null;
			return fsm != null;
		}
		if (attackFSMVariants != null)
		{
			for (int i = 0; i < attackFSMVariants.Length; i++)
			{
				AttackFSMVariant attackFSMVariant = attackFSMVariants[i];
				if (attackFSMVariant != null && !(attackFSMVariant.id != id))
				{
					if (attackFSMVariant.mode == AttackFSMVariantMode.FullGraph && attackFSMVariant.fsm != null)
					{
						fsm = attackFSMVariant.fsm;
						overlay = null;
						return true;
					}
					if (attackFSMVariant.mode == AttackFSMVariantMode.Overlay && attackFSM != null && attackFSMVariant.overlay != null)
					{
						fsm = attackFSM;
						overlay = attackFSMVariant.overlay;
						return true;
					}
				}
			}
		}
		fsm = null;
		overlay = null;
		return false;
	}

	public void Precache(List<YooAssetReference> list)
	{
		OverrideMotion[] array = moveMotions;
		for (int i = 0; i < array.Length; i++)
		{
			OverrideMotion overrideMotion = array[i];
			if (overrideMotion.motion != null)
			{
				overrideMotion.motion.Precache(list);
			}
		}
		array = attackMotions;
		for (int i = 0; i < array.Length; i++)
		{
			OverrideMotion overrideMotion2 = array[i];
			if (overrideMotion2.motion != null)
			{
				overrideMotion2.motion.Precache(list);
			}
		}
	}

	public void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
		if (collector == null)
		{
			return;
		}
		if (moveMotions != null)
		{
			for (int i = 0; i < moveMotions.Length; i++)
			{
				moveMotions[i].motion?.CollectEffectPrewarm(collector, mapping);
			}
		}
		if (attackMotions != null)
		{
			for (int j = 0; j < attackMotions.Length; j++)
			{
				attackMotions[j].motion?.CollectEffectPrewarm(collector, mapping);
			}
		}
		if (EngineConfigs.ability == null)
		{
			return;
		}
		CollectAbilityNames(abilities, collector, mapping);
		if (abilitiyBindings != null)
		{
			for (int k = 0; k < abilitiyBindings.Length; k++)
			{
				CollectAbilityNames(abilitiyBindings[k].abilitiyNames, collector, mapping);
			}
		}
	}

	private static void CollectAbilityNames(string[] abilityNames, EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping)
	{
		if (abilityNames == null)
		{
			return;
		}
		foreach (string text in abilityNames)
		{
			if (!string.IsNullOrEmpty(text) && EngineConfigs.ability.TryGetValue(text, out var value))
			{
				value?.CollectEffectPrewarm(collector, mapping);
			}
		}
	}
}
