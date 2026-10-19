using ACT.Config;
using ACT.Core;
using ACT.MultiPlayer;
using Fundamental;

namespace ACT.Battle;

public class CompAssistNpc : EcsComponent, ITableKey
{
	public int id;

	public int npcId;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		id = 0;
		npcId = 0;
	}

	public void InitProperties(CompAbility compAbility)
	{
		EntityEnemyData entityEnemyData = RuntimeConfigs.data.entityEnemyDatas[id];
		CoreUtils.StartPropertyCal();
		CoreUtils.AddProperties(entityEnemyData.characterPorpertyBase);
		CoreUtils.AddProperties(RuntimeConfigs.data.entityEnemyLevelDataTemplates[CoreUtils.CalEnytityTemplateId(entityEnemyData.attrType, compAbility.level)].enemyProperty, entityEnemyData.attrSer);
		compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Monseter, id);
		compAbility.CalAllProperty();
	}

	public void InitDummyAbilities(CompAbility compAbility)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		int[] skill = RuntimeConfigs.data.entityEnemyDatas[id].skill;
		foreach (int key in skill)
		{
			Ability ability = systemAbility.abilityPool.Get();
			ability.Init(compAbility.owner, compAbility.owner, AbilitySource.UpgradeSkill, new MPSkill
			{
				id = key,
				level = 1
			});
			compAbility.dummyAbilities.Add(key, ability);
		}
	}
}
