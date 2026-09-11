using UnityEngine;

[ExecuteInEditMode]
public class PositionAttachIsNotChild : MonoBehaviour
{
	public Transform AttachTransform;

	public Vector3 PositionOffset;

	public bool IsEnable = true;

	private Transform Tran;

	private EffectController com;

	private void Start()
	{
		Tran = base.transform;
		if (!(AttachTransform == null) && IsEnable)
		{
			com = Tran.gameObject.GetComponent<EffectController>();
			Tran.position = AttachTransform.position;
		}
	}

	private void LateUpdate()
	{
		if (com != null)
		{
			com.Hide(!AttachTransform.gameObject.activeSelf);
		}
		if (AttachTransform != null)
		{
			Tran.position = AttachTransform.position + PositionOffset;
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
