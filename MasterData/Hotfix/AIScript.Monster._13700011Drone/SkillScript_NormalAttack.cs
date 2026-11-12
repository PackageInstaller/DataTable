using System.Collections;
using AIScript.Utils;

namespace AIScript.Monster._13700011Drone;

public class SkillScript_NormalAttack : SkillSimpleBase
{
	private int keyIndex = 1;

	private PlayerAdventureActor _summoner;

	private string _skillCombo;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!(PickTarget() == null))
		{
			if (_summoner == null)
			{
				_skillCombo = (string.IsNullOrEmpty(_skillCombo) ? "Atk1" : _skillCombo);
			}
			else
			{
				_skillCombo = (CommonUtils.HavePersonalPerk(_summoner.dataID, 513728, out var _) ? "Atk1_P28" : "Atk1");
			}
			BeginAttack(keyIndex, _skillCombo, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private AdventureActor PickTarget()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null && activedPlayerActor.attackTarget != null && !activedPlayerActor.attackTarget.IsDead())
		{
			return activedPlayerActor.attackTarget as AdventureActor;
		}
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false) as AdventureActor;
	}
}
