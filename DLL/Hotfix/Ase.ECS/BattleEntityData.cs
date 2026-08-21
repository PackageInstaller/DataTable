namespace Ase.ECS;

public class BattleEntityData : EntityViewModel
{
	private string name;

	private DRBattleEntityConfig _drBattleEntityConfig;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	private BattleEntityData()
	{
	}

	public static BattleEntityData Create(BaseEntity baseEntity, DRBattleEntityConfig drBattleEntityConfig)
	{
		return new BattleEntityData
		{
			_drBattleEntityConfig = drBattleEntityConfig,
			entity = baseEntity,
			Name = drBattleEntityConfig.Name,
			level = 1
		};
	}

	protected override void InitEmptyProperty()
	{
		propertyList.Add("Hp", PropertyData.Create(_drBattleEntityConfig.HP, _drBattleEntityConfig.HP));
		propertyList.Add("Attack", PropertyData.Create(_drBattleEntityConfig.Attack));
		propertyList.Add("Defence", PropertyData.Create(_drBattleEntityConfig.Defence));
		propertyList.Add("Level", PropertyData.Create(1f));
		propertyList.Add("Crit", PropertyData.Create(10f));
		propertyList.Add("Speed", PropertyData.Create(_drBattleEntityConfig.Speed));
		propertyList.Add("RotateSpeed", PropertyData.Create(_drBattleEntityConfig.TurnAroundSpeed));
		propertyList.Add("StateTime", PropertyData.Create(0f, 1f));
		propertyList.Add("AttackDistance", PropertyData.Create(3f));
		propertyList.Add("AttractionMultiplier", PropertyData.Create(1f));
		propertyList.Add("AttractionPower", PropertyData.Create(1f));
		propertyList.Add("AttractionResistance", PropertyData.Create(9999f));
	}

	public override string GetName()
	{
		return _drBattleEntityConfig.Name;
	}
}
