using GameFramework.Runtime;

namespace Ase;

public class HeroIndepentResView : UGuiView
{
	protected BattleUserViewModel viewModel;

	protected HeroIndepentType _heroIndepentType;

	protected bool isInit;

	public void OnInitIndepentView(object userData)
	{
		InitData();
		viewModel = userData as BattleUserViewModel;
		if (viewModel != null && !viewModel.IsEmpty)
		{
			viewModel = viewModel;
			if (!isInit)
			{
				BindUI();
			}
		}
	}

	public virtual void BindUI()
	{
		if (viewModel.HeroData != null && _heroIndepentType == viewModel.HeroData.HeroIndepentType)
		{
			isInit = true;
		}
	}

	public virtual void InitData()
	{
	}

	public void RefreshData(BattleUserViewModel viewModel)
	{
		if (this.viewModel != null && !viewModel.IsEmpty)
		{
			this.viewModel = viewModel;
			if (!isInit)
			{
				BindUI();
			}
			else
			{
				ClearBingUI(this.viewModel);
			}
			if (isInit)
			{
				this.SetDataContext(viewModel);
			}
		}
	}

	public virtual void ClearBingUI(BattleUserViewModel viewModel)
	{
		if (isInit && viewModel.HeroData.HeroIndepentType != _heroIndepentType)
		{
			isInit = false;
			base.gameObject.SetActive(value: false);
		}
	}
}
