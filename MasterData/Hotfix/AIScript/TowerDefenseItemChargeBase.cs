using TrueSync;

namespace AIScript;

public class TowerDefenseItemChargeBase
{
	private const string TOWERDEFENSE_UPDATE_ITEM_CARD = "TOWERDEFENSE_UPDATE_ITEM_CARD";

	private const string TOWERDEFENSE_UPDATE_ITEM_ENERGY = "TOWERDEFENSE_UPDATE_ITEM_ENERGY";

	private const string TOWERDEFENSE_SHOW_ITEM_ENERGY = "TOWERDEFENSE_SHOW_ITEM_ENERGY";

	private int itemID;

	protected int amount;

	protected int p1;

	protected int p2;

	protected int p3;

	public int curItemNum;

	protected bool startLogc;

	private bool showEnergy;

	public virtual void InitConfig(int id, int amount, int p1, int p2, int p3)
	{
		itemID = id;
		this.amount = amount;
		this.p1 = p1;
		this.p2 = p2;
		this.p3 = p3;
		startLogc = false;
		curItemNum = this.p1;
		UpdateItemCardNum();
	}

	public virtual void StartLogic()
	{
		startLogc = true;
	}

	protected void ShowEnergy()
	{
		if (!showEnergy)
		{
			showEnergy = true;
			MonoSingleton<LuaManager>.Instance.FireEvent("TOWERDEFENSE_SHOW_ITEM_ENERGY", a1: true);
		}
	}

	protected void CloseEnergy()
	{
		if (showEnergy)
		{
			showEnergy = false;
			MonoSingleton<LuaManager>.Instance.FireEvent("TOWERDEFENSE_SHOW_ITEM_ENERGY", a1: false);
		}
	}

	protected void UpdateEnergy(FP value)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("TOWERDEFENSE_UPDATE_ITEM_ENERGY", (float)value, 1, p2, a4: true);
	}

	public virtual void UpdateLogic()
	{
	}

	private void UpdateItemCardNum()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("TOWERDEFENSE_UPDATE_ITEM_CARD", itemID, curItemNum);
	}

	public void AddItemCardNum(int num = 1)
	{
		curItemNum += num;
		if (amount != 0 && curItemNum >= amount)
		{
			curItemNum = amount;
		}
		UpdateItemCardNum();
	}

	public void MinusItemCardNum(int num = 1)
	{
		curItemNum -= num;
		if (curItemNum <= 0)
		{
			curItemNum = 0;
		}
		UpdateItemCardNum();
	}
}
