#define ENABLE_LOG
using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置Shader参数", 0)]
[Category("✫ DragonLost/View")]
[Description("设置实体的材质球的指定Shader参数。")]
public class SetEntityMaterialDissolve : ActionTaskBase
{
	[Header("============= 通用参数 =============")]
	[Name("实体Id", 0)]
	[Description("要设置材质参数的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("操作类型", 0)]
	[Description("设置实体材质球的操作类型。")]
	public ShaderOperationType OperationType;

	[Name("控制指定的shader变量名", 0)]
	[Description("要变化的Shader参数的名称。")]
	public string MaterialName;

	[Name("是否使用材质球唯一Id", 0)]
	[Description("是否通过SetOrCreateEntityMaterial返回的运行时材质Id定位材质球。")]
	public bool IsUseMaterialRuntimeId;

	[Name("唯一Id", 0)]
	[Description("设置实体材质球返回的唯一Id。")]
	[ShowIf("IsUseMaterialRuntimeId", 1)]
	public BBParameter<int> MaterialRuntimeId;

	[Name("改变的材质球索引", 0)]
	[Description("要修改的材质球的索引。")]
	[ShowIf("IsUseMaterialRuntimeId", 0)]
	public BBParameter<int> MaterialIndex;

	[Name("是否多绑点", 0)]
	public bool IsMultiplePoint;

	[Name("实体绑点Key", 0)]
	[Description("实体绑定点的名称。")]
	[ShowIf("IsMultiplePoint", 0)]
	public BBParameter<string> PointName;

	[Name("实体绑点Key列表", 0)]
	[Description("实体绑定点的名称。")]
	[ShowIf("IsMultiplePoint", 1)]
	public BBParameter<List<string>> PointListName;

	[Name("特效状态", 0)]
	[Description("设置特效状态")]
	public EffectOperationType EffectState;

	[Name("是否该特效结束", 0)]
	[Description("! 结束后将清除特效材质")]
	public bool IsEffectEnd;

	[Header("============= 值参数 =============")]
	[Name("控制变化的时间", 0)]
	[Description("控制材质参数变化的时间（秒）。")]
	[ShowIf("OperationType", 0)]
	public float LifeTime = 1f;

	[Name("变化的目标值 (Range: 0~1)", 0)]
	[Description("变化后的目标值（范围：0~1）。")]
	[ShowIf("OperationType", 0)]
	public float TargetValue;

	[Header("============= 值参数 =============")]
	[HideIf("OperationType", 0)]
	[Name("设置的值", 0)]
	[Description("设置的值")]
	public BBParameter<float> FloatValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(EntityId.value);
		if (entity == null)
		{
			LogActionError($"控制实体指定材质溶解错误：找不到{EntityId.value} 的实体！！");
			EndAction();
			return;
		}
		EntityPointMaterialComponent component = entity.GetComponent<EntityPointMaterialComponent>();
		if (component == null)
		{
			LogActionError("实体中没有找到EntityPointMaterialCompoment..");
			EndAction();
			return;
		}
		bool isEffectEnd = IsEffectEnd;
		switch (OperationType)
		{
		case ShaderOperationType.CHANGE:
			if (IsMultiplePoint)
			{
				if (PointListName.value == null)
				{
					EndAction();
					return;
				}
				for (int k = 0; k < PointListName.value.Count; k++)
				{
					string pointName3 = PointListName.value[k];
					if (IsUseMaterialRuntimeId)
					{
						component.SetShaderParamByMaterialRuntimeId(pointName3, MaterialRuntimeId.value, LifeTime, MaterialName, TargetValue, isEffectEnd);
					}
					else
					{
						component.SetShaderParam(pointName3, MaterialIndex.value, LifeTime, MaterialName, TargetValue, isEffectEnd);
					}
				}
			}
			else if (IsUseMaterialRuntimeId)
			{
				component.SetShaderParamByMaterialRuntimeId(PointName.value, MaterialRuntimeId.value, LifeTime, MaterialName, TargetValue, isEffectEnd);
			}
			else
			{
				component.SetShaderParam(PointName.value, MaterialIndex.value, LifeTime, MaterialName, TargetValue, isEffectEnd);
			}
			break;
		case ShaderOperationType.SET:
			if (IsMultiplePoint)
			{
				if (PointListName.value == null)
				{
					EndAction();
					return;
				}
				for (int j = 0; j < PointListName.value.Count; j++)
				{
					string pointName2 = PointListName.value[j];
					if (IsUseMaterialRuntimeId)
					{
						component.SetShaderParamByMaterialRuntimeId(pointName2, MaterialRuntimeId.value, MaterialName, FloatValue.value, isEffectEnd);
					}
					else
					{
						component.SetShaderParam(pointName2, MaterialIndex.value, MaterialName, FloatValue.value, isEffectEnd);
					}
				}
			}
			else if (IsUseMaterialRuntimeId)
			{
				component.SetShaderParamByMaterialRuntimeId(PointName.value, MaterialRuntimeId.value, MaterialName, FloatValue.value, isEffectEnd);
			}
			else
			{
				component.SetShaderParam(PointName.value, MaterialIndex.value, MaterialName, FloatValue.value, isEffectEnd);
			}
			break;
		case ShaderOperationType.ADD:
			if (IsMultiplePoint)
			{
				if (PointListName.value == null)
				{
					EndAction();
					return;
				}
				for (int i = 0; i < PointListName.value.Count; i++)
				{
					string pointName = PointListName.value[i];
					if (IsUseMaterialRuntimeId)
					{
						component.AddShaderParamByMaterialRuntimeId(pointName, MaterialRuntimeId.value, MaterialName, FloatValue.value, isEffectEnd);
					}
					else
					{
						component.AddShaderParam(pointName, MaterialIndex.value, MaterialName, FloatValue.value, isEffectEnd);
					}
				}
			}
			else if (IsUseMaterialRuntimeId)
			{
				component.AddShaderParamByMaterialRuntimeId(PointName.value, MaterialRuntimeId.value, MaterialName, FloatValue.value, isEffectEnd);
			}
			else
			{
				component.AddShaderParam(PointName.value, MaterialIndex.value, MaterialName, FloatValue.value, isEffectEnd);
			}
			break;
		}
		EndAction(EntityId.value != 0);
	}
}
