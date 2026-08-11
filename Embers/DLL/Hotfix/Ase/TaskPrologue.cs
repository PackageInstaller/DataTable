using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class TaskPrologue
{
	public int PrologueId;

	public bool invertCondition;

	public List<OpenCondition> TaskConditions;

	public bool CheckTaskCondition()
	{
		if (invertCondition)
		{
			return !Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckMapDataNodeActived(TaskConditions);
		}
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckMapDataNodeActived(TaskConditions);
	}
}
