using System.Collections.Generic;

namespace Ase.ECS;

public class SummonedEntityView : TargetView
{
	public List<BuffInfo> buffList = new List<BuffInfo>();

	public void Refresh()
	{
		LinkedList<Buff> linkedList = mBaseEntity.GetSystem<BuffSystem>()?.GetEntityBuffs(mBaseEntity.Id);
		if (linkedList == null)
		{
			return;
		}
		buffList.Clear();
		foreach (Buff item in linkedList)
		{
			buffList.Add(new BuffInfo(item));
		}
	}
}
