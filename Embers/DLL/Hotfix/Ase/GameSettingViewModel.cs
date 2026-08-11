using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class GameSettingViewModel : OptionBase
{
	private BattleWorldMode battleWorldMode;

	private bool inBattle;

	private bool isInCaves;

	private bool saveEnable = true;

	private bool showResetButton = true;

	private bool showFuncBtn;

	private bool hideQuitBtn;

	private string exitBattleBtnText;

	private int curTab = -1;

	private int skillIndex;

	private int statusIndex;

	private int graphicsIndex;

	private int audioIndex;

	private int keySettingIndex;

	private int battleIndex;

	private int otherIndex;

	private bool isCampaignWorldBoss;

	private KeySettingViewModel _keySettingViewModel;

	private SkillSettingViewModel settingViewModel;

	private StatusSettingViewModel statusViewModel;

	private TeachingManualViewModel manualViewModel;

	private Dictionary<string, GameSettingItemViewModel> settingViewModels = new Dictionary<string, GameSettingItemViewModel>();

	private List<string> realTimeWorkList = new List<string> { "主声音", "音乐音量", "音效音量", "语音音量" };

	private SimpleCommand<string> funcCmd;

	private string TDA_entrance = "";

	private string versionInfo;

	private bool openCodeExchangeEnable = true;

	public bool ShowResetButton
	{
		get
		{
			return showResetButton;
		}
		set
		{
			Set(ref showResetButton, value, "ShowResetButton");
		}
	}

	public bool ShowFuncBtn
	{
		get
		{
			return showFuncBtn;
		}
		set
		{
			Set(ref showFuncBtn, value, "ShowFuncBtn");
		}
	}

	public string ExitBattleBtnText
	{
		get
		{
			return exitBattleBtnText;
		}
		set
		{
			Set(ref exitBattleBtnText, value, "ExitBattleBtnText");
		}
	}

	public bool IsInCaves
	{
		get
		{
			return isInCaves;
		}
		set
		{
			Set(ref isInCaves, value, "IsInCaves");
		}
	}

	public string VersionInfo
	{
		get
		{
			return versionInfo;
		}
		set
		{
			Set(ref versionInfo, value, "VersionInfo");
		}
	}

	public bool InBattle => inBattle;

	public BattleWorldMode BattleWorldMode => battleWorldMode;

	public SkillSettingViewModel SettingViewModel => settingViewModel;

	public StatusSettingViewModel StatusViewModel => statusViewModel;

	public TeachingManualViewModel ManualViewModel => manualViewModel;

	public KeySettingViewModel KeySettingViewModel => _keySettingViewModel;

	public Dictionary<string, GameSettingItemViewModel> SettingViewModels => settingViewModels;

	public SimpleCommand<string> FuncCmd => funcCmd;

	public GameSettingViewModel()
	{
		InitRawSettings();
		VersionInfo = GameEntry.Setting.GetString("版本信息");
	}

	public GameSettingViewModel(OptionBase parent, string tdaEntrance)
	{
		base.parent = parent;
		TDA_entrance = tdaEntrance;
		InitRawSettings();
		VersionInfo = GameEntry.Setting.GetString("版本信息");
	}

	public GameSettingViewModel(OptionBase parent, string tdaEntrance, bool inBattle = false, BattleWorldMode battleWorldMode = BattleWorldMode.GameBack, bool isInCaves = false, bool hideQuitBtn = false, bool isCampaignWorldBoss = false)
	{
		base.parent = parent;
		TDA_entrance = tdaEntrance;
		this.inBattle = inBattle;
		this.battleWorldMode = battleWorldMode;
		this.hideQuitBtn = hideQuitBtn;
		IsInCaves = isInCaves;
		ShowResetButton = !inBattle;
		this.isCampaignWorldBoss = isCampaignWorldBoss;
		switch (battleWorldMode)
		{
		case BattleWorldMode.SingleBattle:
		case BattleWorldMode.SyncBattle:
			ExitBattleBtnText = "退出副本";
			break;
		case BattleWorldMode.LevelBattle:
			ExitBattleBtnText = "退出关卡";
			break;
		}
		funcCmd = new SimpleCommand<string>(FuncConfirm);
		manualViewModel = new TeachingManualViewModel(this, showSearch: false);
		InitManualDatas();
		InitRawSettings();
	}

	private void InitRawSettings()
	{
		_keySettingViewModel = new KeySettingViewModel(this, inBattle);
		foreach (KeyValuePair<string, GameSettingConfigHelper.SettingData> setting in GameSettingConfigHelper.Settings)
		{
			bool workWhenChanged = realTimeWorkList.Contains(setting.Key);
			settingViewModels.Add(setting.Key, new GameSettingItemViewModel(this, setting.Value, inBattle, workWhenChanged));
		}
	}

	private void InitManualDatas()
	{
		DRManual[] array = new DRManual[0];
		if (battleWorldMode == BattleWorldMode.LevelBattle)
		{
			array = GameEntry.DataTable.GetDataRows((DRManual p) => p.Type == 2 || p.Type == 1);
		}
		else if (battleWorldMode == BattleWorldMode.SingleBattle || battleWorldMode == BattleWorldMode.SyncBattle)
		{
			array = GameEntry.DataTable.GetDataRows((DRManual p) => p.Type == 1);
		}
		List<TeachingPoint> list = new List<TeachingPoint>();
		if (array != null)
		{
			DRManual[] array2 = array;
			foreach (DRManual drManual in array2)
			{
				if (TeachingDefinition.GetTeachingPointOpenState(drManual))
				{
					list.Add(new TeachingPoint(drManual));
				}
			}
		}
		manualViewModel.RefreshData(list);
	}

	public void InitIndex(int skill, int status, int graphics, int audio, int keySetting, int battle, int other)
	{
		skillIndex = skill;
		statusIndex = status;
		graphicsIndex = graphics;
		audioIndex = audio;
		keySettingIndex = keySetting;
		battleIndex = battle;
		otherIndex = other;
	}

	public void ChangeTab(int newTab)
	{
		curTab = newTab;
		if (!inBattle)
		{
			ShowResetButton = newTab == graphicsIndex || newTab == battleIndex;
		}
		ShowFuncBtn = inBattle && (newTab == skillIndex || newTab == statusIndex) && !hideQuitBtn;
	}

	public void GamePause()
	{
		Singleton<AudioSystem>.Instance.SetHostingAudioPause(pause: true);
		parent.ItemOnClick(ProcessOperationEnum.GamePause);
	}

	public override void Close()
	{
		Singleton<AudioSystem>.Instance.SetHostingAudioPause(pause: false);
		parent.ItemOnClick(ProcessOperationEnum.GameResume);
		base.Close();
	}

	public void TryReset2Default()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否将当前页恢复成默认配置", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				ResetAll2Default();
			}
		});
	}

	private async void ResetAll2Default()
	{
		List<string> list = new List<string>();
		if (curTab == graphicsIndex)
		{
			if (!settingViewModels.TryGetValue("画质预设", out var value))
			{
				return;
			}
			value.SetDefault();
			if ((int)value.Value != 3)
			{
				ApplyGraphicsData((int)value.Value);
				await Save();
				Toast.ShowInfo("已恢复默认设置");
				return;
			}
			list = GameSettingConfigHelper.SettingEnum[SettingTypeEnum.GraphicsSetting];
		}
		if (curTab == keySettingIndex)
		{
			list = GameSettingConfigHelper.SettingEnum[SettingTypeEnum.KeySetting];
		}
		else if (curTab == battleIndex)
		{
			list = GameSettingConfigHelper.SettingEnum[SettingTypeEnum.CombatSetting];
		}
		if (list.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<string, GameSettingItemViewModel> settingViewModel in settingViewModels)
		{
			if (!(settingViewModel.Key == "画质预设") && list.Contains(settingViewModel.Key))
			{
				settingViewModel.Value.SetDefault();
			}
		}
		await Save();
		Toast.ShowInfo("已恢复默认设置");
	}

	public override async void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: GameSettingItemViewModel obj2 } optionArg)
		{
			if (optionArg.OptionName.Equals("Save"))
			{
				await TrySave(obj2);
			}
			else if (optionArg.OptionName.Equals("Change"))
			{
				OnSettingChanged(obj2);
			}
		}
	}

	private async Task<bool> TrySave(GameSettingItemViewModel itemVm)
	{
		OnSettingChanged(itemVm);
		Save(itemVm);
		AddSettingChangeTDA(itemVm);
		return true;
	}

	private async Task Save()
	{
		Loading loading = await Loading.Show();
		foreach (GameSettingItemViewModel value in settingViewModels.Values)
		{
			Save(value);
		}
		loading?.Dispose();
	}

	private void Save(GameSettingItemViewModel itemVm)
	{
		if (saveEnable)
		{
			saveEnable = false;
			itemVm.Save();
			bool flag = true;
			try
			{
				GameEntry.Setting.Save();
			}
			catch
			{
				flag = false;
			}
			if (flag)
			{
				itemVm.ClearCache();
			}
			saveEnable = true;
		}
	}

	private void OnSettingChanged(GameSettingItemViewModel itemVm)
	{
		if (GameSettingConfigHelper.SettingEnum[SettingTypeEnum.GraphicsSetting].Contains(itemVm.Name))
		{
			if (itemVm.Name.Equals("画质预设"))
			{
				ApplyGraphicsData((int)itemVm.Value);
			}
			else if (!settingViewModels["画质预设"].Value.Equals(3f))
			{
				settingViewModels["画质预设"].Value = 3f;
				Save(settingViewModels["画质预设"]);
			}
		}
	}

	private void ApplyGraphicsData(int graphicsLevel)
	{
		if (graphicsLevel != 3)
		{
			GraphicsData graphicsSettingScheme = GraphicsSetting.GetGraphicsSettingScheme(graphicsLevel + 1);
			settingViewModels["帧率"].SetValueByGraphicData(graphicsSettingScheme.FrameRataLock);
			settingViewModels["渲染精度"].SetValueByGraphicData(graphicsSettingScheme.RenderAccuracy);
			settingViewModels["阴影"].SetValueByGraphicData(graphicsSettingScheme.Shadow);
			settingViewModels["特效等级"].SetValueByGraphicData(graphicsSettingScheme.EffectLevel);
			settingViewModels["抗锯齿"].SetValueByGraphicData(graphicsSettingScheme.AntiAliasing);
			settingViewModels["HDR"].SetValueByGraphicData(graphicsSettingScheme.HDR ? 1 : 0);
			settingViewModels["Bloom"].SetValueByGraphicData(graphicsSettingScheme.Bloom ? 1 : 0);
			settingViewModels["暗角"].SetValueByGraphicData(graphicsSettingScheme.Vignette ? 1 : 0);
			settingViewModels["分辨率"].SetValueByGraphicData(graphicsSettingScheme.Resolution);
			Save();
		}
	}

	public void LogoutConfirm()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否退出当前帐号?", "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				Logout();
				Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Logout();
			}
		});
	}

	public void OpenCodeExchangeWindow()
	{
		if (!openCodeExchangeEnable)
		{
			return;
		}
		openCodeExchangeEnable = false;
		InputConfirmViewModel vm = new InputConfirmViewModel(this);
		vm.Title = "兑换码";
		vm.PlaceholderText = "请输入兑换码";
		vm.CharacterLimit = 13;
		vm.ShowPasteBtn = true;
		vm.SetConfirmCallback(delegate(string content)
		{
			if (string.IsNullOrEmpty(content))
			{
				Toast.ShowInfo("兑换码不能为空");
			}
			else if (!CodeExchangeValidCheck(content))
			{
				Toast.ShowInfo("兑换码错误");
			}
			else
			{
				TryUseCodeExchange(content);
				vm.Close();
			}
		});
		openWindowRequest.Raise(new OpenViewArg(typeof(InputConfirmWindow), vm, "GameSetting"), delegate
		{
			openCodeExchangeEnable = true;
		});
	}

	private bool CodeExchangeValidCheck(string code)
	{
		if (code.Length < 3 || code.Length > 13)
		{
			return false;
		}
		return true;
	}

	private async void TryUseCodeExchange(string content)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().RequestUseExchangeCode(content);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("兑换成功，奖励已发送至邮件");
		}
	}

	private void FuncConfirm(string arg)
	{
		funcCmd.Enabled = false;
		if (arg.Equals("ExitBattle"))
		{
			ExitBattleConfirm();
		}
		else if (arg.Equals("ExitCaves"))
		{
			ExitCaveConfirm();
		}
	}

	private void ExitBattleConfirm()
	{
		string message = "";
		if (isCampaignWorldBoss)
		{
			message = "中途退出本任务，会导致团队挑战失败，是否退出？";
		}
		else if (battleWorldMode == BattleWorldMode.SingleBattle || battleWorldMode == BattleWorldMode.SyncBattle)
		{
			message = "是否确认退出副本";
		}
		else if (battleWorldMode == BattleWorldMode.LevelBattle)
		{
			message = "是否确认退出关卡";
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", message, "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				switch (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess())
				{
				case GameProcessType.Battle:
				case GameProcessType.Monster:
					ExitCopy();
					break;
				case GameProcessType.Story:
					ExitStory();
					break;
				}
			}
			else if (result.Result == -2)
			{
				funcCmd.Enabled = true;
			}
		});
	}

	private void ExitCaveConfirm()
	{
		if (!IsInCaves)
		{
			funcCmd.Enabled = true;
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否确认离开洞穴", "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				ExitCave();
			}
			else if (result.Result == -2)
			{
				funcCmd.Enabled = true;
			}
		});
	}

	private void ExitCopy()
	{
		parent.ItemOnClick(ProcessOperationEnum.GameOver);
	}

	private void ExitStory()
	{
		if (battleWorldMode == BattleWorldMode.LevelBattle && !Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
		{
			Toast.ShowInfo("前期剧情体验中，无法退出");
			funcCmd.Enabled = true;
		}
		else
		{
			parent.ItemOnClick(ProcessOperationEnum.GameOver);
		}
	}

	private void ExitCave()
	{
		if (battleWorldMode == BattleWorldMode.LevelBattle && !Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
		{
			Toast.ShowInfo("当前无法逃离！");
			funcCmd.Enabled = true;
		}
		else
		{
			parent.ItemOnClick(ProcessOperationEnum.GameResume);
			parent.ItemOnClick(new OptionArg(this, "Revert"));
			Close();
		}
	}

	private async void Logout()
	{
		parent?.ItemOnClick("Logout");
		Close();
	}

	public void AddHero(List<HeroSkinBind> heros)
	{
		if (heros != null && heros.Count != 0 && settingViewModel == null)
		{
			settingViewModel = new SkillSettingViewModel(this, heros);
		}
	}

	public void AddStatusHeroes(List<StatusSettingViewModel.StatusHeroSnapshot> heroes, Dictionary<int, StatusSettingViewModel.StatusBattleSnapshot> battleDataMap, bool enableRealtimeBuff = false)
	{
		if (heroes != null && heroes.Count != 0)
		{
			if (statusViewModel == null)
			{
				statusViewModel = new StatusSettingViewModel(this);
			}
			statusViewModel.SetRealtimeBuffEnabled(enableRealtimeBuff);
			statusViewModel.SetHeroes(heroes, battleDataMap);
		}
	}

	private void AddSettingChangeTDA(GameSettingItemViewModel itemVm)
	{
		string value = "";
		if (curTab == graphicsIndex)
		{
			value = "画面设置";
		}
		else if (curTab == audioIndex)
		{
			value = "声音设置";
		}
		if (curTab == battleIndex)
		{
			value = "战斗设置";
		}
		if (curTab == otherIndex)
		{
			value = "其他设置";
		}
		float floatRawValue = GameSettingExtension.GetFloatRawValue(itemVm.Name);
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("name", itemVm.Name);
		dictionary.Add("val", floatRawValue.ToString());
		List<Dictionary<string, object>> list = CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Get();
		list.Add(dictionary);
		Dictionary<string, object> dictionary2 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary2.Add("entrance", TDA_entrance);
		dictionary2.Add("setting_name", value);
		dictionary2.Add("setting_detail", list);
		TDAHandler.Instance.SendUserEvent("setting_set", dictionary2);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
		list.Clear();
		CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Release(list);
		dictionary2.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary2);
	}
}
