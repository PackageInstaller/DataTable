#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("给目标单位添加免疫状态", 0)]
[Category("✫ DragonLost/State")]
[Description("给指定目标单位添加免疫状态，并可选择是否跟随技能移除状态。")]
public class AttachImmuneState : ActionTaskBase
{
	[RequiredField]
	[Name("Buff Id", 0)]
	[Description("要添加的免疫状态的Buff Id。")]
	public int buffId;

	[Name("目标实体Id", 0)]
	[Description("要给其添加免疫状态的目标实体的Id。")]
	public BBParameter<int> targetParamId;

	[Name("是否跟随技能移除状态", 0)]
	[Description("是否在技能结束时移除免疫状态。")]
	public bool followSkillRemove;

	[Name("是否返回真是操作結果", 0)]
	[Description("确定节点是否返回真实操作结果。")]
	public bool useOptionState;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetParamId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("给目标单位添加免疫状态错误:实体为空！");
			EndAction();
		}
		else if (useOptionState)
		{
			EndAction(entity.GetComponent<StateComponent>()?.AddImmuneBuff(buffId));
		}
		else
		{
			entity.GetComponent<StateComponent>()?.AddImmuneBuff(buffId);
			EndAction();
		}
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null)
		{
			BaseEntity entity = GetEntity(targetParamId.value, isSyncEntity: false);
			if (followSkillRemove)
			{
				entity?.GetComponent<StateComponent>()?.RemoveImmuneBuff(buffId);
			}
		}
	}
}
