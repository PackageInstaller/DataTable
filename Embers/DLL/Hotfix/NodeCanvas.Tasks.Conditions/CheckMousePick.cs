using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("Input (Legacy System)")]
public class CheckMousePick : ConditionTask
{
	public ButtonKeys buttonKey;

	[LayerField]
	public int layer;

	[BlackboardOnly]
	public BBParameter<GameObject> saveGoAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	[BlackboardOnly]
	public BBParameter<Vector3> savePosAs;

	private RaycastHit hit;

	protected override string info
	{
		get
		{
			string text = buttonKey.ToString() + " Click";
			if (!string.IsNullOrEmpty(savePosAs.name))
			{
				text += $"\n<i>(SavePos As {savePosAs})</i>";
			}
			if (!string.IsNullOrEmpty(saveGoAs.name))
			{
				text += $"\n<i>(SaveGo As {saveGoAs})</i>";
			}
			return text;
		}
	}

	protected override bool OnCheck()
	{
		if (Input.GetMouseButtonDown((int)buttonKey) && Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), ref hit, float.PositiveInfinity, 1 << layer))
		{
			saveGoAs.value = ((Component)(object)((RaycastHit)(ref hit)).collider).gameObject;
			saveDistanceAs.value = ((RaycastHit)(ref hit)).distance;
			savePosAs.value = ((RaycastHit)(ref hit)).point;
			return true;
		}
		return false;
	}
}
