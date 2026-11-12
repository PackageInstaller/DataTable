using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_Ball_Lv6Ball : SkillSimpleBase
{
	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private AdventureActor summoner;

	private string areaEffect;

	private string Warning45;

	private string Warning90;

	private string WarningLoop45;

	private string WarningLoop90;

	private string BlastEffect;

	private FP BlastCountDown;

	private FP BlastStyle;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		isAtk = GetLogicTagToggleValue(_actor, "Attack");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		areaEffect = (isRed ? "AreaEffect_72007_AreaAttack_red" : "AreaEffect_72007_AreaAttack_green");
		Warning45 = (isRed ? "AreaEffect_72007_Warning45_Red" : "AreaEffect_72007_Warning45_Green");
		Warning90 = (isRed ? "AreaEffect_72007_Warning90_Red" : "AreaEffect_72007_Warning90_Green");
		WarningLoop45 = (isRed ? "fx_m72007_loop_warning_45_red_tip" : "fx_m72007_loop_warning_45_green_tip");
		WarningLoop90 = (isRed ? "fx_m72007_loop_warning_red_tip" : "fx_m72007_loop_warning_green_tip");
		BlastEffect = (isRed ? "fx_m72007_base_Red_Attack_Explosion" : "fx_m72007_base_Green_Attack_Explosion");
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 curIndexByPos = Config.GetCurIndexByPos(GetPosition());
		int num = curIndexByPos.x.AsInt();
		int num2 = curIndexByPos.y.AsInt();
		List<int> ranseList = new List<int>();
		for (int i = 0; i < Config.cellCount; i++)
		{
			for (int j = 0; j < Config.cellCount; j++)
			{
				if ((i == num || j == num2) && !Config.IsOutOfRange(i, j))
				{
					int num3 = 0;
					if (num < i)
					{
						num3 = -90;
					}
					else if (num > i)
					{
						num3 = 90;
					}
					else if (num2 > j)
					{
						num3 = 180;
					}
					TSVector2 cellPosByIndex = Config.GetCellPosByIndex(i, j);
					StartCor(WarningAndAttack(Warning90, areaEffect, cellPosByIndex, num3, i == num && j == num2));
					ranseList.Add(Config.GetCellIndexByIndex(i, j));
				}
			}
		}
		while (GetLogicTagToggleValue(_actor, "Lv6CommonWaiting"))
		{
			yield return null;
		}
		BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5);
		Skill_Attack_Ball_Lv6Ball skill_Attack_Ball_Lv6Ball = this;
		string blastEffect = BlastEffect;
		TSVector2 position = GetPosition();
		skill_Attack_Ball_Lv6Ball.PlayEffect(blastEffect, 1f, default, position);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent.intParamList = ranseList;
		adventureActorCustomEvent.intParam = (isRed ? 1 : 2);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		yield return WaitTime(0.75);
		_actor.DestroySelf();
	}

	private IEnumerator WarningAndAttack(string Area1, string Area2, TSVector2 Position, FP Rotation, bool SelfWarningPlay)
	{
		if (!SelfWarningPlay)
		{
			PlayAreaEffect(Area1, Position, Rotation);
		}
		else if (Area1 == Warning45)
		{
			PlayEffect(WarningLoop45, 1f, default, Position);
		}
		else if (Area1 == Warning90)
		{
			PlayEffect(WarningLoop90, 1f, default, Position);
		}
		while (GetLogicTagToggleValue(_actor, "Lv6CommonWaiting"))
		{
			yield return null;
		}
		PlayAreaEffect(Area2, Position);
	}
}
