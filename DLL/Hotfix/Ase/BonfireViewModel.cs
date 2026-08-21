namespace Ase;

public class BonfireViewModel : OptionBase
{
	private bool btnEnable;

	private new string viewName = "篝火";

	public string ViewName
	{
		get
		{
			return viewName;
		}
		private set
		{
			Set(ref viewName, value, "ViewName");
		}
	}

	public BonfireViewModel()
	{
		btnEnable = true;
	}

	public override async void ItemOnClick(object obj)
	{
		btnEnable = true;
	}

	public async void WeaponCastingOnClick()
	{
		if (btnEnable)
		{
			btnEnable = false;
		}
	}

	public async void EquipmentCastingOnClick()
	{
		if (btnEnable)
		{
			btnEnable = false;
		}
	}

	public async void CookingOnClick()
	{
	}

	public async void AlchemyOnClick()
	{
	}

	public void BackOnClick()
	{
		if (btnEnable)
		{
			btnEnable = false;
			dismissRequest.Raise();
			OpenBattleWindow();
		}
	}

	public void HideBattleWindow()
	{
	}

	public void OpenBattleWindow()
	{
	}
}
