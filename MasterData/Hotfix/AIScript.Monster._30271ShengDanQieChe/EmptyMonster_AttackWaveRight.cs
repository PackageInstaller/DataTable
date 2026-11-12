using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class EmptyMonster_AttackWaveRight : SkillSimpleBase
{
	private readonly TSVector2 CenterPosition = new TSVector2(0, 0);

	private string AttackWave = "RotateWeapon_CallMinions_AttackWave1";

	private string AttackWave_Hard = "RotateWeapon_CallMinions_AttackWave1_Hard";

	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable();
		if (GetTargetByTeammateIndex(0).Count != 0)
		{
			ShootWeapon(AttackWave, CenterPosition, 0);
		}
		else
		{
			ShootWeapon(AttackWave_Hard, CenterPosition, 0);
		}
		yield return WaitTime(999);
	}
}
