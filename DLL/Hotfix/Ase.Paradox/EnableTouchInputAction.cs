using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("启用触摸输入", 0)]
[Category("✫ Entity")]
[Description("启用或禁用实体的触摸输入，并指定可用的技能列表。")]
public class EnableTouchInputAction : ActionTaskBase
{
	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要启用或禁用触摸输入的实体的ID。")]
	public BBParameter<int> entityId;

	[RequiredField]
	[Name("启用状态", 0)]
	[Description("指示是否启用触摸输入。")]
	public BBParameter<bool> enable;

	[RequiredField]
	[Name("技能列表", 0)]
	[Description("可用于触摸输入的技能列表。")]
	public BBParameter<List<HeroSkillTypeEnum>> skillList;

	[Name("是否跟随行为树结束重置", 0)]
	[Description("指示是否在行为树结束时重置触摸输入状态。")]
	public bool followTreeRecovery = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (skillList != null && skillList.value != null)
		{
			_ = skillList.value.Count;
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
	}
}
