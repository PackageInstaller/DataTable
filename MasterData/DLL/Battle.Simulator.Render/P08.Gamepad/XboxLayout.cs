using UnityEngine;

namespace P08.Gamepad;

public class XboxLayout : GamepadLayout
{
	public static En_XboxOneControllerLayout ConvertOnPC(string pValue)
	{
		if (int.TryParse(pValue, out var result))
		{
			switch ((KeyCode)result)
			{
			case KeyCode.JoystickButton0:
				return En_XboxOneControllerLayout.AButton;
			case KeyCode.JoystickButton1:
				return En_XboxOneControllerLayout.BButton;
			case KeyCode.JoystickButton2:
				return En_XboxOneControllerLayout.Xbutton;
			case KeyCode.JoystickButton3:
				return En_XboxOneControllerLayout.YButton;
			case KeyCode.JoystickButton4:
				return En_XboxOneControllerLayout.LeftBumper;
			case KeyCode.JoystickButton5:
				return En_XboxOneControllerLayout.RightBumper;
			case KeyCode.JoystickButton6:
				return En_XboxOneControllerLayout.MenuButton;
			case KeyCode.JoystickButton7:
				return En_XboxOneControllerLayout.ViewButton;
			case KeyCode.JoystickButton8:
				return En_XboxOneControllerLayout.LeftStickButton;
			case KeyCode.JoystickButton9:
				return En_XboxOneControllerLayout.RightStickButton;
			}
		}
		else
		{
			switch (pValue)
			{
			case "Axis2N":
				return En_XboxOneControllerLayout.LeftStickUp;
			case "Axis2P":
				return En_XboxOneControllerLayout.LeftStickDown;
			case "Axis1N":
				return En_XboxOneControllerLayout.LeftStickLeft;
			case "Axis1P":
				return En_XboxOneControllerLayout.LeftStickRight;
			case "Axis3N":
				return En_XboxOneControllerLayout.LeftTrigger;
			case "Axis3P":
				return En_XboxOneControllerLayout.RightTrigger;
			case "Axis7P":
				return En_XboxOneControllerLayout.DirectionalPadUp;
			case "Axis7N":
				return En_XboxOneControllerLayout.DirectionalPadDown;
			case "Axis6N":
				return En_XboxOneControllerLayout.DirectionalPadLeft;
			case "Axis6P":
				return En_XboxOneControllerLayout.DirectionalPadRight;
			case "Axis5N":
				return En_XboxOneControllerLayout.RightStickUp;
			case "Axis5P":
				return En_XboxOneControllerLayout.RightStickDown;
			case "Axis4N":
				return En_XboxOneControllerLayout.RightStickLeft;
			case "Axis4P":
				return En_XboxOneControllerLayout.RightStickRight;
			}
		}
		return En_XboxOneControllerLayout.None;
	}

	public static ButtonParameter ConvertOnPC(En_XboxOneControllerLayout pOneControllerLayout)
	{
		return pOneControllerLayout switch
		{
			En_XboxOneControllerLayout.LeftStickButton => new ButtonParameter
			{
				m_value = 338.ToString()
			}, 
			En_XboxOneControllerLayout.RightStickButton => new ButtonParameter
			{
				m_value = 339.ToString()
			}, 
			En_XboxOneControllerLayout.YButton => new ButtonParameter
			{
				m_value = 333.ToString()
			}, 
			En_XboxOneControllerLayout.AButton => new ButtonParameter
			{
				m_value = 330.ToString()
			}, 
			En_XboxOneControllerLayout.Xbutton => new ButtonParameter
			{
				m_value = 332.ToString()
			}, 
			En_XboxOneControllerLayout.BButton => new ButtonParameter
			{
				m_value = 331.ToString()
			}, 
			En_XboxOneControllerLayout.ViewButton => new ButtonParameter
			{
				m_value = 336.ToString()
			}, 
			En_XboxOneControllerLayout.MenuButton => new ButtonParameter
			{
				m_value = 337.ToString()
			}, 
			En_XboxOneControllerLayout.LeftBumper => new ButtonParameter
			{
				m_value = 334.ToString()
			}, 
			En_XboxOneControllerLayout.RightBumper => new ButtonParameter
			{
				m_value = 335.ToString()
			}, 
			En_XboxOneControllerLayout.LeftTrigger => new ButtonParameter
			{
				m_value = "Axis9P"
			}, 
			En_XboxOneControllerLayout.RightTrigger => new ButtonParameter
			{
				m_value = "Axis10P"
			}, 
			En_XboxOneControllerLayout.LeftStickUp => new ButtonParameter
			{
				m_value = "Axis2N"
			}, 
			En_XboxOneControllerLayout.LeftStickDown => new ButtonParameter
			{
				m_value = "Axis2P"
			}, 
			En_XboxOneControllerLayout.LeftStickLeft => new ButtonParameter
			{
				m_value = "Axis1N"
			}, 
			En_XboxOneControllerLayout.LeftStickRight => new ButtonParameter
			{
				m_value = "Axis1P"
			}, 
			En_XboxOneControllerLayout.RightStickUp => new ButtonParameter
			{
				m_value = "Axis5N"
			}, 
			En_XboxOneControllerLayout.RightStickDown => new ButtonParameter
			{
				m_value = "Axis5P"
			}, 
			En_XboxOneControllerLayout.RightStickLeft => new ButtonParameter
			{
				m_value = "Axis4N"
			}, 
			En_XboxOneControllerLayout.RightStickRight => new ButtonParameter
			{
				m_value = "Axis4P"
			}, 
			En_XboxOneControllerLayout.DirectionalPadUp => new ButtonParameter
			{
				m_value = "Axis7P"
			}, 
			En_XboxOneControllerLayout.DirectionalPadDown => new ButtonParameter
			{
				m_value = "Axis7N"
			}, 
			En_XboxOneControllerLayout.DirectionalPadLeft => new ButtonParameter
			{
				m_value = "Axis6N"
			}, 
			En_XboxOneControllerLayout.DirectionalPadRight => new ButtonParameter
			{
				m_value = "Axis6P"
			}, 
			_ => null, 
		};
	}
}
