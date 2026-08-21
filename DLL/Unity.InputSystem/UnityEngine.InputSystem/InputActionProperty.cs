using System;

namespace UnityEngine.InputSystem;

[Serializable]
public struct InputActionProperty : IEquatable<InputActionProperty>, IEquatable<InputAction>, IEquatable<InputActionReference>
{
	[SerializeField]
	private bool m_UseReference;

	[SerializeField]
	private InputAction m_Action;

	[SerializeField]
	private InputActionReference m_Reference;

	public InputAction action
	{
		get
		{
			if (!m_UseReference)
			{
				return m_Action;
			}
			if (!(m_Reference != null))
			{
				return null;
			}
			return m_Reference.action;
		}
	}

	public InputActionReference reference
	{
		get
		{
			if (!m_UseReference)
			{
				return null;
			}
			return m_Reference;
		}
	}

	internal InputAction serializedAction => m_Action;

	internal InputActionReference serializedReference => m_Reference;

	public InputActionProperty(InputAction action)
	{
		m_UseReference = false;
		m_Action = action;
		m_Reference = null;
	}

	public InputActionProperty(InputActionReference reference)
	{
		m_UseReference = true;
		m_Action = null;
		m_Reference = reference;
	}

	public bool Equals(InputActionProperty other)
	{
		if (m_Reference == other.m_Reference && m_UseReference == other.m_UseReference)
		{
			return m_Action == other.m_Action;
		}
		return false;
	}

	public bool Equals(InputAction other)
	{
		return action == other;
	}

	public bool Equals(InputActionReference other)
	{
		return m_Reference == other;
	}

	public override bool Equals(object obj)
	{
		if (m_UseReference)
		{
			return Equals(obj as InputActionReference);
		}
		return Equals(obj as InputAction);
	}

	public override int GetHashCode()
	{
		if (m_UseReference)
		{
			if (!(m_Reference != null))
			{
				return 0;
			}
			return m_Reference.GetHashCode();
		}
		if (m_Action == null)
		{
			return 0;
		}
		return m_Action.GetHashCode();
	}

	public static bool operator ==(InputActionProperty left, InputActionProperty right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputActionProperty left, InputActionProperty right)
	{
		return !left.Equals(right);
	}
}
