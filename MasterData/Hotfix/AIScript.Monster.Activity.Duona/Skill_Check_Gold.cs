using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Activity.Duona;

public class Skill_Check_Gold : SkillSimpleBase
{
	private readonly string fx_Alias = "Actor/Monster/30821XinXiang_Gold/FX/fx_drop_mail_gold_receive";

	private FP intervaltime = 0.03f;

	private int checkid = 308030301;

	private int dropitemid = 126;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		FP fP = Distance(GetPosition(), GetEntityPosition(currentPlayer));
		while (fP > 3)
		{
			yield return WaitTime(intervaltime);
			currentPlayer = GetCurrentPlayer();
			fP = Distance(GetPosition(), GetEntityPosition(currentPlayer));
		}
		int count = GetBuffNum(GetCurrentPlayer(), checkid);
		if (count > 0)
		{
			RemoveBuffFromTarget(currentPlayer, checkid);
			PlayFx(fx_Alias, 1f, 0, GetPosition(), 0, null, 1f, actorScale: true);
			yield return WaitTime(1);
		}
		while (count > 0)
		{
			Skill_Check_Gold skill_Check_Gold = this;
			TSVector2 position = GetPosition();
			FP radius = 4;
			FP innerRadius = 2;
			FP angle = 360;
			FP rotation = 0;
			DeterministicShape shapeData = skill_Check_Gold.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			yield return WaitTime(0.3f);
			DropItem(dropitemid, GetPosition());
			count--;
			yield return WaitTime(0.03f);
		}
		yield return WaitTime(0.1f);
		yield return WaitTime(1);
	}
}
