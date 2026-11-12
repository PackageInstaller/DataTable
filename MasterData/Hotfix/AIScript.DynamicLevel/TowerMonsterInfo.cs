namespace AIScript.DynamicLevel;

public class TowerMonsterInfo : LogicComponent
{
	public int leftRouteLen { get; set; }

	public bool CanSelect(AdventureActor target)
	{
		return (Entity as MonsterAdventureActor).IsSearchableByEnemy(target);
	}
}
