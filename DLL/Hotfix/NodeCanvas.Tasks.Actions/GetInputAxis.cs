using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Input (Legacy System)")]
public class GetInputAxis : ActionTask
{
	public BBParameter<string> xAxisName = "Horizontal";

	public BBParameter<string> yAxisName;

	public BBParameter<string> zAxisName = "Vertical";

	public BBParameter<float> multiplier = 1f;

	[BlackboardOnly]
	public BBParameter<Vector3> saveAs;

	[BlackboardOnly]
	public BBParameter<float> saveXAs;

	[BlackboardOnly]
	public BBParameter<float> saveYAs;

	[BlackboardOnly]
	public BBParameter<float> saveZAs;

	public bool repeat;

	protected override void OnExecute()
	{
		Do();
	}

	protected override void OnUpdate()
	{
		Do();
	}

	private void Do()
	{
		float num = (string.IsNullOrEmpty(xAxisName.value) ? 0f : Input.GetAxis(xAxisName.value));
		float num2 = (string.IsNullOrEmpty(yAxisName.value) ? 0f : Input.GetAxis(yAxisName.value));
		float num3 = (string.IsNullOrEmpty(zAxisName.value) ? 0f : Input.GetAxis(zAxisName.value));
		saveXAs.value = num * multiplier.value;
		saveYAs.value = num2 * multiplier.value;
		saveZAs.value = num3 * multiplier.value;
		saveAs.value = new Vector3(num, num2, num3) * multiplier.value;
		if (!repeat)
		{
			EndAction();
		}
	}
}
