using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Set Layer Weight", 0)]
[Category("Animator")]
public class MecanimSetLayerWeight : ActionTask<Animator>
{
	public BBParameter<int> layerIndex;

	[SliderField(0, 1)]
	public BBParameter<float> layerWeight;

	[SliderField(0, 1)]
	public float transitTime;

	private float currentValue;

	protected override string info => "Set Layer " + layerIndex?.ToString() + ", weight " + layerWeight;

	protected override void OnExecute()
	{
		currentValue = base.agent.GetLayerWeight(layerIndex.value);
	}

	protected override void OnUpdate()
	{
		float num = ((transitTime > 0f) ? Mathf.Lerp(currentValue, layerWeight.value, base.elapsedTime / transitTime) : layerWeight.value);
		base.agent.SetLayerWeight(layerIndex.value, num);
		if (base.elapsedTime >= transitTime)
		{
			EndAction(success: true);
		}
	}
}
