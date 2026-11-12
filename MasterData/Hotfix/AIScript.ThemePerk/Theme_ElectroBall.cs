#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_ElectroBall : BaseTheme
{
	private const string electroBallPrefab = "Misc/FateCard/Theme_electroBall";

	private static readonly int electroBallDamageTag = CommonHelper.StringToHash("electroBall");

	private readonly FP duration = 10f;

	private const string fxPath = "FX/Perk/fx_perk_loop_light_lightning_ball_01";

	private readonly FP radius = 0.5f;

	private readonly FP rotateSpeed = 180;

	private readonly FP rotateRadius = 1.2;

	private const int maxCount = 3;

	private const string triggerFxPath = "FX/Perk/fx_perk_base_light_trigger_s";

	private const int perkId_1 = 500401;

	private readonly FP trigger_Percentage1 = 100;

	private readonly FP cd_1 = 3;

	private const int hitDamageId_1 = 500401;

	private const int perkId_2 = 500402;

	private readonly FP trigger_Percentage2 = 100;

	private readonly FP cd_2 = 3;

	private const int hitDamageId_2 = 500402;

	private const int perkId_3 = 500403;

	private readonly FP trigger_Percentage3 = 100;

	private readonly FP cd_3 = 3;

	private const int hitDamageId_3 = 500403;

	private const int perkId_4 = 500404;

	private readonly FP trigger_Percentage4 = 100;

	private readonly FP cd_4 = 0.5;

	private const int hitDamageId_4 = 500404;

	private const int perkId_8 = 500408;

	private const int buffId_8 = 40811;

	private readonly Dictionary<int, int> additionalAttrIdDic_8 = new Dictionary<int, int>
	{
		[1] = 2,
		[2] = 4,
		[3] = 6,
		[4] = 5,
		[5] = 7,
		[6] = 8
	};

	private const int perkId_9 = 500409;

	private readonly FP trigger_Percentage9 = 100;

	private readonly Dictionary<int, int> buffIdDic_9 = new Dictionary<int, int>
	{
		[1] = 40911,
		[2] = 40921,
		[3] = 40931,
		[4] = 40941,
		[5] = 40951,
		[6] = 40961
	};

	private const int perkId_10 = 500410;

	private readonly FP cd_10 = 1;

	private readonly FP trigger_Percentage10 = 20;

	private static readonly int lightMarkTag = CommonHelper.StringToHash("LightTag");

	private readonly Dictionary<int, int> buffIdDic_10 = new Dictionary<int, int>
	{
		[1] = 41011,
		[2] = 41021,
		[3] = 41031,
		[4] = 41041,
		[5] = 41051,
		[6] = 41061
	};

	private const int perkId_11 = 500411;

	private const int hitDamageId_11 = 500401;

	private readonly Dictionary<int, int> addMaxCountDic_11 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 2,
		[5] = 2
	};

	private readonly Dictionary<int, FP> triggerIntervalDic_11 = new Dictionary<int, FP>
	{
		[1] = 5,
		[2] = 5,
		[3] = 5,
		[4] = 9,
		[5] = 1
	};

	private const int perkId_12 = 500412;

	private const string bulletPath_12 = "Misc/FateCard/Theme_ElectroBall_12";

	private readonly Dictionary<int, int> triggerTimeDic_12 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 16,
		[3] = 12,
		[4] = 14,
		[5] = 12
	};

	private const int perkId_13 = 500413;

	private readonly FP cd_13 = 0.3;

	private readonly FP searchRadius_13 = 10;

	private const string bulletPath_13 = "Misc/FateCard/Theme_ElectroBall_13";

	private const int perkId_14 = 500414;

	private const string bulletPath_14 = "Misc/FateCard/Theme_ElectroBall_14";

	private readonly Dictionary<int, FP> triggerIntervalDic_14 = new Dictionary<int, FP>
	{
		[1] = 10,
		[2] = 8,
		[3] = 6,
		[4] = 4,
		[5] = 2
	};

	private const int perkId_15 = 500415;

	private const string fxPath_15 = "FX/Perk/fx_perk_loop_light_lightning_ball_15";

	private readonly FP radius_15 = 1f;

	private const int additionalAttr_15 = 20;

	private readonly Dictionary<int, int> buffIdDic_15 = new Dictionary<int, int>
	{
		[1] = 41511,
		[2] = 41521,
		[3] = 41531,
		[4] = 41541,
		[5] = 41551
	};

	private const int taskPerkId_1 = 500416;

	private readonly FP searchRadius_Task_1 = 10;

	private const string bulletPath_Task_1 = "Misc/FateCard/Theme_ElectroBall_13";

	private const int taskPerkId_2 = 500417;

	private readonly FP rotateRadius_Task_2 = 1.5;

	private readonly FP rotateSpeed_Task_2 = 270;

	private const int taskPerkId_3 = 500418;

	private const int addMaxCount_Task_3 = 1;

	private const int infiniteCount_Task_3 = 2;

	private const int hitDamageId_Task_3 = 500401;

	private ElectroBallEntity _electroBallEntity;

	private int _electroBallCount;

	private CoroutineNode _perkCor_11;

	private int _perkTriggerTime_12;

	private CoroutineNode _perkCor_14;

	private int ElectroBallCount
	{
		get
		{
			return _electroBallCount;
		}
		set
		{
			if (_electroBallCount == value)
			{
				return;
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500415, out var perkLevel))
			{
				int num = value - _electroBallCount;
				int buffID = buffIdDic_15.get_Item(perkLevel);
				if (num > 0)
				{
					for (int i = 0; i < num; i++)
					{
						_actor.buffComponent.AddBuff(buffID, _actor);
					}
				}
				else if (num < 0)
				{
					for (int j = 0; j < num; j++)
					{
						_actor.buffComponent.RemoveBuffByBuffId(buffID, 1);
					}
				}
			}
			_electroBallCount = value;
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		GenerateElectroBallEntity();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500411, out var perkLevel))
		{
			_perkCor_11 = StartLogicCoroutine(CheckLogic_Perk11(triggerIntervalDic_11.get_Item(perkLevel)));
		}
		_perkTriggerTime_12 = 0;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500414, out var perkLevel2))
		{
			_perkCor_14 = StartLogicCoroutine(CheckLogic_Perk14(triggerIntervalDic_14.get_Item(perkLevel2)));
		}
	}

	private void GenerateElectroBallEntity()
	{
		string assetName = "Assets/AssetBundles/Misc/FateCard/Theme_electroBall.prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
		if (gameObject == null)
		{
			NovaLogger.Error("电球预制体不存在");
			return;
		}
		_electroBallEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, _actor.transform.position, Quaternion.identity) as ElectroBallEntity;
		if (_electroBallEntity == null)
		{
			NovaLogger.Error("实体未挂载电球组件");
			return;
		}
		_electroBallEntity.maxCount = 3;
		_electroBallEntity.duration = duration;
		_electroBallEntity.radius = radius;
		_electroBallEntity.rotateSpeed = rotateSpeed;
		_electroBallEntity.rotateRadius = rotateRadius;
		string assetName2 = "Assets/AssetBundles/FX/Perk/fx_perk_loop_light_lightning_ball_01.prefab";
		_electroBallEntity.fx = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName2, typeof(GameObject)) as GameObject;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500411, out var perkLevel))
		{
			_electroBallEntity.maxCount += addMaxCountDic_11.get_Item(perkLevel);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500415, out var perkLevel2))
		{
			_electroBallEntity.radius = radius_15;
			assetName2 = "Assets/AssetBundles/FX/Perk/fx_perk_loop_light_lightning_ball_15.prefab";
			_electroBallEntity.fx = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName2, typeof(GameObject)) as GameObject;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500417, out perkLevel2))
		{
			_electroBallEntity.rotateSpeed = rotateSpeed_Task_2;
			_electroBallEntity.rotateRadius = rotateRadius_Task_2;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500418, out perkLevel2))
		{
			_electroBallEntity.maxCount++;
			for (int i = 0; i < 2; i++)
			{
				GenerateElectroBall(500401, isInfinite: true);
			}
		}
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500401, out var _) && CheckPerkCDTimeout(500401, cd_1) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1)
		{
			GenerateElectroBall(500401);
			TriggerPerk(500401);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500402, out var _) && CheckPerkCDTimeout(500402, cd_2) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2)
		{
			GenerateElectroBall(500402);
			TriggerPerk(500402);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500403, out var _) && CheckPerkCDTimeout(500403, cd_3) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3)
		{
			GenerateElectroBall(500403);
			TriggerPerk(500403);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500404, out var _) && CheckPerkCDTimeout(500404, cd_4) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4)
		{
			GenerateElectroBall(500404);
			TriggerPerk(500404);
		}
	}

	private IEnumerator CheckLogic_Perk11(FP checkInteval)
	{
		FP interval = checkInteval;
		while (interval > 0)
		{
			if (ElectroBallCount >= _electroBallEntity.maxCount)
			{
				interval = checkInteval;
			}
			else
			{
				interval -= LogicDeltaTime;
				if (interval < 0)
				{
					GenerateElectroBall(500401);
					interval = checkInteval;
				}
			}
			yield return null;
		}
	}

	private IEnumerator CheckLogic_Perk14(FP checkInteval)
	{
		FP interval = checkInteval;
		while (interval > 0)
		{
			if (ElectroBallCount >= _electroBallEntity.maxCount)
			{
				interval -= LogicDeltaTime;
				if (interval < 0)
				{
					AdventureActor actor = _actor;
					TSVector2 position = _actor.tsTransform.Position;
					ILRuntimeAPI.Shoot("Misc/FateCard/Theme_ElectroBall_14", actor, default, default, default, position, null, AimType.Position, BulletDirectionType.BulletToTarget);
					interval = checkInteval;
				}
			}
			else
			{
				interval = checkInteval;
			}
			yield return null;
		}
	}

	public void OnUpdate()
	{
		if (_electroBallEntity != null)
		{
			ElectroBallCount = _electroBallEntity.ElectroBallCount;
		}
	}

	private void GenerateElectroBall(int hitDamageId, bool isInfinite = false)
	{
		if (_electroBallEntity == null)
		{
			return;
		}
		CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_light_trigger_s");
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500416, out var _) && ElectroBallCount >= _electroBallEntity.maxCount)
		{
			LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchRadius_Task_1);
			if (logicEntity != null)
			{
				TSVector2 firstElectroBallPosition = _electroBallEntity.GetFirstElectroBallPosition();
				AdventureActor actor = _actor;
				LogicEntity target = logicEntity;
				ILRuntimeAPI.Shoot("Misc/FateCard/Theme_ElectroBall_13", actor, default, firstElectroBallPosition, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
		_electroBallEntity.GenerateElectroBall(_actor, hitDamageId, isInfinite);
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		_ = _evt.from;
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, electroBallDamageTag))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500408, out var perkLevel) && CommonUtils.CheckHitByTag(_evt.hitDamageTag, electroBallDamageTag))
		{
			int buffNum = monsterAdventureActor.buffComponent.GetBuffNum(40811, 0);
			if (buffNum > 0)
			{
				AdventureActor.AddFromAttr(additionalAttrIdDic_8.get_Item(perkLevel), _actor, buffNum);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500415, out var _))
		{
			AdventureActor.AddFromAttr(20, _actor);
		}
	}

	protected override void OnCrit(AdventureActorReceiveCritDamageEvent _evt)
	{
		base.OnCrit(_evt);
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500413, out var _) && ElectroBallCount >= 3 && CheckPerkCDTimeout(500413, cd_13))
		{
			LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchRadius_13);
			if (logicEntity != null)
			{
				TSVector2 position = _electroBallEntity.FinishElectroBall();
				AdventureActor actor = _actor;
				LogicEntity target = logicEntity;
				ILRuntimeAPI.Shoot("Misc/FateCard/Theme_ElectroBall_13", actor, default, position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
				TriggerPerk(500413);
			}
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		AdventureActor adventureActor = _evt.to as AdventureActor;
		if (!CommonUtils.CheckHitByTag(_evt.hitDamageTag, electroBallDamageTag))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500408, out var _))
		{
			adventureActor.buffComponent?.AddBuff(40811, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500409, out var perkLevel2) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage9)
		{
			adventureActor.buffComponent?.AddBuff(buffIdDic_9.get_Item(perkLevel2), _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500410, out var perkLevel3) && CheckPerkCDTimeout(500410, cd_10) && (CommonUtils.CheckElementMark(CommonDefine.Light, adventureActor) || TSRandom.Range(FP.Zero, 100) <= trigger_Percentage10))
		{
			_actor.buffComponent.AddBuff(buffIdDic_10.get_Item(perkLevel3), _actor);
			TriggerPerk(500410);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500412, out var perkLevel4))
		{
			_perkTriggerTime_12++;
			if (_perkTriggerTime_12 >= triggerTimeDic_12.get_Item(perkLevel4))
			{
				AdventureActor actor = _actor;
				TSVector2 position = _actor.tsTransform.Position;
				ILRuntimeAPI.Shoot("Misc/FateCard/Theme_ElectroBall_12", actor, default, default, default, position, null, AimType.Position, BulletDirectionType.BulletToTarget);
				_perkTriggerTime_12 = 0;
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_electroBallEntity?.Finish();
		_electroBallEntity = null;
		if (_perkCor_11 != null)
		{
			StopLogicCoroutine(_perkCor_11);
		}
		_perkCor_11 = null;
		_perkTriggerTime_12 = 0;
		if (_perkCor_14 != null)
		{
			StopLogicCoroutine(_perkCor_14);
		}
		_perkCor_14 = null;
	}
}
