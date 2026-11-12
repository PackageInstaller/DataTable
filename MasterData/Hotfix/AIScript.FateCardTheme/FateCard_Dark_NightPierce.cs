#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Dark_NightPierce : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string normalPath_Pierce = "FateCard_Dark_NightPierce";

	private readonly FP circleRadius = 10;

	private readonly int normal_damageId = 986491;

	private readonly string proaPath_Pierce = "FateCard_Dark_NightPierce_A";

	private readonly int proA_damageId = 986492;

	private readonly FP angle = 30;

	private readonly int proB_damageId = 986493;

	private readonly int proC_damageId = 986494;

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
		NovaLogger.Debug("FateCard_Dark_NightPierce OnTrigger");
		if (CheckTimeout(cd) && OnExcute())
		{
			TriggerTheme();
		}
	}

	private bool OnExcute()
	{
		LogicEntity logicEntity = CommonUtils.SearchNearTargetByCircle(_actor, circleRadius);
		if (logicEntity == null)
		{
			return false;
		}
		string fxAlias = normalPath_Pierce;
		int hitId = normal_damageId;
		if (CanExcuteA)
		{
			fxAlias = proaPath_Pierce;
			hitId = proA_damageId;
		}
		if (CanExcuteB)
		{
			hitId = proB_damageId;
		}
		if (CanExcuteC)
		{
			hitId = proC_damageId;
		}
		TSVector2 normalized = (logicEntity.tsTransform.Position - _actor.tsTransform.Position).normalized;
		FP rotation = normalized.GetAngle();
		PlayAreaEffect(fxAlias, _actor.tsTransform.Position, hitId, rotation);
		if (CanExcuteB)
		{
			rotation = TSVector2.Rotate(normalized, angle).GetAngle();
			PlayAreaEffect(fxAlias, _actor.tsTransform.Position, hitId, rotation);
			rotation = TSVector2.Rotate(normalized, -angle).GetAngle();
			PlayAreaEffect(fxAlias, _actor.tsTransform.Position, hitId, rotation);
		}
		return true;
	}
}
