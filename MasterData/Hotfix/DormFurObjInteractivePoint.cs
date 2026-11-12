using UnityEngine;

public class DormFurObjInteractivePoint
{
	public long bindEntityID;

	public long reserveEntityID;

	public Transform target_by_anim_start;

	public Transform target_by_anim_end;

	public Transform target_by_design_start;

	public Transform target_by_design_end;

	public GameObject indicator;

	public bool IsUsing => bindEntityID > 0;

	public bool IsFreeFor(long entityID)
	{
		if (bindEntityID > 0)
		{
			return false;
		}
		if (reserveEntityID > 0)
		{
			return reserveEntityID == entityID;
		}
		return true;
	}
}
