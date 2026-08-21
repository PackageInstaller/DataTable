using GameFramework.Runtime;

namespace Ase;

public class HeroInfoViewModel : OptionBase
{
	private HeroModel _heroModel;

	public string ShowName;

	private InteractionRequest _onRefreshQuest;

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		private set
		{
			Set(ref _heroModel, value, "HeroModel");
			_onRefreshQuest.Raise();
		}
	}

	public InteractionRequest OnRefreshQuest => _onRefreshQuest;

	public void SetData(HeroModel heroModel)
	{
		if (heroModel != null)
		{
			ShowName = heroModel.Name;
		}
		HeroModel = heroModel;
	}

	public void ChangeHero(int index)
	{
		parent?.ItemOnClick(new OptionArg(index, "ChangeHero"));
		EndDrag();
	}

	public void BeginDrag()
	{
		parent?.ItemOnClick("HideUI");
	}

	public void EndDrag()
	{
		parent?.ItemOnClick("ShowUI");
	}

	public HeroInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
		_onRefreshQuest = new InteractionRequest();
	}
}
