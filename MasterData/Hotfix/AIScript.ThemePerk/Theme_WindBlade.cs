#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_WindBlade : BaseTheme
{
	private const string windBladePath = "Misc/FateCard/Theme_windBlade";

	private static readonly int windBladeDamageTag = CommonHelper.StringToHash("WindBlade");

	private const string triggerFxPath = "FX/Perk/fx_perk_base_wind_trigger_s";

	private const int windBladeDefaultReboundCount = 3;

	private readonly FP shootDelay = 0.1f;

	private const string whiteWindBladeBulltKey = "WindBladeWhite";

	private readonly FP whiteWindBladeBulltSearchTargetRadius = 10;

	private const int perkId_1 = 500801;

	private readonly FP trigger_Percentage1 = 100;

	private readonly FP cd_1 = 2;

	private const int hitDamageId_1 = 500801;

	private const int perkId_2 = 500802;

	private readonly FP trigger_Percentage2 = 100;

	private readonly FP cd_2 = 2;

	private const int hitDamageId_2 = 500802;

	private const int perkId_3 = 500803;

	private readonly FP trigger_Percentage3 = 100;

	private readonly FP cd_3 = 2;

	private const int hitDamageId_3 = 500803;

	private const int perkId_4 = 500804;

	private readonly FP trigger_Percentage4 = 100;

	private readonly FP cd_4 = 2;

	private const int hitDamageId_4 = 500804;

	private const int perkId_8 = 500808;

	private readonly Dictionary<int, int> buffIdDic_8 = new Dictionary<int, int>
	{
		[1] = 80811,
		[2] = 80821,
		[3] = 80831,
		[4] = 80831,
		[5] = 80831
	};

	private const int perkId_9 = 500809;

	private readonly Dictionary<int, FP> reduceCDDic_9 = new Dictionary<int, FP>
	{
		[1] = 0.1,
		[2] = 0.15,
		[3] = 0.2,
		[4] = 0,
		[5] = 0
	};

	private readonly Dictionary<int, FP> minTriggerCDDic_9 = new Dictionary<int, FP>
	{
		[1] = 1.2,
		[2] = 1,
		[3] = 0.8,
		[4] = 0,
		[5] = 0
	};

	private const int perkId_10 = 500810;

	private readonly Dictionary<int, int> addReboundTimeDic_10 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 2,
		[4] = 0,
		[5] = 0
	};

	private readonly Dictionary<int, int> additionalAttrDic_10 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 10,
		[3] = 15,
		[4] = 7,
		[5] = 7
	};

	private const int perkId_11 = 500811;

	private const int hitDamageId_11 = 500811;

	private const string triggerFx_11 = "FX/Perk/fx_perk_hit_wind_fengren_11";

	private readonly FP triggerInterval_11 = 0.1;

	private readonly Dictionary<int, int> triggerCountDic_11 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 0,
		[5] = 0
	};

	private const int perkId_12 = 500812;

	private readonly Dictionary<int, FP> triggerRateDic_12 = new Dictionary<int, FP>
	{
		[1] = 25,
		[2] = 30,
		[3] = 35,
		[4] = 99,
		[5] = 99
	};

	private readonly Dictionary<int, string> scatteringDartsPathDic_12 = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_windBlade_White_3",
		[2] = "Misc/FateCard/Theme_windBlade_White_4",
		[3] = "Misc/FateCard/Theme_windBlade_White_5",
		[4] = "Misc/FateCard/Theme_windBlade_White_3",
		[5] = "Misc/FateCard/Theme_windBlade_White_3"
	};

	private readonly Dictionary<int, int> triggerMaxCountDic_12 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 2,
		[4] = 1,
		[5] = 1
	};

	private const int perkId_13 = 500813;

	private const int hitDamageId_13 = 500813;

	private readonly Dictionary<int, int> addCountDic_13 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 1,
		[3] = 2,
		[4] = 0,
		[5] = 0
	};

	private const int perkId_14 = 500814;

	private const string triggerFx_14 = "FX/Perk/fx_perk_base_wind_fengren_bird_end_14";

	private readonly FP cd_14 = 3;

	private readonly Dictionary<int, string> scatteringDartsPathDic_14 = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_windBlade_White_3",
		[2] = "Misc/FateCard/Theme_windBlade_White_4",
		[3] = "Misc/FateCard/Theme_windBlade_White_5",
		[4] = "Misc/FateCard/Theme_windBlade_White_3",
		[5] = "Misc/FateCard/Theme_windBlade_White_3"
	};

	private const int perkId_Tast_1 = 500816;

	private const int triggerCount_Task_1 = 15;

	private const int buffId_Task_1 = 81611;

	private readonly FP duration_Task_1 = 10;

	private readonly FP minTriggerTime_Task_1 = 0.5;

	private readonly FP maxTriggerTime_Task_1 = 1.5;

	private readonly List<string> scatteringDartsPathList_Task_1 = new List<string> { "Misc/FateCard/Theme_windBlade_White_3", "Misc/FateCard/Theme_windBlade_White_4", "Misc/FateCard/Theme_windBlade_White_5" };

	private Dictionary<string, GameObject> _scatteringDartsPrefabDic;

	private Dictionary<int, FP> _curTriggerCDDic;

	private Dictionary<int, int> _reboundCountDic;

	private Dictionary<long, int> _triggerCountDic_12;

	private int _triggerCount_Task_1;

	private CoroutineNode _taskCor_1;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_curTriggerCDDic == null)
		{
			_curTriggerCDDic = new Dictionary<int, FP>(4);
		}
		_curTriggerCDDic.Add(1, cd_1);
		_curTriggerCDDic.Add(2, cd_2);
		_curTriggerCDDic.Add(3, cd_3);
		_curTriggerCDDic.Add(4, cd_4);
		_triggerCount_Task_1 = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WINDBLADE_REBOUND", OnWindBladeRebound);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_FINISH", OnWeaponFinish);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500801, out var _))
		{
			FP cd = _curTriggerCDDic.get_Item(1);
			if (CheckPerkCDTimeout(500801, cd) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1)
			{
				ShootWindBlade(500801);
				TriggerPerk(500801);
				_curTriggerCDDic.set_Item(1, cd_1);
			}
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500802, out var _))
		{
			FP cd = _curTriggerCDDic.get_Item(2);
			if (CheckPerkCDTimeout(500802, cd) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2)
			{
				ShootWindBlade(500802);
				TriggerPerk(500802);
				_curTriggerCDDic.set_Item(2, cd_2);
			}
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500803, out var _))
		{
			FP cd = _curTriggerCDDic.get_Item(3);
			if (CheckPerkCDTimeout(500803, cd) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3)
			{
				ShootWindBlade(500803);
				TriggerPerk(500803);
				_curTriggerCDDic.set_Item(3, cd_3);
			}
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500804, out var _))
		{
			FP cd = _curTriggerCDDic.get_Item(4);
			if (CheckPerkCDTimeout(500804, cd) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4)
			{
				ShootWindBlade(500804);
				TriggerPerk(500804);
				_curTriggerCDDic.set_Item(4, cd_4);
			}
		}
	}

	private void ShootWindBlade(int hitDamageId)
	{
		CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_wind_trigger_s");
		int num = 1;
		int num2 = 3;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500810, out var perkLevel))
		{
			num2 += addReboundTimeDic_10.get_Item(perkLevel);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500813, out var perkLevel2))
		{
			num += addCountDic_13.get_Item(perkLevel2);
		}
		StartLogicCoroutine(CurShootWindBlade(num, hitDamageId, num2));
	}

	private IEnumerator CurShootWindBlade(int shootCount, int hitDamageId, int reboundTime)
	{
		int i = 0;
		while (i < shootCount)
		{
			hitDamageId = ((i == 0) ? hitDamageId : 500813);
			TSVector2 dirction = _actor.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dirction = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			AdventureWindBlade adventureWindBlade = ILRuntimeAPI.Shoot("Misc/FateCard/Theme_windBlade", _actor, _actor.tsTransform.Position, dirction) as AdventureWindBlade;
			int perkLevel;
			if (adventureWindBlade != null)
			{
				adventureWindBlade.hitDamageId = hitDamageId;
				adventureWindBlade.reboundCount = reboundTime;
				adventureWindBlade.damageImmuneDuration = -1;
				adventureWindBlade.reboundToPlayer = ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500814, out perkLevel);
			}
			else
			{
				NovaLogger.Error("释放的飞行道具非风刃");
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootDelay));
			perkLevel = i++;
		}
	}

	private void OnWeaponBorn(IEvent evt)
	{
		AdventureWeaponBornEvent adventureWeaponBornEvent = evt as AdventureWeaponBornEvent;
		if (!(adventureWeaponBornEvent.sender is AdventureWindBlade) || !(adventureWeaponBornEvent.owner is PlayerAdventureActor) || !(adventureWeaponBornEvent.sender as AdventureWindBlade != null) || !ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500816, out var _))
		{
			return;
		}
		if (!_actor.buffComponent.CheckBuffByBuffID(81611))
		{
			_triggerCount_Task_1++;
			if (_triggerCount_Task_1 >= 15)
			{
				if (_taskCor_1 != null)
				{
					StopLogicCoroutine(_taskCor_1);
				}
				_taskCor_1 = StartLogicCoroutine(CheckLogic_Task1(duration_Task_1));
				_triggerCount_Task_1 = 0;
			}
		}
		else
		{
			_triggerCount_Task_1 = 0;
		}
	}

	private IEnumerator CheckLogic_Task1(FP duration)
	{
		FP leftTime = duration;
		_actor.buffComponent.AddBuff(81611, _actor);
		FP triggerInterval = TSRandom.Range(minTriggerTime_Task_1, maxTriggerTime_Task_1);
		while (leftTime > 0)
		{
			triggerInterval -= LockStepManager.deltaTime;
			if (triggerInterval < 0)
			{
				int index = TSRandom.Range(0, scatteringDartsPathList_Task_1.Count);
				if (_scatteringDartsPrefabDic == null)
				{
					_scatteringDartsPrefabDic = new Dictionary<string, GameObject>(10);
				}
				if (!_scatteringDartsPrefabDic.ContainsKey(scatteringDartsPathList_Task_1.get_Item(index)))
				{
					string assetName = "Assets/AssetBundles/" + scatteringDartsPathList_Task_1.get_Item(index) + ".prefab";
					GameObject value = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
					_scatteringDartsPrefabDic.Add(scatteringDartsPathList_Task_1.get_Item(index), value);
				}
				GameObject gameObject = _scatteringDartsPrefabDic.get_Item(scatteringDartsPathList_Task_1.get_Item(index));
				if (gameObject != null)
				{
					SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, _actor.transform.position, Quaternion.identity);
				}
				triggerInterval = TSRandom.Range(minTriggerTime_Task_1, maxTriggerTime_Task_1);
			}
			leftTime -= LockStepManager.deltaTime;
			yield return null;
		}
		_actor.buffComponent.RemoveBuffByBuffId(81611);
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		_ = _evt.from;
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, windBladeDamageTag) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500810, out var perkLevel))
		{
			int value = 0;
			_reboundCountDic?.TryGetValue(_evt.uniqueAttackId, out value);
			if (value > 0)
			{
				AdventureActor.AddFromAttr(additionalAttrDic_10.get_Item(perkLevel), _actor, value);
			}
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		AdventureActor adventureActor = _evt.to as AdventureActor;
		if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, windBladeDamageTag))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500808, out var perkLevel))
			{
				adventureActor.buffComponent?.AddBuff(buffIdDic_8.get_Item(perkLevel), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500809, out var perkLevel2))
			{
				FP fP = reduceCDDic_9.get_Item(perkLevel2);
				FP fP2 = minTriggerCDDic_9.get_Item(perkLevel2);
				for (int i = 1; i <= 4; i++)
				{
					FP fP3 = _curTriggerCDDic.get_Item(i);
					fP3 -= fP;
					fP3 = ((fP3 >= fP2) ? fP3 : fP2);
					_curTriggerCDDic.set_Item(i, fP3);
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500811, out var perkLevel3))
			{
				StartLogicCoroutine(CheckLogic_Perk11(_actor, adventureActor, triggerCountDic_11.get_Item(perkLevel3)));
			}
		}
		AdventureWindBlade adventureWindBlade = _evt.weapon as AdventureWindBlade;
		if (!(adventureWindBlade != null) || !(adventureWindBlade.owner is PlayerAdventureActor) || !ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500812, out var perkLevel4))
		{
			return;
		}
		if (_triggerCountDic_12 == null)
		{
			_triggerCountDic_12 = new Dictionary<long, int>(10);
		}
		bool flag = _triggerCountDic_12.TryGetValue(adventureWindBlade.Id, out var value);
		if (value < triggerMaxCountDic_12.get_Item(perkLevel4) && TSRandom.Range(FP.Zero, 100) <= triggerRateDic_12.get_Item(perkLevel4))
		{
			if (_scatteringDartsPrefabDic == null)
			{
				_scatteringDartsPrefabDic = new Dictionary<string, GameObject>(10);
			}
			if (!_scatteringDartsPrefabDic.ContainsKey(scatteringDartsPathDic_12.get_Item(perkLevel4)))
			{
				string assetName = "Assets/AssetBundles/" + scatteringDartsPathDic_12.get_Item(perkLevel4) + ".prefab";
				GameObject value2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
				_scatteringDartsPrefabDic.Add(scatteringDartsPathDic_12.get_Item(perkLevel4), value2);
			}
			GameObject gameObject = _scatteringDartsPrefabDic.get_Item(scatteringDartsPathDic_12.get_Item(perkLevel4));
			if (gameObject != null)
			{
				SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, adventureWindBlade.transform.position, Quaternion.identity);
			}
			if (flag)
			{
				_triggerCountDic_12.get_Item(adventureWindBlade.Id)++;
			}
			else
			{
				_triggerCountDic_12.Add(adventureWindBlade.Id, 1);
			}
		}
	}

	private IEnumerator CheckLogic_Perk11(AdventureActor actor, AdventureActor target, int triggerCount)
	{
		int count = 0;
		while (count < triggerCount && !target.IsDead())
		{
			ILRuntimeAPI.HitActor(actor, target, 500811, "FX/Perk/fx_perk_hit_wind_fengren_11", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			count++;
			yield return triggerInterval_11;
		}
	}

	private void OnWindBladeRebound(IEvent evt)
	{
		WindBladeReboundEvent windBladeReboundEvent = evt as WindBladeReboundEvent;
		if (windBladeReboundEvent.owner is PlayerAdventureActor)
		{
			if (_reboundCountDic == null)
			{
				_reboundCountDic = new Dictionary<int, int>(10);
			}
			if (_reboundCountDic.ContainsKey(windBladeReboundEvent.windBlade.uniqueAttackId))
			{
				_reboundCountDic.get_Item(windBladeReboundEvent.windBlade.uniqueAttackId)++;
			}
			else
			{
				_reboundCountDic.Add(windBladeReboundEvent.windBlade.uniqueAttackId, 1);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500814, out var perkLevel) && windBladeReboundEvent.reboundWithPlayer && CheckPerkCDTimeout(500814, cd_14))
		{
			CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_wind_fengren_bird_end_14");
			if (_scatteringDartsPrefabDic == null)
			{
				_scatteringDartsPrefabDic = new Dictionary<string, GameObject>(10);
			}
			if (!_scatteringDartsPrefabDic.ContainsKey(scatteringDartsPathDic_14.get_Item(perkLevel)))
			{
				string assetName = "Assets/AssetBundles/" + scatteringDartsPathDic_14.get_Item(perkLevel) + ".prefab";
				GameObject value = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
				_scatteringDartsPrefabDic.Add(scatteringDartsPathDic_14.get_Item(perkLevel), value);
			}
			GameObject gameObject = _scatteringDartsPrefabDic.get_Item(scatteringDartsPathDic_14.get_Item(perkLevel));
			if (gameObject != null)
			{
				SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, windBladeReboundEvent.windBlade.transform.position, Quaternion.identity);
			}
			TriggerPerk(500814);
		}
	}

	private void OnWeaponFinish(IEvent evt)
	{
		AdventureWindBlade adventureWindBlade = (evt as AdventureWeaponFinishEvent).sender as AdventureWindBlade;
		if (!(adventureWindBlade == null))
		{
			_reboundCountDic?.Remove(adventureWindBlade.uniqueAttackId);
			_triggerCountDic_12?.Remove(adventureWindBlade.Id);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner is PlayerAdventureActor && adventureBulletBornEvent.tag.Equals("WindBladeWhite"))
		{
			AdventureBezierBullet adventureBezierBullet = adventureBulletBornEvent.sender as AdventureBezierBullet;
			if (adventureBezierBullet != null)
			{
				LogicEntity target = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, whiteWindBladeBulltSearchTargetRadius);
				adventureBezierBullet.target = target;
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WINDBLADE_REBOUND", OnWindBladeRebound);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_FINISH", OnWeaponFinish);
		_curTriggerCDDic?.Clear();
		_reboundCountDic?.Clear();
		_triggerCountDic_12?.Clear();
		if (_taskCor_1 != null)
		{
			StopLogicCoroutine(_taskCor_1);
		}
		_triggerCount_Task_1 = 0;
	}
}
