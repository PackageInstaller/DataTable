#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityVersion1Window : UGuiWindow
{
	public int aniInterval;

	public List<ContentConfigItem> contentConfigItems;

	public ScrollRect scrollView;

	public TextMeshProUGUI activityTime;

	public TextMeshProUGUI activityTime2;

	public Button btnBack;

	public Button btnBg;

	public TextMeshProUGUI curCount;

	public TextMeshProUGUI maxCount;

	public TextMeshProUGUI acumCount;

	public Button btnShop;

	public Button btnScoreTask;

	public Button btnAchieve;

	public Button btnStory;

	public GameObject panel1;

	public GameObject panel2;

	public LockTipsView rankLockView;

	public LockTipsView levelLockView;

	public GameObject gotoRed;

	public GameObject storeRed;

	public GameObject taskRed;

	public GameObject achiRed;

	public List<VersionMoneyView> propViews;

	public Transform pointRoot;

	private List<ActivityVersionPointItemView> pointViewList;

	public ActivityVersionStoryView storyView;

	public CopyItemDetail1View copyDetailView;

	private ActivityVersion1ViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ActivityVersion1ViewModel>();
		BindingSet<ActivityVersion1Window, ActivityVersion1ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ActivityVersion1Window v) => v.OnVisibleChanged).To((ActivityVersion1ViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((ActivityVersion1Window v) => v.OnDismissRequest).To((ActivityVersion1ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityVersion1Window v) => v.OpenUguiWindow).To((ActivityVersion1ViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((ActivityVersion1Window v) => v.OpenUguiWindow2).To((ActivityVersion1ViewModel vm) => vm.OpenWindowRequest2);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.CloseWindow);
		bindingSet.Bind<TextMeshProUGUI>(curCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.CurCount}");
		bindingSet.Bind<TextMeshProUGUI>(maxCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.MaxCount}");
		bindingSet.Bind<TextMeshProUGUI>(acumCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityVersion1ViewModel vm) => $"{vm.AcumCount}");
		bindingSet.Bind<TextMeshProUGUI>(activityTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersion1ViewModel vm) => vm.ActivityTimeText);
		if ((UnityEngine.Object)(object)activityTime2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(activityTime2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersion1ViewModel vm) => vm.ActivityTimeText2);
		}
		bindingSet.Bind(gotoRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.GoToRed);
		bindingSet.Bind(storeRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.StoreRed);
		bindingSet.Bind(taskRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.TaskRed);
		bindingSet.Bind(achiRed).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.AchiRed);
		bindingSet.Bind(btnStory).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenPanel2");
		bindingSet.Bind(btnAchieve).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenAchieve");
		bindingSet.Bind(btnScoreTask).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenScoreTask");
		bindingSet.Bind(btnShop).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenShop");
		bindingSet.Bind(btnShop.gameObject).For((GameObject v) => v.activeSelf).To((ActivityVersion1ViewModel vm) => vm.ShowLimitedContent);
		bindingSet.Bind(btnBg).For((Button v) => v.onClick).To((ActivityVersion1ViewModel vm) => vm.OptCmd)
			.CommandParameter("OnCancel");
		bindingSet.Bind().For((ActivityVersion1Window v) => v.OnOpt).To((ActivityVersion1ViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		LoadProp();
		viewModel.CreateRankLock();
		panel1.gameObject.SetActive(value: true);
		panel2.gameObject.SetActive(value: false);
		storyView.gameObject.SetActive(value: false);
		copyDetailView.gameObject.SetActive(value: false);
		pointViewList = new List<ActivityVersionPointItemView>();
		rankLockView.Init(viewModel.RankLockVm);
		levelLockView.Init(viewModel.LevelLockVm);
		InitContentSize();
		GetAllPoint();
		SettleInitParam();
		viewModel.InitAchiRedPoint();
	}

	private void InitContentSize()
	{
		float width = btnBg.GetComponent<RectTransform>().rect.width;
		float width2 = scrollView.GetComponent<RectTransform>().rect.width;
		for (int i = 0; i < contentConfigItems.Count; i++)
		{
			if (i != 0 || !(width * (float)(i + 1) / (float)contentConfigItems.Count - width2 < 0f))
			{
				contentConfigItems[i].GetComponent<RectTransform>().sizeDelta = new Vector2(width * (float)(i + 1) / (float)contentConfigItems.Count - width2, contentConfigItems[i].GetComponent<RectTransform>().sizeDelta.y);
			}
		}
	}

	private async UniTaskVoid SettleInitParam()
	{
		if (viewModel == null || viewModel.initParam == null || !"OpenPanel2".Equals(viewModel.initParam.OptionName))
		{
			return;
		}
		SettleOpt(viewModel.initParam.OptionName);
		if (viewModel.initParam.Obj != null)
		{
			object obj = viewModel.initParam.Obj;
			if (obj is CopyData copyData)
			{
				await UniTask.WaitUntil(() => Visibility);
				viewModel.OpenSingle(copyData);
			}
		}
		viewModel.initParam = null;
	}

	private void GetAllPoint()
	{
		viewModel.CheckTime();
		ActivityVersionPointItemView[] componentsInChildren = pointRoot.GetComponentsInChildren<ActivityVersionPointItemView>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			ActivityVersionPointItemViewModel pointVM = viewModel.GetPointVM(componentsInChildren[i].VAItemId);
			if (pointVM != null)
			{
				componentsInChildren[i].Init(pointVM);
			}
			pointViewList.Add(componentsInChildren[i]);
		}
		SettleRankLock(-1);
	}

	private void SettleRankLock(int pos)
	{
		ContentConfig rankLockRank = viewModel.GetRankLockRank();
		if (pos != -1)
		{
			for (int i = 0; i < contentConfigItems.Count; i++)
			{
				if (contentConfigItems[i].gameObject.activeSelf && contentConfigItems[i].lockId == rankLockRank.lockId)
				{
					return;
				}
			}
		}
		for (int j = 0; j < contentConfigItems.Count; j++)
		{
			contentConfigItems[j].gameObject.SetActive(contentConfigItems[j].lockId == rankLockRank.lockId);
			if (contentConfigItems[j].lockId == rankLockRank.lockId)
			{
				pointRoot.SetParent(contentConfigItems[j].transform);
				pointRoot.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
				scrollView.content = contentConfigItems[j].GetComponent<RectTransform>();
				scrollView.normalizedPosition = new Vector2((pos == -1) ? 0f : contentConfigItems[j].pos, 0f);
			}
		}
		List<int> list = new List<int>();
		if (rankLockRank.lockId == -1)
		{
			for (int k = 0; k < pointViewList.Count; k++)
			{
				if (pos != -1 && !pointViewList[k].gameObject.activeSelf)
				{
					list.Add(k);
				}
				pointViewList[k].gameObject.SetActive(value: true);
			}
		}
		else
		{
			for (int l = 0; l < pointViewList.Count; l++)
			{
				if (pos != -1 && !pointViewList[l].gameObject.activeSelf && rankLockRank.rank > pointViewList[l].GetRank())
				{
					list.Add(l);
				}
				pointViewList[l].gameObject.SetActive(rankLockRank.rank > pointViewList[l].GetRank());
			}
		}
		if (pos != -1)
		{
			PlayNewUnlockAni(list);
		}
	}

	private void LoadProp()
	{
		if (propViews == null || propViews.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < propViews.Count; i++)
		{
			if (!(propViews[i] == null))
			{
				VersionMoneyViewModel versionMoneyViewModel = viewModel.AddProp(propViews[i].id);
				if (versionMoneyViewModel != null)
				{
					propViews[i].Init(versionMoneyViewModel);
				}
			}
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenPanel1".Equals(optName))
		{
			panel1.gameObject.SetActive(value: true);
			panel2.gameObject.SetActive(value: false);
			viewModel?.SyncPanelState(isPanel1: true);
		}
		else if ("OpenPanel2".Equals(optName))
		{
			panel1.gameObject.SetActive(value: false);
			panel2.gameObject.SetActive(value: true);
			viewModel?.SyncPanelState(isPanel1: false);
			copyDetailView.gameObject.SetActive(value: false);
			PlayPanel2Ani();
			ContentConfig rankLockRank = viewModel.GetRankLockRank();
			for (int i = 0; i < contentConfigItems.Count; i++)
			{
				if (contentConfigItems[i].lockId == rankLockRank.lockId)
				{
					scrollView.normalizedPosition = new Vector2(0f, 0f);
				}
			}
		}
		else if ("ShowStoryView".Equals(optName))
		{
			if (storyView != null)
			{
				storyView.Init(viewModel.GetStoryVM());
				storyView.gameObject.SetActive(value: true);
			}
			copyDetailView.gameObject.SetActive(value: false);
		}
		else if ("CloseStoryView".Equals(optName))
		{
			storyView.gameObject.SetActive(value: false);
		}
		else if ("ShowCopyDetailView".Equals(optName))
		{
			if (copyDetailView != null)
			{
				copyDetailView.Init(viewModel.GetCopyDetailVM());
				copyDetailView.gameObject.SetActive(value: true);
			}
		}
		else if ("OnCancel".Equals(optName))
		{
			copyDetailView.gameObject.SetActive(value: false);
			storyView.gameObject.SetActive(value: false);
		}
		else if ("CheckRankLock".Equals(optName))
		{
			SettleRankLock(0);
		}
	}

	private async Task PlayPanel2Ani()
	{
		List<int> activeIndex = new List<int>();
		for (int i = 0; i < pointViewList.Count; i++)
		{
			if (pointViewList[i].gameObject.activeSelf)
			{
				activeIndex.Add(i);
			}
			pointViewList[i].gameObject.SetActive(value: false);
		}
		for (int j = 0; j < activeIndex.Count; j++)
		{
			pointViewList[activeIndex[j]].gameObject.SetActive(value: true);
			await Task.Delay(aniInterval);
		}
	}

	private async void PlayNewUnlockAni(List<int> activeIndex)
	{
		for (int i = 0; i < activeIndex.Count; i++)
		{
			pointViewList[activeIndex[i]].gameObject.SetActive(value: false);
		}
		for (int j = 0; j < activeIndex.Count; j++)
		{
			pointViewList[activeIndex[j]].gameObject.SetActive(value: true);
			await Task.Delay(aniInterval);
		}
	}

	protected async void OpenUguiWindow2(object sender, InteractionEventArgs args)
	{
		Action callback = null;
		try
		{
			callback = args.Callback;
			OpenViewArgTemp openViewArg = (OpenViewArgTemp)args.Context;
			ViewConfig? viewConfig = null;
			string path;
			if (openViewArg.Path == null)
			{
				ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
				if (viewConfigs == null || viewConfigs.Length == 0)
				{
					throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
				}
				path = viewConfigs[0].ViewPath;
				viewConfig = viewConfigs[0];
			}
			else
			{
				ViewConfig[] viewConfigs2 = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewPath.Equals(openViewArg.Path));
				if (viewConfigs2 != null && viewConfigs2.Length != 0)
				{
					viewConfig = viewConfigs2[0];
				}
				path = openViewArg.Path;
			}
			if (openViewArg.IsOpenWindow)
			{
				await CheckOpenWindow(path, openViewArg.UserData, callback, openViewArg.UiGroupName, viewConfig, openViewArg.Entrance);
			}
			else
			{
				await CheckOpenView(openViewArg.ViewName, path, openViewArg.UserData, viewConfig, openViewArg.Entrance, callback);
			}
		}
		catch (Exception ex)
		{
			callback?.Invoke();
			Log.Error("打开界面发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected override void OnDestroy()
	{
		viewModel?.OnMainWindowClosed();
		viewModel = null;
		base.OnDestroy();
	}
}
