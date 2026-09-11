using UnityEngine;

namespace Packages.BattleSimulator.Simulator.SimulatorUI;

public class P08JoystickWithAimSight : IStickControllerGameLogic
{
	public AimSightMoveScript aimSight;

	public P08JoystickWithAimSight(AimSightMoveScript aimSight)
	{
		this.aimSight = aimSight;
	}

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		if (aimSight != null)
		{
			aimSight.ClampInScreen(joystickForwardVector * 10f);
		}
	}
}
