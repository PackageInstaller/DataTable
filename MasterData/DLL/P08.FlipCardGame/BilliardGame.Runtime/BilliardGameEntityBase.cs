using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public abstract class BilliardGameEntityBase
{
	public int entityID { get; protected set; }

	public Vector3 position
	{
		get
		{
			if (null != go)
			{
				return go.transform.position;
			}
			return Vector3.zero;
		}
	}

	public GameObject go { get; protected set; }

	public BilliardGameEntityBase(int entityID, GameObject go)
	{
		this.entityID = entityID;
		this.go = go;
	}

	public virtual void Tick()
	{
	}

	public abstract void Dispose();

	public virtual BTEnv GetBuff(int buffID)
	{
		return null;
	}
}
