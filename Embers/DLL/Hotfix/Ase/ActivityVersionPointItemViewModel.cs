using GameFramework.Runtime;

namespace Ase;

public class ActivityVersionPointItemViewModel : SelectItemViewModel
{
	private SimpleCommand<string> optCmd;

	private InteractionRequest<string> optRequest;

	private ActivityVersionData data;

	private CopyData copyData;

	public ActivityVersionData Data
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

	public ICommand OptCmd => optCmd;

	public IInteractionRequest OptRequest => optRequest;

	public ActivityVersionPointItemViewModel()
	{
	}

	public ActivityVersionPointItemViewModel(OptionBase parent, ActivityVersionData data)
	{
		base.parent = parent;
		this.data = data;
	}

	public CopyData GetCopyData()
	{
		if (data.Type != 2)
		{
			return null;
		}
		if (copyData == null)
		{
			copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(data.DrVersionActivity.Content);
		}
		return copyData;
	}

	public override void OnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OnClickPoint"));
	}
}
