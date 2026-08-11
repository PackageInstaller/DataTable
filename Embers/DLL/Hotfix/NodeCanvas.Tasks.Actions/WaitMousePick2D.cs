using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Input (Legacy System)")]
public class WaitMousePick2D : ActionTask
{
	public enum ButtonKeys
	{
		Left,
		Right,
		Middle
	}

	public ButtonKeys buttonKey;

	public LayerMask mask = -1;

	[BlackboardOnly]
	public BBParameter<GameObject> saveObjectAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	[BlackboardOnly]
	public BBParameter<Vector3> savePositionAs;

	private int buttonID;

	private RaycastHit2D hit;

	protected override string info => $"Wait Object '{buttonKey}' Click. Save As {saveObjectAs}";

	protected override void OnUpdate()
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
				savePositionAs.value = ((RaycastHit2D)(ref hit)).point;
				saveObjectAs.value = ((Component)(object)((RaycastHit2D)(ref hit)).collider).gameObject;
				saveDistanceAs.value = ((RaycastHit2D)(ref hit)).distance;
				EndAction(success: true);
			}
		}
	}
}
