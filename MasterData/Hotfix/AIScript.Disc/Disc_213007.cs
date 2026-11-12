using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Disc;

public class Disc_213007 : DiscScriptBase
{
	private const int discId = 213007;

	private List<int> skillId_s2 = new List<int> { 30071 };

	private const int power_p = 3007100;

	private const int hit_id = 3007101;

	private const string hit_fx_Path = "FX/Perk/fx_perk_base_wind_wind_area_explosion_high";

	private int skill2_level;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		skill2_level = GetDiscSkillv(213007, skillId_s2);
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
		base.OnElementMarkTrigger(_evt);
		if (skill2_level >= 1 && _evt.elementType == HotfixEnum.elementType.AE)
		{
			int num = CommonUtils.GetScriptValue(_actor, 3007100).AsInt();
			(_evt.triggerActor as PlayerAdventureActor).playerSkillCd?.AddEnergy(num);
			ILRuntimeAPI.HitActor(_evt.triggerActor, _evt.markActor, 3007101, "FX/Perk/fx_perk_base_wind_wind_area_explosion_high");
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
