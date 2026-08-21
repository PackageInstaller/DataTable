using System.Linq;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Users;

namespace Cinemachine;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineAlternativeInput.html")]
public class CinemachineInputProvider : MonoBehaviour, AxisState.IInputAxisProvider
{
	[Tooltip("Leave this at -1 for single-player games.  For multi-player games, set this to be the player index, and the actions will be read from that player's controls")]
	public int PlayerIndex = -1;

	[Tooltip("If set, Input Actions will be auto-enabled at start")]
	public bool AutoEnableInputs = true;

	[Tooltip("Vector2 action for XY movement")]
	public InputActionReference XYAxis;

	[Tooltip("Float action for Z movement")]
	public InputActionReference ZAxis;

	private const int NUM_AXES = 3;

	private InputAction[] m_cachedActions;

	public virtual float GetAxisValue(int axis)
	{
		if (base.enabled)
		{
			InputAction inputAction = ResolveForPlayer(axis, (axis == 2) ? ZAxis : XYAxis);
			if (inputAction != null)
			{
				switch (axis)
				{
				case 0:
					return inputAction.ReadValue<Vector2>().x;
				case 1:
					return inputAction.ReadValue<Vector2>().y;
				case 2:
					return inputAction.ReadValue<float>();
				}
			}
		}
		return 0f;
	}

	protected InputAction ResolveForPlayer(int axis, InputActionReference actionRef)
	{
		if (axis < 0 || axis >= 3)
		{
			return null;
		}
		if (actionRef == null || actionRef.action == null)
		{
			return null;
		}
		if (m_cachedActions == null || m_cachedActions.Length != 3)
		{
			m_cachedActions = new InputAction[3];
		}
		if (m_cachedActions[axis] != null && actionRef.action.id != m_cachedActions[axis].id)
		{
			m_cachedActions[axis] = null;
		}
		if (m_cachedActions[axis] == null)
		{
			m_cachedActions[axis] = actionRef.action;
			if (PlayerIndex != -1)
			{
				m_cachedActions[axis] = GetFirstMatch(InputUser.all[PlayerIndex], actionRef);
			}
			if (AutoEnableInputs && actionRef != null && actionRef.action != null)
			{
				actionRef.action.Enable();
			}
		}
		if (m_cachedActions[axis] != null && m_cachedActions[axis].enabled != actionRef.action.enabled)
		{
			if (actionRef.action.enabled)
			{
				m_cachedActions[axis].Enable();
			}
			else
			{
				m_cachedActions[axis].Disable();
			}
		}
		return m_cachedActions[axis];
		static InputAction GetFirstMatch(in InputUser user, InputActionReference aRef)
		{
			return user.actions.First((InputAction x) => x.id == aRef.action.id);
		}
	}

	protected virtual void OnDisable()
	{
		m_cachedActions = null;
	}
}
