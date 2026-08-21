using UnityEngine;

namespace DG.Tweening.Core;

internal class TweenLink
{
	public readonly GameObject target;

	public readonly LinkBehaviour behaviour;

	public bool lastSeenActive;

	public TweenLink(GameObject target, LinkBehaviour behaviour)
	{
		this.target = target;
		this.behaviour = behaviour;
		lastSeenActive = target.activeInHierarchy;
	}
}
