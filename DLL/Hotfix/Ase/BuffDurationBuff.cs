using System.Collections.Generic;
using UnityEngine.Pool;

namespace Ase;

public class BuffDurationBuff : BuffOperationBase<BuffDataBuffDuration>
{
	protected override void OnExecute()
	{
		List<Buff> list = BuffExtension.FindTargetBuffByTeamType(base.buffFrom, base.buffOwner, dataBase.teamType, dataBase.buffId);
		for (int i = 0; i < list.Count; i++)
		{
			switch (dataBase.changeType)
			{
			case ChangeType.Set:
				list[i].SetDuration(dataBase.buffDuration);
				break;
			case ChangeType.Add:
				list[i].SetDuration(list[i].GetDuration() + dataBase.buffDuration);
				break;
			case ChangeType.Dec:
				list[i].SetDuration(list[i].GetDuration() - dataBase.buffDuration);
				break;
			case ChangeType.Clear:
				list[i].SetDuration(0f);
				break;
			case ChangeType.Reset:
				list[i].SetDuration(list[i].Config.Duration);
				break;
			}
		}
		CollectionPool<List<Buff>, Buff>.Release(list);
	}
}
