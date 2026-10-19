using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class ConfigGroundLightDiePara : LuminSerializedScriptableObject
{
	public List<GroundLightDieParaStruct> list;

	public Dictionary<EnemyRace, Dictionary<MonsterWeigtType, EnemyDieEffect>> enemyDieEffectDic = new Dictionary<EnemyRace, Dictionary<MonsterWeigtType, EnemyDieEffect>>();
}
