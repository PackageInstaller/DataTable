using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Physics")]
[Description("Get hit info for ALL objects in the linecast, in Lists")]
public class GetLinecastInfo2DAll : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public LayerMask mask = -1;

	[BlackboardOnly]
	public BBParameter<List<GameObject>> saveHitGameObjectsAs;

	[BlackboardOnly]
	public BBParameter<List<float>> saveDistancesAs;

	[BlackboardOnly]
	public BBParameter<List<Vector3>> savePointsAs;

	[BlackboardOnly]
	public BBParameter<List<Vector3>> saveNormalsAs;

	private RaycastHit2D[] hits;

	protected override void OnExecute()
	{
		hits = Physics2D.LinecastAll((Vector2)base.agent.position, (Vector2)target.value.transform.position, (int)mask);
		if (hits.Length != 0)
		{
			saveHitGameObjectsAs.value = hits.Select((RaycastHit2D h) => ((Component)(object)((RaycastHit2D)(ref h)).collider).gameObject).ToList();
			saveDistancesAs.value = hits.Select((RaycastHit2D h) => ((RaycastHit2D)(ref h)).fraction).ToList();
			savePointsAs.value = hits.Select((RaycastHit2D h) => new Vector3(((RaycastHit2D)(ref h)).point.x, ((RaycastHit2D)(ref h)).point.y, target.value.transform.position.z)).ToList();
			saveNormalsAs.value = hits.Select((RaycastHit2D h) => new Vector3(((RaycastHit2D)(ref h)).normal.x, ((RaycastHit2D)(ref h)).normal.y, 0f)).ToList();
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
