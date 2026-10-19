using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断FullFeature", "Predicate", new string[] { "check", "full", "feature", "predicate", "condition" })]
public class CheckFullFeature : ConfigPredicate
{
	public int FeatureID;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompCharacter(out CompCharacter component))
		{
			return false;
		}
		if (component.characterSource is Character character)
		{
			int featureData = character.GetFeatureData(FeatureID, FeatureData.FeatureSourceType.Equip | FeatureData.FeatureSourceType.Gem);
			EquipFeatureData data = CoreUtils.GetData(FeatureID, RuntimeConfigs.data.equipFeatureDatas);
			return featureData >= data.maxLv;
		}
		return false;
	}
}
