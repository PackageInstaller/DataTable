using UnityEngine;

namespace ACT.Model.ChatBubbleModel;

public interface IBubbleObject
{
	Vector3 GetBubbleRootPosition();

	Transform GetBubbleRootTransform();
}
