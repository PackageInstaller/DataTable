using System.Collections;

namespace AIScript.Monster._12301111FengTun;

public class SkillScript_NormalAttack : SkillSimpleBase
{
	private string atkTagNrm = "Atk1";

	private string atkTagP3 = "Atk2";

	private int sumDataId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		AdventureActor summonActor = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor;
		if (summonActor != null)
		{
			sumDataId = summonActor.dataID;
		}
	}

	private string GetAtkTag()
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(sumDataId, Parallel.perkId_p3, out var _) && Parallel.start_p3_Time + 5 >= _actor.LogicTime)
		{
			return atkTagP3;
		}
		return atkTagNrm;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, GetAtkTag(), flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
