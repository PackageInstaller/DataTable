namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改能量Charge", "Action", new string[] { "modify", "energy", "charge" })]
public class ActionModifyEnergyCharge : ConfigAction
{
	public ConfigFunction<float> addValue;

	public ConfigFunction<float> mulValue;

	public override void Do(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			AttackData attackData = getAttackData.GetAttackData();
			attackData.energyChargeAdd += addValue.Return(memory);
			attackData.energyChargeMul *= mulValue.Return(memory);
		}
	}
}
