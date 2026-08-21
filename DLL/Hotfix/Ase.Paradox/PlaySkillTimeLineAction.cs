using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放一个技能TimeLine", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过ID播放一个技能TimeLine")]
public class PlaySkillTimeLineAction : ActionTaskBase
{
	[Name("执行实体ID", 0)]
	public BBParameter<int> ExecuteEntity;

	[Name("SkillTimeLine ID", 0)]
	public BBParameter<int> SkillTimeLineId;

	[Name("返回的Line执行ID", 0)]
	public BBParameter<int> SkillExecuteId;

	public bool IsWaitExecuteEnd;

	private int _executeId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(ExecuteEntity.value);
		if (entity == null)
		{
			EndAction();
			return;
		}
		if (SkillExecuteId.value != 0)
		{
			ownerEntity.GetSystem<SkillTimeLineSystem>().ExecuteSkillTimeLine(SkillExecuteId.value);
		}
		else
		{
			BBParameter<int> skillExecuteId = SkillExecuteId;
			skillExecuteId.value = await ownerEntity.GetSystem<SkillTimeLineSystem>().ExecuteSkillTimeLine(SkillTimeLineId.value, entity);
		}
		if (!IsWaitExecuteEnd)
		{
			EndAction();
		}
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		PlayableStateEnum skillTimelineState = ownerEntity.GetSystem<SkillTimeLineSystem>().GetSkillTimelineState(SkillExecuteId.value);
		if (skillTimelineState == PlayableStateEnum.Exit || skillTimelineState == PlayableStateEnum.Error)
		{
			EndAction();
		}
	}
}
