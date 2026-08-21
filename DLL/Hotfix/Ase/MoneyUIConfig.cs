using System;

namespace Ase;

[Serializable]
public class MoneyUIConfig
{
	public RoleMoneyEnum MoneyType;

	public bool ShowGetBtn;

	public JumpWindowArg GetJumpWindowConfig;
}
