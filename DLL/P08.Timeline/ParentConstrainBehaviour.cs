using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

public class ParentConstrainBehaviour : PlayableBehaviour
{
	public GameObject child;

	public GameObject parent;

	private ParentConstraint parentConstraint;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (parent == null)
		{
			Debug.LogError("ParentConstrainBehaviour has no parent!");
			if (parentConstraint != null)
			{
				parentConstraint.constraintActive = false;
			}
			return;
		}
		parentConstraint = child.GetComponentOrAdd<ParentConstraint>();
		if (parentConstraint == null)
		{
			Debug.LogError("ParentConstrainBehaviour could not create ParentConstraint!");
			return;
		}
		if (parentConstraint.sourceCount == 0)
		{
			parentConstraint.AddSource(new ConstraintSource
			{
				sourceTransform = parent.transform,
				weight = 1f
			});
		}
		parentConstraint.constraintActive = true;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (parentConstraint != null)
		{
			parentConstraint.constraintActive = false;
		}
	}
}
