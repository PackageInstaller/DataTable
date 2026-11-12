using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15601;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Boom = CommonHelper.StringToHash("PenguinDollAtk");

	private FP summonOffset_Skill = 3;

	private int summonedId = 8015601;

	private SummonCfg summonCfg_Summon = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		leftTime = -1
	};

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int hasP3 = CommonHelper.StringToHash("hasP3");

	private const int perkId_2 = 1560102;

	private int buffId_2 = 801560210;

	private const int perkId_3 = 1560103;

	private int buffId_3 = 801560220;

	public FP modelScale_Summoned_3 = 1.05;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1560106] = 60 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (GetPerk(1560102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom))
		{
			AdventureActor adventureActor = evt.from as AdventureActor;
			int buffID = ((GetPerk(1560103) && adventureActor.CheckTag(hasP3)) ? buffId_3 : buffId_2);
			monster.buffComponent.AddBuff(buffID, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public override void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
		base.OnBulletFinish(evt);
		if (!(evt.tag == "PenguinStatueCalling_Fly"))
		{
			return;
		}
		TSVector2 result = evt.bulletPosition;
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		CommonUtils.SummonMonster(_actor, 0, summonedId, result, _actor.tsTransform.Forward, summonCfg_Summon, null, (MonsterAdventureActor monster) =>
		{
			if (GetPerk(1560103))
			{
				monster.AddTag(hasP3);
				monster.actorScaleInfo.modelScale = modelScale_Summoned_3;
			}
			else
			{
				monster.actorScaleInfo.modelScale = monster.actorScaleInfo.originModelScale;
			}
		});
	}
}
