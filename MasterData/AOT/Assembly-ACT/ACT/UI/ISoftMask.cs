using UnityEngine;

namespace ACT.UI;

public interface ISoftMask
{
	bool isAlive { get; }

	bool isMaskingEnabled { get; }

	Material GetReplacement(Material original);

	void ReleaseReplacement(Material replacement);

	void UpdateTransformChildren(Transform transform);
}
