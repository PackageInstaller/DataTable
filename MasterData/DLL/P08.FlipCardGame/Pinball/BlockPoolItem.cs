using UnityEngine;

namespace Pinball;

public class BlockPoolItem : MonoBehaviour
{
	public bool isReturning;

	public PolygonType BlockType { get; private set; }

	public void Initialize(PolygonType type)
	{
		BlockType = type;
		isReturning = false;
	}
}
