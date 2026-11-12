using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class Parallel_FangWeiBiao : ParallelBase
{
	private const int perkId_21 = 516121;

	private const int perkId_22 = 516122;

	private const int perkId_23 = 516123;

	private const int perkId_24 = 516124;

	private static readonly FP fangWeiBiaoLeftTime_P23 = 11.5;

	private const string areaEffect_Base = "AreaEffect_16101_CeHui";

	private const string areaEffect_P21 = "AreaEffect_16101_CeHui_P21";

	private static readonly string[] areaEffect_P22_ByTier = new string[3] { "AreaEffect_16101_CeHui", "AreaEffect_16101_CeHui_P22_Lv1", "AreaEffect_16101_CeHui_P22_Lv2" };

	private static readonly string[] areaEffect_P21P22_ByTier = new string[3] { "AreaEffect_16101_CeHui_P21", "AreaEffect_16101_CeHui_P21P22_Lv1", "AreaEffect_16101_CeHui_P21P22_Lv2" };

	private static readonly string[] areaEffect_P24_ByTier = new string[3] { "AreaEffect_16101_CeHui_P24", "AreaEffect_16101_CeHui_P24_Lv1", "AreaEffect_16101_CeHui_P24_Lv2" };

	private PlayerAdventureActor _summoner;

	private readonly List<long> _ceHuiAreaIds = new List<long>();

	private CoroutineNode _corClear;

	public override void OnEnable()
	{
		base.OnEnable();
		_summoner = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor as PlayerAdventureActor;
		_actor.EnableInvincible();
		_actor.EnableSearchedImmunity();
		_actor.EnableCloseBlock();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEventRaw);
		if (GetPerk(516123))
		{
			StartCoroutine(ref _corClear, ClearLoop());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEventRaw);
		_actor.DisableInvincible();
		_actor.DisableSearchedImmunity();
		StopCoroutine(ref _corClear);
		_ceHuiAreaIds.Clear();
		_summoner = null;
	}

	private void OnCustomEventRaw(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config.playCeHuiEvt)
		{
			PlayCeHuiArea();
		}
	}

	private void PlayCeHuiArea()
	{
		long num = ILRuntimeAPI.PlayAreaEffect(_actor, GetCeHuiAreaKey(), _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		if (num > 0)
		{
			_ceHuiAreaIds.Add(num);
		}
	}

	private string GetCeHuiAreaKey()
	{
		if (GetPerk(516124))
		{
			return areaEffect_P24_ByTier[GetFangWeiBiaoLvTier()];
		}
		bool perk = GetPerk(516121);
		if (!GetPerk(516122))
		{
			if (!perk)
			{
				return "AreaEffect_16101_CeHui";
			}
			return "AreaEffect_16101_CeHui_P21";
		}
		int fangWeiBiaoLvTier = GetFangWeiBiaoLvTier();
		if (!perk)
		{
			return areaEffect_P22_ByTier[fangWeiBiaoLvTier];
		}
		return areaEffect_P21P22_ByTier[fangWeiBiaoLvTier];
	}

	private int GetFangWeiBiaoLvTier()
	{
		int num = 0;
		if (_summoner != null)
		{
			num = (int)(long)_summoner.logicVariable.GetLogicTagValue("161_FangWeiBiaoLv");
		}
		if (num >= 4)
		{
			return 2;
		}
		if (num >= 2)
		{
			return 1;
		}
		return 0;
	}

	private void StopCeHuiAreas()
	{
		for (int i = 0; i < _ceHuiAreaIds.Count; i++)
		{
			ILRuntimeAPI.StopAreaEffect(_ceHuiAreaIds.get_Item(i));
		}
		_ceHuiAreaIds.Clear();
	}

	private IEnumerator ClearLoop()
	{
		yield return _actor.WaitTime(fangWeiBiaoLeftTime_P23);
		StopCeHuiAreas();
		_actor.DestroySelf();
	}
}
