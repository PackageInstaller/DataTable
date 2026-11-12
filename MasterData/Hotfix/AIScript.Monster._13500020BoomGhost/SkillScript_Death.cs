using System.Collections;

namespace AIScript.Monster._13500020BoomGhost;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "BoomGhostDead";

	private const int perkId_29 = 513529;

	private const int buff_29 = 13552911;

	private PlayerAdventureActor summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PauseMovementAgent();
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.EnableMovementAgent();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		if (GetPerkLv(513529, out var _))
		{
			int buffNumByID = summoner.buffComponent.GetBuffNumByID(13552911);
			_actor.buffComponent.AddBuffNum(13552911, buffNumByID, summoner);
		}
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv);
	}
}
