using UnityEngine;

[ExecuteInEditMode]
public class ChildLockRotation : MonoBehaviour
{
	public bool IsEnable = true;

	public Quaternion LockRotationValue = Quaternion.identity;

	private void Start()
	{
		base.transform.rotation = LockRotationValue;
	}

	private void LateUpdate()
	{
		if (IsEnable)
		{
			base.transform.rotation = LockRotationValue;
		}
	}

	public void DisenableLock()
	{
		IsEnable = false;
	}

	public void EnableLockWithoutUpdateLockRotation()
	{
		IsEnable = true;
	}
}
