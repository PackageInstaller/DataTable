using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.World;

namespace ACT.Model;

public class EnemyTypeInfo
{
	public int enemyId;

	public int enemyTypeId;

	public EnemyType enemyType;

	public ACT.World.MapArea enemyArea;

	public List<int> reward;

	public int worldBossId;

	public int iconAtlasId;

	public int typeName;

	public int typeDescribe;

	public int enemyRegion;

	public EnemyTypeInfo(EntityEnemyData entityEnemyData)
	{
		EntityData data = CoreUtils.GetData(entityEnemyData.id, RuntimeConfigs.data.entityDatas);
		ACT.Config.MapArea data2 = CoreUtils.GetData(entityEnemyData.nativePlace, RuntimeConfigs.data.mapAreas);
		enemyId = entityEnemyData.id;
		enemyTypeId = entityEnemyData.enemyType;
		reward = new List<int>();
		iconAtlasId = entityEnemyData.monsterIcon;
		typeName = data.nameLocal;
		typeDescribe = data.descriptionLocal;
		if (data2 != null)
		{
			enemyRegion = data2.name;
			enemyArea = (ACT.World.MapArea)data2.id;
		}
		enemyType = data.type switch
		{
			2 => EnemyType.LittleMonster, 
			6 => EnemyType.EliteMonster, 
			3 => EnemyType.Boss, 
			_ => EnemyType.None, 
		};
		if (enemyType == EnemyType.Boss)
		{
			WorldBossMonster value = RuntimeConfigs.data.worldBossMonsters.FirstOrDefault((KeyValuePair<int, WorldBossMonster> _) => _.Value.worldBossID == entityEnemyData.id).Value;
			if (value != null)
			{
				worldBossId = value.id;
			}
		}
	}
}
