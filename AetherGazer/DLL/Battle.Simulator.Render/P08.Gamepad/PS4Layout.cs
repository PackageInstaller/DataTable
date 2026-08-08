using UnityEngine;

namespace P08.Gamepad;

public class PS4Layout : GamepadLayout
{
	public static En_Dualshock4ControllerLayout ConvertOnPC(string pValue)
	{
		if (int.TryParse(pValue, out var result))
		{
			switch ((KeyCode)result)
			{
			case KeyCode.JoystickButton0:
				return En_Dualshock4ControllerLayout.SquareButton;
			case KeyCode.JoystickButton1:
				return En_Dualshock4ControllerLayout.CrossButton;
			case KeyCode.JoystickButton2:
				return En_Dualshock4ControllerLayout.CircleButton;
			case KeyCode.JoystickButton3:
				return En_Dualshock4ControllerLayout.TriangleButton;
			case KeyCode.JoystickButton4:
				return En_Dualshock4ControllerLayout.L1Button;
			case KeyCode.JoystickButton5:
				return En_Dualshock4ControllerLayout.R1Button;
			case KeyCode.JoystickButton6:
				return En_Dualshock4ControllerLayout.L2Button;
			case KeyCode.JoystickButton7:
				return En_Dualshock4ControllerLayout.R2Button;
			case KeyCode.JoystickButton8:
				return En_Dualshock4ControllerLayout.ShareButton;
			case KeyCode.JoystickButton9:
				return En_Dualshock4ControllerLayout.OpetionsButton;
			case KeyCode.JoystickButton10:
				return En_Dualshock4ControllerLayout.L3Button;
			case KeyCode.JoystickButton11:
				return En_Dualshock4ControllerLayout.R3Button;
			case KeyCode.JoystickButton12:
				return En_Dualshock4ControllerLayout.PSButton;
			case KeyCode.JoystickButton13:
				return En_Dualshock4ControllerLayout.TouchPadButton;
			}
		}
		else
		{
			switch (pValue)
			{
			case "Axis2N":
				return En_Dualshock4ControllerLayout.LeftStickUp;
			case "Axis2P":
				return En_Dualshock4ControllerLayout.LeftStickDown;
			case "Axis1N":
				return En_Dualshock4ControllerLayout.LeftStickLeft;
			case "Axis1P":
				return En_Dualshock4ControllerLayout.LeftStickRight;
			case "Axis8P":
				return En_Dualshock4ControllerLayout.DirectionalButtonsUp;
			case "Axis8N":
				return En_Dualshock4ControllerLayout.DirectionalButtonsDown;
			case "Axis7N":
				return En_Dualshock4ControllerLayout.DirectionalButtonsLeft;
			case "Axis7P":
				return En_Dualshock4ControllerLayout.DirectionalButtonsRight;
			case "Axis6N":
				return En_Dualshock4ControllerLayout.RightStickUp;
			case "Axis6P":
				return En_Dualshock4ControllerLayout.RightStickDown;
			case "Axis3N":
				return En_Dualshock4ControllerLayout.RightStickLeft;
			case "Axis3P":
				return En_Dualshock4ControllerLayout.RightStickRight;
			}
		}
		return En_Dualshock4ControllerLayout.None;
	}

	public static ButtonParameter ConvertOnPC(En_Dualshock4ControllerLayout pDualshock4ControllerLayout)
	{
		return pDualshock4ControllerLayout switch
		{
			En_Dualshock4ControllerLayout.L3Button => new ButtonParameter
			{
				m_value = 340.ToString()
			}, 
			En_Dualshock4ControllerLayout.R3Button => new ButtonParameter
			{
				m_value = 341.ToString()
			}, 
			En_Dualshock4ControllerLayout.TriangleButton => new ButtonParameter
			{
				m_value = 333.ToString()
			}, 
			En_Dualshock4ControllerLayout.CrossButton => new ButtonParameter
			{
				m_value = 331.ToString()
			}, 
			En_Dualshock4ControllerLayout.SquareButton => new ButtonParameter
			{
				m_value = 330.ToString()
			}, 
			En_Dualshock4ControllerLayout.CircleButton => new ButtonParameter
			{
				m_value = 332.ToString()
			}, 
			En_Dualshock4ControllerLayout.ShareButton => new ButtonParameter
			{
				m_value = 338.ToString()
			}, 
			En_Dualshock4ControllerLayout.OpetionsButton => new ButtonParameter
			{
				m_value = 339.ToString()
			}, 
			En_Dualshock4ControllerLayout.L1Button => new ButtonParameter
			{
				m_value = 334.ToString()
			}, 
			En_Dualshock4ControllerLayout.R1Button => new ButtonParameter
			{
				m_value = 335.ToString()
			}, 
			En_Dualshock4ControllerLayout.L2Button => new ButtonParameter
			{
				m_value = 336.ToString()
			}, 
			En_Dualshock4ControllerLayout.R2Button => new ButtonParameter
			{
				m_value = 337.ToString()
			}, 
			En_Dualshock4ControllerLayout.LeftStickUp => new ButtonParameter
			{
				m_value = "Axis2N"
			}, 
			En_Dualshock4ControllerLayout.LeftStickDown => new ButtonParameter
			{
				m_value = "Axis2P"
			}, 
			En_Dualshock4ControllerLayout.LeftStickLeft => new ButtonParameter
			{
				m_value = "Axis1N"
			}, 
			En_Dualshock4ControllerLayout.LeftStickRight => new ButtonParameter
			{
				m_value = "Axis1P"
			}, 
			En_Dualshock4ControllerLayout.RightStickUp => new ButtonParameter
			{
				m_value = "Axis6N"
			}, 
			En_Dualshock4ControllerLayout.RightStickDown => new ButtonParameter
			{
				m_value = "Axis6P"
			}, 
			En_Dualshock4ControllerLayout.RightStickLeft => new ButtonParameter
			{
				m_value = "Axis3N"
			}, 
			En_Dualshock4ControllerLayout.RightStickRight => new ButtonParameter
			{
				m_value = "Axis3P"
			}, 
			En_Dualshock4ControllerLayout.DirectionalButtonsUp => new ButtonParameter
			{
				m_value = "Axis8P"
			}, 
			En_Dualshock4ControllerLayout.DirectionalButtonsDown => new ButtonParameter
			{
				m_value = "Axis8N"
			}, 
			En_Dualshock4ControllerLayout.DirectionalButtonsLeft => new ButtonParameter
			{
				m_value = "Axis7N"
			}, 
			En_Dualshock4ControllerLayout.DirectionalButtonsRight => new ButtonParameter
			{
				m_value = "Axis7P"
			}, 
			_ => null, 
		};
	}
}
