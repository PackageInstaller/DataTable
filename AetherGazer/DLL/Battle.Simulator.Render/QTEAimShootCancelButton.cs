using System;

public class QTEAimShootCancelButton : P08EXButton
{
	public QTEAimShootWithListScript LockScript;

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(CancelLock));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(CancelLock));
	}

	private void CancelLock()
	{
		LockScript.mAimTime = 0f;
	}
}
