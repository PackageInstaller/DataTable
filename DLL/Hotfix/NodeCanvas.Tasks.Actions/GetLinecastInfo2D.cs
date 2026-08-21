using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Physics")]
public class GetLinecastInfo2D : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public LayerMask mask = -1;

	[BlackboardOnly]
	public BBParameter<GameObject> saveHitGameObjectAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	[BlackboardOnly]
	public BBParameter<Vector3> savePointAs;

	[BlackboardOnly]
	public BBParameter<Vector3> saveNormalAs;

	private RaycastHit2D hit;

	protected override void OnExecute()
	{
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		hit = Physics2D.Linecast((Vector2)base.agent.position, (Vector2)target.value.transform.position, (int)mask);
		if ((Object)(object)((RaycastHit2D)(ref hit)).collider != null)
		{
			saveHitGameObjectAs.value = ((Component)(object)((RaycastHit2D)(ref hit)).collider).gameObject;
			saveDistanceAs.value = ((RaycastHit2D)(ref hit)).fraction;
			savePointAs.value = ((RaycastHit2D)(ref hit)).point;
			saveNormalAs.value = ((RaycastHit2D)(ref hit)).normal;
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
