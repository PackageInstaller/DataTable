using System;

public class EntityMoveToEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public Int3 mTargetPos;

	public int mEnityID;

	internal EntityMoveToEvent(int newEntity, Int3 targetPos)
	{
		mTargetPos = targetPos;
		mEnityID = newEntity;
	}

	public override void OnEnterPool()
	{
		throw new NotImplementedException();
	}

	public override void Release()
	{
		throw new NotImplementedException();
	}
}
