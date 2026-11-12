using System.Collections;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Spawn_Lv1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] WakeUpCombo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetLogicTagFpValue(_actor, "Phase", 1);
		SetLogicTagFpValue(_actor, "Difficulty", 1);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetPosition();
		TSVector2 tSVector = TransLocalPosToWorldPos(relativePoint: new TSVector2(0, 1), csOrigin: position, csForward: GetForward());
		SetLogicTagFpValue(_actor, "SpawnPositionX", position.x);
		SetLogicTagFpValue(_actor, "SpawnPositionY", position.y);
		SetLogicTagFpValue(_actor, "SpawnDirectionX", tSVector.x);
		SetLogicTagFpValue(_actor, "SpawnDirectionY", tSVector.y);
		AddBuffToTarget(_actor, 990020140);
		SetBattleOutEnable();
		BeginAttack(1, WakeUpCombo, flushInputedKeys: true);
		while (!GetLogicTagToggleValue(_actor, "WakeUp"))
		{
			yield return null;
		}
		if (GetTargetByTeammateIndex(0).Count != 0)
		{
			SetLogicTagFpValue(_actor, "LeaderSpawnPositionX", GetLogicTagFpValue(GetTargetByTeammateIndex(0).get_Item(0), "SpawnPositionX"));
		}
		CancelAttack();
		RemoveBuffFromTarget(_actor, 501619920);
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitTime(0.5);
		if (_actor.dataID == GetTeammateIdByIndex(0))
		{
			AddShieldToTarget(_actor, 501619910);
			SetLogicTagToggleValue(_actor, "BattleInterrupted", value: true);
		}
		yield return WaitTime(0.5);
		ShowCenterHpBar();
		SetBattleOutDisable();
		SetImmuneControlEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetImmuneControlDisable();
	}
}
