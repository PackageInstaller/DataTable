using UnityEngine;

namespace ACT.UI;

public struct SpawnNumPositionConfig
{
	public Vector2 bias;

	public Vector2 randomRectangles;

	public Vector3 GetPosition(Vector3 pos, bool faceLeft)
	{
		return pos + new Vector3(faceLeft ? (0f - bias.x) : bias.x, bias.y, 0f) + new Vector3(Random.Range(0f - randomRectangles.x, randomRectangles.x), Random.Range(0f - randomRectangles.y, randomRectangles.y), 0f);
	}
}
