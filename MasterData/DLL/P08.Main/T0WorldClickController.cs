using UnityEngine;
using UnityEngine.Events;

public class T0WorldClickController : MonoBehaviour
{
	public UnityEvent clickCallBack;

	private bool _isPressingInside;

	public void InvokePointerDown()
	{
		_isPressingInside = true;
	}

	public void InvokePointerUp()
	{
		if (_isPressingInside)
		{
			clickCallBack?.Invoke();
		}
		_isPressingInside = false;
	}
}
