using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Trigger;

public class AttackFromYiYe : SkillSimpleBase
{
	private List<string> SnipeFXs = new List<string> { "Actor/Character/14501/FX/fx_14501_base_P1_Sniper01", "Actor/Character/14501/FX/fx_14501_base_P1_Sniper02", "Actor/Character/14501/FX/fx_14501_base_P1_Sniper03", "Actor/Character/14501/FX/fx_14501_base_P1_Sniper04" };

	private string StellRainFX = "Actor/Character/14501/FX/fx_14501_bullet_Skill_Sup_SteelRain";

	private readonly List<FP> BuffList = new List<FP> { 999002110, 999002120, 999002150 };

	private TSVector2 PlayPosition;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", SniperShootEvent);
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", SniperShootEvent);
	}

	protected override IEnumerator DoMainLogic()
	{
		while (GetBuffNum(_actor, 999002130) == 0)
		{
			yield return null;
		}
		yield return WaitTime(2);
		StartCor(SteelRain());
		yield return WaitTime(20);
		StartCor(SnipeFinalBattle());
		while (true)
		{
			yield return null;
		}
	}

	private void SniperShootEvent(IEvent evt)
	{
		AdventureActorGetBuff obj = evt as AdventureActorGetBuff;
		int buffId = obj.eventInfo.buffId;
		AdventureActor adventureActor = obj.sender as AdventureActor;
		if (BuffList.Contains(buffId) && adventureActor != _actor)
		{
			string fX = SnipeFXs.get_Item((int)(long)GetRandomValue(0, 3.99, isInt: true));
			FP wtime = 0;
			switch (buffId)
			{
			case 999002110:
				wtime = 0;
				break;
			case 999002120:
				wtime = 2;
				break;
			case 999002150:
				wtime = 4;
				break;
			}
			StartCor(SnipeShoot(wtime, fX, adventureActor));
		}
	}

	private IEnumerator SnipeShoot(FP Wtime, string FX, LogicEntity sender)
	{
		yield return WaitTime(Wtime);
		if (sender != null)
		{
			AttackFromYiYe attackFromYiYe = this;
			TSVector2 entityPosition = GetEntityPosition(sender);
			long id = attackFromYiYe.PlayEffect(FX, 1f, default, entityPosition);
			AdventureActor kill = sender as AdventureActor;
			for (int i = 0; i < 9; i++)
			{
				ModifyEffectPosition(id, default, default, sender);
				yield return WaitTime(0.1f);
			}
			kill.DestroySelf();
		}
	}

	private IEnumerator SnipeFinalBattle()
	{
		while (true)
		{
			LogicEntity attackTarget = (GetCurrentPlayer() as AdventureActor).attackTarget;
			if (attackTarget != null)
			{
				string fX = SnipeFXs.get_Item((int)(long)GetRandomValue(0, 3.99, isInt: true));
				StartCor(SnipeShoot(0, fX, attackTarget));
				yield return WaitTime(1.75);
			}
			else
			{
				yield return WaitTime(0.1);
			}
		}
	}

	private IEnumerator SteelRain()
	{
		while (true)
		{
			LogicEntity attackTarget = (GetCurrentPlayer() as AdventureActor).attackTarget;
			if (attackTarget != null)
			{
				FP randomValue = GetRandomValue(0, 360, isInt: true);
				AttackFromYiYe attackFromYiYe = this;
				TSVector2 entityPosition = GetEntityPosition(attackTarget);
				FP width = 10;
				FP length = 4;
				FP rotation = randomValue;
				DeterministicShape attackshape = attackFromYiYe.GetShapeData(DeterministicShape.ShapeType.Rectangle, entityPosition, width, length, default, default, default, rotation);
				AttackFromYiYe attackFromYiYe2 = this;
				string stellRainFX = StellRainFX;
				TSVector2 entityPosition2 = GetEntityPosition(attackTarget);
				rotation = randomValue;
				long StellRainFXID = attackFromYiYe2.PlayEffect(stellRainFX, 1f, default, entityPosition2, rotation);
				for (int i = 0; i < 6; i++)
				{
					List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
					foreach (LogicEntity item in GetTargetsFromShape(attackshape, targetsByFaction))
					{
						AdventureActor adventureActor = item as AdventureActor;
						DirectDamage(adventureActor, (int)((float)adventureActor.actorHealthInfo.hpMax * 0.3f), null);
					}
					yield return WaitTime(0.5f);
				}
				StopEffect(StellRainFXID);
				yield return WaitTime(5);
			}
			else
			{
				yield return WaitTime(0.1);
			}
		}
	}
}
