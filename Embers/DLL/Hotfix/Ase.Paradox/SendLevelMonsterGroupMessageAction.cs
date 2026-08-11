using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("发送关卡怪物组事件", 0)]
[Category("✫ DragonLost/Monster")]
[Description("向关卡的怪物组发送特定类型的事件")]
public class SendLevelMonsterGroupMessageAction : ActionTaskBase
{
	[Name("消息类型", 0)]
	[Description("要发送的怪物组事件的类型")]
	public MonsterGroupEventType messageType;

	protected override void OnExecute()
	{
		base.OnExecute();
		MonsterGroup data = GetOwnerEntity().GetData<MonsterGroup>(MonsterGroup.MONSTERGROUP_KEY);
		if ((Object)(object)data != null)
		{
			data.PublishMonsterEvent(messageType);
		}
		OnActionFinish();
	}
}
