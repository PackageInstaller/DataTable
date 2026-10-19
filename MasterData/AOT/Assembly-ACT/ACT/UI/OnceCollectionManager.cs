using System.Linq;
using ACT.Core;
using ACT.Event;
using Fundamental;

namespace ACT.UI;

public class OnceCollectionManager
{
	public void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OnceCollectionChange, OnOnceCollectionChange);
	}

	public void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OnceCollectionChange, OnOnceCollectionChange);
	}

	private void OnOnceCollectionChange(BaseEventContent obj)
	{
		OnceCollectionChangeEvt onceCollectionChangeEvt = (OnceCollectionChangeEvt)obj;
		if (RuntimeConfigs.data.game.OneCollectionEA.Contains(onceCollectionChangeEvt.id))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ONCECOLLECTIONCELL, new MonoOnceCollectionData
			{
				itemId = onceCollectionChangeEvt.id,
				curCount = onceCollectionChangeEvt.newCount
			});
		}
	}
}
