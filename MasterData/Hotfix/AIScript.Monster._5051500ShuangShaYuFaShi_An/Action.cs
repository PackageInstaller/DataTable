using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_An;

public class Action : AIBase
{
	protected enum Stage
	{
		Common,
		Fury
	}

	protected enum SkillId
	{
		QianShui = 5052000,
		QianShui_QiangHua = 5052004,
		AnYingQiu = 5052002,
		AnYingQiu_QiangHua = 5052006,
		AnYingChongJi = 5052001,
		AnYingChongJi_QiangHua = 5052005,
		AnYingGuangShu = 5052003,
		AnYingGuangShu_QiangHua = 5052007
	}

	private readonly int targetMonsterId = 5051500;

	private Stage stage;

	private SkillId curSkillId = SkillId.QianShui;

	private int qianshuiCount;

	private bool playOtherRdm;

	private int noCount;

	private bool forceQiangHuaGuangShu;

	public void OnEnable()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		stage = Stage.Common;
	}

	public void OnDisable()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		instance.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	private void MonsterDied(IEvent ievent)
	{
		if (ievent != null && ((AdventureMonsterDiedEvent)ievent).id == targetMonsterId)
		{
			ResetStage(Stage.Fury);
		}
	}

	public void OnStart()
	{
		ResetStage(Stage.Common, switchFlow: true);
		SwitchStageFlow();
	}

	public void OnStop()
	{
	}

	private void OnCastSkillEnd(IEvent ievent)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = (AdventureActorCastSkillEndEvent)ievent;
		if (adventureActorCastSkillEndEvent != null && ((AdventureActor)adventureActorCastSkillEndEvent.sender).Id == _actor.Id)
		{
			SwitchStageFlow();
		}
	}

	private void SwitchStageFlow()
	{
		if (stage == Stage.Common)
		{
			CommonFlow();
		}
		else if (stage == Stage.Fury)
		{
			FuryFlow();
		}
	}

	private void ResetStage(Stage stage, bool switchFlow = false)
	{
		this.stage = stage;
		qianshuiCount = 0;
	}

	private void CommonFlow()
	{
		if (qianshuiCount < 2)
		{
			ILRuntimeAPI.CreateSkill(5052000, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			qianshuiCount++;
		}
		else
		{
			qianshuiCount = 0;
			SwitchSkill();
		}
		void SwitchSkill()
		{
			if (playOtherRdm)
			{
				playOtherRdm = false;
				int num = TSRandom.Range(0, 2);
				if (curSkillId == SkillId.AnYingChongJi)
				{
					if (num <= 1)
					{
						curSkillId = SkillId.AnYingQiu;
					}
					else
					{
						curSkillId = SkillId.AnYingGuangShu;
					}
				}
				else if (curSkillId == SkillId.AnYingGuangShu)
				{
					if (num <= 1)
					{
						curSkillId = SkillId.AnYingQiu;
					}
					else
					{
						curSkillId = SkillId.AnYingChongJi;
					}
				}
				else if (curSkillId == SkillId.AnYingQiu)
				{
					if (num <= 1)
					{
						curSkillId = SkillId.AnYingChongJi;
					}
					else
					{
						curSkillId = SkillId.AnYingGuangShu;
					}
				}
			}
			else
			{
				FP fP = TSVector2.Distance(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position);
				if (fP <= 3)
				{
					if (curSkillId == SkillId.AnYingChongJi)
					{
						playOtherRdm = true;
					}
					curSkillId = SkillId.AnYingChongJi;
				}
				else if (fP <= 6)
				{
					if (curSkillId == SkillId.AnYingGuangShu)
					{
						playOtherRdm = true;
					}
					curSkillId = SkillId.AnYingGuangShu;
				}
				else
				{
					if (curSkillId == SkillId.AnYingQiu)
					{
						playOtherRdm = true;
					}
					curSkillId = SkillId.AnYingQiu;
				}
			}
			ILRuntimeAPI.CreateSkill((int)curSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
		}
	}

	private void FuryFlow()
	{
		if (forceQiangHuaGuangShu)
		{
			ILRuntimeAPI.CreateSkill(5052007, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			forceQiangHuaGuangShu = false;
			qianshuiCount = 0;
			noCount = 0;
			return;
		}
		if (qianshuiCount < 1)
		{
			qianshuiCount++;
			if (noCount >= 2)
			{
				_actor.logicVariable.SetLogicTagValue("QiangHuaQianShui", 1);
			}
			else
			{
				_actor.logicVariable.SetLogicTagValue("QiangHuaQianShui", 0);
			}
			ILRuntimeAPI.CreateSkill(5052004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			return;
		}
		qianshuiCount = 0;
		if (noCount >= 2)
		{
			ILRuntimeAPI.CreateSkill((int)curSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			forceQiangHuaGuangShu = false;
			qianshuiCount = 0;
			noCount = 0;
		}
		else
		{
			SwitchSkill();
		}
		void SwitchSkill()
		{
			FP fP = TSVector2.Distance(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position);
			if (fP <= 3)
			{
				noCount++;
				forceQiangHuaGuangShu = false;
				ILRuntimeAPI.CreateSkill(5052005, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			}
			else if (fP <= 6)
			{
				noCount++;
				forceQiangHuaGuangShu = false;
				ILRuntimeAPI.CreateSkill(5052006, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			}
			else
			{
				noCount = 0;
				forceQiangHuaGuangShu = true;
				_actor.logicVariable.SetLogicTagValue("QiangHuaQianShui", 1);
				ILRuntimeAPI.CreateSkill(5052004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false);
			}
		}
	}
}
