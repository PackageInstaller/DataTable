using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14201;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Skill = CommonHelper.StringToHash("Skill");

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private string areaEffect_base = "AreaEffect_142_SkillSup_ZhuaJi";

	private FP fixRot_left = -45;

	private FP fixRot_right = 45;

	private FP castOffset = 4;

	private int perkId_1 = 1420101;

	private int buffId_1 = 801420030;

	private int buffId_2 = 801420040;

	private int perkId_2 = 1420102;

	private string areaEffect_2 = "AreaEffect_142_SkillSup_ZhuaJi_P21";

	private int perkId_4 = 1420104;

	private string areaEffect_plus = "AreaEffect_142_TD_ZhuaJi_Plus";

	private string areaEffect_super = "AreaEffect_142_TD_ZhuaJi_Super";

	private string areaEffect_4 = "AreaEffect_142_TD_ZhuaJi_Super_P";

	private int count_4 = 4;

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill) && GetPerk(perkId_1))
		{
			monster.buffComponent?.AddBuff(buffId_1, _actor);
			monster.buffComponent?.AddBuff(buffId_2, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode == castAreaEvent)
		{
			OnCastArea(evt.boolParam, evt.intParam);
			if (GetPerk(perkId_2))
			{
				string fxAlias = (GetPerk(perkId_4) ? areaEffect_4 : areaEffect_2);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
		}
	}

	private void OnCastArea(bool isLeft, int clawCount)
	{
		TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * castOffset));
		FP rotation = _actor.tsTransform.Rotation + ((!isLeft) ? 180 : 0) + (isLeft ? fixRot_left : fixRot_right);
		string fxAlias = areaEffect_base;
		if (GetPerk(perkId_4))
		{
			fxAlias = ((clawCount > 0 && clawCount % count_4 == 0) ? areaEffect_super : areaEffect_plus);
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, rotation);
	}
}
