namespace AIScript.Monster.TowerDefense;

public class TowerCharacterSpawn : AIBase
{
	public void OnStart()
	{
		_actor.Action(makeThreatAlert: false);
	}
}
