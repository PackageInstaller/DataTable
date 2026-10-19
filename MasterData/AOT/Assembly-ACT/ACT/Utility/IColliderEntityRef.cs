using ACT.Battle;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Utility;

public interface IColliderEntityRef
{
	MonoEntity GetMonoEntity();

	void RemoveEntityRef();

	(bool, FindTargetResult) FindResult(Vector3 anchor, Vector3 touchForward);
}
