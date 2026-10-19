using System;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行文本消息", "Action", new string[] { "text", "message", "ui", "hud", "tip" })]
public class ActionTextMessage : ConfigAction
{
	public TextMessage textMessage;

	public override void Do(ActionMemory memory)
	{
		if (textMessage != TextMessage.None)
		{
			DamageNumberSpawnEvt evt = Singleton<EventManager>.instance.GetEvt<DamageNumberSpawnEvt>();
			evt.cmdDamageNumber = new CmdDamageNumber
			{
				damageFeature = GetDamageFeature(textMessage),
				pos = memory.target.entity.GetNetColliderPosition()
			};
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.DamageNumberSpawn, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private DamageFeature GetDamageFeature(TextMessage message)
	{
		return message switch
		{
			TextMessage.Immune => DamageFeature.Resistance, 
			TextMessage.Parry => DamageFeature.Block, 
			TextMessage.Deflect => DamageFeature.Deflect, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}
}
