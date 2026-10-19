using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.Configs;

public struct ListenEvtItem
{
	[Tooltip("监听事件的类型")]
	public ListenEvtType listenEvtType;

	public bool global;

	[Tooltip("监听之后执行的事件")]
	public ConfigAction[] actions;

	public bool MatchType(ListenEvtType type, BaseEvt evt)
	{
		switch (listenEvtType)
		{
		case ListenEvtType.AfterMeKillBullet:
			if (evt is EvtKillEntity evtKillEntity2)
			{
				Entity attackee = evtKillEntity2.attackData.attackee;
				if (attackee.IsTrajectory() && attackee.GetCompAbility().hp <= 0)
				{
					return true;
				}
			}
			break;
		case ListenEvtType.AfterMeKillEntity:
			if (evt is EvtKillEntity evtKillEntity && evtKillEntity.attackData.attackee.GetCompAbility().hp <= 0)
			{
				return true;
			}
			break;
		}
		return type == listenEvtType;
	}
}
