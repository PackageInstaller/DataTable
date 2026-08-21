using Ase;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("Input (Legacy System)")]
public class CheckMousePick2D : ConditionTask
{
	public ButtonKeys buttonKey;

	public LayerMask mask = -1;

	[BlackboardOnly]
	public BBParameter<GameObject> saveGoAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	[BlackboardOnly]
	public BBParameter<Vector3> savePosAs;

	private int buttonID;

	private RaycastHit2D hit;

	protected override string info
	{
		get
		{
			string text = buttonKey.ToString() + " Click";
			if (!savePosAs.isNone)
			{
				text = text + "\nSavePos As " + savePosAs;
			}
			if (!saveGoAs.isNone)
			{
				text = text + "\nSaveGo As " + saveGoAs;
			}
			return text;
		}
	}

	protected override bool OnCheck()
	{
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		buttonID = (int)buttonKey;
		if (Input.GetMouseButtonDown(buttonID))
		{
			Ray ray = GameEntry.Camera.MainCamera.ScreenPointToRay(Input.mousePosition);
			hit = Physics2D.Raycast((Vector2)ray.origin, (Vector2)ray.direction, float.PositiveInfinity, (int)mask);
			if ((Object)(object)((RaycastHit2D)(ref hit)).collider != null)
			{
				savePosAs.value = ((RaycastHit2D)(ref hit)).point;
				saveGoAs.value = ((Component)(object)((RaycastHit2D)(ref hit)).collider).gameObject;
				saveDistanceAs.value = ((RaycastHit2D)(ref hit)).distance;
				return true;
			}
		}
		return false;
	}
}
