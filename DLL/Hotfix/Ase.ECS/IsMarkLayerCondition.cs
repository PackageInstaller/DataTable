using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("判断标记层数", 0)]
[Category("✫ DragonLost/DataNode")]
[Description("判断指定实体的特定标记层数是否满足给定的数学关系条件。")]
public class IsMarkLayerCondition : ConditionTaskBase
{
	[Name("标记ID", 0)]
	[Description("要检查的标记的ID。")]
	public BBParameter<string> markId;

	[Name("目标实体ID", 0)]
	[Description("要检查标记的实体的ID。")]
	public BBParameter<int> entityId;

	[Name("标记层数", 0)]
	[Description("要比较的标记层数值。")]
	public BBParameter<int> MarkLayerBbParameter;

	[Name("数学关系", 0)]
	[Description("用于比较标记层数的数学关系。")]
	public BBParameter<NumberContact> numberContact;

	private int layer;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (string.IsNullOrEmpty(markId.value))
		{
			return false;
		}
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			return false;
		}
		layer = entity.GetComponent<DataNodeComponent>()?.GetMarkLayer(markId.value) ?? 0;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"检查标记层数 {markId.value}，层数为 {layer}，目标层数为 {MarkLayerBbParameter.value}", entity);
		}
		return CheckNumberContact();
	}

	private bool CheckNumberContact()
	{
		return numberContact.value switch
		{
			NumberContact.than => layer > MarkLayerBbParameter.value, 
			NumberContact.equal => layer == MarkLayerBbParameter.value, 
			NumberContact.less => layer < MarkLayerBbParameter.value, 
			NumberContact.lessEqual => layer <= MarkLayerBbParameter.value, 
			NumberContact.thanEqual => layer >= MarkLayerBbParameter.value, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}
}
