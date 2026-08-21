using System;
using System.Linq;

namespace UnityEngine.InputSystem;

public class InputActionReference : ScriptableObject
{
	[SerializeField]
	internal InputActionAsset m_Asset;

	[SerializeField]
	internal string m_ActionId;

	[NonSerialized]
	private InputAction m_Action;

	public InputActionAsset asset => m_Asset;

	public InputAction action
	{
		get
		{
			if (m_Action == null)
			{
				if (m_Asset == null)
				{
					return null;
				}
				m_Action = m_Asset.FindAction(new Guid(m_ActionId));
			}
			return m_Action;
		}
	}

	public void Set(InputAction action)
	{
		if (action == null)
		{
			m_Asset = null;
			m_ActionId = null;
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

	private void SetInternal(InputActionAsset asset, InputAction action)
	{
		InputActionMap actionMap = action.actionMap;
		if (!asset.actionMaps.Contains(actionMap))
		{
			throw new ArgumentException($"Action '{action}' is not contained in asset '{asset}'", "action");
		}
		m_Asset = asset;
		m_ActionId = action.id.ToString();
		base.name = GetDisplayName(action);
	}

	public override string ToString()
	{
		try
		{
			InputAction inputAction = action;
			return m_Asset.name + ":" + inputAction.actionMap.name + "/" + inputAction.name;
		}
		catch
		{
			if (m_Asset != null)
			{
				return m_Asset.name + ":" + m_ActionId;
			}
		}
		return base.ToString();
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
		if (!string.IsNullOrEmpty(base.name))
		{
			return base.name;
		}
		return GetDisplayName(action);
	}

	public static implicit operator InputAction(InputActionReference reference)
	{
		return reference?.action;
	}

	public static InputActionReference Create(InputAction action)
	{
		if (action == null)
		{
			return null;
		}
		InputActionReference inputActionReference = ScriptableObject.CreateInstance<InputActionReference>();
		inputActionReference.Set(action);
		return inputActionReference;
	}

	public InputAction ToInputAction()
	{
		return action;
	}
}
