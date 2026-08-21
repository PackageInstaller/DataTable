using System.Collections.Generic;

namespace P08.Gamepad;

public class OtherLayout : GamepadLayout
{
	public OtherLayout()
	{
		m_fileFormatVersion = 2;
		m_buttonMapLayouts = new List<ButtonParameter>();
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.MoveUp,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.MoveDown,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.MoveLeft,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.MoveRight,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Lock,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Melee,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Skill1,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Skill2,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Skill3,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Avoid,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Ultimate1,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Ultimate2,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.Ultimate3,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.CameraLeft,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.CameraRight,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.SubJoystickUp,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.SubJoystickDown,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.SubJoystickLeft,
			m_value = string.Empty
		});
		m_buttonMapLayouts.Add(new ButtonParameter
		{
			m_buttonType = En_ButtonType.SubJoystickRight,
			m_value = string.Empty
		});
	}
}
