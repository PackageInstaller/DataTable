#define LOG_DEBUG
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_EarthQuake : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string normalPath_Quake = "FateCard_EarthQuake";

	private readonly int normal_damageId = 986461;

	private readonly int onceId_proA = 30;

	private readonly int count_max = 10;

	private readonly FP cd_proA = 3;

	private readonly int quakeAtk_Tag = CommonHelper.StringToHash("EarthQuake");

	private readonly int proA_damageId = 986462;

	private readonly string probPath_Quake = "FateCard_EarthQuake_B";

	private readonly int proB_damageId = 986463;

	private readonly int proC_damageId = 986464;

	private Dictionary<long, int> monsterBehitCouts = new Dictionary<long, int>();

	private Dictionary<long, FP> monsterBehitTime = new Dictionary<long, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		monsterBehitCouts?.Clear();
		monsterBehitTime?.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_EarthQuake OnTrigger");
		if (CheckTimeout(cd) && ShowEarthQuake())
		{
			TriggerTheme();
		}
	}

	private bool ShowEarthQuake()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		attackTarget = attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, 10);
		if (attackTarget == null)
		{
			return false;
		}
		string fxAlias = normalPath_Quake;
		int hitId = normal_damageId;
		if (CanExcuteA)
		{
			hitId = proA_damageId;
		}
		if (CanExcuteB)
		{
			hitId = proB_damageId;
			fxAlias = probPath_Quake;
		}
		if (CanExcuteC)
		{
			hitId = proC_damageId;
		}
		PlayAreaEffect(fxAlias, attackTarget.tsTransform.Position, hitId);
		return true;
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		if (!CanExcuteA && !CanExcuteC)
		{
			return;
		}
		AdventureActor adventureActor = _evt.from as AdventureActor;
		if (!(_evt.to != null) || !(adventureActor != null) || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, quakeAtk_Tag))
		{
			return;
		}
		long id = _evt.to.Id;
		if (monsterBehitCouts.TryGetValue(id, out var value))
		{
			if (monsterBehitTime.TryGetValue(id, out var value2) && _actor.LogicTime - value2 < cd_proA)
			{
				value++;
				value = ((value > count_max) ? count_max : value);
				monsterBehitTime.set_Item(id, _actor.LogicTime);
				monsterBehitCouts.set_Item(id, value);
				AdventureActor.AddFromAttr(onceId_proA, _actor, value);
			}
			else
			{
				AdventureActor.AddFromAttr(onceId_proA, _actor);
				monsterBehitCouts.set_Item(id, 1);
				monsterBehitTime.set_Item(id, _actor.LogicTime);
			}
		}
		else
		{
			AdventureActor.AddFromAttr(onceId_proA, _actor);
			monsterBehitCouts.Add(id, 1);
			monsterBehitTime.Add(id, _actor.LogicTime);
		}
	}
}
