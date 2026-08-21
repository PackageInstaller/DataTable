using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Conditions;

[Category("Movement")]
[Description("Check if a path exists for the agent and optionaly save the resulting path positions")]
public class PathExists : ConditionTask<NavMeshAgent>
{
	public BBParameter<Vector3> targetPosition;

	[BlackboardOnly]
	public BBParameter<List<Vector3>> savePathAs;

	protected override bool OnCheck()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Invalid comparison between Unknown and I4
		NavMeshPath val = new NavMeshPath();
		base.agent.CalculatePath(targetPosition.value, val);
		savePathAs.value = val.corners.ToList();
		return (int)val.status == 0;
	}
}
