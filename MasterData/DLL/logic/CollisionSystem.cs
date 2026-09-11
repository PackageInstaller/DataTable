using System.Collections.Generic;
using Entitas;
using Pathfinding.Util;

public class CollisionSystem : IExecuteSystem, ISystem
{
	public SimContext mSimContext;

	private DynamicTree<ISimShape> mTree;

	public List<ISimShape> lastCollisionPair;

	public CollisionSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Execute()
	{
		if (mTree == null)
		{
			mTree = mSimContext.sEntityAABBTree.mDynamicTree;
		}
		List<ISimShape> pair = ListPool<ISimShape>.Claim();
		mTree.QueryCollisionPair(ref pair);
		for (int i = 0; i < pair.Count; i += 2)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(pair[i].OwnerID);
			SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(pair[i + 1].OwnerID);
			if (!entityWithEntityID.hasEntityCollisionInfo)
			{
				entityWithEntityID.AddEntityCollisionInfo(entityWithEntityID2, CollisionStatus.OnEnter);
			}
			else if (entityWithEntityID.entityCollisionInfo.contactEntity != entityWithEntityID2)
			{
				entityWithEntityID.entityCollisionInfo.collisionStatus = CollisionStatus.OnEnter;
			}
			else if (entityWithEntityID.entityCollisionInfo.collisionStatus == CollisionStatus.OnEnter)
			{
				entityWithEntityID.entityCollisionInfo.collisionStatus = CollisionStatus.OnStay;
			}
			else if (entityWithEntityID.entityCollisionInfo.collisionStatus == CollisionStatus.OnLeave)
			{
				entityWithEntityID.entityCollisionInfo.collisionStatus = CollisionStatus.OnEnter;
			}
			if (!entityWithEntityID2.hasEntityCollisionInfo)
			{
				entityWithEntityID2.AddEntityCollisionInfo(entityWithEntityID, CollisionStatus.OnEnter);
			}
			else if (entityWithEntityID2.entityCollisionInfo.contactEntity != entityWithEntityID)
			{
				entityWithEntityID2.entityCollisionInfo.collisionStatus = CollisionStatus.OnEnter;
			}
			else if (entityWithEntityID2.entityCollisionInfo.collisionStatus == CollisionStatus.OnEnter)
			{
				entityWithEntityID2.entityCollisionInfo.collisionStatus = CollisionStatus.OnStay;
			}
			else if (entityWithEntityID2.entityCollisionInfo.collisionStatus == CollisionStatus.OnLeave)
			{
				entityWithEntityID2.entityCollisionInfo.collisionStatus = CollisionStatus.OnEnter;
			}
			entityWithEntityID.entityCollisionInfo.contactEntity = entityWithEntityID2;
			entityWithEntityID2.entityCollisionInfo.contactEntity = entityWithEntityID;
		}
		if (lastCollisionPair != null)
		{
			for (int j = 0; j < lastCollisionPair.Count; j++)
			{
				ISimShape simShape = lastCollisionPair[j];
				if (simShape == null)
				{
					continue;
				}
				bool flag = false;
				for (int k = 0; k < pair.Count; k++)
				{
					if (pair[k] == simShape)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					SimEntity entityWithEntityID3 = mSimContext.GetEntityWithEntityID(simShape.OwnerID);
					if (entityWithEntityID3 == null)
					{
						return;
					}
					entityWithEntityID3.entityCollisionInfo.collisionStatus = CollisionStatus.OnLeave;
				}
			}
		}
		if (lastCollisionPair != null)
		{
			ListPool<ISimShape>.Release(lastCollisionPair);
		}
		lastCollisionPair = pair;
	}
}
