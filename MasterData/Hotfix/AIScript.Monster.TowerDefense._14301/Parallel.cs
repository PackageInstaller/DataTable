using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense._14301;

public class Parallel : TowerCharacterParalletBase
{
	private const int perkId_3 = 1430103;

	private int buff_3 = 801430010;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerk(1430103))
		{
			_actor.buffComponent.AddBuff(buff_3, _actor);
		}
	}
}
