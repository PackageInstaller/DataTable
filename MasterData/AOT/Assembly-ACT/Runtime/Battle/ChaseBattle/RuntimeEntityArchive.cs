using Bamboo.ECS;
using UnityEngine;

namespace Runtime.Battle.ChaseBattle;

public class RuntimeEntityArchive
{
	public Entity Entity { get; set; }

	public Vector3 Position { get; set; }

	public int ChunkID { get; set; }

	public float HpPercent { get; set; }
}
