using UnityEngine;

namespace BilliardGame.Runtime;

public class BilliardGameBehaviorBase : MonoBehaviour
{
	public int entityID { get; protected set; }

	public void SetEntityID(int entityID)
	{
		this.entityID = entityID;
	}

	public virtual void Init()
	{
	}

	public virtual void Dispose()
	{
	}
}
