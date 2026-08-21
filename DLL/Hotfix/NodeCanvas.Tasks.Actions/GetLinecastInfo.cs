using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Physics")]
public class GetLinecastInfo : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public BBParameter<LayerMask> layerMask = (LayerMask)(-1);

	[BlackboardOnly]
	public BBParameter<GameObject> saveHitGameObjectAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	[BlackboardOnly]
	public BBParameter<Vector3> savePointAs;

	[BlackboardOnly]
	public BBParameter<Vector3> saveNormalAs;

	private RaycastHit hit;

	protected override void OnExecute()
	{
		if (Physics.Linecast(base.agent.position, target.value.transform.position, ref hit, (int)layerMask.value))
		{
			saveHitGameObjectAs.value = ((Component)(object)((RaycastHit)(ref hit)).collider).gameObject;
			saveDistanceAs.value = ((RaycastHit)(ref hit)).distance;
			savePointAs.value = ((RaycastHit)(ref hit)).point;
			saveNormalAs.value = ((RaycastHit)(ref hit)).normal;
			EndAction(success: true);
		}
		else
		{
			EndAction(success: false);
		}
	}

	public override void OnDrawGizmosSelected()
	{
		if ((bool)base.agent && (bool)target.value)
		{
			Gizmos.DrawLine(base.agent.position, target.value.transform.position);
		}
	}
}
