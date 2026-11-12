using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11201;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_NormalAtk = CommonHelper.StringToHash("NrmAtk");

	private const int perkId_2 = 1120102;

	private int cd_2 = 5;

	private int prob_2 = 30;

	private string areaEffect_2 = "AreaEffect_T2";

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1120107] = 42 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NormalAtk) && GetPerk(1120102) && TSRandom.Range(0, 100) < prob_2 && CheckPerkCd(1120102L, cd_2))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_2, monster.tsTransform.Position);
		}
	}
}
