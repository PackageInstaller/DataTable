using System.Collections.Generic;

namespace AIScript.Monster._Dark._50111buffjingling;

public class Death : SkillAdvancedBase
{
	protected readonly int buffId = 501110030;

	public void OnStart()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		_actor.InitSearchEntityContext(list, onlyAlive: true, includeSelf: false);
		_actor.SearchEntityFriendly(list);
		foreach (LogicEntity item in list)
		{
			item.gameObject.GetComponent<AdventureActor>().buffComponent.RemoveBuffByBuffId(buffId);
		}
		_skill?.Clear();
	}
}
