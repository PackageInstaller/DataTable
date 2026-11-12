using AIScript.Monster.Template;
using AdventureBehaviour;

namespace AIScript.Monster._50161BianSuCiKe;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private static readonly int summonSkillId = 5016105;

	private static readonly int dashSkillId = 5016101;

	private static readonly int shootSkillId = 5016102;

	private static readonly int topdownSkillId = 5016103;

	private static readonly int hideSkillId = 5016104;

	private int _currentSkillId;

	private bool _skillFinishByLostControl;

	public void OnEnable()
	{
		_skillFinishByLostControl = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnStateSwitch);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BIANSUCIKE_MESSAGE", OnReceiveMessage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnStateSwitch);
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (evt is AdventureMonsterBiansucikeMessage adventureMonsterBiansucikeMessage && adventureMonsterBiansucikeMessage.monsterId == _actor.Id)
		{
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_summon")
			{
				_skillFinishByLostControl = false;
				_actor.InterruptForceControl();
				_actor.InterruptChaos();
				CastSkill(summonSkillId);
			}
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_hide_1")
			{
				_actor.logicVariable.SetLogicTagValue("skillType", 1);
				CastSkill(hideSkillId);
			}
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_hide_2")
			{
				_actor.logicVariable.SetLogicTagValue("skillType", 2);
				CastSkill(hideSkillId);
			}
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_dash")
			{
				CastSkill(dashSkillId);
			}
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_shoot")
			{
				CastSkill(shootSkillId);
			}
			if (adventureMonsterBiansucikeMessage.operationType == "castSkill_topDown")
			{
				CastSkill(topdownSkillId);
			}
		}
	}

	private void CastSkill(int skillId)
	{
		if (_actor.state == ActorState.Action || _actor.state == ActorState.Idle)
		{
			_actor.InterruptAttack(force: true);
			_actor.actorSkillManage.DestoryAllSkill();
			_currentSkillId = skillId;
			_skillFinishByLostControl = false;
			ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool result) =>
			{
				if (_actor.state == ActorState.Action)
				{
					SetActorState();
					SendSkillFinishMessage();
				}
				else if (_actor.state == ActorState.LostControl)
				{
					_skillFinishByLostControl = true;
					_actor.InterruptBattleOut();
					_actor.InterruptHideModel();
					_actor.InterruptCloseBlock();
					_actor.InterruptSuperArmor();
				}
				_currentSkillId = 0;
			});
		}
		else if (skillId != hideSkillId)
		{
			SendSkillFinishMessage();
		}
	}

	private void OnStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.Id == _actor.Id && adventureActorStateSwitchEvent._acState == ActorState.Action && _skillFinishByLostControl)
		{
			_actor.logicVariable.SetLogicTagValue("skillType", 1);
			_actor.logicVariable.ToggleLogicTag("FinishByLostControl", value: true);
			CastSkill(hideSkillId);
		}
	}

	private void SetActorState()
	{
		_actor.InterruptBattleOut();
		_actor.InterruptHideModel();
		_actor.InterruptCloseBlock();
		_actor.InterruptSuperArmor();
		if (!_actor.logicVariable.GetLogicTagToggle("SummonToDive"))
		{
			_actor.EnableBattleOut();
			_actor.EnableHideModel();
		}
		else
		{
			_actor.logicVariable.ToggleLogicTag("SummonToDive", value: false);
		}
	}

	private void SendSkillFinishMessage()
	{
		if (_currentSkillId != summonSkillId)
		{
			AdventureMonsterBiansucikeMessage adventureMonsterBiansucikeMessage = AdventureMonsterBiansucikeMessage.Generate();
			adventureMonsterBiansucikeMessage.monsterId = _actor.Id;
			adventureMonsterBiansucikeMessage.operationType = "skillFinish";
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterBiansucikeMessage);
		}
	}
}
