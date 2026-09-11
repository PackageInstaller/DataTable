using System;
using UnityEngine;

namespace T0World;

public class T0BedInteractAreaItem : MonoBehaviour
{
	private BedPosEnum posType;

	private Action<BedPosEnum> clickCallback;

	private void Awake()
	{
		base.gameObject.layer = LayerMask.NameToLayer("Effect");
	}

	public void SetData(BedPosEnum _posType)
	{
		posType = _posType;
	}

	public void SetClickCallback(Action<BedPosEnum> _clickCallback)
	{
		clickCallback = _clickCallback;
	}

	public void TriggerClick()
	{
		if (clickCallback != null)
		{
			clickCallback(posType);
		}
	}

	public void Show(bool isShow)
	{
		base.gameObject.SetActive(isShow);
	}

	public void Dispose()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}
}
