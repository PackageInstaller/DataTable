using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using ACT.Sound;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT;

public class EscItem : MonoBehaviour
{
	public string toOpen;

	public int systemId;

	public BImage icon;

	public LocalizeStringEvent systemName;

	[SerializeReference]
	public UIViewData param;

	public RedDotItem redDotItem;

	public OperateBtnPrompt operateBtnPrompt;

	private StringBuilder _sb;

	private void OnEnable()
	{
		MonoECS instance = MonoECS.instance;
		if (!(instance == null))
		{
			instance.onInputModeChange.AddListener(OnInputModeChange);
			SetPromptIconState(instance.InputMode);
		}
	}

	private void OnDisable()
	{
		MonoECS instance = MonoECS.instance;
		if (instance != null)
		{
			instance.onInputModeChange.RemoveListener(OnInputModeChange);
		}
	}

	private void OnInputModeChange(DeviceInputMode mode)
	{
		SetPromptIconState(mode);
	}

	private void Start()
	{
		_sb = new StringBuilder();
		try
		{
			ACT.Config.SystemOpen data = CoreUtils.GetData(systemId, RuntimeConfigs.data.systemOpens);
			ApplyLocalName(data);
			ApplyIcon(data);
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
		OnStart();
	}

	protected virtual void OnStart()
	{
	}

	protected virtual void ApplyIcon(ACT.Config.SystemOpen systemData)
	{
		if ((bool)icon.icon)
		{
			this.GetImageStation().LoadImage(236, systemData.id, icon);
		}
	}

	protected virtual void ApplyLocalName(ACT.Config.SystemOpen systemData)
	{
		if ((bool)systemName)
		{
			systemName.StringReference.TableEntryReference = systemData.localNameId;
		}
	}

	protected virtual void SetPromptIconState(DeviceInputMode mode)
	{
		OperateBtnPrompt operateBtnPrompt = this.operateBtnPrompt;
		if ((object)operateBtnPrompt != null && operateBtnPrompt.ManualMode)
		{
			switch (mode)
			{
			case DeviceInputMode.TouchScreen:
				this.operateBtnPrompt?.gameObject.SetActive(value: false);
				break;
			case DeviceInputMode.KeyboardAndMouse:
				this.operateBtnPrompt?.gameObject.SetActive(value: true);
				break;
			case DeviceInputMode.Gamepad:
				this.operateBtnPrompt?.gameObject.SetActive(value: false);
				break;
			}
		}
	}

	protected virtual int GetSystemOpenEventType()
	{
		return 1;
	}

	public void OnClick()
	{
		if (Singleton<GameState>.instance.PlayerAlive != PlayerLiveState.Normal)
		{
			return;
		}
		ACT.EventTrack.SystemOpen evt = EventTrackSolver.Instance.GetEvt<ACT.EventTrack.SystemOpen>();
		evt.id = systemId;
		evt.type = GetSystemOpenEventType();
		EventTrackSolver.Instance.Dispatch(evt);
		foreach (KeyValuePair<UI_TYPE, UIData> dICT_UI_DATum in CommonUIData.DICT_UI_DATA)
		{
			if (dICT_UI_DATum.Value == null || !dICT_UI_DATum.Value.mobilePath.Equals(toOpen))
			{
				continue;
			}
			if (systemId == 1013)
			{
				if (Model<GuideModel>.Interface.IsInStrongGuide() || MonoECS.instance.playState == PlayState.UnBattle || MonoECS.instance.IsInTrainingground)
				{
					Singleton<NewUIManager>.instance.OpenUIAsync(dICT_UI_DATum.Key, new TeamViewData
					{
						source = (MonoECS.instance.IsInTrainingground ? TeamProfileSource.Traininground : TeamProfileSource.World)
					}, isneedinqueue: false);
				}
				else
				{
					GameUtility.OpenToolTip(479);
				}
			}
			else if (systemId == 1044)
			{
				if (Model<BattlePassModel>.Interface.AvailAble)
				{
					Singleton<NewUIManager>.instance.OpenUIAsync(dICT_UI_DATum.Key, param, isneedinqueue: false);
				}
			}
			else
			{
				if (toOpen == "UI/IntegratedExploringView")
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Common_Entrance_Click", new AudioPlayOptions
					{
						attachTarget = Camera.main.transform
					});
				}
				Singleton<NewUIManager>.instance.OpenUIAsync(dICT_UI_DATum.Key, param, isneedinqueue: false);
			}
			GameUtility.SendFinshStepGuideEvent((GuideConsts.GuideType)systemId);
		}
	}

	public void RefreshRedDot(int systemId, bool systemOpenDotActive)
	{
		if (redDotItem == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("检查红点组件是否赋值");
			}
			return;
		}
		RedDotType redDotType;
		if (systemId != 1044)
		{
			redDotType = (systemOpenDotActive ? RedDotType.SystemNew : RedDotType.Dot);
		}
		else
		{
			redDotType = (systemOpenDotActive ? RedDotType.SystemNew : (Model<BattlePassModel>.Interface.NewRedDotExist ? RedDotType.New : RedDotType.Dot));
		}
		redDotItem.displayAction = (systemOpenDotActive ? ((RedDotDisplayAction)new CurSystemUnLockDotActive
		{
			isActive = true
		}) : ((RedDotDisplayAction)new SelfNodeActive()));
		redDotItem.redDotType = redDotType;
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}
}
