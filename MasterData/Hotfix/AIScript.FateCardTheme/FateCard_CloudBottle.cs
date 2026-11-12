#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_CloudBottle : BaseFateCardTheme
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

	private const string bulletPath_CloudBottle = "FateCard_CloudBottle_base";

	private readonly FP cd = 3;

	private const string fxPath_CloudBottle = "water_cloudbottle_center_1";

	private readonly List<FP> explosionTimesRatioList = new List<FP> { 20, 30, 50 };

	private readonly FP interval_Explosion = 0.3;

	private const int hitDamageId_InnerCircle = 986191;

	private const int hitDamageId_CenterCircle = 986191;

	private const int hitDamageId_OuterCircle = 986191;

	private const string fxPath_InnerCircle = "water_cloudbottle_a";

	private readonly FP radius_InnerCircle = 2;

	private static readonly int damageTag_InnerCircle = CommonHelper.StringToHash("CloudBottle_a");

	private const string fxPath_CenterCircle = "water_cloudbottle_b";

	private readonly FP radius_CenterCircle = 3;

	private const string damageTag_CenterCircle = "CloudBottle_b";

	private const string fxPath_OuterCircle = "water_cloudbottle_c";

	private readonly FP radius_OuterCircle = 5;

	private const string damageTag_OuterCircle = "CloudBottle_c";

	private const string fxPath_Hitted = "";

	private readonly FP fxDelayTime_AfterExplosion = 0.6f;

	private const string bulletPath_11 = "FateCard_CloudBottle_11";

	private const int minShootCount_11 = 3;

	private const int maxShootCount_11 = 5;

	private readonly FP searchTargetRadius_11 = 10;

	private const int addExplosionTimes_Task1 = 3;

	private const string BulletTag_CloudBottle = "CloudBottleBullet";

	private List<FP> _curExplosionTimesRatioList;

	private FP _totalExplosionTimesRatio;

	private Dictionary<string, GameObject> _fxPrefabDic;

	private CommomAreaHitConfig _areaHitConfig;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_CloudBottle OnEnable");
		base.OnEnable();
		_curExplosionTimesRatioList = explosionTimesRatioList;
		for (int i = 0; i < _curExplosionTimesRatioList.Count; i++)
		{
			_totalExplosionTimesRatio += _curExplosionTimesRatioList.get_Item(i);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_curExplosionTimesRatioList?.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_CloudBottle OnTrigger");
		if (CheckTimeout(cd) && ShootCloudBottle(TriggerSoltType.Normal))
		{
			TriggerTheme();
		}
	}

	protected bool ShootCloudBottle(TriggerSoltType slotType)
	{
		LogicEntity logicEntity = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (logicEntity == null)
		{
			return false;
		}
		int num = 0;
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("FateCard_CloudBottle_base", _actor, default, _actor.tsTransform.Position, default, logicEntity.tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
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
		if (array.Length >= 3 || string.Equals(array[0], "CloudBottleBullet"))
		{
			CommonUtils.TryParseStringParamToInt(array[1], out var intValue);
			if (intValue != 0)
			{
				CommonUtils.TryParseStringParamToInt(array[2], out var intValue2);
				StartLogicCoroutine(CloudBottleExplosion(_evt.owner, _evt.bulletPosition, _evt.bulletPositionY, (TriggerSoltType)intValue, intValue2));
			}
		}
	}

	protected IEnumerator CloudBottleExplosion(AdventureActor actor, TSVector2 position, FP positionY, TriggerSoltType soltType = TriggerSoltType.Normal, int bulletPerkId = 0)
	{
		int totalTimes = 1;
		string fxPath = "water_cloudbottle_center_1";
		FP fP = TSRandom.Range(0f, _totalExplosionTimesRatio);
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
		if (CanExcuteB)
		{
			totalTimes += 3;
			random = true;
		}
		AdventureFXPlayer fxPlayer = null;
		GameObject cloudBottleFx = GetCloudBottleFx(fxPath);
		if (cloudBottleFx != null)
		{
			fxPlayer = AdventureFXPlayer.PlayFX(cloudBottleFx, 1f, new Vector3((float)position.x, (float)positionY, (float)position.y), Quaternion.identity);
		}
		int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		while (true)
		{
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
	}

	protected void CircleAreaHit(AdventureActor actor, TSVector2 position, FP positionY, CircleHitType circleHitType, TriggerSoltType soltType, int uniqueAttackId, int bulletPerkId = 0)
	{
		switch (circleHitType)
		{
		case CircleHitType.Inner:
			CircleAreaHit(actor, position, positionY, "water_cloudbottle_a", radius_InnerCircle, 986191, uniqueAttackId);
			break;
		case CircleHitType.Center:
			CircleAreaHit(actor, position, positionY, "water_cloudbottle_b", radius_CenterCircle, 986191, uniqueAttackId);
			break;
		case CircleHitType.Outer:
			CircleAreaHit(actor, position, positionY, "water_cloudbottle_c", radius_OuterCircle, 986191, uniqueAttackId);
			break;
		}
	}

	private void CircleAreaHit(AdventureActor actor, TSVector2 position, FP positionY, string fxPath, FP radius, int hitDamageId, int uniqueAttackId)
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

	private GameObject GetCloudBottleFx(string fxPath)
	{
		if (_fxPrefabDic == null)
		{
			_fxPrefabDic = new Dictionary<string, GameObject>(2);
		}
		if (!_fxPrefabDic.ContainsKey(fxPath))
		{
			GameObject fxByAlias = ModuleController<AdventureModuleController>.Instance.GetFxByAlias(_actor, fxPath, forceUseCommonConfig: true);
			_fxPrefabDic.Add(fxPath, fxByAlias);
		}
		return _fxPrefabDic.get_Item(fxPath);
	}

	private FP GetLeftRatioByIndex(int index)
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

	private void OnAfterSingleCloudBottleExplosion(int times, AdventureActor actor, TSVector2 position, FP positionY, int uniqueAttackId)
	{
		if (!CanExcuteA)
		{
			return;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(actor, position, searchTargetRadius_11, (List<LogicEntity> targets) =>
		{
			if (targets.Count > 0)
			{
				int num = TSRandom.Range(3, 6);
				int num2 = 0;
				for (int i = 0; i < targets.Count; i++)
				{
					ILRuntimeAPI.Shoot("FateCard_CloudBottle_11", actor, default, position, default, targets.get_Item(i).tsTransform.Position, null, AimType.Position, BulletDirectionType.BulletToTarget);
					num2++;
					if (num2 >= num)
					{
						break;
					}
				}
			}
		}, isConfront: true);
	}
}
