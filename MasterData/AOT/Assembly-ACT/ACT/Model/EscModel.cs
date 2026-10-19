using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using Fundamental;

namespace ACT.Model;

public class EscModel : Model<EscModel>
{
	public int EscSelectSystemId { get; private set; }

	protected override void Init()
	{
		EscSelectSystemId = 0;
	}

	protected override void UnInit()
	{
		EscSelectSystemId = 0;
	}

	public void SetEscSelectSystemId(int systemId)
	{
		EscSelectSystemId = systemId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_SelectEscSystemId, null);
	}

	public List<BubbleSystem> GetBubbleSystems()
	{
		List<BubbleSystem> list = new List<BubbleSystem>();
		foreach (BubbleSystem value in RuntimeConfigs.data.bubbleSystems.Values)
		{
			if (value.canBeSee && !IsSoldOut(value.targetId))
			{
				list.Add(value);
			}
		}
		list.Sort((BubbleSystem l, BubbleSystem r) =>
		{
			int priority = l.priority;
			return priority.CompareTo(r.priority);
		});
		return list;
	}

	private bool IsSoldOut(int giftPackId)
	{
		if (giftPackId <= 0)
		{
			return false;
		}
		return Model<ShopModel>.Interface.BundleLeftCount(giftPackId) == 0;
	}
}
