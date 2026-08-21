using UnityEngine;

namespace ParadoxNotion;

public interface IEventData
{
	GameObject receiver { get; }

	object sender { get; }

	object valueBoxed { get; }
}
