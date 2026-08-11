#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class SelectBuffViewModel : OptionBase
{
	private readonly List<RecommendItemViewModel> buffItems = new List<RecommendItemViewModel>();

	private readonly InteractionRequest<string> optRequest;

	private readonly SimpleCommand<string> optCommand;

	private RecommendItemViewModel curSelect;

	private int selectedBuffId;

	private int curCopyType;

	private bool isShow;

	private bool isConfirmEnable;

	public int SelectedBuffId
	{
		get
		{
			return selectedBuffId;
		}
		private set
		{
			Set(ref selectedBuffId, value, "SelectedBuffId");
		}
	}

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		private set
		{
			Set(ref isShow, value, "IsShow");
		}
	}

	public bool IsConfirmEnable
	{
		get
		{
			return isConfirmEnable;
		}
		private set
		{
			Set(ref isConfirmEnable, value, "IsConfirmEnable");
		}
	}

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<RecommendItemViewModel> BuffItems => buffItems;

	public int CopyType => curCopyType;

	public SelectBuffViewModel()
	{
	}

	public SelectBuffViewModel(OptionBase parent)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
	}

	public void RefreshRecommends(List<DRRecommend> recommends, int copyType)
	{
		if (copyType != curCopyType)
		{
			buffItems.Clear();
			curSelect = null;
			curCopyType = copyType;
			BuildBuffItems(recommends);
		}
	}

	private void BuildBuffItems(List<DRRecommend> recommends)
	{
		if (recommends == null || recommends.Count == 0)
		{
			return;
		}
		for (int i = 0; i < recommends.Count; i++)
		{
			DRRecommend drRecommend = recommends[i];
			DRBuff dataRow = GameEntry.DataTable.GetDataRow((DRBuff p) => p.Id == drRecommend.AssociatedId);
			string name = dataRow?.Name ?? $"Buff {drRecommend.AssociatedId}";
			string desc = dataRow?.Desc ?? string.Empty;
			string icon = $"UIBuff_{dataRow.Id}";
			List<CopyTeamItemViewModel> list = new List<CopyTeamItemViewModel>();
			if (drRecommend.RecommendId != null)
			{
				for (int num = 0; num < drRecommend.RecommendId.Count; num++)
				{
					HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(drRecommend.RecommendId[num]);
					if (heroById == null || heroById.Empty)
					{
						CopyTeamItemViewModel copyTeamItemViewModel = new CopyTeamItemViewModel(this);
						heroById = HeroModel.CreateByConfig(drRecommend.RecommendId[num]);
						copyTeamItemViewModel.RefreshData(heroById);
						copyTeamItemViewModel.SetSelect(isSelect: true);
						list.Add(copyTeamItemViewModel);
					}
					else
					{
						list.Add(new CopyTeamItemViewModel(this, heroById, 0, "", showPos: false));
					}
				}
			}
			RecommendItemViewModel recommendItemViewModel = new RecommendItemViewModel(this, drRecommend.AssociatedId, name, desc, icon, list);
			buffItems.Add(recommendItemViewModel);
			if (curSelect == null)
			{
				SetSelect(recommendItemViewModel);
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is RecommendItemViewModel recommendItemViewModel)
		{
			SetSelect(recommendItemViewModel);
		}
		else
		{
			base.ItemOnClick(obj);
		}
	}

	private void SetSelect(RecommendItemViewModel itemVm)
	{
		if (curSelect != null)
		{
			curSelect.IsSelect = false;
		}
		curSelect = itemVm;
		if (curSelect != null)
		{
			curSelect.IsSelect = true;
			SelectedBuffId = curSelect.BuffId;
		}
		IsConfirmEnable = curSelect != null && curSelect.BuffId != 0;
	}

	private void OnOpt(string optName)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		if ("Confirm".Equals(optName))
		{
			if (curSelect == null)
			{
				optCommand.Enabled = true;
				return;
			}
			parent?.ItemOnClick(new OptionArg(SelectedBuffId, "SelectBuffConfirm"));
			IsShow = false;
		}
		else if ("Close".Equals(optName))
		{
			IsShow = false;
		}
		optCommand.Enabled = true;
	}

	public void SetShow(int buffId)
	{
		IsShow = true;
		if (buffId == 0)
		{
			if (curSelect != null)
			{
				curSelect.IsSelect = false;
				curSelect = null;
			}
			SelectedBuffId = 0;
			IsConfirmEnable = false;
			return;
		}
		RecommendItemViewModel recommendItemViewModel = null;
		for (int i = 0; i < buffItems.Count; i++)
		{
			if (buffItems[i].BuffId == buffId)
			{
				recommendItemViewModel = buffItems[i];
				break;
			}
		}
		if (recommendItemViewModel == null)
		{
			Log.Error($"SelectBuffViewModel SetShow 找不到 BuffId {buffId}");
			return;
		}
		SetSelect(recommendItemViewModel);
		IsConfirmEnable = true;
	}
}
