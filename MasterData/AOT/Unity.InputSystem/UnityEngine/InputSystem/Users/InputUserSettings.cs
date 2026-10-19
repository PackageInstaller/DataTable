using System;

namespace UnityEngine.InputSystem.Users;

[Serializable]
internal class InputUserSettings
{
	[SerializeField]
	private string m_CustomBindings;

	public string customBindings { get; set; }

	public bool invertMouseX { get; set; }

	public bool invertMouseY { get; set; }

	public float? mouseSmoothing { get; set; }

	public float? mouseSensitivity { get; set; }

	public bool invertStickX { get; set; }

	public bool invertStickY { get; set; }

	public bool swapSticks { get; set; }

	public bool swapBumpers { get; set; }

	public bool swapTriggers { get; set; }

	public bool swapDpadAndLeftStick { get; set; }

	public float vibrationStrength { get; set; }

	public virtual void Apply(IInputActionCollection actions)
	{
	}
}
