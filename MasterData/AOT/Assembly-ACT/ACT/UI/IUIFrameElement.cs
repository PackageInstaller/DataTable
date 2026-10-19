using UnityEngine;

namespace ACT.UI;

internal interface IUIFrameElement
{
	void Initialize()
	{
	}

	void UnInitialize()
	{
	}

	void AddListener()
	{
	}

	void RemoveListener()
	{
	}

	void PushInStack()
	{
	}

	void PopUpStack()
	{
	}

	void OnUIDestroy()
	{
	}

	IBaseUIView GetParentView()
	{
		if (!(this is Component { transform: var transform }))
		{
			return null;
		}
		return transform?.GetComponentInParent<IBaseUIView>(includeInactive: true);
	}
}
