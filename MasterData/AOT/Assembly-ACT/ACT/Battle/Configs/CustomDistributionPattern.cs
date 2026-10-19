using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class CustomDistributionPattern : TransformsPattern
{
	public BulletAimRotationType bulletAimRotationType;

	public ConfigFunction<float> functionCount;

	public List<ConfigFunction<Vector3>> originList;

	public List<ConfigFunction<Vector3>> aimPosList;

	public List<ConfigFunction<Quaternion>> customRotation;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		if (functionCount == null)
		{
			return;
		}
		int num = (int)functionCount.Return(memory);
		if (num != originList.Count || num != aimPosList.Count || num != customRotation.Count)
		{
			Debug.LogError(memory.ability.config.name + "发射数量与发射位置列表数量不一致");
			return;
		}
		transforms.Clear();
		for (int i = 0; i < num; i++)
		{
			Vector3 vector = originList[i].Return(memory);
			_ = Vector3.zero;
			Quaternion quaternion = Quaternion.identity;
			switch (bulletAimRotationType)
			{
			case BulletAimRotationType.bytargetPos:
				quaternion = Quaternion.LookRotation(((aimPosList[i] == null) ? vector : aimPosList[i].Return(memory)) - vector);
				transforms.Add((vector, quaternion.eulerAngles));
				break;
			case BulletAimRotationType.byCustomRotation:
				quaternion = ((customRotation[i] == null) ? Quaternion.identity : customRotation[i].Return(memory));
				break;
			}
			transforms.Add((vector, quaternion.eulerAngles));
		}
	}
}
