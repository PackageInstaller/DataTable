using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101.Summoned.JuDian;

public class Parallel_JuDian : ParallelBase
{
	private const int perkId_2 = 516102;

	private const int perkId_4 = 516104;

	private FP exploreRadius_4 = 5;

	private FP interval_4 = 3;

	private const int perkId_8 = 516108;

	private const string areaEffect_JuDian_Debuff_8 = "AreaEffect_16101_JuDian_Debuff";

	private PlayerAdventureActor _summoner;

	private long _auraId_8;

	private CoroutineNode _corExplore;

	public override void OnEnable()
	{
		base.OnEnable();
		_summoner = (_actor as MonsterAdventureActor)?.monsterSummonInfo.SummonActor as PlayerAdventureActor;
		_actor.EnableInvincible();
		_actor.EnableSearchedImmunity();
		_actor.EnableCloseBlock();
		if (GetPerk(516108))
		{
			_auraId_8 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16101_JuDian_Debuff", _actor.tsTransform.Position);
		}
		if (GetPerk(516104))
		{
			StartCoroutine(ref _corExplore, ExploreLoop());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.DisableInvincible();
		_actor.DisableSearchedImmunity();
		if (_auraId_8 != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(_auraId_8);
			_auraId_8 = 0L;
		}
		StopCoroutine(ref _corExplore);
		_summoner = null;
	}

	private IEnumerator ExploreLoop()
	{
		while (true)
		{
			yield return _actor.WaitTime(interval_4);
			TSVector2 spwanPos = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, 0, exploreRadius_4);
			string fxAlias = (GetPerk(516102) ? "Drop_16101_Res_P02" : "Drop_16101_Res");
			ILRuntimeAPI.PlayDrop(_summoner, fxAlias, spwanPos);
		}
	}
}
