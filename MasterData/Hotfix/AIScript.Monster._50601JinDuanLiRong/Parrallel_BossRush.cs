using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Parrallel_BossRush : Parallel_BossRush
{
	private readonly int hitTag = CommonHelper.StringToHash("TornadoDamage");

	private readonly FP liveTime = 2;

	private FP cd_Time_1 = 0.5;

	private readonly string In_CheckBossScro_Tag1 = "In_CheckBossScro_Tag1";

	private readonly int hitTag2 = CommonHelper.StringToHash("CombDamage");

	private readonly FP liveTime2 = 2;

	private readonly FP cd_Time_2 = 0.5;

	private readonly string In_CheckBossScro_Tag2 = "In_CheckBossScro_Tag2";

	private string bossTagId = "100003";

	private int interval = 5;

	private int buff_boss = 631004001;

	private int buff_player = 631004002;

	private FP addEnergy = 20;

	private string xsTagId = "100014";

	private int interval_xs = 1;

	private int buff_xs_self = 631014001;

	private int buff_xs_main_1 = 631014001;

	private int buff_xs_main_2 = 631014002;

	private string pjTagId = "100021";

	private int markCount_pj = 4;

	private int buff_poJia = 631021020;

	private CoroutineNode corCheckHit;

	private FP currenCD;

	private FP dration;

	private bool hasTag;

	private CoroutineNode corBuff;

	private bool hasXsTag;

	private CoroutineNode corXs;

	private bool hasPjTag;

	private int markHitCount_pj;

	public override void OnStart()
	{
		base.OnStart();
		currenCD = 0;
		StartCoroutine(ref corCheckHit, DoCheckHit());
		hasTag = _actor.CheckTag(bossTagId);
		if (hasTag)
		{
			StartCoroutine(ref corBuff, DoAddBuff());
		}
		hasXsTag = _actor.CheckTag(xsTagId);
		if (hasXsTag)
		{
			StartCoroutine(ref corXs, DoXuShi());
		}
		hasPjTag = _actor.CheckTag(pjTagId);
		if (hasPjTag)
		{
			markHitCount_pj = 0;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corCheckHit);
		StopCoroutine(ref corBuff);
		StopCoroutine(ref corXs);
	}

	private bool CheckTag(string tag)
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor == null || activedPlayerActor.IsDead())
		{
			return false;
		}
		if (string.IsNullOrEmpty(tag))
		{
			return false;
		}
		if (_actor.logicVariable == null)
		{
			return false;
		}
		return _actor.logicVariable.GetLogicTagToggle(tag);
	}

	private IEnumerator DoCheckHit()
	{
		dration = 0;
		while (true)
		{
			if (CheckTag(In_CheckBossScro_Tag1) && currenCD <= 0)
			{
				if (dration >= liveTime)
				{
					dration = 0;
					if (_monster.CheckScoreBossBehaviour(16))
					{
						_monster.TriggerScoreBossBehaviour(16);
					}
				}
				dration += _actor.LogicDeltaTime;
			}
			else if (CheckTag(In_CheckBossScro_Tag2) && currenCD <= 0)
			{
				if (dration >= liveTime2)
				{
					dration = 0;
					if (_monster.CheckScoreBossBehaviour(17))
					{
						_monster.TriggerScoreBossBehaviour(17);
					}
				}
				dration += _actor.LogicDeltaTime;
			}
			else
			{
				dration = 0;
			}
			currenCD -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.to is PlayerAdventureActor)
		{
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag))
			{
				currenCD = cd_Time_1;
				dration = 0;
			}
			else if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, hitTag2))
			{
				currenCD = cd_Time_2;
				dration = 0;
			}
		}
	}

	private IEnumerator DoAddBuff()
	{
		bool isAction = false;
		while (true)
		{
			if (!isAction)
			{
				if (_actor.state == ActorState.Action)
				{
					isAction = true;
				}
				yield return null;
			}
			else
			{
				_actor.buffComponent.AddBuff(buff_boss, _actor);
				yield return _actor.WaitTime(interval);
			}
		}
	}

	private IEnumerator DoXuShi()
	{
		while (_actor.state != ActorState.Action)
		{
			yield return null;
		}
		List<PlayerAdventureActor> assists = new List<PlayerAdventureActor>();
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist)
			{
				assists.Add(playerAdventureActor);
			}
		}
		if (assists.Count == 0)
		{
			yield break;
		}
		int[] buffMainMap = new int[assists.Count];
		buffMainMap[0] = buff_xs_main_1;
		if (assists.Count > 1)
		{
			buffMainMap[1] = buff_xs_main_2;
		}
		FP[] timers = new FP[assists.Count];
		while (true)
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			for (int j = 0; j < assists.Count; j++)
			{
				PlayerAdventureActor playerAdventureActor2 = assists.get_Item(j);
				if (playerAdventureActor2 == null || playerAdventureActor2.IsDead())
				{
					continue;
				}
				if (playerAdventureActor2.isResident)
				{
					timers[j] += _actor.LogicDeltaTime;
					if (timers[j] >= interval_xs)
					{
						timers[j] = 0;
						playerAdventureActor2.buffComponent.AddBuff(buff_xs_self, playerAdventureActor2);
						if (activedPlayerActor != null && !activedPlayerActor.IsDead())
						{
							activedPlayerActor.buffComponent.AddBuff(buffMainMap[j], playerAdventureActor2);
						}
					}
				}
				else
				{
					timers[j] = 0;
				}
			}
			yield return null;
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		if (elementMarkTriggerEvent.markActor != _actor)
		{
			return;
		}
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (hasTag && activedPlayerActor != null && elementMarkTriggerEvent.triggerActor == activedPlayerActor && _actor.buffComponent.RemoveBuffByBuffId(buff_boss, 1))
		{
			_actor.buffComponent.AddBuff(buff_player, _actor);
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).playerSkillCd.AddEnergy(addEnergy);
			}
		}
		if (hasPjTag)
		{
			OnMarkTrigger_PoJia();
		}
	}

	private void OnMarkTrigger_PoJia()
	{
		markHitCount_pj++;
		if (markHitCount_pj >= markCount_pj)
		{
			markHitCount_pj = 0;
			_actor.buffComponent.AddBuff(buff_poJia, _actor);
		}
	}
}
