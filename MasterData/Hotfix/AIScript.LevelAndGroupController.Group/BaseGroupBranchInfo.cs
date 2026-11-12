using System;

namespace AIScript.LevelAndGroupController.Group;

public class BaseGroupBranchInfo
{
	public int id;

	public MonsterActionBase.OperateDelegate operateIEnumerator;

	public Action operateCompleteCallback;

	public BaseGroupBranchInfo(int id, MonsterActionBase.OperateDelegate operateIEnumerator = null, Action operateCompleteCallback = null)
	{
		this.id = id;
		this.operateIEnumerator = operateIEnumerator;
		this.operateCompleteCallback = operateCompleteCallback;
	}
}
