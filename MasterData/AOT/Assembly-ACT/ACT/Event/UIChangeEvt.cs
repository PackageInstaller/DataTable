using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Event;

public class UIChangeEvt : BaseEventContent
{
	public bool changeIcon;

	public bool changeEffect;

	public ActionUIChange.IconType type;

	public Entity owner;
}
