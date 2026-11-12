using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._14700011DevilSpeaker;

public class Skill_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	private FP range = 1;

	private FP time = 0.5;

	private FP radiusLimit = 5;

	private PlayerAdventureActor summoner;

	private Dash dash = new Dash();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		_actor.EnableUnparalleled();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor as PlayerAdventureActor;
	}

	protected override void OnSkillDisable()
	{
		dash.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 logicTagTSVector2Value = summoner.logicVariable.GetLogicTagTSVector2Value("targetPos");
		FP logicTagValue = summoner.logicVariable.GetLogicTagValue("monsterRadius");
		TSVector2 normalized = (logicTagTSVector2Value - summoner.tsTransform.Position).normalized;
		TSVector2 tSVector = TSVector2.Rotate(normalized, (TSRandom.Range(0, 100) < 50) ? 90 : (-90));
		if (logicTagValue > radiusLimit)
		{
			tSVector = normalized;
		}
		normalized = logicTagTSVector2Value + tSVector * (logicTagValue + range) - _actor.tsTransform.Position;
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		dash.BeginDash(_actor, normalized.normalized, normalized.magnitude / time, normalized.magnitude, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
