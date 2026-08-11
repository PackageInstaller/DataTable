using System.Collections.Generic;
using UnityEngine.Pool;

namespace Ase;

public class BuffLayerBuff : BuffOperationBase<BuffDataBuffLayer>
{
	protected override void OnExecute()
	{
		List<Buff> list = BuffExtension.FindTargetBuffByTeamType(base.buffFrom, base.buffOwner, dataBase.teamType, dataBase.buffId);
		for (int i = 0; i < list.Count; i++)
		{
			switch (dataBase.changeType)
			{
			case ChangeType.Set:
				list[i].SetLayer(dataBase.buffLayer);
				break;
			case ChangeType.Add:
				list[i].SetLayer(list[i].GetLayer() + dataBase.buffLayer);
				break;
			case ChangeType.Dec:
				list[i].SetLayer(list[i].GetLayer() - dataBase.buffLayer);
				break;
			case ChangeType.Clear:
			case ChangeType.Reset:
				list[i].SetLayer(0);
				break;
			}
		}
		CollectionPool<List<Buff>, Buff>.Release(list);
	}
}
