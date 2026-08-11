using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("测试Log (实体ID)", 0)]
public class TestDebugToEntityID : ActionTaskBase
{
	public BBParameter<int> entityID;

	public BBParameter<string> Content;

	[Name("是否添加时间戳", 0)]
	public bool IsAddTimeStamp;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(entityID.value);
		if (entity == null)
		{
			OnActionFail($"输出Log失败，实体为空:{entityID.value}");
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"测试Log  世界帧 ： {ownerEntity.GetWorld().Tick} 打印 : {Content.value} ", entity);
		}
		_ = IsAddTimeStamp;
		EndAction();
	}
}
