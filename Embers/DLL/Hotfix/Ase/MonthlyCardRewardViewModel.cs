using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MonthlyCardRewardViewModel : OptionBase
{
	private int leftRewardDay;

	private List<PropDataBase> rewards = new List<PropDataBase>();

	private SimpleCommand getReward;

	private InteractionRequest onGetRewardSuccess = new InteractionRequest();

	public int LeftRewardDay
	{
		get
		{
			return leftRewardDay;
		}
		set
		{
			Set(ref leftRewardDay, value, "LeftRewardDay");
		}
	}

	public InteractionRequest OnGetRewardSuccess => onGetRewardSuccess;

	public SimpleCommand GetReward => getReward;

	public MonthlyCardRewardViewModel()
	{
	}

	public MonthlyCardRewardViewModel(OptionBase parent)
	{
		base.parent = parent;
		getReward = new SimpleCommand(RequestGetReward);
		LeftRewardDay = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMonthlyCardLeftDay();
	}

	private async void RequestGetReward()
	{
		getReward.Enabled = false;
		KeyValuePair<bool, List<PropDataBase>> keyValuePair = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestGetMonthlyCardReward();
		if (keyValuePair.Key)
		{
			rewards = keyValuePair.Value;
			onGetRewardSuccess.Raise();
		}
		getReward.Enabled = true;
	}

	public void OpenPropGetWindow()
	{
		if (rewards != null && rewards.Count > 0)
		{
			PropGetViewModel userData = new PropGetViewModel(this, rewards);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
			{
				Close();
			});
		}
		else
		{
			Close();
		}
	}
}
