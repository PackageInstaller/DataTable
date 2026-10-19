using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class DiskRecoveryComp : RecoveryCompBase
{
	[SerializeField]
	private ActButton _filterBtn;

	[SerializeField]
	private ActButton _quickFillBtn;

	public override void Init(MonoInventoryView monoInventoryView)
	{
		base.Init(monoInventoryView);
		_filterBtn.SetBtnClick(monoInventoryView.OnClickFilterBtnHandle);
		_quickFillBtn.SetBtnClick(OnClickQuickFillBtnHandle);
	}

	private void OnClickQuickFillBtnHandle()
	{
		monoInventoryView.OnQuickFill();
	}
}
