using System;
using System.Collections;
using TrueSync;
using UnityEngine;

public class AdventureAutoBattleCommands
{
	public enum AutoBattleCommandType
	{
		Standby,
		Attack,
		Skill,
		SkillUltimate,
		Dodge,
		CastSkill_1,
		CastSkill_2,
		CastUltimate_1,
		CastUltimate_2
	}

	public class AutoBattleCommandBase
	{
		private AdventurePlayerController playerController;

		protected PlayerAdventureActor actor;

		protected PlayerSkillCd skillMgr;

		protected int actorID;

		public float holdDuration;

		public virtual bool IsValid => true;

		public AutoBattleCommandBase(int actorID)
		{
			this.actorID = actorID;
		}

		public AutoBattleCommandBase(PlayerAdventureActor actor)
		{
			if (null == actor)
			{
				Debug.LogError("初始化角色为空!");
				return;
			}
			this.actor = actor;
			skillMgr = actor.GetLogicComponent<PlayerSkillCd>();
			playerController = SceneSingleton<AdventurePlayerController>.Instance;
		}

		public virtual bool Execute(Action callback)
		{
			return true;
		}
	}

	public class AutoBattleCommand_Standby : AutoBattleCommandBase
	{
		public AutoBattleCommand_Standby(PlayerAdventureActor actor)
			: base(actor)
		{
		}

		public override bool Execute(Action callback)
		{
			if (null == actor)
			{
				callback?.Invoke();
				return false;
			}
			return actor.StandBy(callback);
		}
	}

	public class AutoBattleCommand_SkillBase : AutoBattleCommandBase
	{
		protected Action callback;

		protected int skillId;

		protected SkillPhaseFeatureFlag flag = SkillPhaseFeatureFlag.Dodge;

		protected ActionKey key = ActionKey.A;

		protected string holdingKey = "";

		private CoroutineNode holdCoroutine;

		public override bool IsValid
		{
			get
			{
				if (skillMgr == null)
				{
					return false;
				}
				skillId = skillMgr.GetCurrentBindSkillId(key);
				return skillMgr.CanUseCD(skillId);
			}
		}

		public AutoBattleCommand_SkillBase(int actorID)
			: base(actorID)
		{
		}

		public AutoBattleCommand_SkillBase(PlayerAdventureActor actor)
			: base(actor)
		{
		}

		public override bool Execute(Action callback)
		{
			this.callback = callback;
			SceneSingleton<AdventurePlayerController>.Instance.AutoBattle_InsertNewOperation(key, ButtonState.Press);
			callback?.Invoke();
			return true;
		}

		protected void CreateSkillFinish(bool success)
		{
			if (!success)
			{
				Failed();
			}
		}

		protected IEnumerator HoldCoroutine()
		{
			yield return holdDuration;
			if (!string.IsNullOrEmpty(holdingKey))
			{
				actor.logicVariable.ToggleLogicTag(holdingKey, value: false);
			}
		}

		protected void Failed()
		{
			callback?.Invoke();
			callback = null;
		}

		protected virtual void OnCastSkillEnd(IEvent ievent)
		{
			AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = (AdventureActorCastSkillEndEvent)ievent;
			if (adventureActorCastSkillEndEvent != null && ((AdventureActor)adventureActorCastSkillEndEvent.sender).Id == actor.Id && skillId == adventureActorCastSkillEndEvent.skillEventInfo?.skillId)
			{
				callback?.Invoke();
				callback = null;
				Debug.LogError($"call back{skillId}");
			}
		}
	}

	public class AutoBattleCommand_Attack : AutoBattleCommand_SkillBase
	{
		public AutoBattleCommand_Attack(PlayerAdventureActor actor)
			: base(actor)
		{
			flag = SkillPhaseFeatureFlag.Normal;
			key = ActionKey.Normal;
		}
	}

	public class AutoBattleCommand_Skill : AutoBattleCommand_SkillBase
	{
		public AutoBattleCommand_Skill(PlayerAdventureActor actor)
			: base(actor)
		{
			flag = SkillPhaseFeatureFlag.Skill1;
			key = ActionKey.B;
			holdingKey = "HoldingKeyD";
		}
	}

	public class AutoBattleCommand_SkillUltimate : AutoBattleCommand_SkillBase
	{
		public AutoBattleCommand_SkillUltimate(PlayerAdventureActor actor)
			: base(actor)
		{
			flag = SkillPhaseFeatureFlag.Ultimate;
			key = ActionKey.D;
		}
	}

	public class AutoBattleCommand_Dodge : AutoBattleCommand_SkillBase
	{
		public AutoBattleCommand_Dodge(PlayerAdventureActor actor)
			: base(actor)
		{
			flag = SkillPhaseFeatureFlag.Dodge;
			key = ActionKey.A;
		}

		protected override void OnCastSkillEnd(IEvent ievent)
		{
			base.OnCastSkillEnd(ievent);
		}
	}

	public class AutoBattleCommand_CastSkill_Support1 : AutoBattleCommand_SkillBase
	{
		public override bool IsValid => true;

		public AutoBattleCommand_CastSkill_Support1(int actorID)
			: base(actorID)
		{
			key = ActionKey.SwitchPreActor;
		}
	}

	public class AutoBattleCommand_CastSkill_Support2 : AutoBattleCommand_SkillBase
	{
		public override bool IsValid => true;

		public AutoBattleCommand_CastSkill_Support2(int actorID)
			: base(actorID)
		{
			key = ActionKey.SwitchNextActor;
		}
	}

	public class AutoBattleCommand_Ultimate_Support1 : AutoBattleCommand_SkillBase
	{
		public override bool IsValid => true;

		public AutoBattleCommand_Ultimate_Support1(int actorID)
			: base(actorID)
		{
			key = ActionKey.SwitchPreWithUltra;
		}
	}

	public class AutoBattleCommand_Ultimate_Support2 : AutoBattleCommand_SkillBase
	{
		public override bool IsValid => true;

		public AutoBattleCommand_Ultimate_Support2(int actorID)
			: base(actorID)
		{
			key = ActionKey.SwitchNextWithUltra;
		}
	}
}
