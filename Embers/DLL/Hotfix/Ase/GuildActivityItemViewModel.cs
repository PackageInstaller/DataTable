namespace Ase;

public class GuildActivityItemViewModel : OptionBase
{
	private GuildActivityExpeditionData data;

	public GuildActivityExpeditionData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public GuildActivityItemViewModel()
	{
	}

	public GuildActivityItemViewModel(OptionBase parent, GuildActivityExpeditionData data)
	{
		base.parent = parent;
		this.data = data;
	}

	public void OpenActivity()
	{
		if (data.IsEntireTimeLock)
		{
			Toast.ShowInfo("活动未开放！");
		}
		else if (parent != null)
		{
			parent.ItemOnClick(new OptionArg(this, "OpenActivityExpedition"));
		}
	}
}
