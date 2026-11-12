#define LOG_DEBUG
using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11001;

public class SkillScript_Zhukong_Skill : SkillAdvancedBase
{
	private readonly string SkillTag = "110_Mian_Skill_SanLianZhan";

	private readonly string SkillTag_t1 = "110_Mian_Skill_SanLianZhan_T1";

	private readonly string zhFsTag = "110_Main_Skill_ZhaoHuanFenShen";

	private readonly string fsHuiXTag = "110_FenShen_SanLianZhan";

	private const int zhCount = 1;

	private const string fsHuiXTag_t1 = "110_FenShen_SanLianZhan_T1";

	private readonly string event_start_inv = "110CloseCollision";

	private readonly string event_end_inv = "110OpenCollision";

	private int curenFrament;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11001 SkillScript_Zhukong_Skill OnDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
		if (GetPerk(511007))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11050711);
		}
		if (GetPerk(511010))
		{
			Parallel.normalComboTime = _actor.LogicTime;
			_actor.logicVariable.SetLogicTagValue("normalCount", 3);
		}
		_actor.movementFSM.DisableRootMotionForceDir();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11001 SkillScript_Zhukong_Skill OnEnable");
		base.OnSkillEnable();
	}

	public void aimDirec()
	{
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			_actor.CancelAiming();
			_actor.Aim(movementInputDirection);
			_actor.movementFSM.EnableRootMotionForceDir(movementInputDirection);
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("===================_11001 SkillScript_Zhukong_Skill OnStart");
		DefaultLookAt(useInputDirectionFirst: true, useSemiAutoBattleMode: true);
		string text = SkillTag;
		if (GetPerk(511001))
		{
			text = SkillTag_t1;
		}
		string actionTag = text;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnCustomEvent(string eventName)
	{
		if (zhFsTag.Equals(eventName))
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 0);
			int num = 1;
			if (GetPerk(511003))
			{
				num += (int)(long)CommonUtils.GetScriptValue(_actor, 11030011);
			}
			_actor.logicVariable.SetLogicTagValue("fenSheng", num);
		}
		else if (fsHuiXTag.Equals(eventName))
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 2);
			AdventurActorNormalEvent adventurActorNormalEvent = AdventurActorNormalEvent.Generate();
			adventurActorNormalEvent.sender = _actor;
			adventurActorNormalEvent.stateID = 2;
			adventurActorNormalEvent.enventTag = "fsSkill";
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorNormalEvent);
		}
		else if ("110_FenShen_SanLianZhan_T1".Equals(eventName))
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 3);
			AdventurActorNormalEvent adventurActorNormalEvent2 = AdventurActorNormalEvent.Generate();
			adventurActorNormalEvent2.sender = _actor;
			adventurActorNormalEvent2.stateID = 3;
			adventurActorNormalEvent2.enventTag = "fsSkill";
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorNormalEvent2);
		}
		if (eventName.Equals(event_start_inv))
		{
			_actor.movAgent.canBlock = false;
		}
		else if (eventName.Equals(event_end_inv))
		{
			_actor.movAgent.canBlock = true;
		}
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("===================_11001 SkillScript_Zhukong_Skill Skill_1 onFinish");
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		NovaLogger.Debug("===================_11001 SkillScript_Zhukong_Skill onInterrupt");
		_skill.Clear();
	}

	public virtual void OnUpdate()
	{
	}
}
