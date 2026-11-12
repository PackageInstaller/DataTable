#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Shark : BaseFateCardTheme
{
	private readonly string sharkBullut = "FateCard_Shark_Bullet_base";

	private readonly int damageId = 986221;

	private readonly FP cd = 3;

	private readonly FP circleRadius = 15;

	private const string triggerFxPath = "";

	private static readonly int bullutTag = CommonHelper.StringToHash("Shark");

	private static readonly int hitTag_shark = CommonHelper.StringToHash("Shark");

	private static readonly int hitTag_shark_strong = CommonHelper.StringToHash("Shark_Strong");

	private FP baseDelayTime = 0.5;

	private int count_18 = 2;

	private string bullut_18 = "FateCard_Shark_Bullet_18";

	private int hitDmgId_18 = 986222;

	private int buff_18 = 4011;

	private string drop_16 = "FateCard_Shark_Drop_16";

	private int hitDmgId_16 = 986223;

	private readonly int interval_16 = 3;

	private int shootCount;

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private HashSet<long> dropHash_16 = new HashSet<long>();

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_Shark OnEnable");
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		if (CanExcuteB)
		{
			CoroutineNode item = StartLogicCoroutine(IntervalDrop());
			corList.Add(item);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
		shootCount = 0;
		dropHash_16.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_Shark OnTrigger");
		if (CheckTimeout(cd))
		{
			Shoot(sharkBullut, _actor.attackTarget, damageId);
			TriggerTheme();
		}
	}

	private void Shoot(string bullut, LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "");
			string bullut2 = GetBullut();
			AdventureActor actor = _actor;
			FP heightCenter = _actor.dtCollider.HeightCenter;
			LogicEntity target2 = target;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut2, actor, default, default, heightCenter, default, target2, AimType.Target, BulletDirectionType.BulletToTarget);
			adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			if (CanExcuteA && string.Equals(bullut2, bullut_18))
			{
				adventureBulletBase.hitBox.hitDamageId = hitDmgId_18;
			}
			FixBullutInfo(adventureBulletBase, adventureBulletBase.hitBox.hitDamageId);
			RefreshCount(bullut2);
		}
	}

	private IEnumerator IntervalDrop()
	{
		int rawTime = interval_16;
		FP curTime = 0;
		while (true)
		{
			if (curTime < 0)
			{
				long num = ILRuntimeAPI.PlayDrop(_actor, drop_16);
				if (num > 0)
				{
					dropHash_16.Add(num);
				}
				curTime = rawTime;
			}
			curTime -= LogicDeltaTime;
			yield return null;
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		AdventureDropFinishEvent obj = evt as AdventureDropFinishEvent;
		long entityID = obj.entityID;
		if (!obj.isPickUp || !CanExcuteB || !dropHash_16.Contains(entityID))
		{
			return;
		}
		LogicEntity logicEntity = ((_actor.attackTarget != null) ? _actor.attackTarget : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (logicEntity != null)
		{
			string bullut = GetBullut();
			AdventureActor actor = _actor;
			TSVector2 position = logicEntity.tsTransform.Position;
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut, actor, default, default, default, position, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (CanExcuteA && string.Equals(bullut, bullut_18))
			{
				adventureBulletBase.ResetHitID(hitDmgId_18);
			}
			else
			{
				adventureBulletBase.hitBox.hitDamageId = hitDmgId_16;
			}
			RefreshCount(bullut);
		}
		dropHash_16.Remove(entityID);
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark);
			bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_shark_strong);
			if ((flag | flag2) && (CanExcuteA & flag2))
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_18, _actor);
			}
		}
	}

	private void FixBullutInfo(AdventureBulletBase bullCom, int finalHitDmgId)
	{
		bullCom.temphitDmgId = finalHitDmgId;
		bullCom.hitBox.hitDamageId = 986224;
		bullCom.ModifyBulletTag(bullutTag);
	}

	protected override void OnNoDmgHit(AdventureActorNoDamageEvent evt)
	{
		base.OnNoDmgHit(evt);
		if (evt.weapon != null && evt.weapon.CheckBulletTag(bullutTag))
		{
			CoroutineNode item = StartLogicCoroutine(DelayHit(evt.to, evt.weapon.temphitDmgId), runImmediately: true);
			corList.Add(item);
		}
	}

	private IEnumerator DelayHit(LogicEntity to, int hitDmgId)
	{
		yield return baseDelayTime;
		ILRuntimeAPI.HitActor(_actor, to as AdventureActor, hitDmgId);
	}

	private void RefreshCount(string tempBullut)
	{
		if (CanExcuteA && string.Equals(tempBullut, sharkBullut))
		{
			shootCount++;
		}
	}

	private string GetBullut()
	{
		if (CanExcuteA && shootCount >= count_18)
		{
			shootCount = 0;
			return bullut_18;
		}
		return sharkBullut;
	}
}
