using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_FreezeArea : BaseTheme
{
	private readonly int iceElfCount = 3;

	private readonly FP iceAreaReduceT = 10;

	private readonly FP searchTargetRadius = 7;

	private readonly Dictionary<int, string> iceArea_Com = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_FreezeArea_Area_base_1",
		[2] = "Misc/FateCard/Theme_FreezeArea_Area_base_2",
		[3] = "Misc/FateCard/Theme_FreezeArea_Area_base_3"
	};

	private readonly Dictionary<int, string> iceArea_Special = new Dictionary<int, string>
	{
		[1] = "Misc/FateCard/Theme_FreezeArea_Area_17_1",
		[2] = "Misc/FateCard/Theme_FreezeArea_Area_17_2",
		[3] = "Misc/FateCard/Theme_FreezeArea_Area_17_3"
	};

	private readonly List<string> iceElfList = new List<string> { "Misc/FateCard/Theme_FreezeArea_SnowBall_1", "Misc/FateCard/Theme_FreezeArea_SnowBall_2", "Misc/FateCard/Theme_FreezeArea_SnowBall_3" };

	private static readonly int iceElfTag = CommonHelper.StringToHash("iceElf");

	private readonly int perkId_1 = 501601;

	private readonly FP cd_1 = 3;

	private readonly int prob_1 = 100;

	private readonly int hitDamageId_1 = 501601;

	private readonly int perkId_2 = 501602;

	private readonly FP cd_2 = 3;

	private readonly int prob_2 = 100;

	private readonly int hitDamageId_2 = 501602;

	private readonly int perkId_3 = 501603;

	private readonly FP cd_3 = 2;

	private readonly int prob_3 = 100;

	private readonly int hitDamageId_3 = 501603;

	private readonly int perkId_4 = 501604;

	private readonly FP cd_4 = 3;

	private readonly int prob_4 = 100;

	private readonly int hitDamageId_4 = 501604;

	private readonly int perkId_8 = 501608;

	private readonly FP delay_8 = 0.2;

	private readonly Dictionary<int, FP> dicProb_8 = new Dictionary<int, FP>
	{
		[1] = 25,
		[2] = 50,
		[3] = 75,
		[4] = 25,
		[5] = 30
	};

	private readonly int perkId_9 = 501609;

	private readonly Dictionary<int, int> dicEnemyCount_9 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3,
		[4] = 5,
		[5] = 5
	};

	private readonly Dictionary<int, FP> dicCoolTime_9 = new Dictionary<int, FP>
	{
		[1] = 0.6,
		[2] = 0.9,
		[3] = 1.2,
		[4] = 1.4,
		[5] = 1.5
	};

	private readonly int perkId_10 = 501610;

	private readonly Dictionary<int, int> dicHpPercentDict_10 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 30,
		[3] = 40,
		[4] = 20,
		[5] = 25
	};

	private readonly Dictionary<int, int> DicAtkPercentForDamageLimit_10 = new Dictionary<int, int>
	{
		[1] = 200,
		[2] = 300,
		[3] = 400,
		[4] = 400,
		[5] = 500
	};

	private readonly string hitFxPath_10 = "FX/Perk/fx_perk_hit_ice_zone_snowball";

	private readonly string attackTag_10 = "iceElf";

	private readonly int perkId_11 = 501611;

	private readonly Dictionary<int, int> dicElfCount_11 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3,
		[4] = 5,
		[5] = 4
	};

	private readonly int hitDamageId_11 = 501611;

	private readonly Dictionary<int, string> dicHitFx_11 = new Dictionary<int, string>
	{
		[1] = "FX/Perk/fx_perk_base_ice_zone_in_flash_11",
		[2] = "FX/Perk/fx_perk_base_ice_zone_mid_flash_11",
		[3] = "FX/Perk/fx_perk_base_ice_zone_out_flash_11"
	};

	private readonly Dictionary<int, int> dicbuff_11 = new Dictionary<int, int>
	{
		[1] = 161111,
		[2] = 161121,
		[3] = 161131,
		[4] = 161141,
		[5] = 161151
	};

	private readonly int perkId_12 = 501612;

	private readonly Dictionary<int, int> dicBuff_12 = new Dictionary<int, int>
	{
		[1] = 161211,
		[2] = 161221,
		[3] = 161231,
		[4] = 161241,
		[5] = 161251
	};

	private readonly FP singleTarget_cd_12 = 8;

	private readonly Dictionary<int, int> dicAttrId_12 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 20,
		[5] = 25
	};

	private readonly List<int> buffTag_12 = new List<int>
	{
		CommonHelper.StringToHash("减速"),
		CommonHelper.StringToHash("束缚")
	};

	private readonly int perkId_13 = 501613;

	private readonly int buff_13 = 161312;

	private readonly Dictionary<int, int> dicBuff_13 = new Dictionary<int, int>
	{
		[1] = 161311,
		[2] = 161321,
		[3] = 161331,
		[4] = 161341,
		[5] = 161351
	};

	private readonly string drop_13 = "Misc/FateCard/Theme_FreezeArea_Drop_13";

	private readonly int perkId_14 = 501614;

	private readonly Dictionary<int, int> dicProb_14 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 40,
		[3] = 60,
		[4] = 80,
		[5] = 80
	};

	private readonly int hitDamageId_14 = 501614;

	private static readonly int waterMaskTag = CommonHelper.StringToHash("WaterTag1");

	private readonly string hitFxPath_14 = "FX/Perk/fx_perk_base_ice_zone_flash_16";

	private readonly int perkId_15 = 501615;

	private readonly Dictionary<int, List<int>> dicEff_15 = new Dictionary<int, List<int>>
	{
		[1] = new List<int> { 10, 20, 30 },
		[2] = new List<int> { 20, 40, 60 },
		[3] = new List<int> { 30, 60, 90 },
		[4] = new List<int> { 15, 30, 45 },
		[5] = new List<int> { 15, 30, 45 }
	};

	private readonly Dictionary<int, int> dicFXBuff_15 = new Dictionary<int, int>
	{
		[1] = 161511,
		[2] = 161521,
		[3] = 161531
	};

	private readonly int buffid_15 = 161512;

	private readonly Dictionary<int, int> dicBuffCount_15 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3
	};

	private readonly int taskPerkId_1 = 501616;

	private readonly List<int> buffTag_16 = new List<int>
	{
		CommonHelper.StringToHash("减速"),
		CommonHelper.StringToHash("束缚"),
		CommonHelper.StringToHash("WaterTag1")
	};

	private readonly int hitDamageId_task1 = 501616;

	private readonly FP intervalTime_task1 = 3;

	private readonly int taskPerkId_2 = 501617;

	private readonly Dictionary<int, int> dicEff_task_2 = new Dictionary<int, int> { [5] = 98020 };

	private readonly int taskPerkId_3 = 501618;

	private readonly int buff_task_3 = 161811;

	private int _tmpIceElfIndex = -1;

	private string _tmpIceElf = string.Empty;

	private int _iceAreaLevel;

	private int _shootIceElfCount;

	private long _currentAreaId;

	private CoroutineNode _corReduceArea;

	private List<CoroutineNode> _corPlayPrek8List = new List<CoroutineNode>();

	private int _shootIceElfCount_11;

	private Dictionary<long, FP> dicPrekAddBuffCD_12 = new Dictionary<long, FP>();

	private List<long> _dropIdList_13 = new List<long>();

	private bool isSpecialArea;

	private int _fx_PrekBuff_15;

	private CoroutineNode _corCheckAreaPrek_16;

	private int _addBuffPrek_17;

	public override void OnEnable()
	{
		base.OnEnable();
		if (GetPerkLv(perkId_13, out var _))
		{
			_actor.buffComponent.AddBuff(buff_13, _actor);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_tmpIceElfIndex = -1;
		_shootIceElfCount_11 = 0;
		clearAreaMsg();
		dicPrekAddBuffCD_12.Clear();
		_dropIdList_13.Clear();
		for (int i = 0; i < _corPlayPrek8List.Count; i++)
		{
			_actor.StopLogicCoroutine(_corPlayPrek8List.get_Item(i));
		}
		_corPlayPrek8List.Clear();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		CheckPlayIceElf(perkId_1, 1, prob_1, cd_1, hitDamageId_1);
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		CheckPlayIceElf(perkId_2, 2, prob_2, cd_2, hitDamageId_2);
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		CheckPlayIceElf(perkId_3, 3, prob_3, cd_3, hitDamageId_3);
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		CheckPlayIceElf(perkId_4, 4, prob_4, cd_4, hitDamageId_4);
	}

	private void CheckPlayIceElf(int perkId, int perkIndex, int prob, FP cd, int hitDamageId)
	{
		if (!GetPerkLv(perkId, out var _) || !CheckPerkCDTimeout(perkId, cd) || TSRandom.Range(0, 100) > prob)
		{
			return;
		}
		TriggerPerk(perkId);
		LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (!(logicEntity != null))
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position;
		randomIceElf();
		if (_tmpIceElf != string.Empty)
		{
			string tmpIceElf = _tmpIceElf;
			AdventureActor actor = _actor;
			LogicEntity target = logicEntity;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(tmpIceElf, actor, default, position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null)
			{
				_tmpIceElf = string.Empty;
				adventureBulletBase.hitDamageId = hitDamageId;
				adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			}
		}
		if (!checkHaveIceArea())
		{
			_iceAreaLevel = 1;
			PalyAreaEffect(1);
		}
		_shootIceElfCount++;
		ShootIceElfCount();
		playPrek_11();
		playPrek_8(hitDamageId);
		playPrek_9(perkId);
	}

	private void ShootIceElfCount()
	{
		if (_shootIceElfCount >= iceElfCount)
		{
			if (_iceAreaLevel < 3)
			{
				_iceAreaLevel++;
				PalyAreaEffect(_iceAreaLevel);
			}
			else if (_corReduceArea != null)
			{
				_actor.StopLogicCoroutine(_corReduceArea);
				_corReduceArea = null;
				_corReduceArea = _actor.StartLogicCoroutine(CorReduceArea());
			}
			_shootIceElfCount = 0;
		}
	}

	private void playPrek_8(int hitDamageId)
	{
		if (GetPerkLv(perkId_8, out var lv) && TSRandom.Range(0, 100) <= dicProb_8.get_Item(lv))
		{
			CoroutineNode item = _actor.StartLogicCoroutine(CorPlayPrek_8(hitDamageId));
			_corPlayPrek8List.Add(item);
		}
	}

	private IEnumerator CorPlayPrek_8(int hitDamageId)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delay_8));
		LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (!(logicEntity != null))
		{
			yield break;
		}
		TSVector2 position = _actor.tsTransform.Position;
		randomIceElf();
		if (_tmpIceElf != string.Empty)
		{
			string tmpIceElf = _tmpIceElf;
			AdventureActor actor = _actor;
			LogicEntity target = logicEntity;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(tmpIceElf, actor, default, position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null)
			{
				_tmpIceElf = string.Empty;
				adventureBulletBase.hitDamageId = hitDamageId;
				adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			}
		}
		_shootIceElfCount++;
		ShootIceElfCount();
		playPrek_11();
	}

	private void playPrek_9(int perkId)
	{
		if (GetPerkLv(perkId_9, out var lv))
		{
			List<LogicEntity> currentAreaEnemy = getCurrentAreaEnemy();
			if (currentAreaEnemy != null && currentAreaEnemy.Count >= dicEnemyCount_9.get_Item(lv))
			{
				FP reduceCd = dicCoolTime_9.get_Item(lv);
				ModifyPerkCD(perkId, reduceCd);
			}
		}
	}

	private void playPrek_11()
	{
		if (!GetPerkLv(perkId_11, out var lv))
		{
			return;
		}
		_shootIceElfCount_11++;
		if (_shootIceElfCount_11 < dicElfCount_11.get_Item(lv))
		{
			return;
		}
		if (checkHaveIceArea())
		{
			List<LogicEntity> currentAreaEnemy = getCurrentAreaEnemy();
			if (currentAreaEnemy != null)
			{
				for (int i = 0; i < currentAreaEnemy.Count; i++)
				{
					AdventureActor adventureActor = currentAreaEnemy.get_Item(i) as AdventureActor;
					ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId_11);
					adventureActor.buffComponent.AddBuff(dicbuff_11.get_Item(lv), _actor);
				}
			}
			string fxAlias = dicHitFx_11.get_Item(_iceAreaLevel);
			new PlayFX().Play(_actor, fxAlias, 1f, _actor.transform.position, Quaternion.identity);
		}
		_shootIceElfCount_11 = 0;
	}

	private void clearAreaMsg()
	{
		if (_corReduceArea != null)
		{
			_actor.StopLogicCoroutine(_corReduceArea);
			_corReduceArea = null;
		}
		if (_fx_PrekBuff_15 != 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(_fx_PrekBuff_15);
			_fx_PrekBuff_15 = 0;
		}
		if (_corCheckAreaPrek_16 != null)
		{
			_actor.StopLogicCoroutine(_corCheckAreaPrek_16);
			_corCheckAreaPrek_16 = null;
		}
		_currentAreaId = 0L;
		_iceAreaLevel = 0;
		_shootIceElfCount = 0;
	}

	private bool checkHaveIceArea()
	{
		if (_currentAreaId == 0L)
		{
			return false;
		}
		if (ILRuntimeAPI.GetAreaEffect(_currentAreaId) != null)
		{
			return true;
		}
		clearAreaMsg();
		return false;
	}

	private List<LogicEntity> getCurrentAreaEnemy()
	{
		if (_currentAreaId == 0L)
		{
			return null;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(_currentAreaId);
		if (areaEffect == null)
		{
			clearAreaMsg();
			return null;
		}
		return CommonUtils.SearchNearTargetsByCircle(_actor, areaEffect.hitBoxRadius, isConfront: true, includeSelf: false);
	}

	private AreaEffectEntity getCurrentArea()
	{
		if (_currentAreaId == 0L)
		{
			return null;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(_currentAreaId);
		if (areaEffect == null)
		{
			clearAreaMsg();
			return null;
		}
		return areaEffect;
	}

	private void PalyAreaEffect(int _lv)
	{
		string fxAlias = iceArea_Com.get_Item(_lv);
		if (GetPerkLv(taskPerkId_2, out var _))
		{
			fxAlias = iceArea_Special.get_Item(_lv);
		}
		TSVector2 position = _actor.tsTransform.Position;
		FP angle = _actor.tsTransform.Forward.GetAngle();
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, angle, (AreaEffectEntity entity) =>
		{
			_currentAreaId = entity.Id;
			if (_corReduceArea == null)
			{
				_corReduceArea = _actor.StartLogicCoroutine(CorReduceArea());
			}
			else
			{
				_actor.StopLogicCoroutine(_corReduceArea);
				_corReduceArea = null;
				_corReduceArea = _actor.StartLogicCoroutine(CorReduceArea());
			}
			if (GetPerkLv(perkId_15, out var _))
			{
				_fx_PrekBuff_15 = dicFXBuff_15.get_Item(_iceAreaLevel);
				_actor.buffComponent.AddBuff(_fx_PrekBuff_15, _actor);
			}
			if (_corCheckAreaPrek_16 == null && GetPerkLv(taskPerkId_1, out var _))
			{
				_corCheckAreaPrek_16 = _actor.StartLogicCoroutine(CorCheckAreaPrek_16());
			}
		});
	}

	private IEnumerator CorReduceArea()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(iceAreaReduceT));
		if (!checkHaveIceArea())
		{
			yield break;
		}
		_corReduceArea = null;
		if (_iceAreaLevel > 1)
		{
			_iceAreaLevel--;
			PalyAreaEffect(_iceAreaLevel);
			yield break;
		}
		_iceAreaLevel--;
		if (ILRuntimeAPI.GetAreaEffect(_currentAreaId) != null)
		{
			ILRuntimeAPI.StopAreaEffect(_currentAreaId);
		}
		_currentAreaId = 0L;
	}

	private IEnumerator CorCheckAreaPrek_16()
	{
		while (true)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(intervalTime_task1));
			playPrek_16();
		}
	}

	private void playPrek_16()
	{
		if (!GetPerkLv(taskPerkId_1, out var _))
		{
			return;
		}
		List<LogicEntity> currentAreaEnemy = getCurrentAreaEnemy();
		if (currentAreaEnemy == null)
		{
			return;
		}
		for (int i = 0; i < currentAreaEnemy.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = currentAreaEnemy.get_Item(i) as MonsterAdventureActor;
			for (int j = 0; j < buffTag_16.Count; j++)
			{
				if (!monsterAdventureActor.buffComponent.CheckBuffByBuffTag(buffTag_16.get_Item(j)))
				{
					continue;
				}
				TSVector2 position = _actor.tsTransform.Position;
				randomIceElf();
				if (_tmpIceElf != string.Empty)
				{
					string tmpIceElf = _tmpIceElf;
					AdventureActor actor = _actor;
					LogicEntity target = monsterAdventureActor;
					AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(tmpIceElf, actor, default, position, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
					if (adventureBulletBase != null)
					{
						_tmpIceElf = string.Empty;
						int hitDamageId = (adventureBulletBase.hitDamageId = hitDamageId_task1);
						adventureBulletBase.hitBox.hitDamageId = hitDamageId;
					}
				}
				playPrek_11();
				break;
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		_ = evt.from;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, iceElfTag))
		{
			bool flag = false;
			AreaEffectEntity currentArea = getCurrentArea();
			if (currentArea != null && TSVector2.Distance(monsterAdventureActor.tsTransform.Position, currentArea.tsTransform.Position) < currentArea.hitBoxRadius)
			{
				flag = true;
			}
			if (GetPerkLv(perkId_12, out var lv) && flag)
			{
				if (dicPrekAddBuffCD_12.ContainsKey(monsterAdventureActor.Id))
				{
					if (dicPrekAddBuffCD_12.get_Item(monsterAdventureActor.Id) + singleTarget_cd_12 <= LockStepManager.time)
					{
						int buffID = dicBuff_12.get_Item(lv);
						monsterAdventureActor.buffComponent.AddBuff(buffID, _actor);
						dicPrekAddBuffCD_12.set_Item(monsterAdventureActor.Id, LockStepManager.time);
					}
				}
				else
				{
					int buffID2 = dicBuff_12.get_Item(lv);
					monsterAdventureActor.buffComponent.AddBuff(buffID2, _actor);
					dicPrekAddBuffCD_12.Add(monsterAdventureActor.Id, LockStepManager.time);
				}
				for (int i = 0; i < buffTag_12.Count; i++)
				{
					if (monsterAdventureActor.buffComponent.CheckBuffByBuffTag(buffTag_12.get_Item(i)))
					{
						AdventureActor.AddFromAttr(dicAttrId_12.get_Item(lv), _actor);
						break;
					}
				}
			}
		}
		if (evt.elementType == HotfixEnum.elementType.WE && GetPerkLv(perkId_15, out var lv2) && _iceAreaLevel != 0)
		{
			AdventureActor.AddFromAttr(dicEff_15.get_Item(lv2).get_Item(_iceAreaLevel - 1), _actor);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		if (!((evt as AdventureActorReceiveDamageBeforeHitEvent).to as PlayerAdventureActor != null) || !GetPerkLv(taskPerkId_2, out var _) || !checkHaveIceArea())
		{
			return;
		}
		int count = getCurrentAreaEnemy().Count;
		int num = 0;
		foreach (KeyValuePair<int, int> item in dicEff_task_2)
		{
			if (count <= item.Key)
			{
				num = item.Value;
			}
		}
		if (num != 0)
		{
			AdventureActor.AddToAttr(num, _actor);
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHitPost(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, iceElfTag) || !(monsterAdventureActor != null))
		{
			return;
		}
		bool flag = false;
		AreaEffectEntity currentArea = getCurrentArea();
		if (currentArea != null && TSVector2.Distance(monsterAdventureActor.tsTransform.Position, currentArea.tsTransform.Position) < currentArea.hitBoxRadius)
		{
			flag = true;
		}
		if (GetPerkLv(perkId_10, out var lv) && flag)
		{
			FP val = (float)monsterAdventureActor.actorHealthInfo.hpMax * ((float)dicHpPercentDict_10.get_Item(lv) / 100f);
			FP val2 = (FP)_actor.actorInfo.atk * FP.FromPercent(DicAtkPercentForDamageLimit_10.get_Item(lv));
			val = TSMath.Min(val, val2);
			monsterAdventureActor.DirectDamage((int)(long)val, attackTag_10, _actor.Id);
		}
		if (GetPerkLv(perkId_13, out lv) && flag)
		{
			long num = ILRuntimeAPI.PlayDrop(monsterAdventureActor, drop_13);
			if (num > 0)
			{
				_dropIdList_13.Add(num);
			}
		}
		if (GetPerkLv(perkId_14, out lv))
		{
			if (CommonUtils.CheckElementMark(CommonDefine.Water, monsterAdventureActor))
			{
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, hitDamageId_14, null, hitFxPath_14, attackFxPlayOnTarget: true);
			}
			else if (TSRandom.Range(0, 100) <= dicProb_14.get_Item(lv))
			{
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, hitDamageId_14, null, hitFxPath_14, attackFxPlayOnTarget: true);
			}
		}
		if (GetPerkLv(perkId_15, out lv) && _iceAreaLevel != 0)
		{
			int num2 = dicBuffCount_15.get_Item(_iceAreaLevel);
			for (int i = 0; i < num2; i++)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffid_15, _actor);
			}
		}
		if (GetPerkLv(taskPerkId_3, out lv) && flag)
		{
			monsterAdventureActor.buffComponent.AddBuff(buff_task_3, _actor);
		}
	}

	private void randomIceElf()
	{
		int num = TSRandom.Range(0, iceElfList.Count);
		if (num != _tmpIceElfIndex)
		{
			_tmpIceElfIndex = num;
			_tmpIceElf = iceElfList.get_Item(num);
		}
		else
		{
			randomIceElf();
		}
	}

	protected void OnDropFinish(IEvent evt)
	{
		if (GetPerkLv(perkId_13, out var lv))
		{
			AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
			if (adventureDropFinishEvent.isPickUp && _dropIdList_13.Contains(adventureDropFinishEvent.entityID))
			{
				_actor.buffComponent.AddBuff(dicBuff_13.get_Item(lv), _actor);
			}
		}
	}

	protected void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && adventureAreaEffectFinishEvent.entityID == _currentAreaId && _fx_PrekBuff_15 != 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(_fx_PrekBuff_15);
			_fx_PrekBuff_15 = 0;
		}
	}
}
