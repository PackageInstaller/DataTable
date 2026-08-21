using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class LookAt : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> lookTarget;

	public bool repeat;

	protected override string info => "LookAt " + lookTarget;

	protected override void OnExecute()
	{
		DoLook();
	}

	protected override void OnUpdate()
	{
		DoLook();
	}

	private void DoLook()
	{
		Vector3 position = lookTarget.value.transform.position;
		position.y = base.agent.position.y;
		base.agent.LookAt(position);
		if (!repeat)
		{
			EndAction(success: true);
		}
	}
}
