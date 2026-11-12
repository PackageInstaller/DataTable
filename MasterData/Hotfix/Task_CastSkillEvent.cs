using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/AI与技能/释放技能", 1)]
public class Task_CastSkillEvent : TaskCellBase
{
	public enum OperateAIType
	{
		[InspectorName("技能id")]
		Id,
		[InspectorName("技能路径")]
		path
	}

	public OperateAIType _opType;

	public int skillId;

	public string skillPath;

	public int factionId = 6;

	protected override void OnExecute()
	{
		if (_opType == OperateAIType.Id)
		{
			AdventureUseFakeActorCastSkillEvent adventureUseFakeActorCastSkillEvent = AdventureUseFakeActorCastSkillEvent.Generate();
			adventureUseFakeActorCastSkillEvent.position = new TSVector2(Entity.tsTransform.Position.x, Entity.tsTransform.Position.y);
			adventureUseFakeActorCastSkillEvent.positionY = Entity.tsTransform.PositionY;
			adventureUseFakeActorCastSkillEvent.direction = new TSVector2(Entity.tsTransform.Forward.x, Entity.tsTransform.Forward.y);
			adventureUseFakeActorCastSkillEvent.templeteId = GetGlobTempleteId();
			adventureUseFakeActorCastSkillEvent.attributeId = GetGlobAttributeId();
			adventureUseFakeActorCastSkillEvent.skillId = skillId;
			adventureUseFakeActorCastSkillEvent.factionId = factionId;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureUseFakeActorCastSkillEvent);
		}
		else
		{
			Singleton<TriggerManager>.Instance?.StartTriggerAI(skillPath);
		}
		EndAction();
	}
}
