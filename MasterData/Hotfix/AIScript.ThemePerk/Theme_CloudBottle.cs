using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.ThemePerk;

public class Theme_CloudBottle : BaseTheme
{
	protected enum CircleHitType
	{
		Inner,
		Center,
		Outer
	}

	protected enum TriggerSoltType
	{
		None,
		Normal,
		Dodge,
		Skill,
		UltraSkill
	}

	private readonly FP searchTargetRadius = 10;

	private const string bulletPath_CloudBottle = "Misc/FateCard/Theme_CloudBottle_base";

	private const string fxPath_CloudBottle = "FX/Perk/fx_perk_loop_water_cloudbottle_center_1";

	private readonly FP fxDelayTime_AfterExplosion = 0.6f;

	private readonly List<FP> explosionTimesRatioList = new List<FP> { 20, 50, 30 };

	private static readonly int damageTag_Explosion = CommonHelper.StringToHash("CloudBottle");

	private readonly FP interval_Explosion = 0.3;

	private const string fxPath_InnerCircle = "FX/Perk/fx_perk_base_water_cloudbottle_a";

	private readonly FP radius_InnerCircle = 2;

	private static readonly int damageTag_InnerCircle = CommonHelper.StringToHash("CloudBottle_a");

	private const string fxPath_CenterCircle = "FX/Perk/fx_perk_base_water_cloudbottle_b";

	private readonly FP radius_CenterCircle = 3;

	private const string damageTag_CenterCircle = "CloudBottle_b";

	private const string fxPath_OuterCircle = "FX/Perk/fx_perk_base_water_cloudbottle_c";

	private readonly FP radius_OuterCircle = 5;

	private const string damageTag_OuterCircle = "CloudBottle_c";

	private const string fxPath_Hitted = "";

	private static readonly int waterMarkTag = CommonHelper.StringToHash("WaterTag");

	private const int perkId_1 = 501501;

	private readonly FP triggerPercentage_1 = 100;

	private readonly FP cd_1 = 4;

	private const int hitDamageId_InnerCircle_1 = 5015011;

	private const int hitDamageId_CenterCircle_1 = 5015012;

	private const int hitDamageId_OuterCircle_1 = 5015013;

	private const int perkId_2 = 501502;

	private readonly FP triggerPercentage_2 = 100;

	private readonly FP cd_2 = 4;

	private const int hitDamageId_InnerCircle_2 = 5015021;

	private const int hitDamageId_CenterCircle_2 = 5015022;

	private const int hitDamageId_OuterCircle_2 = 5015023;

	private const int perkId_3 = 501503;

	private readonly FP triggerPercentage_3 = 100;

	private readonly FP cd_3 = 4;

	private const int hitDamageId_InnerCircle_3 = 5015031;

	private const int hitDamageId_CenterCircle_3 = 5015032;

	private const int hitDamageId_OuterCircle_3 = 5015033;

	private const int perkId_4 = 501504;

	private readonly FP triggerPercentage_4 = 100;

	private readonly FP cd_4 = 4;

	private const int hitDamageId_InnerCircle_4 = 5015041;

	private const int hitDamageId_CenterCircle_4 = 5015042;

	private const int hitDamageId_OuterCircle_4 = 5015043;

	private const int perkId_8 = 501508;

	private readonly Dictionary<int, int> additionalAttrIdDic_8 = new Dictionary<int, int>
	{
		[1] = 50,
		[2] = 100,
		[3] = 150,
		[4] = 80,
		[5] = 90
	};

	private const int perkId_9 = 501509;

	private readonly Dictionary<int, FP> explosionIntervalDic_9 = new Dictionary<int, FP>
	{
		[1] = 0.24,
		[2] = 0.18,
		[3] = 0.12,
		[4] = 0.12,
		[5] = 0.1
	};

