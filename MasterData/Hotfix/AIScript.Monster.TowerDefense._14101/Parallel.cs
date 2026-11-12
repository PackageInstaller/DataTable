using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14101;

public class Parallel : TowerCharacterParalletBase
{
	private int skillTag_hit = CommonHelper.StringToHash("141SkillFire");

	public const int perkId_1 = 1410101;

	public const int buff_01 = 801410010;

	public const int perkId_2 = 1410102;

	public const int perkId_3 = 1410103;

	public const int buff_03 = 801410020;

	public const int buff_count = 3;

	public const int perkId_4 = 1410104;

	public static readonly FP addLoopTime = 3;

	public const int buff_04 = 801410030;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnReceiveAttack(AdventureActorReceiveAttackEvent evt)
	{
		base.OnReceiveAttack(evt);
		_ = evt.from?.Id == _actor.Id;
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, skillTag_hit) && GetPerk(1410104))
		{
			monster.buffComponent?.AddBuff(801410030, _actor);
		}
	}
}
