#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_LightingBolt : BaseFateCardTheme
{
	private readonly int damageId = 986341;

	private readonly FP cd = 2;

	private readonly FP circleRadius = 5;

	private const string triggerFxPath = "light_trigger_s";

	private readonly string fireBullut = "FateCard_LightningBolt";

	private static readonly int fireTag = CommonHelper.StringToHash("Lightning");

	private static readonly int fireTag2 = CommonHelper.StringToHash("LightningPro");

	private readonly string fireBullut_Big = "FateCard_LightningBolt_08";

	private readonly string strongBullut_Big = "FateCard_LightningBolt_11q1";

	private readonly int buff_11 = 986341;

	private readonly int prob_11 = 50;

	private int buff_Strong = 986340;

	private int damageId_ProB = 986342;

	private readonly string strongBullut = "FateCard_LightningBolt_1q1";

	private int maxShootRC = 5;

	private AdventureTimeBomb bulletObj;

	private string tagCastCount = "CastCount_Blot";

	private bool isInStrongState => _actor.buffComponent.CheckBuffByBuffID(buff_Strong);

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_LightingBolt OnEnable");
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ClearKey(tagCastCount);
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_LightingBolt OnTrigger");
		if (CheckTimeout(cd))
		{
			Shoot(_actor.attackTarget, damageId);
			TriggerTheme();
		}
	}

	private void Shoot(LogicEntity target, int hitDamageId)
	{
		target = ((target != null) ? target : CommonUtils.SearchNearTargetByCircle(_actor, circleRadius));
		if (!(target == null))
		{
			CommonUtils.PlayOneOffFx(_actor, "light_trigger_s");
			string bullet = GetBullet();
			AdventureActor actor = _actor;
			TSVector2 position = target.tsTransform.Position;
			TSVector2 position2 = target.tsTransform.Position;
			bulletObj = ILRuntimeAPI.Shoot(bullet, actor, default, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget) as AdventureTimeBomb;
			bulletObj.hitBox.hitDamageId = hitDamageId;
			bulletObj.ModifyBulletTag(0);
			if (isInStrongState)
			{
				bulletObj.hitBox.hitDamageId = damageId_ProB;
			}
			if (CanExcuteB && !isInStrongState)
			{
				AddKey(tagCastCount);
				RefreshShootRC();
			}
		}
	}

	private void RefreshShootRC()
	{
		if (GetKeyCount(tagCastCount) >= maxShootRC)
		{
			ClearKey(tagCastCount);
			EnterStrongState();
		}
	}

	private void EnterStrongState()
	{
		_actor.buffComponent.AddBuff(buff_Strong, _actor);
	}

	private string GetBullet()
	{
		string result = (isInStrongState ? strongBullut : fireBullut);
		if (CanExcuteA)
		{
			result = (isInStrongState ? strongBullut_Big : fireBullut_Big);
		}
		return result;
	}

	protected override void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		base.OnHitPre(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag);
			bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, fireTag2);
			if ((flag | flag2) && CanExcuteA && TSRandom.Range(0, 100) <= prob_11 && monsterAdventureActor != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_11, _actor);
			}
		}
	}
}
