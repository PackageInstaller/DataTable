using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class UpdateBuff : BuffOperationBase<BuffDataUpdate>
{
	private int addCount;

	private Dictionary<int, List<BaseEntity>> addBuffEntitysDic = new Dictionary<int, List<BaseEntity>>();

	protected override void OnExecute()
	{
		if (addCount >= dataBase.count)
		{
			return;
		}
		List<BaseEntity> targetByTeamTypeList = BuffExtension.GetTargetByTeamTypeList(base.buffFrom, base.buffOwner, dataBase.teamType);
		if (targetByTeamTypeList == null)
		{
			return;
		}
		BuffSystem system = base.buffOwner.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		addCount++;
		foreach (BaseEntity item in targetByTeamTypeList)
		{
			system.CheckAndAcquireBuff(base.buffFrom, item, dataBase.buffID);
		}
		addBuffEntitysDic.Add(addCount, targetByTeamTypeList);
	}

	protected override void OnNotExecute()
	{
		if (addCount <= 0)
		{
			return;
		}
		if (addBuffEntitysDic.Remove(addCount, out var value))
		{
			BuffSystem system = base.buffOwner.GetSystem<BuffSystem>();
			foreach (BaseEntity item in value)
			{
				system.FinishEntityBuff(item.Id, dataBase.buffID);
			}
		}
		addCount--;
	}

	protected override void OnClear()
	{
		addBuffEntitysDic.Clear();
		addCount = 0;
	}
}
