using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("发送交互物事件", 0)]
[Description("向交互物发送指定事件类型。")]
[Category("✫ DragonLost/Interactive")]
public class SendInteractiveEventAction : ActionTaskBase
{
	[Name("事件类型", 0)]
	[Description("要发送的交互物事件类型。")]
	public BBParameter<MapItemEventType> eventType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().IsInteractiveEntity || GetOwnerEntity().GetEntityType() == EntityType.NPC)
		{
			GetOwnerEntity().GetComponent<InteractiveStateComponent>()?.SendInteractiveEvent(eventType.value);
		}
		OnActionFinish();
	}
}
