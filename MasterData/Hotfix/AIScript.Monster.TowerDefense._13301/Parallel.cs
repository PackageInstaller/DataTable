using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._13301;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Skill = CommonHelper.StringToHash("Skill");

	private const int perkId_2 = 1330102;

	private int buffId_2 = 801330210;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>
	{
		[1330105] = 15,
		[1330107] = 15
	};

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && GetPerk(1330102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			monster.buffComponent.AddBuff(buffId_2, _actor);
		}
	}
}
