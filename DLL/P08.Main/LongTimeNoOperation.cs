using UnityEngine;
using UnityEngine.Events;

public class LongTimeNoOperation : MonoBehaviour
{
	public bool isAllowCheck;

	public float maxTimeOffset = 30f;

	private float lastOpTime;

	public UnityEvent action;

	public UnityEvent onAnyInput;

	public bool actionCallOnceOnly;

	public bool onAnyInputCallOnceOnly = true;

	private bool actionCalled;

	private bool onAnyInputCalled;

	private float nowTime => Time.time;

	private void OnEnable()
	{
		lastOpTime = nowTime;
		actionCalled = (onAnyInputCalled = false);
	}

	private void Update()
	{
		CheckOperate();
	}

	public void CheckOperate()
	{
		if (Input.anyKey)
		{
			AnyInputOperation();
		}
		if (isAllowCheck && nowTime - lastOpTime > maxTimeOffset)
		{
			TakeOperate();
		}
	}

	public void TakeOperate()
	{
		lastOpTime = nowTime;
		if (!actionCallOnceOnly || !actionCalled)
		{
			actionCalled = true;
			action?.Invoke();
		}
	}

	public void AnyInputOperation()
	{
		lastOpTime = nowTime;
		if (!onAnyInputCallOnceOnly || !onAnyInputCalled)
		{
			onAnyInputCalled = true;
			onAnyInput?.Invoke();
		}
	}
}
