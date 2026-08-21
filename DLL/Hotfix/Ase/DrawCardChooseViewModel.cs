using System.Collections.Generic;

namespace Ase;

public class DrawCardChooseViewModel : OptionBase
{
	private DrawCardChooseItemViewModel selectedViewModel;

	private List<DrawCardChooseItemViewModel> chooseItemViewModels;

	public DrawCardChooseItemViewModel SelectedViewModel => selectedViewModel;

	public List<DrawCardChooseItemViewModel> ChooseItemViewModels => chooseItemViewModels;

	public DrawCardChooseViewModel(OptionBase parent, List<DrawCardItemInfo> drawCardItemInfos)
	{
		base.parent = parent;
		chooseItemViewModels = new List<DrawCardChooseItemViewModel>();
		for (int i = 0; i < drawCardItemInfos.Count; i++)
		{
			chooseItemViewModels.Add(new DrawCardChooseItemViewModel(this, drawCardItemInfos[i], i));
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: DrawCardChooseItemViewModel obj2 } optionArg)
		{
			if (optionArg.OptionName.Equals("Select"))
			{
				ChangeSelectedViewModel(obj2);
			}
			else if (optionArg.OptionName.Equals("Confirm"))
			{
				ConfirmOnClick();
			}
		}
	}

	private void ChangeSelectedViewModel(DrawCardChooseItemViewModel chooseItemViewModel)
	{
		if (selectedViewModel == null || chooseItemViewModel.Index != selectedViewModel.Index)
		{
			selectedViewModel = chooseItemViewModel;
			switch (chooseItemViewModel.Index)
			{
			case 0:
				SelectLeft();
				break;
			case 1:
				SelectMiddle();
				break;
			case 2:
				SelectRight();
				break;
			}
		}
	}

	private void SelectLeft()
	{
		chooseItemViewModels[0].SetSelected(value: true);
		chooseItemViewModels[0].Move("Amplify");
		chooseItemViewModels[1].SetSelected(value: false);
		chooseItemViewModels[1].Move("Right1");
		chooseItemViewModels[2].SetSelected(value: false);
		chooseItemViewModels[2].Move("Right2");
	}

	private void SelectMiddle()
	{
		chooseItemViewModels[0].SetSelected(value: false);
		chooseItemViewModels[0].Move("Left1");
		chooseItemViewModels[1].SetSelected(value: true);
		chooseItemViewModels[1].Move("Amplify");
		chooseItemViewModels[2].SetSelected(value: false);
		chooseItemViewModels[2].Move("Right1");
	}

	private void SelectRight()
	{
		chooseItemViewModels[0].SetSelected(value: false);
		chooseItemViewModels[0].Move("Left2");
		chooseItemViewModels[1].SetSelected(value: false);
		chooseItemViewModels[1].Move("Left1");
		chooseItemViewModels[2].SetSelected(value: true);
		chooseItemViewModels[2].Move("Amplify");
	}

	private void ConfirmOnClick()
	{
		parent.ItemOnClick(this);
	}
}
