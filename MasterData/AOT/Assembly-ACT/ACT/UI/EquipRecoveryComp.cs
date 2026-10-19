using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class EquipRecoveryComp : RecoveryCompBase
{
	[SerializeField]
	private ActButton _filterBtn;

	[SerializeField]
	private ActButton _sortBtn;

	[SerializeField]
	private ActButton _quickFillBtn;

	public override void Init(MonoInventoryView monoInventoryView)
	{
		base.Init(monoInventoryView);
		_filterBtn.SetBtnClick(monoInventoryView.OnClickFilterBtnHandle);
		_sortBtn.SetBtnClick(monoInventoryView.OnClickSortBtnHandle);
		_quickFillBtn.SetBtnClick(OnClickQuickFillBtnHandle);
	}

	private void OnClickQuickFillBtnHandle()
	{
		monoInventoryView.OnQuickFill();
	}
}
