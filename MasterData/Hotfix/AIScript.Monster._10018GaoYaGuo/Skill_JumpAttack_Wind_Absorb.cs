using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_JumpAttack_Wind_Absorb : SkillSimpleBase
{
	private LogicEntity Master;

	private TSVector2 Position;

	private CoroutineNode TornadoCor;

	protected override void OnSkillEnable()
	{
		Master = GetMonsterCloner();
		Position = GetEntityPosition(Master);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_JumpAttack_Wind_Absorb skill_JumpAttack_Wind_Absorb = this;
		TSVector2 position = Position;
		long FX1 = skill_JumpAttack_Wind_Absorb.PlayEffect("Wind1", 1f, default, position, default, 1.25f);
		Skill_JumpAttack_Wind_Absorb skill_JumpAttack_Wind_Absorb2 = this;
		position = Position;
		long FX2 = skill_JumpAttack_Wind_Absorb2.PlayEffect("Wind2", 1f, default, position, default, 1.25f);
		yield return WaitTime(0.25);
		StartCor(ref TornadoCor, Tornado(Position));
		yield return WaitTime(2.5);
		StopCor(TornadoCor);
		StopEffect(FX1);
		StopEffect(FX2);
	}

	private IEnumerator Tornado(TSVector2 Position)
	{
		Skill_JumpAttack_Wind_Absorb skill_JumpAttack_Wind_Absorb = this;
		FP radius = 4.5;
		DeterministicShape TornadoShape = skill_JumpAttack_Wind_Absorb.GetShapeData(DeterministicShape.ShapeType.Circle, Position, default, default, radius);
		while (true)
		{
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, Position, GetTargetsFromShape(TornadoShape, GetTargetsByFaction(isFriend: false)), 0.3, 3, 4, 20, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
			yield return WaitTime(0.1);
		}
	}
}
