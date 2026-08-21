using GameFramework.Runtime;

namespace Ase;

public class HeroViewModel : OptionBase
{
	protected bool empty;

	protected HeroModel data;

	protected InteractionRequest refreshFgRequest = new InteractionRequest();

	public bool Empty
	{
		get
		{
			return empty;
		}
		private set
		{
			Set(ref empty, value, "Empty");
		}
	}

	public HeroModel Data
	{
		get
		{
			return data ?? (data = new HeroModel());
		}
		set
		{
			Set(ref data, value, "Data");
			Empty = data.IsNullOrEmpty();
		}
	}

	public IInteractionRequest RefreshFgRequest => refreshFgRequest;

	public HeroViewModel(OptionBase parent)
	{
		base.parent = parent;
		Data = new HeroModel();
	}

	public HeroViewModel(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		Data = heroModel;
	}

	public void SetData(HeroModel data)
	{
		Data = data;
		refreshFgRequest.Raise();
	}

	public void OnClick()
	{
		parent.ItemOnClick(this);
	}
}
