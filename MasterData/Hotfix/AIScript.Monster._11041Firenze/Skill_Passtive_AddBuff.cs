using System.Collections;
using TrueSync;

namespace AIScript.Monster._11041Firenze;

public class Skill_Passtive_AddBuff : SkillAdvancedBase
{
	private readonly int buffId = 110410210;

	private readonly int hpPercent = 20;

	private readonly int delayTime = 10;

	private long totleDamage;

	private bool isAnysis;

	private FP timer;

	private CoroutineNode _cdCoroutine;

	private CoroutineNode corMain;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		Clear();
	}

	public void OnStart()
	{
		_actor.EnableLogicUpdate();
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		StopCoroutine(ref _cdCoroutine);
	}

	protected override void OnActorLostControl(IEvent evt)
	{
	}

	private IEnumerator DoMainLogic()
	{
		AddBuff();
		yield return null;
	}

	private void AddBuff()
	{
		BuffCom logicComponent = _actor.GetLogicComponent<BuffCom>();
		if (!logicComponent.CheckBuffByBuffID(buffId))
		{
			logicComponent?.AddBuff(buffId, _actor);
		}
		isAnysis = true;
	}

	private void OnDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.to == _actor && isAnysis)
		{
			totleDamage += adventureActorReceiveDamageEvent.damageToShieldAndHp;
			long num = _actor.actorHealthInfo.hpMax * hpPercent / 100;
			if (totleDamage >= num)
			{
				_actor.GetLogicComponent<BuffCom>()?.RemoveBuffByBuffId(buffId);
				totleDamage = 0L;
				timer = delayTime;
				StartCoroutine(ref _cdCoroutine, cdHandler());
				isAnysis = false;
			}
		}
	}

	private IEnumerator cdHandler()
	{
		while (timer > 0)
		{
			timer -= _actor.LogicDeltaTime;
			yield return null;
		}
		StopCoroutine(ref _cdCoroutine);
		AddBuff();
	}
}
