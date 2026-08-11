using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

[Trigger("实体2交互物传参触发器")]
public class Entity2MapItemHitedEventTrigger : BaseEventTriggerNode
{
	public bool IsPlayer;

	public bool IsUpdateData;

	public bool IsSaveData;

	public MapItemNode MapItemNode;

	public List<MapItemNode> mapItemList;

	public string messageKey;

	public MapDataNodeParadoxParameter mapDataNodeParadoxParameter;

	private ISubscription<BattleMessage> subscription;

	public override string TriggerName => "实体受击-交互物传参触发器";

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		if (base.TriggerSwitch)
		{
			RegisterMessage();
		}
	}

	public void RegisterMessage()
	{
		if (subscription == null)
		{
			subscription = base.World.GetWorldMessenger().Subscribe<BattleMessage>(OnMessage);
		}
	}

	public void UnRegisterMessage()
	{
		if (subscription != null)
		{
			subscription.Dispose();
			subscription = null;
		}
	}

	public override void Active()
	{
		base.Active();
		RegisterMessage();
	}

	public override void Disable()
	{
		base.Disable();
		UnRegisterMessage();
	}

	private void OnMessage(BattleMessage message)
	{
		if (message != null && (IsPlayer || (!((Object)(object)MapItemNode == null) && MapItemNode.Entity != null && message.Sender != null)) && message.EventType == BattleEventType.Damage)
		{
			if (IsPlayer && message.Sender.IsActorEntity)
			{
				DoExecute();
			}
			else if (!IsPlayer && message.Sender.Id == MapItemNode.Entity.Id)
			{
				DoExecute();
			}
		}
	}

	public override void OnDisposed()
	{
		base.OnDisposed();
		UnRegisterMessage();
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		if (mapItemList == null || mapItemList.Count <= 0)
		{
			return;
		}
		foreach (MapItemNode mapItem in mapItemList)
		{
			if ((Object)(object)mapItem != null)
			{
				mapItem.SendParadoxMessage(messageKey, mapDataNodeParadoxParameter);
				if (IsUpdateData)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxData(levelId, mapItem.Uid, messageKey, mapDataNodeParadoxParameter);
				}
			}
		}
		if (IsSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
		}
	}
}
