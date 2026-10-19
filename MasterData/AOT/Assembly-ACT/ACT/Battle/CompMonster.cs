using ACT.Config;
using ACT.Core;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class CompMonster : EcsComponent, ITableKey
{
	public int id;

	public int monsterPointId;

	public int level;

	public bool shareBossInfoUI;

	public int totalDamage;

	public void InitDummyAbilities(CompAbility compAbility)
	{
		int[] skill = RuntimeConfigs.data.entityEnemyDatas[id].skill;
		foreach (int key in skill)
		{
			Ability ability = Singleton<GameManager>.instance.ecsManager.systemAbility.abilityPool.Get();
			ability.Init(compAbility.owner, compAbility.owner, AbilitySource.UpgradeSkill, new MPSkill
			{
				id = key,
				level = 1
			});
			compAbility.dummyAbilities.Add(key, ability);
		}
	}

	public void InitProperties(CompAbility compAbility)
	{
		EntityEnemyData entityEnemyData = RuntimeConfigs.data.entityEnemyDatas[id];
		CoreUtils.StartPropertyCal();
		CoreUtils.AddProperties(entityEnemyData.characterPorpertyBase);
		CoreUtils.AddProperties(RuntimeConfigs.data.entityEnemyLevelDataTemplates[CoreUtils.CalEnytityTemplateId(entityEnemyData.attrType, compAbility.level)].enemyProperty, entityEnemyData.attrSer);
		compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Monseter, owner.GetCompMonster().id);
		compAbility.CalAllProperty();
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		id = 0;
		monsterPointId = 0;
		level = 0;
		shareBossInfoUI = false;
		totalDamage = 0;
	}
}
