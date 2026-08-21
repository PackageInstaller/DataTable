using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildInfoView : UGuiView
{
	[SerializeField]
	private Image flagIcon;

	[SerializeField]
	private Button btnChangeFlagIcon;

	[SerializeField]
	private Button btnOpenReport;

	[SerializeField]
	private Text guildName;

	[SerializeField]
	private Button btnChangeGuildName;

	[SerializeField]
	private TextMeshProUGUI guildLevel;

	[SerializeField]
	private InputField inputChangeDesc;

	[SerializeField]
	private Text masterName;

	[SerializeField]
	private TextMeshProUGUI memberCount;

	[SerializeField]
	private TextMeshProUGUI activityPoint;

	[SerializeField]
	private TextMeshProUGUI fund;

	[SerializeField]
	private TextMeshProUGUI uid;

	[SerializeField]
	private TextMeshProUGUI buffName;

	[SerializeField]
	private Button btnBuffDetail;

	[SerializeField]
	private int eventDisplayCount;

	[SerializeField]
	private GuildEventMsgItem eventMsgItemTpl;

	[SerializeField]
	private RectTransform eventMsgRoot;

	[SerializeField]
	private Button btnOpenRank;

	[SerializeField]
	private Button btnOpenBuild;

	[SerializeField]
	private GameObject tipsMask;

	[SerializeField]
	private Button btnCloseTipsMask;

	[SerializeField]
	private TextMeshProUGUI buffDetail;

	private GameObjectPool eventMsgItemPool;

	private GuildInfoViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildInfoViewModel>(userData);
		eventMsgItemPool = new GameObjectPool(eventMsgItemTpl.gameObject, eventMsgRoot);
		BindingSet<GuildInfoView, GuildInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(flagIcon).For((Image v) => v.sprite).To((GuildInfoViewModel vm) => vm.FlagIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(guildName).For((Text v) => v.text).To((GuildInfoViewModel vm) => vm.GuildName);
		bindingSet.Bind<TextMeshProUGUI>(guildLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.GuildLevel);
		bindingSet.Bind(masterName).For((Text v) => v.text).To((GuildInfoViewModel vm) => vm.MasterName);
		bindingSet.Bind<TextMeshProUGUI>(memberCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.MemberCount);
		bindingSet.Bind<TextMeshProUGUI>(activityPoint).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.ActivePoint);
		bindingSet.Bind<TextMeshProUGUI>(fund).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.Fund);
		bindingSet.Bind<TextMeshProUGUI>(uid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.Uid);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.BuffName);
		bindingSet.Bind<TextMeshProUGUI>(buffDetail).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildInfoViewModel vm) => vm.BuffDetail);
		bindingSet.Bind(btnOpenReport).For((Button v) => v.onClick).To((GuildInfoViewModel vm) => vm.OpenReportCmd)
			.CommandParameter(btnOpenReport.transform.position);
		bindingSet.Bind(btnChangeFlagIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildInfoViewModel vm) => GuildDefinition.CheckGuildMemberPermission(vm.MyPosition, GuildDefinition.GuildPermissions.GuildInfoChange));
		bindingSet.Bind(btnChangeGuildName.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildInfoViewModel vm) => GuildDefinition.CheckGuildMemberPermission(vm.MyPosition, GuildDefinition.GuildPermissions.GuildInfoChange));
		bindingSet.Bind(btnChangeFlagIcon).For((Button v) => v.onClick).To((GuildInfoViewModel vm) => vm.OpenFlagChangeCmd);
		bindingSet.Bind(btnChangeGuildName).For((Button v) => v.onClick).To((GuildInfoViewModel vm) => vm.OpenNameChangeCmd);
		bindingSet.Bind(btnOpenRank).For((Button v) => v.onClick).To((GuildInfoViewModel vm) => vm.OpenRankCmd);
		bindingSet.Bind(btnOpenBuild).For((Button v) => v.onClick).To((GuildInfoViewModel vm) => vm.OpenBuildCmd);
		bindingSet.Bind(btnOpenBuild.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildInfoViewModel vm) => GuildDefinition.CheckGuildMemberPermission(vm.MyPosition, GuildDefinition.GuildPermissions.GuildBuild));
		bindingSet.Bind(inputChangeDesc).For((InputField v) => v.enabled).ToExpression((GuildInfoViewModel vm) => GuildDefinition.CheckGuildMemberPermission(vm.MyPosition, GuildDefinition.GuildPermissions.DescriptionChange));
		bindingSet.Bind().For((GuildInfoView v) => v.RefreshGuildEventMsgItems).To((GuildInfoViewModel vm) => vm.OnEventMsgChanged);
		bindingSet.Build();
		inputChangeDesc.text = _viewModel.GuildDescription;
		inputChangeDesc.onEndEdit.AddListener(OnInputFieldEndEdit);
		btnBuffDetail.onClick.AddListener(OpenTipsMask);
		btnCloseTipsMask.onClick.AddListener(CloseTipsMask);
		RefreshGuildEventMsgItems();
		btnOpenBuild.GetComponent<UIRedPoint>()?.Dispose();
		btnOpenBuild.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildBuild).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildCanBuild)
			.Invoke();
	}

	private async void OnInputFieldEndEdit(string content)
	{
		if (!content.Equals(_viewModel.GuildDescription))
		{
			if (!_viewModel.ChangeDescEnabled)
			{
				Toast.ShowInfo("请稍后再试");
				inputChangeDesc.text = _viewModel.GuildDescription;
			}
			else if (!GuildDefinition.GuildDescValidityChecking(content))
			{
				Toast.ShowInfo("宗旨不可用");
				inputChangeDesc.text = _viewModel.GuildDescription;
			}
			else
			{
				await _viewModel.TryChangeGuildDesc(content);
				inputChangeDesc.text = _viewModel.GuildDescription;
			}
		}
	}

	private void RefreshGuildEventMsgItems(object sender = null, InteractionEventArgs e = null)
	{
		eventMsgItemPool.RecycleAll();
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		if (myGuildData == null || myGuildData.EventMsgDatas == null || myGuildData.EventMsgDatas.Count <= 0)
		{
			return;
		}
		int count = myGuildData.EventMsgDatas.Count;
		int num = Math.Min(count, eventDisplayCount);
		for (int i = 0; i < num; i++)
		{
			GameObject obj = eventMsgItemPool.Allocate(out var newCreate);
			GuildEventMsgItem component = obj.GetComponent<GuildEventMsgItem>();
			GuildEventMsgItemData guildEventMsgItemData = new GuildEventMsgItemData(_viewModel, myGuildData.EventMsgDatas[count - 1 - i]);
			if (newCreate)
			{
				component.Init(guildEventMsgItemData);
			}
			else
			{
				component.SetDataContext(guildEventMsgItemData);
			}
			obj.transform.SetSiblingIndex(i);
			obj.SetActive(value: true);
		}
	}

	private void OpenTipsMask()
	{
		tipsMask.gameObject.SetActive(value: true);
	}

	private void CloseTipsMask()
	{
		tipsMask.gameObject.SetActive(value: false);
	}

	protected override void OnDestroy()
	{
		eventMsgItemPool?.Dispose();
		eventMsgItemPool = null;
		base.OnDestroy();
	}
}
