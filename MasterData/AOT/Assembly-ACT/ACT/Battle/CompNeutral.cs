using ACT.Config;
using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle;

public class CompNeutral : EcsComponent, ITableKey
{
	public int attackableId;

	public int trapType;

	public int defenceTowerType;

	public void InitDummyAbilities(CompAbility compAbility)
	{
	}

	public void InitProperties(CompAbility compAbility)
	{
		EntityNeutralData entityNeutralData = RuntimeConfigs.data.entityNeutralDatas[attackableId];
		CoreUtils.StartPropertyCal();
		CoreUtils.AddProperties(entityNeutralData.characterPorpertyBase);
		compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Neutral, attackableId);
		compAbility.CalAllProperty();
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		attackableId = 0;
		trapType = 0;
		defenceTowerType = 0;
	}

	public int GeyDamageCalType(Entity entity)
	{
		int worldLevel = SystemUnlockManager.worldLevel;
		return CoreUtils.GetData(defenceTowerType * 100 + worldLevel, RuntimeConfigs.data.defenceTowers)?.damageCalcType ?? (-1);
	}
}
