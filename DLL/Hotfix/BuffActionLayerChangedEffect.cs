using System.Collections.Generic;
using Ase;
using UnityEngine.Pool;

public class BuffActionLayerChangedEffect : BuffActionBase
{
	protected Dictionary<int, int> changeDic;

	public override void OnInit(Buff buff, List<float> actionParams)
	{
		actionType = BuffActionTypeEnum.LayerChangedEffect;
		if (actionParams != null && actionParams.Count != 0 && actionParams.Count % 2 == 0)
		{
			changeDic = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
			int num = actionParams.Count / 2;
			for (int i = 0; i < num; i++)
			{
				changeDic.Add((int)actionParams[i * 2], (int)actionParams[i * 2 + 1]);
			}
		}
	}

	public override void OnExcute(Buff buff)
	{
		if (changeDic.TryGetValue(buff.GetLayer(), out var value))
		{
			buff.OnChangedEffect(value);
		}
	}

	public override void Clear()
	{
		CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Release(changeDic);
	}
}
