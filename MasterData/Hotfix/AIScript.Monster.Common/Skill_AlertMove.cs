using System.Collections;
using TrueSync;

namespace AIScript.Monster.Common;

public class Skill_AlertMove : Skill_AlertMoveBase
{
	private new FP movementMaXRuningTime = 5;

	private new FP nearValue_Melee = 3;

	private new FP farValuee_Melee = 6.5;

	private new FP nearValue_Range = 4;

	private new FP farValuee_Range = 8;

	private new FP moveForwardDistance = 5;

	private new FP moveForwardDirection = 10;

	private new FP moveBackwardDistance = 3;

	private new FP moveBackwardRangeOffset = 4.5;

	private new FP moveBackwardDirection = 15;

	private new FP moveOrbitalDistance = 5;

	private new FP moveOrbitalDirection = 180;

	public Skill_AlertMove()
	{
		base.nearValue_Melee = nearValue_Melee;
		base.farValuee_Melee = farValuee_Melee;
		base.movementMaXRuningTime = movementMaXRuningTime;
		base.nearValue_Range = nearValue_Range;
		base.farValuee_Range = farValuee_Range;
		base.moveForwardDistance = moveForwardDistance;
		base.moveForwardDirection = moveForwardDirection;
		base.moveBackwardDistance = moveBackwardDistance;
		base.moveBackwardRangeOffset = moveBackwardRangeOffset;
		base.moveBackwardDirection = moveBackwardDirection;
		base.moveOrbitalDistance = moveOrbitalDistance;
		base.moveOrbitalDirection = moveOrbitalDirection;
	}

	protected override void OnSkillEnable()
	{
		Enable();
	}

	protected override void OnSkillDisable()
	{
		Disable();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (MovementCor() != null)
		{
			yield return MovementCor();
		}
	}
}
