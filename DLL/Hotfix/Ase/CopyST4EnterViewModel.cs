#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class CopyST4EnterViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private List<CopyST4EnterItemViewModel> copyItemVms;

	private string buffDesc;

	private string buffName;

	private int buffType;

	private string propIcon = "";

	private int starCur;

	private int starMax;

	private bool multiCopy;

	private bool red;

	private CopyTypeData curTypeData;

	private CopyST4RewardViewModel rewardVM;

	private CopyT4Stage copyStage;

	private CopyHeroSelectViewModel heroSelectVM;

	private List<int> depthsRewardList;

	private List<CopyPrepareTeam> prepareTeams;

	private CopyST4EnterItemViewModel curSelectTeam;

	public string BuffDesc
	{
		get
		{
			return buffDesc;
		}
		private set
		{
			Set(ref buffDesc, value, "BuffDesc");
		}
	}

	public string PropIcon
	{
		get
		{
			return propIcon;
		}
		private set
		{
			Set(ref propIcon, value, "PropIcon");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		private set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public int BuffType => buffType;

	public int StarMax
	{
		get
		{
			return starMax;
		}
		private set
		{
			Set(ref starMax, value, "StarMax");
		}
	}

	public int StarCur
	{
		get
		{
			return starCur;
		}
		private set
		{
			Set(ref starCur, value, "StarCur");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		private set
		{
			Set(ref red, value, "Red");
		}
	}

	public bool MultiCopy
	{
		get
		{
			return multiCopy;
		}
		private set
		{
			Set(ref multiCopy, value, "MultiCopy");
		}
	}

	public CopyT4Stage CopyStage
	{
		get
		{
			return copyStage;
		}
		private set
		{
			Set(ref copyStage, value, "CopyStage");
		}
	}

	public CopyHeroSelectViewModel HeroSelectVm => heroSelectVM;

	public ICommand OptCommand => optCommand;

	public List<CopyST4EnterItemViewModel> CopyItemVms => copyItemVms;

	public IInteractionRequest OptRequest => optRequest;

	public CopyST4EnterViewModel()
	{
	}

	public CopyST4EnterViewModel(OptionBase parent, List<CopyData> copyDatas)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		if (copyDatas != null && copyDatas.Count > 0)
		{
			EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(copyDatas[0].DepthsEnvironId);
			if (displayInfo.EnvironId == 0)
			{
				Log.Error($"EnvironmentModifier表找不到配置Id【{copyDatas[0].DepthsEnvironId}】,Copy Id【{copyDatas[0].Id}】");
				buffDesc = "";
				buffName = "";
			}
			else
			{
				buffDesc = displayInfo.Desc;
				buffName = displayInfo.Name;
				buffType = (int)displayInfo.TargetType;
			}
		}
		copyItemVms = new List<CopyST4EnterItemViewModel>();
		if (copyDatas.Count > 1)
		{
			multiCopy = true;
		}
		for (int i = 0; i < copyDatas.Count; i++)
		{
			CopyType4TeamConfig teamConfig = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetTeamConfig(copyDatas[i].Id);
			copyItemVms.Add(new CopyST4EnterItemViewModel(this, copyDatas[i], teamConfig, i + 1, multiCopy));
		}
		copyStage = copyItemVms[0].CopyStage;
	}

	public void JumpTo()
	{
	}

	public async UniTask SetCopyData(List<CopyData> copyDatas, List<CopyType4TeamConfig> config)
	{
		if (copyDatas.Count > 1)
		{
			MultiCopy = true;
		}
		if (copyDatas != null && copyDatas.Count > 0)
		{
			EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(copyDatas[0].DepthsEnvironId);
			if (displayInfo.EnvironId == 0)
			{
				Log.Error($"EnvironmentModifier表找不到配置Id【{copyDatas[0].DepthsEnvironId}】,Copy Id【{copyDatas[0].Id}】");
				BuffDesc = "";
				BuffName = "";
			}
			else
			{
				BuffDesc = displayInfo.Desc;
				BuffName = displayInfo.Name;
				buffType = (int)displayInfo.TargetType;
			}
		}
		copyItemVms.Clear();
		if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType4CopySettingInfos(copyDatas)))
		{
			Log.Error("获取深渊副本组队配置失败");
		}
		for (int i = 0; i < copyDatas.Count; i++)
		{
			CopyT4Stage stage = CopyT4Stage.None;
			CopyType4TeamConfig copyType4TeamConfig = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetTeamConfig(copyDatas[i].Id);
			bool flag = false;
			if (copyType4TeamConfig != null)
			{
				List<int> heroList = copyType4TeamConfig.HeroList;
				if (heroList == null || heroList.Count == 0)
				{
					flag = true;
				}
				else
				{
					flag = true;
					for (int j = 0; j < heroList.Count; j++)
					{
						if (heroList[j] != 0)
						{
							flag = false;
							break;
						}
					}
				}
			}
			if ((copyType4TeamConfig == null || flag) && config.Count > i && config[i].CopyId == copyDatas[i].Id)
			{
				copyType4TeamConfig = config[i];
				stage = CopyT4Stage.None;
			}
			CopyST4EnterItemViewModel copyST4EnterItemViewModel = new CopyST4EnterItemViewModel(this, copyDatas[i], copyType4TeamConfig, i + 1, multiCopy);
			copyItemVms.Add(copyST4EnterItemViewModel);
			copyST4EnterItemViewModel.ChangeStage(stage);
		}
		if (copyItemVms.Count > 0)
		{
			CopyStage = copyItemVms[0].CopyStage;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OpenBpConfig"))
			{
				CopyST4EnterItemViewModel item = (CopyST4EnterItemViewModel)optionArg.Obj;
				openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropConfigWindow), item.BPConfigVM), delegate
				{
					item.BpConfigViewModel.Refresh(item.Data.Id);
				});
			}
			else if (optionArg.OptionName.Equals("OpenTeamConfigView"))
			{
				if (copyStage != CopyT4Stage.Entered)
				{
					OpenTeamConfigView((CopyST4EnterItemViewModel)optionArg.Obj);
				}
			}
			else if (optionArg.OptionName.Equals("UnselectTeamHero"))
			{
				if (copyStage != CopyT4Stage.Entered)
				{
					UnselectTeamHero((CopyTeamItemViewModel)optionArg.Obj);
				}
			}
			else if (optionArg.OptionName.Equals("SortTeam"))
			{
				SortHeroSelectVm();
			}
			else if (optionArg.OptionName.Equals("SelectPrefig"))
			{
				SelectPrefig((CopyTeamViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("EnterResult"))
			{
				SetEnterResult((bool)optionArg.Obj);
				parent?.ItemOnClick(obj);
			}
			else if (optionArg.OptionName.Equals("EnterCopy"))
			{
				OnChildEnter((CopyST4EnterItemViewModel)optionArg.Obj);
			}
		}
		else if (obj is CopyHeroItemViewModel heroItemVm)
		{
			SelectHeroInConfig(heroItemVm);
		}
	}

	private void UnselectTeamHero(CopyTeamItemViewModel teamItemViewModel)
	{
		if (heroSelectVM != null && curSelectTeam != null && teamItemViewModel.HeroId != 0)
		{
			curSelectTeam.RemoveHero(teamItemViewModel.HeroId);
			RefreshHeroSelectVm();
		}
	}

	private void OpenTeamConfigView(CopyST4EnterItemViewModel curSelectTeam)
	{
		if (this.curSelectTeam != null && this.curSelectTeam == curSelectTeam)
		{
			return;
		}
		if (heroSelectVM == null)
		{
			heroSelectVM = new CopyHeroSelectViewModel(this);
		}
		SortHeroSelectVm();
		this.curSelectTeam = curSelectTeam;
		this.curSelectTeam.IsConfigging = true;
		this.curSelectTeam.SetHighlight(isHighlight: true);
		heroSelectVM.SetPrefigSelect(curSelectTeam.TeamTag);
		optRequest.Raise("OpenTeamView");
		CopyStage = CopyT4Stage.Configging;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			copyItemVms[i].ChangeStage(copyStage);
		}
		int selectIndex = -1;
		for (int j = 0; j < copyItemVms.Count; j++)
		{
			if (copyItemVms[j] == curSelectTeam)
			{
				selectIndex = j;
				break;
			}
		}
		heroSelectVM.CheckAllPrefigAndConfigSelect(copyItemVms, selectIndex);
	}

	private void SortHeroSelectVm()
	{
		if (!multiCopy)
		{
			heroSelectVM.SortHeroList(copyItemVms[0].GetHeroListInt(), null);
		}
		else
		{
			heroSelectVM.SortHeroList(copyItemVms[0].GetHeroListInt(), copyItemVms[1].GetHeroListInt());
		}
	}

	private void SelectHeroInConfig(CopyHeroItemViewModel heroItemVm)
	{
		if (heroItemVm.HaveTag)
		{
			for (int i = 0; i < copyItemVms.Count; i++)
			{
				copyItemVms[i].RemoveHero(heroItemVm.HeroModel.Id);
			}
		}
		else if (!curSelectTeam.AddHero(heroItemVm.HeroModel.Id, heroItemVm.HeroModel.SkinSuffix, heroItemVm.HeroModel.SkinConfigId))
		{
			Toast.ShowInfo("队伍烬天使已满！");
			return;
		}
		RefreshHeroSelectVm();
	}

	private void SelectPrefig(CopyTeamViewModel copyTeamViewModel)
	{
		List<int> heroId = CollectionPool<List<int>, int>.Get();
		heroId.Clear();
		List<HeroModel> heroModels = new List<HeroModel>();
		copyTeamViewModel.GetHeroIds(in heroModels, in heroId);
		curSelectTeam.SetHero(in heroModels);
		copyTeamViewModel.SetTag(curSelectTeam.TeamTag);
		copyTeamViewModel.SetSelect(isSelect: true);
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (copyItemVms[i] != curSelectTeam)
			{
				copyItemVms[i].RemoveSameHero(in heroId);
			}
		}
		heroId.Clear();
		CollectionPool<List<int>, int>.Release(heroId);
		RefreshHeroSelectVm(copyTeamViewModel);
	}

	private void RefreshHeroSelectVm(CopyTeamViewModel copyTeamViewModel = null)
	{
		int selectIndex = -1;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (copyItemVms[i] == curSelectTeam)
			{
				selectIndex = i;
				break;
			}
		}
		if (heroSelectVM != null)
		{
			heroSelectVM.CheckAllPrefigAndConfigSelect(copyItemVms, selectIndex);
		}
	}

	public async Task OnChildEnter(CopyST4EnterItemViewModel child)
	{
		if (optCommand.Enabled)
		{
			optCommand.Enabled = false;
			CheckChildEnter(child);
		}
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenHero".Equals(optName))
		{
			try
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(HeroWarehouseWindow), new HeroWarehouseViewModel(this)), delegate
				{
					optCommand.Enabled = true;
				});
			}
			catch (Exception message)
			{
				Log.Error(message);
				optCommand.Enabled = true;
			}
		}
		else if ("HideTeamView".Equals(optName))
		{
			for (int num = 0; num < copyItemVms.Count; num++)
			{
				if (!copyItemVms[num].HaveTeam())
				{
					CopyStage = CopyT4Stage.None;
					break;
				}
			}
			if (copyStage == CopyT4Stage.Configging)
			{
				CopyStage = CopyT4Stage.Configed;
			}
			curSelectTeam.IsConfigging = false;
			curSelectTeam.ChangeStage(copyStage);
			curSelectTeam.SetHighlight(isHighlight: false);
			curSelectTeam = null;
			heroSelectVM.CancelCurSelect();
			optRequest.Raise("HideTeamView");
		}
		else if ("ChangeTeam".Equals(optName))
		{
			if (copyStage == CopyT4Stage.Entered || !multiCopy)
			{
				optCommand.Enabled = true;
				return;
			}
			List<HeroSkinBind> heroList = copyItemVms[0].GetHeroList();
			List<HeroSkinBind> heroList2 = copyItemVms[1].GetHeroList();
			copyItemVms[0].SetTeam(heroList2);
			copyItemVms[1].SetTeam(heroList);
			RefreshHeroSelectVm();
		}
		else if ("ClearTeam".Equals(optName))
		{
			if (copyStage == CopyT4Stage.Entered || !multiCopy)
			{
				optCommand.Enabled = true;
				return;
			}
			copyItemVms[0].ClearTeamAndBP();
			copyItemVms[1].ClearTeamAndBP();
			RefreshHeroSelectVm();
			CopyStage = CopyT4Stage.None;
		}
		else if ("SaveTeam".Equals(optName))
		{
			await CheckEnter();
		}
		else if ("ResetTeam".Equals(optName))
		{
			await ResetTeam();
			return;
		}
		optCommand.Enabled = true;
	}

	private async Task ResetTeam()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "重置将清空当前阵容的挑战记录", "确定", "取消");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				Loading loading = await Loading.Show();
				List<int> clearCopyIds = new List<int>();
				bool flag = false;
				if (copyItemVms.Count > 1)
				{
					for (int i = 0; i < copyItemVms.Count; i++)
					{
						if (copyItemVms[i].Data.StarMax == 0)
						{
							flag = true;
						}
					}
				}
				for (int j = 0; j < copyItemVms.Count; j++)
				{
					clearCopyIds.Add(copyItemVms[j].Data.Id);
					copyItemVms[j].ClearTeamAndBP();
					copyItemVms[j].Data.ResetAccess();
					if (flag)
					{
						copyItemVms[j].Data.ResetMax();
					}
					copyItemVms[j].ResetCondition();
					parent.ItemOnClick(new OptionArg(this, "CalStar"));
				}
				bool num = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().ResetFloorCopySetting(clearCopyIds);
				loading.Dispose();
				if (!num)
				{
					Toast.ShowInfo("队伍配置重置失败，请重试！");
				}
				CopyStage = CopyT4Stage.None;
				for (int k = 0; k < copyItemVms.Count; k++)
				{
					copyItemVms[k].ChangeStage(copyStage);
				}
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().RemoveCopyConfig(clearCopyIds);
				RefreshHeroSelectVm();
			}
		});
		optCommand.Enabled = true;
	}

	private void CheckChildEnter(CopyST4EnterItemViewModel enterItem = null)
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (copyItemVms[i].BPEnough())
			{
				continue;
			}
			IAsyncResult<int> result = AlertDialog.Show("提示", "当前队伍中的战斗道具尚未配置齐全，是否要继续挑战", "确定", "取消");
			result.Callbackable().OnCallback(async delegate
			{
				if (result.Result == -1)
				{
					EnterBattle(enterItem);
				}
			});
			optCommand.Enabled = true;
			return;
		}
		SaveBPConfig();
		EnterBattle(enterItem);
	}

	private async Task CheckEnter(CopyST4EnterItemViewModel enterItem = null)
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (!copyItemVms[i].CheckHasP0())
			{
				Toast.ShowInfo("每个队伍需要配置主控烬天使才能出战");
				return;
			}
			if (!copyItemVms[i].HeroCount())
			{
				Toast.ShowInfo("每个队伍至少配置2名烬天使才能出战");
				return;
			}
		}
		for (int j = 0; j < copyItemVms.Count; j++)
		{
			if (copyItemVms[j].BPEnough())
			{
				continue;
			}
			IAsyncResult<int> result = AlertDialog.Show("提示", "当前队伍中的战斗道具尚未配置齐全，是否要继续挑战", "确定", "取消");
			result.Callbackable().OnCallback(async delegate
			{
				if (result.Result == -1 && await SaveTeam())
				{
					EnterBattle(enterItem);
				}
			});
			return;
		}
		if (await SaveTeam())
		{
			EnterBattle(enterItem);
		}
	}

	private async Task<bool> SaveTeam()
	{
		Loading loading = await Loading.Show();
		List<CopyType4TeamConfig> teamConfigs = new List<CopyType4TeamConfig>();
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			CopyType4TeamConfig item = new CopyType4TeamConfig(copyItemVms[i].Data.Id, copyItemVms[i].GetHeroListInt(), copyItemVms[i].GetBPList());
			teamConfigs.Add(item);
		}
		bool num = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetFloorCopySetting(teamConfigs);
		loading.Dispose();
		if (num)
		{
			for (int j = 0; j < teamConfigs.Count; j++)
			{
				teamConfigs[j].SaveHeroCut();
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddCopyConfig(teamConfigs);
			return true;
		}
		Toast.ShowInfo("队伍配置保存失败，请重试！");
		optCommand.Enabled = true;
		return false;
	}

	private bool SaveBPConfig()
	{
		List<CopyType4TeamConfig> list = new List<CopyType4TeamConfig>();
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			CopyType4TeamConfig item = new CopyType4TeamConfig(copyItemVms[i].Data.Id, copyItemVms[i].GetHeroListInt(), copyItemVms[i].GetBPList());
			list.Add(item);
		}
		if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetFloorCopySettingBPConfig(list))
		{
			for (int j = 0; j < list.Count; j++)
			{
				list[j].SaveHeroCut();
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddCopyConfig(list);
			return true;
		}
		Toast.ShowInfo("队伍配置保存失败，请重试！");
		optCommand.Enabled = true;
		return false;
	}

	private void EnterBattle(CopyST4EnterItemViewModel enterItem = null)
	{
		if (enterItem == null)
		{
			parent.ItemOnClick(copyItemVms[0]);
		}
		else
		{
			parent.ItemOnClick(enterItem);
		}
	}

	private void SetEnterResult(bool result)
	{
		CopyStage = CopyT4Stage.Entered;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			copyItemVms[i].ChangeStage(copyStage);
		}
		optCommand.Enabled = true;
	}
}
