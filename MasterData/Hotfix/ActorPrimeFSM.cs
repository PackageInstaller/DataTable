using System.Collections.Generic;
using UnityEngine;

public class ActorPrimeFSM : ActorFSM
{
	internal LogicEntity killer;

	internal IList<int> damageTag;

	internal int uniqueAttackId;

	internal DeadType deadType;

	public ActorPrimeFSM(GameObject actor)
		: base(actor)
	{
	}
}
