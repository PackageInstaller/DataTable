using System;
using System.Collections.Generic;
using ACT.UI.DataProxy;

namespace ACT.UI;

public class RecoveryItemViewData : UIViewData
{
	public List<ItemUnifierProxy> RecoveryItems;

	public Action OnRecovery;

	public bool IsEquipDecompose;
}
