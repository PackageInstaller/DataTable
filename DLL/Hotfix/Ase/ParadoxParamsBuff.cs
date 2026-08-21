using Ase.ECS;
using UnityEngine;

namespace Ase;

public class ParadoxParamsBuff : BuffOperationBase<BuffDataParadoxParams>
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
		DataNodeComponent component2 = base.buffOwner.GetComponent<DataNodeComponent>();
		if (component2 == null)
		{
			return;
		}
		BuffDataParadoxParams.ParadoxParams[] paradoxParams = dataBase.paradoxParams;
		foreach (BuffDataParadoxParams.ParadoxParams paradoxParams2 in paradoxParams)
		{
			switch (paradoxParams2.typeEnum)
			{
			case ValueTypeEnum.Int:
			{
				int variableValue4 = component.GetVariableValue<int>(paradoxParams2.paramsKey);
				DataNodeInt dataNodeInt = new DataNodeInt();
				dataNodeInt.SetValue(variableValue4);
				component2.AddData(paradoxParams2.paramsKey, dataNodeInt);
				break;
			}
			case ValueTypeEnum.Float:
			{
				float variableValue3 = component.GetVariableValue<float>(paradoxParams2.paramsKey);
				DataNodeFloat dataNodeFloat = new DataNodeFloat();
				dataNodeFloat.SetValue(variableValue3);
				component2.AddData(paradoxParams2.paramsKey, dataNodeFloat);
				break;
			}
			case ValueTypeEnum.Vector2:
			{
				Vector2 variableValue2 = component.GetVariableValue<Vector2>(paradoxParams2.paramsKey);
				DataNodeVector2 dataNodeVector2 = new DataNodeVector2();
				dataNodeVector2.SetValue(variableValue2);
				component2.AddData(paradoxParams2.paramsKey, dataNodeVector2);
				break;
			}
			case ValueTypeEnum.Vector3:
			{
				Vector3 variableValue = component.GetVariableValue<Vector3>(paradoxParams2.paramsKey);
				DataNodeVector3 dataNodeVector = new DataNodeVector3();
				dataNodeVector.SetValue(variableValue);
				component2.AddData(paradoxParams2.paramsKey, dataNodeVector);
				break;
			}
			}
		}
	}

	protected override void OnDispose()
	{
		if (treeId != -1)
		{
			base.buffOwner.GetSystem<ParadoxSystem>().StopTree(treeId);
			treeId = -1;
		}
	}
}
