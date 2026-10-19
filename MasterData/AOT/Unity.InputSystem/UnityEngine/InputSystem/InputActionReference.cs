using System;

namespace UnityEngine.InputSystem;

public class InputActionReference : ScriptableObject
{
	[SerializeField]
	internal InputActionAsset m_Asset;

	[SerializeField]
	internal string m_ActionId;

	[NonSerialized]
	private InputAction m_Action;

	public InputActionAsset asset
	{
		get
		{
			if (m_Action?.m_ActionMap == null)
			{
				return m_Asset;
			}
			return m_Action.m_ActionMap.asset;
		}
	}

	public InputAction action
	{
		get
		{
			if (m_Action != null && m_Action.actionMap != null && m_Action.actionMap.asset == m_Asset && (bool)m_Asset)
			{
				return m_Action;
			}
			return m_Action = (m_Asset ? m_Asset.FindAction(new Guid(m_ActionId)) : null);
		}
	}

	public void Set(InputAction action)
	{
		if (action == null)
		{
			m_Asset = null;
			m_ActionId = null;
			m_Action = null;
			name = string.Empty;
			return;
		}
		InputActionMap actionMap = action.actionMap;
		if (actionMap == null || actionMap.asset == null)
		{
			throw new InvalidOperationException($"Action '{action}' must be part of an InputActionAsset in order to be able to create an InputActionReference for it");
		}
		SetInternal(actionMap.asset, action);
	}

	public void Set(InputActionAsset asset, string mapName, string actionName)
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(mapName))
		{
			throw new ArgumentNullException("mapName");
		}
		if (string.IsNullOrEmpty(actionName))
		{
			throw new ArgumentNullException("actionName");
		}
		InputAction inputAction = (asset.FindActionMap(mapName) ?? throw new ArgumentException($"No action map '{mapName}' in '{asset}'", "mapName")).FindAction(actionName);
		if (inputAction == null)
		{
			throw new ArgumentException($"No action '{actionName}' in map '{mapName}' of asset '{asset}'", "actionName");
		}
		SetInternal(asset, inputAction);
	}

	private void SetInternal(InputActionAsset assetArg, InputAction actionArg)
	{
		CheckImmutableReference();
		m_Asset = assetArg;
		m_ActionId = actionArg.id.ToString();
		m_Action = actionArg;
		name = GetDisplayName(actionArg);
	}

	public override string ToString()
	{
		InputAction inputAction = action;
		if (inputAction == null)
		{
			return base.ToString();
		}
		if (inputAction.actionMap != null)
		{
			if (!(m_Asset != null))
			{
				return inputAction.actionMap.name + "/" + inputAction.name;
			}
			return m_Asset.name + ":" + inputAction.actionMap.name + "/" + inputAction.name;
		}
		if (!(m_Asset != null))
		{
			return m_ActionId;
		}
		return m_Asset.name + ":" + m_ActionId;
	}

	private static string GetDisplayName(InputAction action)
	{
		if (string.IsNullOrEmpty(action?.actionMap?.name))
		{
			return action?.name;
		}
		return action.actionMap?.name + "/" + action.name;
	}

	internal string ToDisplayName()
	{
		if (!string.IsNullOrEmpty(name))
		{
			return name;
		}
		return GetDisplayName(action);
	}

	public static implicit operator InputAction(InputActionReference reference)
	{
		return reference?.action;
	}

	public static InputActionReference Create(InputAction action)
	{
		InputActionReference inputActionReference = ScriptableObject.CreateInstance<InputActionReference>();
		inputActionReference.Set(action);
		return inputActionReference;
	}

	internal static void InvalidateAll()
	{
		Object[] array = Resources.FindObjectsOfTypeAll(typeof(InputActionReference));
		for (int i = 0; i < array.Length; i++)
		{
			((InputActionReference)array[i]).Invalidate();
		}
	}

	internal void Invalidate()
	{
		m_Action = null;
	}

	public InputAction ToInputAction()
	{
		return action;
	}

	private void CheckImmutableReference()
	{
	}
}
