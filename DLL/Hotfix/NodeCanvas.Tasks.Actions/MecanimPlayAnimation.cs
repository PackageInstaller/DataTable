using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Name("Play Animation", 0)]
[Category("Animator")]
public class MecanimPlayAnimation : ActionTask<Animator>
{
	public BBParameter<int> layerIndex;

	[RequiredField]
	public BBParameter<string> stateName;

	[SliderField(0, 1)]
	public float transitTime = 0.25f;

	public bool waitUntilFinish;

	private AnimatorStateInfo stateInfo;

	private bool played;

	protected override string info => "Anim '" + stateName.ToString() + "'";

	protected override void OnExecute()
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		if (string.IsNullOrEmpty(stateName.value))
		{
			EndAction();
			return;
		}
		played = false;
		AnimatorStateInfo currentAnimatorStateInfo = base.agent.GetCurrentAnimatorStateInfo(layerIndex.value);
		base.agent.CrossFade(stateName.value, transitTime / ((AnimatorStateInfo)(ref currentAnimatorStateInfo)).length, layerIndex.value);
	}

	protected override void OnUpdate()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		stateInfo = base.agent.GetCurrentAnimatorStateInfo(layerIndex.value);
		if (waitUntilFinish)
		{
			if (((AnimatorStateInfo)(ref stateInfo)).IsName(stateName.value))
			{
				played = true;
				if (base.elapsedTime >= ((AnimatorStateInfo)(ref stateInfo)).length / base.agent.speed)
				{
					EndAction();
				}
			}
			else if (played)
			{
				EndAction();
			}
		}
		else if (base.elapsedTime >= transitTime)
		{
			EndAction();
		}
	}
}
