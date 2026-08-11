using System.Collections.Generic;

namespace Ase;

public class PropExcNoSliderView : PropExcView
{
	public MoneyView moneyView;

	protected override void AddMoneyView()
	{
		base.AddMoneyView();
		MoneyViewModel moneyViewModel = new MoneyViewModel(viewModel);
		moneyView.Init(moneyViewModel);
		moneyView.SetShow(new List<RoleMoneyEnum> { RoleMoneyEnum.Diamond });
	}
}
