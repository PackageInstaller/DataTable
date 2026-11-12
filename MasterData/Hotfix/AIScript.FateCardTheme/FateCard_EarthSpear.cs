#define LOG_DEBUG
using TrueSync;
using UnityEngine;

namespace AIScript.FateCardTheme;

public class FateCard_EarthSpear : BaseFateCardTheme
{
	private readonly FP cd = 4;

	private readonly string normalPath_Spear = "fx_perk_earth_rockspear_1";

	private readonly TSVector posOffset = new TSVector(0, 2, 0);

	private readonly int normal_damageId = 986371;

	private readonly string proaPath_Spear = "fx_perk_earth_rockspear_1_2";

	private readonly int proA_damageId = 986372;

	private readonly string probPath_Spear = "fx_perk_earth_rockspear_2";

	private readonly int proB_damageId = 986373;

	private readonly string procPath_Spear = "fx_perk_earth_rockspear_2_2";

	private readonly int proC_damageId = 986374;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_EarthSpear OnTrigger");
		if (CheckTimeout(cd))
		{
			ShowEarthSpear();
			TriggerTheme();
		}
	}

	private void ShowEarthSpear()
	{
		string stringAlias = normalPath_Spear;
		int hitdamageID = normal_damageId;
		if (CanExcuteA)
		{
			hitdamageID = proA_damageId;
			stringAlias = proaPath_Spear;
		}
		if (CanExcuteB)
		{
			hitdamageID = proB_damageId;
			stringAlias = probPath_Spear;
		}
		if (CanExcuteC)
		{
			hitdamageID = proC_damageId;
			stringAlias = procPath_Spear;
		}
		GameObject gameObject = LoadAsset(stringAlias);
		if (gameObject != null)
		{
			FlowerEntity obj = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, _actor.transform.position, _actor.transform.rotation) as FlowerEntity;
			obj.OnTrigger(posOffset, _actor);
			obj.SetHitdamageID(hitdamageID);
		}
	}
}
