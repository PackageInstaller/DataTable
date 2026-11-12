using TrueSync;

namespace AIScript;

public class TowerDefenseItemCharge1 : TowerDefenseItemChargeBase
{
	private FP itemUpdateDuration = 0;

	private FP itemUpdateSpd = 0.5f;

	public override void InitConfig(int id, int amount, int p1, int p2, int p3)
	{
		base.InitConfig(id, amount, p1, p2, p3);
		itemUpdateDuration = 0;
	}

	public override void StartLogic()
	{
		base.StartLogic();
		ShowEnergy();
		UpdateEnergy(0);
	}

	public override void UpdateLogic()
	{
		if (!startLogc)
		{
			return;
		}
		if (amount > 0 && curItemNum >= amount)
		{
			CloseEnergy();
			return;
		}
		ShowEnergy();
		itemUpdateDuration += LockStepManager.deltaTime;
		if (itemUpdateDuration >= p2)
		{
			itemUpdateDuration -= (FP)p2;
			AddItemCardNum();
			UpdateEnergy(1);
			if (curItemNum >= amount)
			{
				CloseEnergy();
			}
		}
		UpdateEnergy(itemUpdateDuration / p2);
	}
}
