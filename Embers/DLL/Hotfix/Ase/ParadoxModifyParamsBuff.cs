using System;
using Ase.ECS;
using UnityEngine;

namespace Ase;

[Obsolete]
public class ParadoxModifyParamsBuff : BuffOperationBase<BuffDataParadoxModifyParams>
{
	private int treeId = -1;

	protected override void OnExecute()
	{
		RecordData();
		treeId = base.buffOwner.GetSystem<ParadoxSystem>().ExecuteTreeOrFsm(base.buffOwner, dataBase.paradoxId);
	}

	protected void RecordData()
	{
		if (dataBase.paradoxParams.IsNullOrEmpty())
		{
			return;
		}
		AIParadoxComponent component = base.buffOwner.GetComponent<AIParadoxComponent>();
		if (component == null)
		{
			return;
		}
		foreach (BuffDataParadoxModifyParams.ParadoxModifyParams paradoxParam in dataBase.paradoxParams)
		{
			switch (paradoxParam.typeEnum)
			{
			case ValueTypeEnum.Int:
				component.SetVariableValues(paradoxParam.paramsKey, (int)paradoxParam.value);
				break;
			case ValueTypeEnum.Float:
				component.SetVariableValues(paradoxParam.paramsKey, (float)paradoxParam.value);
				break;
			case ValueTypeEnum.Vector2:
				component.SetVariableValues(paradoxParam.paramsKey, (Vector2)paradoxParam.value);
				break;
			case ValueTypeEnum.Vector3:
				component.SetVariableValues(paradoxParam.paramsKey, (Vector3)paradoxParam.value);
				break;
			case ValueTypeEnum.Bool:
				component.SetVariableValues(paradoxParam.paramsKey, (bool)paradoxParam.value);
				break;
			case ValueTypeEnum.String:
				component.SetVariableValues(paradoxParam.paramsKey, (string)paradoxParam.value);
				break;
			}
		}
	}
}
