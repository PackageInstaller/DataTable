using System;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SystemInfoViewModel : OptionBase
{
	private int _gameSettingFPS;

	private int _cacheSettingFPS;

	private int _recodeLowFPSCount;

	private int _recodeHighFPSCount;

	private ISubscription<int> _fpsSettingChanged;

	private int battlePing;

	private int battleFPS;

	private int battleTimeConfig;

	private int battleTime;

	private bool showBag = true;

	public bool reversalTime = true;

	public bool showMenuShort;

	private bool showBattlePing = true;

	private AutoFightToogleEnum autoFightToogleEnum;

	private float m_UpdateInterval;

	private float m_CurrentFps;

	private float m_Accumulator;

	private int m_Frames;

	private float m_TimeLeft;

	private SimpleCommand<string> optCmd;

	private Action<bool> OnPauseTime;

	private Action<bool> switchAutoFight;

	private Action OnTimeOver;

	private bool triggerTimeOverOnCountDownEnd = true;

	private BattleWorldMode _battleMode;

	private int _pingColorIdx;

	private bool startCountDown;

	private bool isPause = true;

	private float tempTime;

	private bool showBattleTime;

	private bool interactable;

	public bool canQuit = true;

	private int taskTime;

	private float taskTimeTemp;

	private bool showTaskTime;

	private bool showBagIcon;

	private bool haveRealPeople;

	public int PingColorIdx
	{
		get
		{
			return _pingColorIdx;
		}
		private set
		{
			Set(ref _pingColorIdx, value, "PingColorIdx");
		}
	}

	public int BattlePing
	{
		get
		{
			return battlePing;
		}
		private set
		{
			value = Mathf.Clamp(value, 0, 460);
			if (battlePing != value)
			{
				Set(ref battlePing, value, "BattlePing");
				SettlePingValue();
			}
		}
	}

	public int BattleFPS
	{
		get
		{
			return battleFPS;
		}
		private set
		{
			Set(ref battleFPS, value, "BattleFPS");
		}
	}

	public bool SettingInteractable
	{
		set
		{
			if (optCmd != null)
			{
				optCmd.Enabled = value;
			}
		}
	}

	public int BattleTime
	{
		get
		{
			return battleTime;
		}
		private set
		{
			Set(ref battleTime, value, "BattleTime");
		}
	}

	public bool StartCountDown
	{
		get
		{
			return startCountDown;
		}
		private set
		{
			Set(ref startCountDown, value, "StartCountDown");
		}
	}

	public bool ShowBattleTime
	{
		get
		{
			return showBattleTime;
		}
		set
		{
			Set(ref showBattleTime, value, "ShowBattleTime");
		}
	}

	public bool ShowBag
	{
		get
		{
			return showBag;
		}
		set
		{
			Set(ref showBag, value, "ShowBag");
		}
	}

	public bool ShowMenuShort
	{
		get
		{
			return showMenuShort;
		}
		set
		{
			Set(ref showMenuShort, value, "ShowMenuShort");
		}
	}

	public bool ShowBattlePing
	{
		get
		{
			return showBattlePing;
		}
		set
		{
			Set(ref showBattlePing, value, "ShowBattlePing");
		}
	}

	public AutoFightToogleEnum AutoFightToogleEnum
	{
		get
		{
			return autoFightToogleEnum;
		}
		set
		{
			Set(ref autoFightToogleEnum, value, "AutoFightToogleEnum");
		}
	}

	public int BattleTimeConfig => battleTimeConfig;

	public ICommand OptCmd => optCmd;

	public BattleWorldMode BattleMode => _battleMode;

	public int TaskTime
	{
		get
		{
			return taskTime;
		}
		private set
		{
			Set(ref taskTime, value, "TaskTime");
		}
	}

	public bool ShowTaskTime
	{
		get
		{
			return showTaskTime;
		}
		set
		{
			Set(ref showTaskTime, value, "ShowTaskTime");
		}
	}

	public bool ShowBagIcon
	{
		get
		{
			return showBagIcon;
		}
		set
		{
			Set(ref showBagIcon, value, "ShowBagIcon");
		}
	}

	public bool HaveRealPeople
	{
		get
		{
			return haveRealPeople;
		}
		set
		{
			Set(ref haveRealPeople, value, "HaveRealPeople");
		}
	}

	public SystemInfoViewModel()
	{
	}

	public SystemInfoViewModel(OptionBase parent, int battleTime)
	{
		base.parent = parent;
		BattleTime = battleTime;
		battleTimeConfig = battleTime;
		BattlePing = 10;
		optCmd = new SimpleCommand<string>(OnOpt);
		int intRawValue = GameSettingExtension.GetIntRawValue("帧率");
		_cacheSettingFPS = (_gameSettingFPS = (intRawValue + 1) * 30);
		_recodeLowFPSCount = 7;
		_recodeHighFPSCount = 0;
		_fpsSettingChanged?.Dispose();
		_fpsSettingChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe("GameSetting_帧率", delegate(int level)
		{
			OnFPSSettingChanged(level);
		});
	}

	private void OnFPSSettingChanged(int level)
	{
		_cacheSettingFPS = (_gameSettingFPS = (level + 1) * 30);
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		OnPauseTime = null;
		OnTimeOver = null;
		switchAutoFight = null;
		_fpsSettingChanged?.Dispose();
		_fpsSettingChanged = null;
	}

	public void FPS_Update()
	{
		m_Frames++;
		m_Accumulator += Time.unscaledDeltaTime;
		m_TimeLeft -= Time.unscaledDeltaTime;
		if (m_TimeLeft <= -1f)
		{
			int value = (int)((m_Accumulator > 0f) ? ((float)m_Frames / m_Accumulator) : 0f);
			value = Mathf.Clamp(value, 0, _cacheSettingFPS);
			BattleFPS = value;
			m_Frames = 0;
			m_Accumulator = 0f;
			m_TimeLeft = 0f;
		}
	}

	private void CheckGameFps(int currentFps)
	{
		if (_gameSettingFPS > 30)
		{
			int num = _cacheSettingFPS - currentFps;
			if (num <= 3)
			{
				_recodeHighFPSCount++;
				_recodeLowFPSCount++;
			}
			else if (num > 10)
			{
				_recodeLowFPSCount--;
				_recodeHighFPSCount--;
			}
			if (_recodeLowFPSCount < 0)
			{
				_cacheSettingFPS = 30;
				_recodeLowFPSCount = 7;
				_recodeHighFPSCount = 0;
			}
			else if (_recodeHighFPSCount >= 7)
			{
				_cacheSettingFPS = 60;
				_recodeLowFPSCount = 7;
				_recodeHighFPSCount = 0;
			}
			if (Application.targetFrameRate != _cacheSettingFPS)
			{
				Application.targetFrameRate = _cacheSettingFPS;
			}
		}
	}

	private void SettlePingValue()
	{
		int pingColorIdx = 0;
		if (battlePing >= 0 && battlePing <= 25)
		{
			pingColorIdx = 4;
		}
		else if (battlePing >= 26 && battlePing <= 50)
		{
			pingColorIdx = 3;
		}
		else if (battlePing >= 51 && battlePing <= 250)
		{
			pingColorIdx = 2;
		}
		else if (battlePing >= 251)
		{
			pingColorIdx = 1;
		}
		PingColorIdx = pingColorIdx;
	}

	public async void AddGameTime(float deltaTime)
	{
		if (!startCountDown || isPause)
		{
			return;
		}
		tempTime += deltaTime;
		if (tempTime >= 1f)
		{
			tempTime--;
			if (reversalTime)
			{
				BattleTime--;
			}
			else
			{
				BattleTime++;
			}
		}
		if (BattleTime <= 0)
		{
			isPause = true;
			if (triggerTimeOverOnCountDownEnd)
			{
				OnTimeOver();
			}
			OnPauseTime?.Invoke(obj: true);
		}
	}

	public void Reset()
	{
		BattleTime = battleTimeConfig;
	}

	public int GameOver()
	{
		return battleTime;
	}

	public void SetBattleMode(BattleWorldMode battleWorldMode)
	{
		_battleMode = battleWorldMode;
	}

	private void OnOpt(string optName)
	{
		optCmd.Enabled = false;
		if ("OpenSetting".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "OpenSetting"));
			return;
		}
		if ("OpenBag".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "OpenBag"));
			return;
		}
		if ("AutoFightClose".Equals(optName))
		{
			if (switchAutoFight != null)
			{
				switchAutoFight(obj: false);
			}
		}
		else if ("AutoFightOpen".Equals(optName))
		{
			if (switchAutoFight != null)
			{
				switchAutoFight(obj: true);
			}
		}
		else if ("AutoFightBanOpen".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "AutoFightBanOpen"));
		}
		else if ("AutoFightBanClose".Equals(optName))
		{
			parent.ItemOnClick(new OptionArg(this, "AutoFightBanClose"));
		}
		optCmd.Enabled = true;
	}

	public void EnableOpt()
	{
		optCmd.Enabled = true;
	}

	public void DisableQuit()
	{
		canQuit = false;
	}

	public void SetBattlePing(int val)
	{
		BattlePing = val;
	}

	public void SetBattleTimeConfig(int time)
	{
		battleTimeConfig = time;
		BattleTime = time;
	}

	public void SetReverseTime(bool reverse)
	{
		reversalTime = reverse;
	}

	public void SetTriggerTimeOverOnCountDownEnd(bool triggerTimeOver)
	{
		triggerTimeOverOnCountDownEnd = triggerTimeOver;
	}

	public int GetBattleTime()
	{
		return battleTimeConfig - battleTime;
	}

	public void StartGameCountDown(bool isStart, bool isRefreshTime = true)
	{
		StartCountDown = isStart;
		isPause = !isStart;
		if (isRefreshTime)
		{
			Reset();
		}
	}

	public void StopBattleTime()
	{
		StartCountDown = false;
	}

	public void AddAction(Action<bool> pauseAction, Action timeOverAction, Action<bool> clickAutoFight)
	{
		OnPauseTime = pauseAction;
		OnTimeOver = timeOverAction;
		switchAutoFight = clickAutoFight;
	}

	public void PauseTime()
	{
		isPause = !isPause;
	}

	public void ShowTime(bool isShow)
	{
		ShowBattleTime = isShow;
	}

	public void SetRealPeopel()
	{
		HaveRealPeople = true;
	}

	public void SetTaskTime(int taskTime)
	{
		TaskTime = taskTime;
	}
}
