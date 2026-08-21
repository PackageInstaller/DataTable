using UnityEngine;

namespace Ase.ECS;

public class CollisionLayer : MonoBehaviour
{
	[CollisionLayer]
	public CollisionSetting.CollisionLayer Layer;

	public int Mass;

	public virtual string CollisionType => "Default";
}
