using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_FireWave : BaseTheme
{
	private const string path_FireWaveBullet = "Misc/FateCard/Theme_fireWave";

	private const string path_FireWaveBullet_11 = "Misc/FateCard/Theme_fireWave_11";

	private const string path_FireWaveBullet_12 = "Misc/FateCard/Theme_fireWave_12";

	private const string path_FireWaveBullet_11_12 = "Misc/FateCard/Theme_fireWave_11_12";

	private readonly FP circleRadius = 5;

	private readonly FP speed = 15;

	private static readonly int fireWaveTag = CommonHelper.StringToHash("fireWave");

	private readonly int fireWaveDamageTag = CommonHelper.StringToHash("fireWave");

	private const string triggerFxPath = "FX/Perk/fx_perk_base_fire_trigger_s";

	private static readonly int fireBuffTag = CommonHelper.StringToHash("BuffTag_FireWave");

	private const int perkId_1 = 500201;

	private readonly FP trigger_Percentage1 = 100;

	private readonly FP cd_1 = 3;

	private const int hitDamageId_1 = 500201;

	private const int perkId_2 = 500202;

	private readonly FP trigger_Percentage2 = 100;

	private readonly FP cd_2 = 3;

	private const int hitDamageId_2 = 500202;

	private const int perkId_3 = 500203;

	private readonly FP trigger_Percentage3 = 100;

	private readonly FP cd_3 = 3;

	private const int hitDamageId_3 = 500203;

	private const int perkId_4 = 500204;

	private readonly FP trigger_Percentage4 = 100;

	private readonly FP cd_4 = 3;

	private const int hitDamageId_4 = 500204;

	private const int perkId_8 = 500208;

	private readonly FP cd_8 = 0;

	private const int triggerCount = 3;

	private readonly Dictionary<int, int> buffIdDic_8 = new Dictionary<int, int>
	{
		[1] = 20811,
		[2] = 20821,
		[3] = 20831,
		[4] = 20841,
		[5] = 20851,
		[6] = 20861
	};

	private const int perkId_9 = 500209;

	private readonly FP cd_9 = 0;

	private readonly Dictionary<int, int> attriIdDic_9 = new Dictionary<int, int>
	{
		[1] = 20911,
		[2] = 20921,
		[3] = 20931,
		[4] = 20941,
		[5] = 20951,
		[6] = 20961
	};

	private const int perkId_10 = 500210;

	private readonly FP cd_10 = 0;

	private readonly int _actorSkillOrUltraTag = CommonHelper.StringToHash("_actorSkillorUltraTag");

	private readonly Dictionary<int, int> attriIdDic_10 = new Dictionary<int, int>
	{
		[1] = 21011,
		[2] = 21021,
		[3] = 21031,
		[4] = 21041,
		[5] = 21051,
		[6] = 21061
	};

	private const int perkId_11 = 500211;

	private readonly Dictionary<int, int> attrIdDic_11 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120
	};

	private const int perkId_12 = 500212;

	private readonly FP speed_12 = 25;

	private readonly Dictionary<int, int> attriIdDic_12 = new Dictionary<int, int>
	{
		[1] = 35,
		[2] = 70,
		[3] = 105
	};

	private const int perkId_13 = 500213;

	private readonly FP range_13 = 5;

	private const string fxPath_13 = "FX/Perk/fx_perk_base_fire_flame_wave_burn_13";

	private readonly Dictionary<int, int> dicHitId_13 = new Dictionary<int, int>
	{
		[1] = 500213,
		[2] = 500219,
		[3] = 500220
	};

	private const int perkId_14 = 500214;

	private static readonly int fireMarkTag = CommonHelper.StringToHash("FireTag");

	private readonly FP range_14 = 10;

	private const string path_Bullet14 = "Misc/FateCard/Theme_fireWave_14";

	private const int hitDamageId_14 = 500214;

	private readonly Dictionary<int, int> dicCD_14 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3
	};

	private readonly Dictionary<int, int> dicTriggerPercent_14 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 45,
		[3] = 60
	};

	private readonly Dictionary<int, int> dicNum_14 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3
	};

	private const int perkId_15 = 500215;

	private readonly FP cd_15 = 0;

	private readonly Dictionary<int, int> attriIdDic_15 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150
	};

	private readonly FP minOffsetAngle = -60;

	private readonly FP maxOffsetAngle = 60;

	private const int perkId_1p = 500216;

	private readonly FP re_cd = 0.25;

	private readonly FP re_cdMax = 1.5;

	private const int perkId_2p = 500217;

	private readonly FP cd_2p = 0;

	private readonly FP fixPercent = 300;

	private const string bomFxPath = "FX/Perk/fx_perk_base_fire_flame_wave_burn_13q02";

	private const int perkId_3p = 500218;

	private readonly FP cd_3p = 15;

	private readonly int buffId_3p = 10800001;

	private Dictionary<string, GameObject> _fireWavePrefabDic;

	private Dictionary<long, int> _bulletHitCountDic;

	private Dictionary<long, long> _bulletReflectSet;

	private FP reCd;

	private Dictionary<long, long> _perk11Dic;

	private List<long> _perk3Pls;

	public override void OnEnable()
	{
		base.OnEnable();
		reCd = 0;
		_fireWavePrefabDic = new Dictionary<string, GameObject>(4);
		_perk11Dic = new Dictionary<long, long>(5);
		_perk3Pls = new List<long>(3);
		_bulletReflectSet = new Dictionary<long, long>(10);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_REFLECT", OnBulletReflect);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REPEAT_REFRESH_BUFF", OnActorRefreshBuff);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500201, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage1 && CheckPerkCD(500201, GetFixedCD(cd_1)))
		{
			reCd = 0;
			ShootFireWave(500201);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500202, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage2 && CheckPerkCD(500202, GetFixedCD(cd_2)))
		{
			reCd = 0;
			ShootFireWave(500202);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500203, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage3 && CheckPerkCD(500203, GetFixedCD(cd_3)))
		{
			reCd = 0;
			ShootFireWave(500203);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500204, out var _) && TSRandom.Range(FP.Zero, 100) <= trigger_Percentage4 && CheckPerkCD(500204, GetFixedCD(cd_4)))
		{
			reCd = 0;
			ShootFireWave(500204);
		}
	}

	private void ShootFireWave(int hitDamageId)
	{
		LogicEntity attackTarget = _actor.attackTarget;
		attackTarget = ((attackTarget != null) ? attackTarget : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (attackTarget == null)
		{
			return;
		}
		CommonUtils.PlayOneOffFx(_actor, "FX/Perk/fx_perk_base_fire_trigger_s");
		GameObject fireWavePrefab = GetFireWavePrefab();
		TSVector2 normalized = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
		AdventureBullet obj = _actor.shootBehaviour.Shoot(fireWavePrefab, _actor.tsTransform.Position, null, normalized) as AdventureBullet;
		obj.ResetHitID(hitDamageId);
		obj.moveSpeed = speed;
		obj.velocitySpeed = speed;
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500213, out var level_13))
		{
			return;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, range_13, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int i = 0; i < result.Count; i++)
				{
					MonsterAdventureActor monsterAdventureActor = result.get_Item(i) as MonsterAdventureActor;
					if (monsterAdventureActor != null && monsterAdventureActor.buffComponent != null && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(fireBuffTag))
					{
						ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, dicHitId_13.get_Item(level_13));
						CommonUtils.PlayOneOffFx(monsterAdventureActor, "FX/Perk/fx_perk_base_fire_flame_wave_burn_13");
					}
				}
			}
		}, isConfront: true);
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		AdventureActor obj = _evt.from as AdventureActor;
		if (obj != null && monsterAdventureActor != null && monsterAdventureActor.buffComponent != null && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(fireBuffTag))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500209, out var perkLevel) && CheckPerkCD(500209, cd_9))
			{
				AdventureActor.AddFromAttr(attriIdDic_9.get_Item(perkLevel), _actor);
			}
			if (CommonUtils.CheckHitByTag(_evt.hitDamageTag, _actorSkillOrUltraTag) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500210, out var perkLevel2) && CheckPerkCD(500210, cd_10))
			{
				AdventureActor.AddFromAttr(attriIdDic_10.get_Item(perkLevel2), _actor);
			}
			if (_evt.weapon != null)
			{
				if (_perk3Pls != null && !_perk3Pls.Contains(_evt.weapon.Id) && CanTriggerPerk(500218, out var _, cd_3p))
				{
					_perk3Pls.Add(_evt.weapon.Id);
				}
				if (_perk3Pls != null && _perk3Pls.Contains(_evt.weapon.Id))
				{
					monsterAdventureActor.buffComponent.AddBuff(buffId_3p, _actor);
				}
			}
		}
		if (!(obj != null) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, fireWaveDamageTag))
		{
			return;
		}
		if (monsterAdventureActor != null && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500211, out var perkLevel3))
		{
			if (!_perk11Dic.ContainsKey(_evt.weapon.Id))
			{
				_perk11Dic.Add(_evt.weapon.Id, monsterAdventureActor.Id);
			}
			if (_perk11Dic.get_Item(_evt.weapon.Id) != monsterAdventureActor.Id)
			{
				AdventureActor.AddFromAttr(attrIdDic_11.get_Item(perkLevel3), _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500212, out var perkLevel4))
		{
			long key = ((_evt.weapon != null) ? _evt.weapon.Id : 0);
			if (monsterAdventureActor != null && _bulletReflectSet.ContainsKey(key) && _bulletReflectSet.get_Item(key) != monsterAdventureActor.Id)
			{
				_bulletReflectSet.set_Item(key, monsterAdventureActor.Id);
				AdventureActor.AddFromAttr(attriIdDic_12.get_Item(perkLevel4), _actor);
			}
		}
		if (CanTriggerPerk(500215, out var lv2, cd_15))
		{
			AdventureActor.AddFromAttr(attriIdDic_15.get_Item(lv2), _actor);
		}
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent _evt)
	{
		base.OnHitPre(_evt);
		if (_evt.from != _actor)
		{
			return;
		}
		for (int i = 0; i < _evt.hitDamageTag.Count; i++)
		{
			if (!object.Equals(_evt.hitDamageTag.get_Item(i), fireWaveDamageTag))
			{
				continue;
			}
			long num = ((_evt.weapon != null) ? _evt.weapon.Id : 0);
			if (num > 0)
			{
				if (_bulletHitCountDic == null)
				{
					_bulletHitCountDic = new Dictionary<long, int>(10);
				}
				if (_bulletHitCountDic.ContainsKey(num))
				{
					_bulletHitCountDic.get_Item(num)++;
				}
				else
				{
					_bulletHitCountDic.Add(num, 1);
				}
			}
			AdventureActor target = _evt.to as AdventureActor;
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500208, out var perkLevel) && num > 0 && CheckPerkCDTimeout(500208, cd_8) && _bulletHitCountDic.get_Item(num) == 3)
			{
				_actor.buffComponent.AddBuff(buffIdDic_8.get_Item(perkLevel), _actor);
				TriggerPerk(500208);
			}
			if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500214, out var level_14) || (!CommonUtils.CheckElementMark(CommonDefine.Fire, target) && TSRandom.Range(0, 100) >= dicTriggerPercent_14.get_Item(level_14)) || !CheckPerkCD(500214, dicCD_14.get_Item(level_14)))
			{
				break;
			}
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, target.tsTransform.Position, range_14, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					for (int num2 = result.Count - 1; num2 > -1; num2--)
					{
						if (result.get_Item(num2).Id == target.Id)
						{
							result.RemoveAt(num2);
							break;
						}
					}
				}
				if (result.Count > 0)
				{
					int num3 = dicNum_14.get_Item(level_14);
					num3 = ((num3 >= result.Count) ? result.Count : num3);
					for (int j = 0; j < num3; j++)
					{
						MonsterAdventureActor monsterAdventureActor = result.get_Item(j) as MonsterAdventureActor;
						if (monsterAdventureActor != null)
						{
							TSVector2 normalized = (monsterAdventureActor.tsTransform.Position - target.tsTransform.Position).normalized;
							_actor.shootBehaviour.Shoot(getFireBulletPrefab("Misc/FateCard/Theme_fireWave_14"), target.tsTransform.Position, null, normalized).ResetHitID(500214);
						}
					}
				}
			}, isConfront: true);
			break;
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		_ = _evt.from != _actor;
	}

	private void OnBulletReflect(IEvent evt)
	{
		AdventureBullet adventureBullet = (evt as AdventureBulletReflectEvent).sender as AdventureBullet;
		if (!(adventureBullet == null) && adventureBullet.owner == _actor && adventureBullet.CheckBulletTag(fireWaveTag) && !_bulletReflectSet.ContainsKey(adventureBullet.Id))
		{
			adventureBullet.moveSpeed = speed_12;
			adventureBullet.velocitySpeed = speed_12;
			_bulletReflectSet.Add(adventureBullet.Id, 1L);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner == _actor && object.Equals(adventureBulletFinishEvent.tag, fireWaveTag))
		{
			AdventureBullet adventureBullet = adventureBulletFinishEvent.sender as AdventureBullet;
			if (_bulletHitCountDic != null && _bulletHitCountDic.ContainsKey(adventureBullet.Id))
			{
				_bulletHitCountDic.Remove(adventureBullet.Id);
			}
			if (_bulletHitCountDic != null && _bulletHitCountDic.ContainsKey(adventureBullet.Id))
			{
				_bulletHitCountDic.Remove(adventureBullet.Id);
			}
			if (_bulletReflectSet != null && _bulletReflectSet.ContainsKey(adventureBullet.Id))
			{
				_bulletReflectSet.Remove(adventureBullet.Id);
			}
			if (_perk11Dic != null && _perk11Dic.ContainsKey(adventureBullet.Id))
			{
				_perk11Dic.Remove(adventureBullet.Id);
			}
			if (_perk3Pls != null && _perk3Pls.Contains(adventureBullet.Id))
			{
				_perk3Pls.Remove(adventureBullet.Id);
			}
		}
	}

	private void OnActorGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor) && CanTriggerPerk(500216, out var _, 0) && adventureActorGetBuff.eventInfo.buffTags.Contains(fireBuffTag))
		{
			reCd += re_cd;
			reCd = ((reCd > re_cdMax) ? re_cdMax : reCd);
		}
	}

	private void OnActorRefreshBuff(IEvent evt)
	{
		AdventureActorRepeatRefreshBuff adventureActorRepeatRefreshBuff = evt as AdventureActorRepeatRefreshBuff;
		if (CanTriggerPerk(500217, out var _, cd_2p) && adventureActorRepeatRefreshBuff.buffEntity.CheckBuffTag(fireBuffTag))
		{
			_ = adventureActorRepeatRefreshBuff.buffEntity.GetBuffAllActiveEffects().Count;
			_ = 0;
		}
	}

	private FP GetFixedCD(FP cd)
	{
		FP fP = cd - reCd;
		if (!(fP > 0))
		{
			return 0;
		}
		return fP;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_REFLECT", OnBulletReflect);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_REPEAT_REFRESH_BUFF", OnActorRefreshBuff);
		reCd = 0;
		_fireWavePrefabDic?.Clear();
		_fireWavePrefabDic = null;
		_perk3Pls?.Clear();
		_perk3Pls = null;
		_bulletHitCountDic?.Clear();
		_bulletHitCountDic = null;
		_perk11Dic?.Clear();
		_perk11Dic = null;
		_bulletReflectSet?.Clear();
		_bulletReflectSet = null;
	}

	private GameObject GetFireWavePrefab()
	{
		string curPath = "Misc/FateCard/Theme_fireWave";
		bool flag = false;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500211, out var perkLevel))
		{
			flag = true;
		}
		bool flag2 = false;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(500212, out perkLevel))
		{
			flag2 = true;
		}
		if (flag)
		{
			curPath = ((!flag2) ? "Misc/FateCard/Theme_fireWave_11" : "Misc/FateCard/Theme_fireWave_11_12");
		}
		else if (flag2)
		{
			curPath = "Misc/FateCard/Theme_fireWave_12";
		}
		return getFireBulletPrefab(curPath);
	}

	private GameObject getFireBulletPrefab(string curPath)
	{
		if (_fireWavePrefabDic.TryGetValue(curPath, out var value))
		{
			return value;
		}
		curPath = "Assets/AssetBundles/" + curPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, curPath, typeof(GameObject)) as GameObject;
		_fireWavePrefabDic.set_Item(curPath, gameObject);
		return gameObject;
	}
}
