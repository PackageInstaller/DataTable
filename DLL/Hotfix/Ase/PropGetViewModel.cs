using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PropGetViewModel : OptionBase
{
	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private PropGetItemsViewModel propGetItemsVM;

	private UniTaskCompletionSource<bool> completionSource;

	public PropGetItemsWindowType GetItemsWindowType;

	private bool isStart;

	private List<HeroRewardInfo> heroRewardInfos;

	private List<int> heroSkinRewardList = new List<int>();

	public IInteractionRequest OptRequest => optRequest;

	public List<KnapsackItemViewModel> PropGetList => propGetItemsVM?.PropGetList;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow: false);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is DrawCardSingleViewModel drawCardSingleViewModel)
			{
				ShowHeroGetWindow(delegate
				{
					ShowHeroSkinWindow(OpenPropItemsGet);
				});
				drawCardSingleViewModel.Close();
			}
			else if (optionArg.Obj is HeroSkinGetViewModel)
			{
				ShowHeroSkinWindow(OpenPropItemsGet);
			}
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}

	public PropGetViewModel()
	{
	}

	public PropGetViewModel(OptionBase parent, List<PropDataBase> itemsGet)
	{
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, itemsGet);
	}

	public PropGetViewModel(OptionBase parent, List<PropDataBase> itemsGet, List<HeroRewardInfo> heroRewardInfos)
	{
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, itemsGet);
		this.heroRewardInfos = heroRewardInfos;
	}

	public PropGetViewModel(OptionBase parent, RewardThings rewardThings)
	{
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, rewardThings?.propItems);
		heroRewardInfos = rewardThings?.heroRewardInfos;
		completionSource = new UniTaskCompletionSource<bool>();
	}

	public PropGetViewModel(OptionBase parent, RewardGetData rewardGetData)
	{
		completionSource = new UniTaskCompletionSource<bool>();
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, rewardGetData.PropList);
		heroRewardInfos = rewardGetData.HeroRewardInfos;
		heroSkinRewardList = rewardGetData.HeroSkinList;
	}

	public PropGetViewModel(OptionBase parent, List<KnapsackPropData> itemsGet)
	{
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, itemsGet);
	}

	public PropGetViewModel(OptionBase parent, List<PropData> itemsGet)
	{
		base.parent = parent;
		propGetItemsVM = new PropGetItemsViewModel(this, itemsGet);
	}

	public PropGetViewModel(OptionBase parent, List<HeroRewardInfo> heroRewardInfos)
	{
		base.parent = parent;
		this.heroRewardInfos = heroRewardInfos;
		propGetItemsVM = null;
	}

	public PropGetViewModel(OptionBase parent, List<int> heroIds)
	{
		base.parent = parent;
		heroRewardInfos = PropHelper.GetHeroRewardInfos(heroIds);
		propGetItemsVM = null;
	}

	public void MergeProp()
	{
		if (propGetItemsVM != null)
		{
			propGetItemsVM.MergeProp();
		}
	}

	public void StartOpen()
	{
		if (!isStart)
		{
			ShowHeroGetWindow(delegate
			{
				ShowHeroSkinWindow(OpenPropItemsGet);
			});
		}
	}

	private void OpenPropItemsGet()
	{
		if (propGetItemsVM == null || propGetItemsVM.PropGetList.Count == 0)
		{
			Close();
		}
		OpenViewArg openViewArg = null;
		switch (GetItemsWindowType)
		{
		case PropGetItemsWindowType.Normal:
			openViewArg = new OpenViewArg(typeof(PropGetItemsWindow), propGetItemsVM);
			break;
		case PropGetItemsWindowType.Activity:
			openViewArg = new OpenViewArg(typeof(ActPropGetItemsWindow), propGetItemsVM);
			break;
		}
		if (openViewArg == null)
		{
			Close();
			return;
		}
		openWindowRequest.Raise(openViewArg, delegate
		{
			Close();
		});
	}

	private void ShowHeroGetWindow(Action finishAction)
	{
		if (heroRewardInfos == null || heroRewardInfos.Count == 0)
		{
			finishAction?.Invoke();
			return;
		}
		HeroRewardInfo heroRewardInfo = heroRewardInfos[0];
		int heroId = heroRewardInfo.heroId;
		heroRewardInfos.RemoveAt(0);
		HeroModel heroModel = new HeroModel(heroId, 0, 0, 1, 0L, 1, 0L);
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		if (heroRewardInfo.heroProducts != null && heroRewardInfo.heroProducts.Count > 0)
		{
			list = heroRewardInfo.heroProducts;
		}
		DrawCardSingleViewModel drawCardSingleViewModel = new DrawCardSingleViewModel(this, heroModel, list, isShowFinal: false, list.Count == 0);
		if (drawCardSingleViewModel.IsSsr)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardSSRWindow), drawCardSingleViewModel));
		}
		else
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardSRWindow), drawCardSingleViewModel));
		}
	}

	private void ShowHeroSkinWindow(Action finishAction)
	{
		if (heroSkinRewardList == null || heroSkinRewardList.Count <= 0)
		{
			finishAction?.Invoke();
			return;
		}
		int id = heroSkinRewardList[0];
		heroSkinRewardList.RemoveAt(0);
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(id);
		if (dataRow == null)
		{
			ShowHeroSkinWindow(finishAction);
		}
		else
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinGetWindow), new HeroSkinGetViewModel(this, dataRow)));
		}
	}

	public UniTask<bool> WaitForClose()
	{
		return completionSource.Task;
	}

	public override void Close()
	{
		if (completionSource != null)
		{
			completionSource?.TrySetResult(result: true);
		}
		base.Close();
	}
}
