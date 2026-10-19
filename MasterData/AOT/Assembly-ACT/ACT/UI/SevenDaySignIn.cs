using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SevenDaySignIn : ActivityCenterBaseUIView<SevendaySignInController>
{
	[Serializable]
	public class SpriteInfo
	{
		public int CharaterId;

		public Sprite Sprite;
	}

	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	public TimeAndDesItem TimeAndDesItem;

	public List<SevenDaySignInItem> SevenDaySignInItems;

	public GameObject FixedPanel;

	public Image FixedIcon;

	public Button ChangeIconButton;

	public List<SpriteInfo> SpriteInfos;

	public GamePadTipsComp GamePadTipsComp;

	private ActivitSignInInfo _activitySignInInfo;

	private int _curGamepadSelectItemIndex = -1;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private ActivityCenterData _activityCenterData;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivitySignInInfo, UpdateActivitySignInInfo);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CloseSevenDayFixedView, CloseSevenDayFixedView);
		StartCoroutine(PlayOpenAnimation());
		RefreshUI();
		InitGameTipsDic();
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
	}

	private void InitGameTipsDic()
	{
		actionDic.Clear();
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
	}

	protected override void UnInit()
	{
		StopCoroutine(PlayOpenAnimation());
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivitySignInInfo, UpdateActivitySignInInfo);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CloseSevenDayFixedView, CloseSevenDayFixedView);
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	public void OnClickChangeButtonHandle()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SEVENDAYSIGNINFIXED);
	}

	private void UpdateActivitySignInInfo(BaseEventContent baseEventContent)
	{
		RefreshUI();
	}

	private void CloseSevenDayFixedView(BaseEventContent baseEventContent)
	{
		StartCoroutine(PlayOpenAnimation());
	}

	private void RefreshUI()
	{
		int signInActivityId = Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.SevenDay);
		_activitySignInInfo = Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(signInActivityId);
		if (_activitySignInInfo != null)
		{
			_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(signInActivityId);
			TimeAndDesItem.Init(_activityCenterData, -1L);
			RefreshItem();
		}
	}

	private void RefreshItem()
	{
		for (int i = 0; i < SevenDaySignInItems.Count; i++)
		{
			SevenDaySignInItems[i].RefreshUI(i, _activityCenterData.StaticActivityData, _activitySignInInfo);
		}
	}

	private IEnumerator PlayOpenAnimation()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Open");
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").Play();
		}
		yield return null;
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		for (int i = 0; i < SevenDaySignInItems.Count; i++)
		{
			SevenDaySignInItems[i].SetGamepadSelect(active: false);
		}
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			_curGamepadSelectItemIndex = -1;
			GamePadTipsComp.ClearAllPrompts();
		}
		else
		{
			_curGamepadSelectItemIndex = GetNormalSelectItemIndex();
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
			RefreshGamepadComp();
		}
	}

	private void RefreshGamepadComp()
	{
		_tipsActions.Clear();
		GamePadTipsComp.ClearAllPrompts();
		_tipsActions.Add(actionDic["UI/Confirm"]);
		_tipsActions.Add(actionDic["UI/Back"]);
		GamePadTipsComp.RegisterInputActions(_tipsActions);
	}

	private int GetNormalSelectItemIndex()
	{
		for (int i = 0; i < SevenDaySignInItems.Count; i++)
		{
			if (SevenDaySignInItems[i].GetRewardState() == 1)
			{
				return i;
			}
		}
		for (int j = 0; j < SevenDaySignInItems.Count; j++)
		{
			if (SevenDaySignInItems[j].GetRewardState() == 0)
			{
				return j;
			}
		}
		return 0;
	}

	public void Left()
	{
		if (_curGamepadSelectItemIndex > 0)
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: false);
			_curGamepadSelectItemIndex--;
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
			RefreshGamepadComp();
		}
	}

	public void Right()
	{
		if (_curGamepadSelectItemIndex >= 0 && _curGamepadSelectItemIndex < SevenDaySignInItems.Count - 1)
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: false);
			_curGamepadSelectItemIndex++;
			SevenDaySignInItems[_curGamepadSelectItemIndex].SetGamepadSelect(active: true);
			RefreshGamepadComp();
		}
	}

	public void ButtonWest()
	{
		if (!Model<ActivityCenterModel>.Interface.GetFixedRewardIsReceive(Model<ActivityCenterModel>.Interface.GetSignInActivityId(SigninType.SevenDay)))
		{
			OnClickChangeButtonHandle();
		}
	}

	public void ButtonSouth()
	{
		if (SevenDaySignInItems[_curGamepadSelectItemIndex].GetRewardState() != 1)
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].OpenRewardDetail();
		}
		else
		{
			SevenDaySignInItems[_curGamepadSelectItemIndex].OnClickItemButtonHandle();
		}
	}

	public void RightStickPress()
	{
		TimeAndDesItem.OnClickActivityDetailButtonHandle();
	}

	public void LeftStickPress()
	{
		SevenDaySignInItems[_curGamepadSelectItemIndex].OpenRewardDetail();
	}
}
