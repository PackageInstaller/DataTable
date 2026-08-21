using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("设置实体材质球", 0)]
[Description("根据给定的实体ID，设置或创建实体的材质球,INHERITE为废弃功能")]
[Category("✫ DragonLost/View")]
public class SetOrCreateEntityMaterial : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要设置或创建材质球的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("改变的材质球ID", 0)]
	[Description("要设置或创建的材质球。")]
	public int materialID;

	[Name("是否多绑点", 0)]
	public bool IsMultiplePoint;

	[Name("实体绑点Key", 0)]
	[Description("要设置或创建材质球的实体绑点的Key。")]
	[ShowIf("IsMultiplePoint", 0)]
	public BBParameter<string> point;

	[Name("实体绑点Key列表", 0)]
	[Description("实体绑定点的名称。")]
	[ShowIf("IsMultiplePoint", 1)]
	public BBParameter<List<string>> PointListName;

	[Name("Set/SUB时是否使用唯一", 0)]
	[Description("是否通过设置实体材质球返回的唯一Id定位材质球。")]
	public bool IsUseMaterialRuntimeId;

	[Name("Set/SUB时使用的唯一Id", 0)]
	[Description("设置实体材质球返回的唯一Id。")]
	public BBParameter<int> ChangeMatUniqueId;

	[Name("材质球索引", 0)]
	[Description("要设置或创建材质球的索引，CREATE是不需要索引")]
	public BBParameter<int> materialIndex;

	[Name("改变类型", 0)]
	[Description("设置实体材质球的操作类型，INHERITE为废弃功能")]
	public ChangeEntityMaterialType materialType;

	[ShowIf("materialType", 3)]
	[Name("继承shader参数", 0)]
	[Description("继承shader参数")]
	public BBParameter<List<ShaderPropertyInfo>> shaderParams;

	[Name("返回唯一Id", 0)]
	[Description("用于存储材质球的唯一Id，删除时会返回0")]
	public BBParameter<int> UniqueId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (entityId == null || point == null || PointListName == null || materialIndex == null || shaderParams == null)
		{
			EndAction();
			return;
		}
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value);
		if (entity == null)
		{
			EndAction();
			return;
		}
		if (PointListName.value == null)
		{
			PointListName.value = new List<string>();
		}
		if (materialType == ChangeEntityMaterialType.SUB)
		{
			entity.GetComponent<EntityPointMaterialComponent>().SetEntityMaterial(null, point.value, materialIndex.value, materialType, IsMultiplePoint, PointListName.value, IsUseMaterialRuntimeId ? ChangeMatUniqueId.value : 0, shaderParams.value);
			if (UniqueId != null)
			{
				UniqueId.value = 0;
			}
			EndAction();
			return;
		}
		DRMaterial dataRow = GameEntry.DataTable.GetDataRow<DRMaterial>(materialID);
		if (dataRow != null)
		{
			string materialByParentSkinConfig = ownerEntity.GetMaterialByParentSkinConfig(dataRow);
			Material mat = GameEntry.Resource.LoadAsset<Material>(materialByParentSkinConfig);
			int value = entity.GetComponent<EntityPointMaterialComponent>().SetEntityMaterial(mat, point.value, materialIndex.value, materialType, IsMultiplePoint, PointListName.value, IsUseMaterialRuntimeId ? ChangeMatUniqueId.value : 0, shaderParams.value);
			if (UniqueId != null)
			{
				UniqueId.value = value;
			}
			entity.GetSystem<GameResourceSystem>()?.AddMaterialResPath(materialByParentSkinConfig);
		}
		EndAction();
	}
}
