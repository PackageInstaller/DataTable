#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HomeComeWindowViewModel : OptionBase
{
	private const int ReturnDurationDays = 14;

	private readonly string[] tabNames = new string[3] { "福利汇总", "签到奖励", "阶段任务" };

	private readonly bool[] tabRedState = new bool[3];

	private readonly InteractionRequest refreshRequest = new InteractionRequest();

	private IHomeComeService service;

	private ISubscription<HomeComeMessage> subscription_HomeComeMessage;

	private bool initialized;

	private bool autoPopupTried;

	private int selectedTabIndex;

	private string leftTimeText = string.Empty;

	private readonly bool requestInfoOnInitialize = true;

	private bool popupOpening;

	public int TabCount => tabNames.Length;

	public int SelectedTabIndex => selectedTabIndex;

	public IInteractionRequest RefreshRequest => refreshRequest;

	public string LeftTimeText
	{
		get
		{
			return leftTimeText;
		}
		private set
		{
			Set(ref leftTimeText, value, "LeftTimeText");
		}
	}

	public HomeComeWindowViewModel()
	{
	}

	public HomeComeWindowViewModel(OptionBase parent, bool requestOnInitialize, int defaultTab = 0)
	{
		base.parent = parent;
		requestInfoOnInitialize = requestOnInitialize;
		selectedTabIndex = Mathf.Clamp(defaultTab, 0, TabCount - 1);
	}

	public string GetTabName(int index)
	{
		if (index < 0 || index >= tabNames.Length)
		{
			return string.Empty;
		}
		return tabNames[index];
	}

	public bool GetTabRed(int index)
	{
		if (index < 0 || index >= tabRedState.Length)
		{
			return false;
		}
		return tabRedState[index];
	}

	public HomeComeData GetData()
	{
		return service?.GetData();
	}

	public void SelectTab(int index)
	{
		int num = Mathf.Clamp(index, 0, TabCount - 1);
		if (num != selectedTabIndex)
		{
			selectedTabIndex = num;
			refreshRequest.Raise();
		}
	}

	public async void Initialize()
	{
		if (initialized)
		{
			return;
		}
		initialized = true;
		service = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
		if (service == null)
		{
			Log.Error("HomeComeWindowViewModel 初始化失败：IHomeComeService 未注册。");
			refreshRequest.Raise();
			return;
		}
		subscription_HomeComeMessage = service.GetMessager()?.Subscribe<HomeComeMessage>(OnHomeComeMessage);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddNormalSecondUpdateAction(OnSecondTick);
		if (requestInfoOnInitialize)
		{
			await service.GetHomeComeInfoRst();
		}
		RefreshAllState();
	}

	private void OnHomeComeMessage(HomeComeMessage message)
	{
		RefreshAllState();
	}

	private void OnSecondTick(long serverTime)
	{
		UpdateLeftTime(serverTime);
	}

	private void RefreshAllState()
	{
		tabRedState[0] = service?.HasGiftRedPoint() ?? false;
		tabRedState[1] = service?.HasSignRedPoint() ?? false;
		tabRedState[2] = service?.HasTaskRedPoint() ?? false;
		long serverTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		UpdateLeftTime(serverTime);
		refreshRequest.Raise();
		TryOpenGiftPopupIfNeeded();
	}

	private void TryOpenGiftPopupIfNeeded()
	{
		if (autoPopupTried || popupOpening)
		{
			return;
		}
		HomeComeData homeComeData = service?.GetData();
		if (homeComeData != null && homeComeData.IsInReturn && !homeComeData.GiftClaimed)
		{
			autoPopupTried = true;
			popupOpening = true;
			HomeComePopupWindowViewModel userData = new HomeComePopupWindowViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(HomeComePopupWindow), userData), delegate
			{
				popupOpening = false;
			});
		}
	}

	private void UpdateLeftTime(long serverTime)
	{
		string text = BuildLeftTimeText(serverTime);
		if (text != LeftTimeText)
		{
			LeftTimeText = text;
		}
	}

	private string BuildLeftTimeText(long serverTime)
	{
		HomeComeData homeComeData = service?.GetData();
		if (homeComeData == null || !homeComeData.IsInReturn)
		{
			return "活动未开启";
		}
		if (serverTime <= 0)
		{
			serverTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		}
		long leftSeconds = homeComeData.GetLeftSeconds(serverTime, 14);
		if (leftSeconds <= 0)
		{
			return "活动已结束";
		}
		return "剩余" + Utility.DateTime.GetLeftDateTime(leftSeconds, "dd\\天hh\\时");
	}

	public override void Dispose()
	{
		subscription_HomeComeMessage?.Dispose();
		subscription_HomeComeMessage = null;
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveNormalSecondUpdateAction(OnSecondTick);
		initialized = false;
		autoPopupTried = false;
		service = null;
		base.Dispose();
	}
}
