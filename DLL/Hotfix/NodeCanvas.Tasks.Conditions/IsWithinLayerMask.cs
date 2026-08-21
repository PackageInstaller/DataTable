using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("GameObject")]
public class IsWithinLayerMask : ConditionTask<Transform>
{
	public BBParameter<LayerMask> targetLayers;

	protected override bool OnCheck()
	{
		return base.agent.gameObject.IsInLayerMask(targetLayers.value);
	}
}
