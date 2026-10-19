using System;

namespace ACT.Config;

[Serializable]
public class StateObjectType
{
	public readonly int id;

	public readonly int typeName;

	public readonly bool isExploreable;

	public readonly int playerRewardId;

	public readonly int unLockState;

	public readonly bool bonefireRefresh;

	public readonly bool countToAreaUnlockTypeObj;

	public readonly float weight;

	public readonly int belongGroup;

	public StateObjectType(int id, int typeName, bool isExploreable, int playerRewardId, int unLockState, bool bonefireRefresh, bool countToAreaUnlockTypeObj, float weight, int belongGroup)
	{
		this.id = id;
		this.typeName = typeName;
		this.isExploreable = isExploreable;
		this.playerRewardId = playerRewardId;
		this.unLockState = unLockState;
		this.bonefireRefresh = bonefireRefresh;
		this.countToAreaUnlockTypeObj = countToAreaUnlockTypeObj;
		this.weight = weight;
		this.belongGroup = belongGroup;
	}
}
