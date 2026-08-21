using System;
using System.Collections.Generic;
using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("召唤物同步创建者数据", 0)]
[Description("根据当前行为树实体的黑板值数据，同步给其所有勾选同步指令的召唤物")]
[Category("✫ DragonLost/Entity")]
public class SummonedSyncCreatorAction : ActionTaskBase
{
	[Serializable]
	[Name("参数同步数据", 0)]
	public class ParadoxSyncParams
	{
		[Name("参数名", 0)]
		public string paramsKey;

		[Name("参数类型", 0)]
		public ValueTypeEnum typeEnum;
	}

	[Name("行为树参数同步数据", 0)]
	public List<ParadoxSyncParams> paradoxParams = new List<ParadoxSyncParams>();

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (paradoxParams.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		AIParadoxComponent aIParadoxComponent = ownerEntity?.GetComponent<AIParadoxComponent>();
		if (aIParadoxComponent == null)
		{
			EndAction();
			return;
		}
		SummonedComponent summonedComponent = ownerEntity?.GetComponent<SummonedComponent>();
		if (summonedComponent == null)
		{
			EndAction();
			return;
		}
		foreach (ParadoxSyncParams paradoxParam in paradoxParams)
		{
			switch (paradoxParam.typeEnum)
			{
			case ValueTypeEnum.Int:
			{
				int variableValue4 = aIParadoxComponent.GetVariableValue<int>(paradoxParam.paramsKey);
				summonedComponent.UpdateSummonedEntityUv(paradoxParam.paramsKey, variableValue4);
				break;
			}
			case ValueTypeEnum.Float:
			{
				float variableValue3 = aIParadoxComponent.GetVariableValue<float>(paradoxParam.paramsKey);
				summonedComponent.UpdateSummonedEntityUv(paradoxParam.paramsKey, variableValue3);
				break;
			}
			case ValueTypeEnum.String:
			{
				string variableValue2 = aIParadoxComponent.GetVariableValue<string>(paradoxParam.paramsKey);
				summonedComponent.UpdateSummonedEntityUv(paradoxParam.paramsKey, variableValue2);
				break;
			}
			case ValueTypeEnum.Bool:
			{
				bool variableValue = aIParadoxComponent.GetVariableValue<bool>(paradoxParam.paramsKey);
				summonedComponent.UpdateSummonedEntityUv(paradoxParam.paramsKey, variableValue);
				break;
			}
			}
		}
		EndAction();
	}
}
