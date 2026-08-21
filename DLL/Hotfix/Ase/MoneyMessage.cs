using GameFramework.Runtime;

namespace Ase;

public class MoneyMessage : MessageBase
{
	public RoleMoneyEnum MoneyType;

	public long Amount;

	public MoneyMessage(object sender, RoleMoneyEnum moneyType, long amount)
		: base(sender)
	{
		base.Sender = sender;
		MoneyType = moneyType;
		Amount = amount;
	}
}
