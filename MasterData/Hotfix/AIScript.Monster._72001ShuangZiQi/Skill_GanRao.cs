using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_GanRao : SkillSimpleBase
{
	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int spawnCount;

	private Queue<LogicEntity> queue = new Queue<LogicEntity>();

	private int totalCount;

	private int SummonBallID_AnotherColor;

	private int AttackTimesCount;

	private string Color;

	private string AttackStartFXName;

	private string LinkFXName;

	private string AreaAimFXName;

	private string LinkEndFXName;

	private string LinkBulletFXName;

	private string WarningFXName;

	private string WarningFinalFXName;

	private long LinkFX;

	private long LinkEndFX;

	private long WarningFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		spawnCount = 0;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		isAtk = GetLogicTagToggleValue(_actor, "Attack");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		GetTargetByTeammateIndex(6);
		AttackTimesCount = Config.UltraSkillAttackTimes.get_Item(lv - 1);
		if (phase != 3)
		{
			AttackTimesCount = 3;
		}
		ChessInitialize();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		SetLogicTagToggleValue(_actor, Config.Skill_GanRao_Finish, value: true);
		queue.Clear();
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (phase <= 2)
		{
			yield return WaitTime(0.25);
		}
		BeginAttack(1, "Noise", flushInputedKeys: true, forceInterruptAttack: true);
		Skill_GanRao skill_GanRao = this;
		string attackStartFXName = AttackStartFXName;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		long AttackStartFX = skill_GanRao.PlayEffect(attackStartFXName, 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < AttackTimesCount; i++)
		{
			FP timecount = 0;
			TSVector2 currentindex = Config.GetCurIndexByPos(GetEntityPosition(GetCurrentPlayer()));
			Skill_GanRao skill_GanRao2 = this;
			Skill_GanRao skill_GanRao3 = this;
			string linkFXName = LinkFXName;
			AdventureActor actor = _actor;
			position = Config.GetCellPosByIndex(currentindex);
			skill_GanRao2.LinkFX = skill_GanRao3.PlayLinkEffect(linkFXName, useCustomSource: false, actor, default, default, null, position, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true);
			while (timecount < 27)
			{
				TSVector2 curIndexByPos = Config.GetCurIndexByPos(GetEntityPosition(GetCurrentPlayer()));
				if (currentindex != curIndexByPos)
				{
					StopEffect(LinkFX);
					currentindex = curIndexByPos;
					Skill_GanRao skill_GanRao4 = this;
					Skill_GanRao skill_GanRao5 = this;
					string linkFXName2 = LinkFXName;
					AdventureActor actor2 = _actor;
					position = Config.GetCellPosByIndex(currentindex);
					skill_GanRao4.LinkFX = skill_GanRao5.PlayLinkEffect(linkFXName2, useCustomSource: false, actor2, default, default, null, position, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true);
				}
				timecount += (FP)1;
				yield return WaitTime(0.033);
			}
			TSVector2 curIndexByPos2 = Config.GetCurIndexByPos(GetEntityPosition(GetCurrentPlayer()));
			TSVector2 finalpos = Config.GetCellPosByIndex(curIndexByPos2);
			WarningFX = PlayEffect(WarningFXName, 0.667f, default, finalpos);
			StopEffect(LinkFX);
			LinkEndFX = PlayLinkEffect(LinkEndFXName, useCustomSource: false, _actor, default, default, null, finalpos, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true);
			yield return WaitTime(2.8);
			StopEffect(LinkEndFX);
			PlayEffect(WarningFinalFXName, 1f, default, finalpos);
			PlayLinkEffect(LinkBulletFXName, useCustomSource: false, _actor, default, default, null, finalpos, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true, 0.667f);
			yield return WaitTime(0.3);
			PlayAreaEffect("NoiseArea", finalpos);
		}
		CancelAttack();
		StopEffect(AttackStartFX);
		StopEffect(LinkFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		_ = evt is AdventureActorDiedEvent;
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		_ = adventureActorCustomEvent.sender;
		if (adventureActorCustomEvent.eventHashCode == Config.bollSpawnEvt)
		{
			queue.Enqueue(adventureActorCustomEvent.target);
			totalCount = adventureActorCustomEvent.intParam;
		}
	}

	private void OnActorStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.dataId == SummonBallID_AnotherColor && adventureActorStateSwitchEvent._acState == ActorState.Action)
		{
			spawnCount++;
		}
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "Red";
		}
		else
		{
			Color = "Green";
		}
		AttackStartFXName = "fx_m72001_loop_Skill06_" + Color + "_show_self_02";
		LinkFXName = "fx_m72001_loop_skill06_" + Color + "_link";
		AreaAimFXName = "fx_m72004_loop_atk_self_5x5_" + Color;
		LinkEndFXName = "fx_m72001_loop_skill06_" + Color + "_link_end";
		LinkBulletFXName = "fx_m72001_bullet_skill06_" + Color + "_link";
		WarningFXName = "Skill06_" + Color + "_warning_15x15";
		WarningFinalFXName = "Skill06_" + Color + "_warning_15x15_end";
	}
}
