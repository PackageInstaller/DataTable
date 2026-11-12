using System.Collections.Generic;

namespace AIScript.Monster._Light._50111buffjingling;

public class Death : SkillAdvancedBase
{
	protected readonly int buffId = 501110060;

	protected readonly int buffId_02 = 501110070;

	public void OnStart()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		_actor.InitSearchEntityContext(list, onlyAlive: true, includeSelf: false);
		_actor.SearchEntityFriendly(list);
		foreach (LogicEntity item in list)
		{
			AdventureActor component = item.gameObject.GetComponent<AdventureActor>();
			component.buffComponent.RemoveBuffByBuffId(buffId);
			component.buffComponent.RemoveBuffByBuffId(buffId_02);
		}
		_skill?.Clear();
	}
}