	private readonly Dictionary<int, int> additionalAttrIdDic_9 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 40,
		[5] = 50
	};

	private const int perkId_10 = 501510;

	private readonly Dictionary<int, List<FP>> explosionTimesRatioListDic_10 = new Dictionary<int, List<FP>>
	{
		[1] = new List<FP> { 15, 45, 40 },
		[2] = new List<FP> { 10, 40, 50 },
		[3] = new List<FP> { 5, 35, 60 },
		[4] = new List<FP> { 50, 40, 80 },
		[5] = new List<FP> { 50, 40, 90 }
	};

	private const int perkId_11 = 501511;

	private const string bulletPath_11 = "Misc/FateCard/Theme_CloudBottle_11";

	private const int minShootCount_11 = 1;

	private const int maxShootCount_11 = 2;

	private readonly FP searchTargetRadius_11 = 6;

	private const int perkId_12 = 501512;

	private const int triggerTimes_12 = 2;

	private readonly FP explosionDelay_12 = 0.3f;

	private const string fxPath_12 = "FX/Perk/fx_perk_base_water_cloudbottle_12";

	private readonly FP radius_12 = 4;

	private const int hitDamageId_12 = 501512;

	private static readonly int damageTag_12 = CommonHelper.StringToHash("CloudBottle_d");

	private readonly Dictionary<int, int> buffIdDic_12 = new Dictionary<int, int>
	{
		[1] = 151211,
		[2] = 151221,
		[3] = 151231,
		[4] = 151241,
		[5] = 151251
	};

	private const int perkId_13 = 501513;

	private const string dropPath_13 = "Misc/FateCard/Theme_CloudBottle_Drop_13";

	private readonly Dictionary<int, FP> reduceCDDic_13 = new Dictionary<int, FP>
	{
		[1] = 0.5,
		[2] = 0.8,
		[3] = 1.0,
		[4] = 0.5,
		[5] = 0.6
	};

	private readonly FP cd_13 = 0;

	private const int perkId_14 = 501514;

	private readonly FP cd_14 = 1;

	private readonly Dictionary<int, FP> triggerPercentageDic_14 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 40,
		[3] = 60,
		[4] = 40,
		[5] = 50
	};

	private readonly Dictionary<int, int> additionalAttrIdDic_14 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 40,
		[5] = 50
	};

	private const int buffId_14 = 4100;

	private const int perkId_15 = 501515;

	private const int triggerTimes_15 = 15;

	private const string bulletPath_CloudBottle_15 = "Misc/FateCard/Theme_CloudBottle_Bullet_15";

	private readonly Dictionary<int, int> buffIdDic_15 = new Dictionary<int, int>
	{
		[1] = 151511,
		[2] = 151521,
		[3] = 151531,
		[4] = 151541,
		[5] = 151551
	};

	private readonly int buffTag_15 = CommonHelper.StringToHash("DocterCloud");

	private const string fxPath_CloudBottle_15 = "FX/Perk/fx_perk_loop_water_cloudbottle_center_15";

	private const string fxPath_InnerCircle_15 = "FX/Perk/fx_perk_base_water_cloudbottle_a_2";

	private const string fxPath_CenterCircle_15 = "FX/Perk/fx_perk_base_water_cloudbottle_b_2";

	private const string fxPath_OuterCircle_15 = "FX/Perk/fx_perk_base_water_cloudbottle_c_2";

	private const int perkId_Task1 = 501516;

	private const int addExplosionTimes_Task1 = 2;

	private const int perkId_Task2 = 501517;

	private const int triggerTimes_Task2 = 3;

	private const string bulletPath_CloudBottle_Task2 = "Misc/FateCard/Theme_CloudBottle_Bullet_17";

	private const string fxPath_CloudBottle_Task2 = "FX/Perk/fx_perk_loop_water_cloudbottle_center_17";

	private const int explosionTimes_Task2 = 4;

	private const string fxPath_Task2 = "FX/Perk/fx_perk_base_water_cloudbottle_12";

	private readonly FP radius_Task2 = 6;

	private const int hitDamageId_Task2 = 501517;

	private const int perkId_Task3 = 501518;

	private const int additionalAttrId_Task3 = 30;

	private const string fxPath_Pull_Task3 = "FX/Perk/fx_perk_base_water_cloudbottle_18";

	private readonly FP pullRaidus_Task3 = 5;

	private readonly FP pullMoveSpeed_Task3 = 10;

	private const int pullMoveLevel_Task3 = 2;

	private readonly FP pullStrenth_Task3 = 4;

	private const string BulletTag_CloudBottle = "CloudBottleBullet";

	private CommomAreaHitConfig _areaHitConfig;

	private Dictionary<string, GameObject> _fxPrefabDic;

	private Dictionary<TriggerSoltType, FP> _triggerCDDic;

	private List<FP> _curExplosionTimesRatioList;

	private FP _totalExplosionTimesRatio;

	private List<FP> _pullDistanceList;

	private Dictionary<long, TriggerSoltType> _dropDic_13;

	private int _triggerTimes_15;

	private int _triggerTimes_Task2;

	private Dictionary<int, int> _triggerTimes_Task3;

	public override void OnEnable()
	{
		base.OnEnable();
		Clear();
		if (_triggerCDDic == null)
		{
			_triggerCDDic = new Dictionary<TriggerSoltType, FP>();
		}
		else
		{
			_triggerCDDic.Clear();
		}
		_triggerCDDic.Add(TriggerSoltType.Normal, cd_1);
		_triggerCDDic.Add(TriggerSoltType.Dodge, cd_2);
		_triggerCDDic.Add(TriggerSoltType.Skill, cd_3);
		_triggerCDDic.Add(TriggerSoltType.UltraSkill, cd_4);
		_curExplosionTimesRatioList = explosionTimesRatioList;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501510, out var perkLevel))
		{
			_curExplosionTimesRatioList = explosionTimesRatioListDic_10.get_Item(perkLevel);
		}
		for (int i = 0; i < _curExplosionTimesRatioList.Count; i++)
		{
			_totalExplosionTimesRatio += _curExplosionTimesRatioList.get_Item(i);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501501, out var _) && CheckPerkCDTimeout(501501, _triggerCDDic.get_Item(TriggerSoltType.Normal)) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_1 && ShootCloudBottle(TriggerSoltType.Normal))
		{
			_triggerCDDic.set_Item(TriggerSoltType.Normal, cd_1);
			TriggerPerk(501501);
		}
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501502, out var _) && CheckPerkCDTimeout(501502, _triggerCDDic.get_Item(TriggerSoltType.Dodge)) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_2 && ShootCloudBottle(TriggerSoltType.Dodge))
		{
			_triggerCDDic.set_Item(TriggerSoltType.Dodge, cd_2);
			TriggerPerk(501502);
		}
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501503, out var _) && CheckPerkCDTimeout(501503, _triggerCDDic.get_Item(TriggerSoltType.Skill)) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_3 && ShootCloudBottle(TriggerSoltType.Skill))
		{
			_triggerCDDic.set_Item(TriggerSoltType.Skill, cd_3);
			TriggerPerk(501503);
		}
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501504, out var _) && CheckPerkCDTimeout(501504, _triggerCDDic.get_Item(TriggerSoltType.UltraSkill)) && TSRandom.Range(FP.Zero, 100) <= triggerPercentage_4 && ShootCloudBottle(TriggerSoltType.UltraSkill))
		{
			_triggerCDDic.set_Item(TriggerSoltType.UltraSkill, cd_4);
			TriggerPerk(501504);
		}
	}

	protected bool ShootCloudBottle(TriggerSoltType slotType)
	{
		LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (logicEntity == null)
		{
			return false;
		}
		string bulletAlias = "Misc/FateCard/Theme_CloudBottle_base";
		int num = 0;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501515, out var perkLevel) && _actor.buffComponent.CheckBuffByBuffTag(buffTag_15))
		{
			bulletAlias = "Misc/FateCard/Theme_CloudBottle_Bullet_15";
			num = 501515;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501517, out perkLevel) && _triggerTimes_Task2 >= 3)
		{
			bulletAlias = "Misc/FateCard/Theme_CloudBottle_Bullet_17";
			num = 501517;
		}
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletAlias, _actor, default, _actor.tsTransform.Position, default, logicEntity.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
		if (adventureBulletBase == null)
		{
			return false;
		}
		adventureBulletBase.ModifyBulletTag(string.Format("{0}_{1}_{2}", "CloudBottleBullet", (int)slotType, num));
		return true;
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		base.OnBulletFinish(_evt);
		string[] array = _evt.tag.Split('_');
		if (array.Length < 3 && !string.Equals(array[0], "CloudBottleBullet"))
		{
			return;
		}
		CommonUtils.TryParseStringParamToInt(array[1], out var intValue);
		if (intValue == 0)
		{
			return;
		}
		CommonUtils.TryParseStringParamToInt(array[2], out var intValue2);
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501517, out var _))
		{
			if (_triggerTimes_Task2 >= 3)
			{
				StartLogicCoroutine(CloudBottleExplosion_Task2(_evt.owner, _evt.bulletPosition, _evt.bulletPositionY, (TriggerSoltType)intValue));
				_triggerTimes_Task2 = 0;
			}
			else
			{
				StartLogicCoroutine(CloudBottleExplosion(_evt.owner, _evt.bulletPosition, _evt.bulletPositionY, (TriggerSoltType)intValue, intValue2));
				_triggerTimes_Task2++;
			}
		}
		else
		{
			StartLogicCoroutine(CloudBottleExplosion(_evt.owner, _evt.bulletPosition, _evt.bulletPositionY, (TriggerSoltType)intValue, intValue2));
		}
	}

	protected TriggerSoltType GetBulletSoltType(string bulletTag)
	{
		if (string.Equals(bulletTag, string.Format("{0}_{1}", "CloudBottleBullet", TriggerSoltType.Normal)))
		{
			return TriggerSoltType.Normal;
		}
		if (string.Equals(bulletTag, string.Format("{0}_{1}", "CloudBottleBullet", TriggerSoltType.Dodge)))
		{
			return TriggerSoltType.Dodge;
		}
		if (string.Equals(bulletTag, string.Format("{0}_{1}", "CloudBottleBullet", TriggerSoltType.Skill)))
		{
			return TriggerSoltType.Skill;
		}
		if (string.Equals(bulletTag, string.Format("{0}_{1}", "CloudBottleBullet", TriggerSoltType.UltraSkill)))
		{
			return TriggerSoltType.UltraSkill;
		}
		return TriggerSoltType.None;
	}

	protected IEnumerator CloudBottleExplosion(AdventureActor actor, TSVector2 position, FP positionY, TriggerSoltType soltType = TriggerSoltType.Normal, int bulletPerkId = 0)
	{
		int totalTimes = 1;
		string fxPath = "FX/Perk/fx_perk_loop_water_cloudbottle_center_1";
		FP fP = TSRandom.Range(0f, _totalExplosionTimesRatio);
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501515, out var perkLevel) && bulletPerkId == 501515)
		{
			fP = _totalExplosionTimesRatio;
			fxPath = "FX/Perk/fx_perk_loop_water_cloudbottle_center_15";
		}
		if (fP >= _totalExplosionTimesRatio)
		{
			totalTimes = _curExplosionTimesRatioList.Count;
		}
		else
		{
			for (int i = 0; i < _curExplosionTimesRatioList.Count; i++)
			{
				FP leftRatioByIndex = GetLeftRatioByIndex(i);
				FP fP2 = leftRatioByIndex + _curExplosionTimesRatioList.get_Item(i);
				if (fP >= leftRatioByIndex && fP < fP2)
				{
					totalTimes = i + 1;
					break;
				}
			}
		}
		int times = 0;
		FP interval = interval_Explosion;
		bool random = false;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501509, out var perkLevel2))
		{
			interval = explosionIntervalDic_9.get_Item(perkLevel2);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501516, out perkLevel))
		{
			totalTimes += 2;
			random = true;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501518, out perkLevel))
		{
			GameObject cloudBottleFx = GetCloudBottleFx("FX/Perk/fx_perk_base_water_cloudbottle_18");
			if (cloudBottleFx != null)
			{
				AdventureFXPlayer.PlayFX(cloudBottleFx, 1f, new Vector3((float)position.x, (float)positionY, (float)position.y), Quaternion.identity);
			}
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, position, pullRaidus_Task3, (List<LogicEntity> targets) =>
			{
				if (targets != null && targets.Count > 0)
				{
					if (_pullDistanceList == null)
					{
						_pullDistanceList = new List<FP>(5);
					}
					else
					{
						_pullDistanceList.Clear();
					}
					for (int j = 0; j < targets.Count; j++)
					{
						_pullDistanceList.Add(TSVector2.Distance(targets.get_Item(j).tsTransform.Position, position));
					}
					ILRuntimeAPI.ForceMoveToPosition(position, targets, pullMoveSpeed_Task3, _pullDistanceList, isCoExist: true, isChangeForward: true, 2, pullStrenth_Task3);
				}
			}, isConfront: true);
		}
		AdventureFXPlayer fxPlayer = null;
		GameObject cloudBottleFx2 = GetCloudBottleFx(fxPath);
		if (cloudBottleFx2 != null)
		{
			fxPlayer = AdventureFXPlayer.PlayFX(cloudBottleFx2, 1f, new Vector3((float)position.x, (float)positionY, (float)position.y), Quaternion.identity);
		}
		int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		while (true)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501518, out perkLevel))
			{
				if (_triggerTimes_Task3 == null)
				{
					_triggerTimes_Task3 = new Dictionary<int, int>(5);
				}
				if (_triggerTimes_Task3.ContainsKey(uniqueAttackId))
				{
					_triggerTimes_Task3.get_Item(uniqueAttackId)++;
				}
				else
				{
					_triggerTimes_Task3.Add(uniqueAttackId, 0);
				}
			}
			CircleHitType nextCircleAreaHitType = GetNextCircleAreaHitType(times, random);
			CircleAreaHit(actor, position, positionY, nextCircleAreaHitType, soltType, uniqueAttackId, bulletPerkId);
			times++;
			OnAfterSingleCloudBottleExplosion(times, actor, position, positionY, uniqueAttackId);
			if (times >= totalTimes)
			{
				break;
			}
			yield return interval;
		}
		yield return fxDelayTime_AfterExplosion;
		fxPlayer?.Stop();
		OnCloudBottleExplosionFinish(actor, position, positionY, soltType);
	}

	protected IEnumerator CloudBottleExplosion_Task2(AdventureActor actor, TSVector2 position, FP positionY, TriggerSoltType soltType = TriggerSoltType.Normal)
	{
		int totalTimes = 4;
		int times = 0;
		FP interval = interval_Explosion;
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501509, out var perkLevel))
		{
			interval = explosionIntervalDic_9.get_Item(perkLevel);
		}
		AdventureFXPlayer fxPlayer = null;
		GameObject cloudBottleFx = GetCloudBottleFx("FX/Perk/fx_perk_loop_water_cloudbottle_center_17");
		if (cloudBottleFx != null)
		{
			fxPlayer = AdventureFXPlayer.PlayFX(cloudBottleFx, 1f, new Vector3((float)position.x, (float)positionY, (float)position.y), Quaternion.identity);
		}
		int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		while (true)
		{
			CircleAreaHit(actor, position, positionY, "FX/Perk/fx_perk_base_water_cloudbottle_12", radius_Task2, 501517, uniqueAttackId);
			times++;
			OnAfterSingleCloudBottleExplosion(times, actor, position, positionY, uniqueAttackId);
			if (times >= totalTimes)
			{
				break;
			}
			yield return interval;
		}
		yield return fxDelayTime_AfterExplosion;
		fxPlayer?.Stop();
		OnCloudBottleExplosionFinish(actor, position, positionY, soltType);
	}

	protected void OnAfterSingleCloudBottleExplosion(int times, AdventureActor actor, TSVector2 position, FP positionY, int uniqueAttackId)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501511, out var perkLevel))
		{
			ILRuntimeAPI.SearchByRangeAndPosition(actor, position, searchTargetRadius_11, (List<LogicEntity> targets) =>
			{
				if (targets.Count > 0)
				{
					int num = TSRandom.Range(1, 3);
					int num2 = 0;
					for (int i = 0; i < targets.Count; i++)
					{
						ILRuntimeAPI.Shoot("Misc/FateCard/Theme_CloudBottle_11", actor, default, position, default, targets.get_Item(i).tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
						num2++;
						if (num2 >= num)
						{
							break;
						}
					}
				}
			}, isConfront: true);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501512, out perkLevel) && times % 2 == 0)
		{
			StartLogicCoroutine(CircleAreaHit_12(actor, position, positionY, "FX/Perk/fx_perk_base_water_cloudbottle_12", radius_12, 501512, uniqueAttackId));
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501515, out var perkLevel2))
		{
			return;
		}
		if (actor.buffComponent.CheckBuffByBuffTag(buffTag_15))
		{
			_triggerTimes_15 = 0;
			return;
		}
		_triggerTimes_15++;
		if (_triggerTimes_15 >= 15)
		{
			actor.buffComponent.AddBuff(buffIdDic_15.get_Item(perkLevel2), _actor);
			_triggerTimes_15 = 0;
		}
	}

	protected void OnCloudBottleExplosionFinish(AdventureActor actor, TSVector2 position, FP positionY, TriggerSoltType soltType = TriggerSoltType.Normal)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501513, out var _) && CheckPerkCDTimeout(501513, cd_13))
		{
			if (_dropDic_13 == null)
			{
				_dropDic_13 = new Dictionary<long, TriggerSoltType>(5);
			}
			long num = ILRuntimeAPI.PlayDrop(actor, "Misc/FateCard/Theme_CloudBottle_Drop_13", position, positionY);
			if (num > 0 && !_dropDic_13.ContainsKey(num))
			{
				_dropDic_13.Add(num, soltType);
			}
			TriggerPerk(501513);
		}
	}

	protected FP GetLeftRatioByIndex(int index)
	{
		FP result = 0;
		if (index > 0)
		{
			for (int i = 0; i < _curExplosionTimesRatioList.Count && i < index; i++)
			{
				result += _curExplosionTimesRatioList.get_Item(i);
			}
		}
		return result;
	}

	protected CircleHitType GetNextCircleAreaHitType(int index, bool random = false)
	{
		if (random)
		{
			index = TSRandom.Range(0, 3);
		}
		return index switch
		{
			0 => CircleHitType.Inner, 
			1 => CircleHitType.Center, 
			2 => CircleHitType.Outer, 
			_ => CircleHitType.Outer, 
		};
	}

	protected GameObject GetCloudBottleFx(string fxPath)
	{
		if (_fxPrefabDic == null)
		{
			_fxPrefabDic = new Dictionary<string, GameObject>(2);
		}
		if (!_fxPrefabDic.ContainsKey(fxPath))
		{
			string assetName = "Assets/AssetBundles/" + fxPath + ".prefab";
			GameObject value = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			_fxPrefabDic.Add(fxPath, value);
		}
		return _fxPrefabDic.get_Item(fxPath);
	}

	protected void CircleAreaHit(AdventureActor actor, TSVector2 position, FP positionY, CircleHitType circleHitType, TriggerSoltType soltType, int uniqueAttackId, int bulletPerkId = 0)
	{
		switch (circleHitType)
		{
		case CircleHitType.Inner:
		{
			int num3 = 0;
			switch (soltType)
			{
			case TriggerSoltType.Normal:
				num3 = 5015011;
				break;
			case TriggerSoltType.Dodge:
				num3 = 5015021;
				break;
			case TriggerSoltType.Skill:
				num3 = 5015031;
				break;
			case TriggerSoltType.UltraSkill:
				num3 = 5015041;
				break;
			}
			if (num3 > 0)
			{
				string fxPath3 = ((bulletPerkId == 501515) ? "FX/Perk/fx_perk_base_water_cloudbottle_a_2" : "FX/Perk/fx_perk_base_water_cloudbottle_a");
				CircleAreaHit(actor, position, positionY, fxPath3, radius_InnerCircle, num3, uniqueAttackId);
			}
			break;
		}
		case CircleHitType.Center:
		{
			int num2 = 0;
			switch (soltType)
			{
			case TriggerSoltType.Normal:
				num2 = 5015012;
				break;
			case TriggerSoltType.Dodge:
				num2 = 5015022;
				break;
			case TriggerSoltType.Skill:
				num2 = 5015032;
				break;
			case TriggerSoltType.UltraSkill:
				num2 = 5015042;
				break;
			}
			if (num2 > 0)
			{
				string fxPath2 = ((bulletPerkId == 501515) ? "FX/Perk/fx_perk_base_water_cloudbottle_b_2" : "FX/Perk/fx_perk_base_water_cloudbottle_b");
				CircleAreaHit(actor, position, positionY, fxPath2, radius_CenterCircle, num2, uniqueAttackId);
			}
			break;
		}
		case CircleHitType.Outer:
		{
			int num = 0;
			switch (soltType)
			{
			case TriggerSoltType.Normal:
				num = 5015013;
				break;
			case TriggerSoltType.Dodge:
				num = 5015023;
				break;
			case TriggerSoltType.Skill:
				num = 5015033;
				break;
			case TriggerSoltType.UltraSkill:
				num = 5015043;
				break;
			}
			if (num > 0)
			{
				string fxPath = ((bulletPerkId == 501515) ? "FX/Perk/fx_perk_base_water_cloudbottle_c_2" : "FX/Perk/fx_perk_base_water_cloudbottle_c");
				CircleAreaHit(actor, position, positionY, fxPath, radius_OuterCircle, num, uniqueAttackId);
			}
			break;
		}
		}
	}

	protected void CircleAreaHit(AdventureActor actor, TSVector2 position, FP positionY, string fxPath, FP radius, int hitDamageId, int uniqueAttackId)
	{
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.position = position;
		_areaHitConfig.fxPositionY = (float)positionY;
		_areaHitConfig.fxAlias = fxPath;
		_areaHitConfig.hitDamageId = hitDamageId;
		_areaHitConfig.uniqueAttackId = uniqueAttackId;
		_areaHitConfig.hittedEffectAlias = "";
		_areaHitConfig.damageImmuneDuration = -1;
		ILRuntimeAPI.CircleAreaHit(actor, _areaHitConfig, radius, 0);
	}

	protected IEnumerator CircleAreaHit_12(AdventureActor actor, TSVector2 position, FP positionY, string fxPath, FP radius, int hitDamageId, int uniqueAttackId)
	{
		yield return explosionDelay_12;
		CircleAreaHit(actor, position, positionY, fxPath, radius, hitDamageId, uniqueAttackId);
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		_ = _evt.from;
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_Explosion))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501508, out var perkLevel) && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_InnerCircle))
		{
			AdventureActor.AddFromAttr(additionalAttrIdDic_8.get_Item(perkLevel), _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501509, out var perkLevel2))
		{
			AdventureActor.AddFromAttr(additionalAttrIdDic_9.get_Item(perkLevel2), _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501514, out var perkLevel3) && CheckPerkCDTimeout(501514, cd_14) && (CommonUtils.CheckElementMark(CommonDefine.Water, monsterAdventureActor) || TSRandom.Range(FP.Zero, 100) <= triggerPercentageDic_14.get_Item(perkLevel3)))
		{
			AdventureActor.AddFromAttr(additionalAttrIdDic_14.get_Item(perkLevel3), _actor);
			monsterAdventureActor.buffComponent.AddBuff(4100, _actor);
			TriggerPerk(501514);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501518, out var _) && _triggerTimes_Task3 != null && _triggerTimes_Task3.ContainsKey(_evt.uniqueAttackId))
		{
			int num = _triggerTimes_Task3.get_Item(_evt.uniqueAttackId);
			if (num > 0)
			{
				AdventureActor.AddFromAttr(30, _actor, num);
			}
		}
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		_ = _evt.from;
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_Explosion) && ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501512, out var perkLevel) && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_12))
		{
			monsterAdventureActor.buffComponent.AddBuff(buffIdDic_12.get_Item(perkLevel), _actor);
		}
	}

	protected void OnDropFinish(IEvent evt)
	{
		if (!ModuleController<AdventureModuleController>.Instance.GetThemePerkLevel(501513, out var perkLevel))
		{
			return;
		}
		AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
		long entityID = adventureDropFinishEvent.entityID;
		if (_dropDic_13 == null || !_dropDic_13.ContainsKey(entityID))
		{
			return;
		}
		if (adventureDropFinishEvent.isPickUp)
		{
			TriggerSoltType key = _dropDic_13.get_Item(entityID);
			if (_triggerCDDic.ContainsKey(key))
			{
				_triggerCDDic.get_Item(key) -= reduceCDDic_13.get_Item(perkLevel);
				_triggerCDDic.set_Item(key, (_triggerCDDic.get_Item(key) >= 0) ? _triggerCDDic.get_Item(key) : ((FP)0));
			}
		}
		_dropDic_13.Remove(entityID);
	}

	protected void Clear()
	{
		_dropDic_13?.Clear();
		_triggerTimes_15 = 0;
		_triggerTimes_Task2 = 0;
		_triggerTimes_Task3?.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		Clear();
	}
}
