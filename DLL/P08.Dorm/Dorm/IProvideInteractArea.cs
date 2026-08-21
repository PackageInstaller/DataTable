using UnityEngine;

namespace Dorm;

public interface IProvideInteractArea : IInteractProvider
{
	BoxCollider Area { get; }

	IProvideInteractEntity Provider { get; }
}
