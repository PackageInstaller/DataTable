using System;

namespace ACT.Config;

[Serializable]
public class MallData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly int title;

	public readonly int[] rechargeIds = new int[0];

	public readonly int[] moneyId = new int[0];

	public readonly int icon;

	public MallData(int id, int nameLocal, int title, int[] rechargeIds, int[] moneyId, int icon)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.title = title;
		this.rechargeIds = rechargeIds;
		this.moneyId = moneyId;
		this.icon = icon;
	}
}
