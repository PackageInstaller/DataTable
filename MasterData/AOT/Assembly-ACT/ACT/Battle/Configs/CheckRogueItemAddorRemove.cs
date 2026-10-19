namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Rogue道具Addor", "Predicate", new string[] { "check", "rogue", "item", "addor", "remove", "predicate", "condition" })]
public class CheckRogueItemAddorRemove : ConfigPredicate
{
	public int[] itemIds;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtAddRogueItem { itemId: var itemId })
		{
			if (itemIds != null && itemIds.Length != 0)
			{
				int[] array = itemIds;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i] == itemId)
					{
						return true;
					}
				}
			}
		}
		else if (memory.evt is EvtRemoveRogueItem { itemId: var itemId2 } && itemIds != null && itemIds.Length != 0)
		{
			int[] array = itemIds;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == itemId2)
				{
					return true;
				}
			}
		}
		return false;
	}
}
