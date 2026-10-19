using System.Collections.Generic;
using ACT.Core;

namespace ACT.Config;

public class EnemyMaterialConfig : LuminSerializedScriptableObject
{
	public Dictionary<int, HashSet<int>> enemyType2Item;

	public Dictionary<int, HashSet<int>> itemFromEnemyType;

	private void GetAllItemFromEnemyType()
	{
		enemyType2Item = new Dictionary<int, HashSet<int>>();
		itemFromEnemyType = new Dictionary<int, HashSet<int>>();
		HashSet<int> hashSet = new HashSet<int>();
		int i;
		foreach (KeyValuePair<int, EntityEnemyData> entityEnemyData2 in RuntimeConfigs.data.entityEnemyDatas)
		{
			entityEnemyData2.Deconstruct(out i, out var value);
			EntityEnemyData entityEnemyData = value;
			int enemyType = entityEnemyData.enemyType;
			if (hashSet.Contains(enemyType) || enemyType == 0)
			{
				continue;
			}
			hashSet.Add(enemyType);
			enemyType2Item.Add(enemyType, new HashSet<int>());
			int[] collectionId = entityEnemyData.collectionId;
			for (i = 0; i < collectionId.Length; i++)
			{
				Collection data = CoreUtils.GetData(collectionId[i], RuntimeConfigs.data.collections);
				if (data == null)
				{
					continue;
				}
				foreach (ItemKv item2 in data.certain)
				{
					enemyType2Item[enemyType].Add(item2.id);
				}
				foreach (ItemKv reward in data.rewards)
				{
					Reward data2 = CoreUtils.GetData(reward.id, RuntimeConfigs.data.rewards);
					if (data2 == null)
					{
						continue;
					}
					foreach (Maybe item3 in data2.dropItem)
					{
						enemyType2Item[enemyType].Add(item3.id);
					}
				}
			}
		}
		foreach (KeyValuePair<int, HashSet<int>> item4 in enemyType2Item)
		{
			item4.Deconstruct(out i, out var value2);
			int item = i;
			foreach (int item5 in value2)
			{
				if (itemFromEnemyType.TryGetValue(item5, out var value3))
				{
					value3.Add(item);
					continue;
				}
				itemFromEnemyType.Add(item5, new HashSet<int> { item });
			}
		}
	}
}
