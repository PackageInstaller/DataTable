using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class StartupWindow : UGuiWindow
{
	public Button loginBtn;

	public Button enterGameBtn;

	public Button btnLogout;

	public Button btnAnnouncement;

	public GameObject loggedInTag;

	public TextMeshProUGUI version;

	[SerializeField]
	private GameObject customerSerGo;

	[SerializeField]
	private Button customerSerBtn;

	[SerializeField]
	private Button repairBtn;

	[SerializeField]
	private Button preServerBtn;

	[SerializeField]
	private Button btnAge;

	[SerializeField]
	private Button btnAgeClose;

	[SerializeField]
	private GameObject ageGo;

	[SerializeField]
	private Button btnProtoWeb;

	[SerializeField]
	private GameObject spineBg;

	[SerializeField]
	private GameObject videoBg;

	[SerializeField]
	private GameObject blackMask;

	[SerializeField]
	private VideoPlayer videoPlayer;

	private StartupViewModel viewModel;

	private bool videoError;

	private bool videoPrepared;

	private float videoPrepareTimeout = 5f;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<StartupViewModel>();
		BindingSet<StartupWindow, StartupViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((StartupWindow v) => v.OpenUguiWindow).To((StartupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((StartupWindow v) => v.OnDismissRequest).To((StartupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(loginBtn).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.LoginCommand)
			.OneWay();
		bindingSet.Bind(loginBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((StartupViewModel vm) => !vm.IsLogin);
		bindingSet.Bind(blackMask.gameObject).For((GameObject v) => v.activeSelf).To((StartupViewModel vm) => vm.EnterGameShowMask);
		bindingSet.Bind(enterGameBtn).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.EnterGameCommand);
		bindingSet.Bind(enterGameBtn.gameObject).For((GameObject v) => v.activeSelf).To((StartupViewModel vm) => vm.IsLogin);
		bindingSet.Bind(btnLogout.gameObject).For((GameObject v) => v.activeSelf).To((StartupViewModel vm) => vm.IsLogin);
		bindingSet.Bind(btnLogout).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.Logout);
		bindingSet.Bind(btnAnnouncement).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.OpenAnnouncementCmd);
		bindingSet.Bind<TextMeshProUGUI>(version).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StartupViewModel vm) => vm.VersionInfo);
		bindingSet.Bind(repairBtn).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.RepairCmd);
		bindingSet.Bind(btnProtoWeb).For((Button v) => v.onClick).To((StartupViewModel vm) => vm.OpenProtoWebCmd);
		bindingSet.Bind(preServerBtn.gameObject).For((GameObject v) => v.activeSelf).To((StartupViewModel vm) => vm.ShowPreServerBtn);
		bindingSet.Build();
		btnAge.onClick.AddListener(delegate
		{
			ageGo.SetActive(value: true);
		});
		btnAgeClose.onClick.AddListener(delegate
		{
			ageGo.SetActive(value: false);
		});
		preServerBtn.onClick.AddListener(delegate
		{
			GameEntry.BuiltinData.SetPreServiceStatus(!GameEntry.BuiltinData.PreServiceStatus);
		});
		loggedInTag.SetActive(value: true);
		bool flag = Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.IfShowCustomerServiceBtn() ?? false;
		customerSerGo.SetActive(flag);
		if (flag)
		{
			customerSerBtn.onClick.AddListener(OnCustomerSerBtnClick);
		}
	}

	private async UniTask ShowStartup()
	{
		spineBg.SetActive(!GameEntry.BuiltinData.LoginVideo);
		videoBg.SetActive(GameEntry.BuiltinData.LoginVideo);
		((Component)(object)videoPlayer).gameObject.SetActive(GameEntry.BuiltinData.LoginVideo);
		if (GameEntry.BuiltinData.LoginVideo)
		{
			videoError = false;
			videoPrepared = false;
			videoPlayer.playOnAwake = false;
			videoPlayer.isLooping = true;
			videoPlayer.prepareCompleted += new EventHandler(OnVideoPrepared);
			videoPlayer.errorReceived += new ErrorEventHandler(OnVideoError);
			videoPlayer.Prepare();
			float time = 0f;
			while (!videoError && !videoPrepared && time < videoPrepareTimeout)
			{
				time += Time.deltaTime;
				await UniTask.Yield();
			}
			if (videoError || time >= videoPrepareTimeout)
			{
				spineBg.SetActive(value: true);
				videoBg.SetActive(value: false);
				((Component)(object)videoPlayer).gameObject.SetActive(value: false);
			}
			else
			{
				videoPlayer.Play();
			}
		}
	}

	private void OnVideoError(VideoPlayer source, string message)
	{
		videoError = true;
	}

	private void OnVideoPrepared(VideoPlayer source)
	{
		videoPrepared = true;
	}

	private void OnCustomerSerBtnClick()
	{
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.CustomerSer();
	}

	protected override async void OnShow()
	{
		viewModel.StartUp();
		await UniTask.WaitUntil(() => base.isActiveAndEnabled);
		await ShowStartup();
		await Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().RequestNoticeData();
		await StreamerMode.Initialized();
		viewModel.ShowLogin();
	}

	public override bool CloseInversion()
	{
		if (viewModel != null && !viewModel.IsCloseView)
		{
			viewModel.Close();
			return true;
		}
		return base.CloseInversion();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		Resources.UnloadUnusedAssets();
	}
}
