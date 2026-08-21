using UnityEngine;

namespace Packages.BattleSimulator.Simulator.SimulatorUI;

public class P08JoystickWithRotateCamera : IStickControllerGameLogic
{
	public AimCameraCtrl cameraCtrl;

	public P08JoystickWithRotateCamera(AimCameraCtrl cameraCtrl)
	{
		this.cameraCtrl = cameraCtrl;
	}

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		if (!(cameraCtrl == null) && joystickForwardVector != Vector2.zero)
		{
			cameraCtrl.SetDragDelta(joystickForwardVector * 10f);
		}
	}
}
