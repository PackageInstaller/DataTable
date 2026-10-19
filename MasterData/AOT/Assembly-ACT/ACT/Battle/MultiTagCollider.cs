using UnityEngine;

namespace ACT.Battle;

public class MultiTagCollider : MonoBehaviour
{
	[SerializeField]
	[Tooltip("碰撞体的自定义标签列表")]
	[FlagsEnum]
	private CustomTag customTags;

	private Collider attachedCollider;

	private void Awake()
	{
	}

	public bool HasTag(CustomTag tag)
	{
		return customTags.HasFlag(tag);
	}
}
