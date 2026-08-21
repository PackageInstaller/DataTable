using System;
using UnityEngine;

namespace Ase;

public class ColliderBtn : MonoBehaviour
{
	private Action onMouseDown;

	private Action onMouseUp;

	public void RegisterEvent(Action mouseDown, Action mouseUp)
	{
		onMouseDown = mouseDown;
		onMouseUp = mouseUp;
	}

	private void OnMouseDown()
	{
		onMouseDown?.Invoke();
	}

	private void OnMouseUp()
	{
		onMouseUp?.Invoke();
	}
}
