using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler, ISelectHandler, IDeselectHandler
{
	[SerializeField]
	private LocalizeStringEvent stageName;

	[SerializeField]
	private TextMeshProUGUI txtProgress;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private Button btnGift;

	[SerializeField]
	private Button btnGo;

	[SerializeField]
	private GameObject btnComplete;

	[SerializeField]
	private RectTransform rewardRoot;

	[SerializeField]
	private GameObject rewardPrefab;

	[SerializeField]
	private BetterAnimation betterAnimation;

	public ViewControlLayer ViewControlLayer;

	public List<GameObject> Prompts;

	private ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState _state;

	private List<ItemUIComponentBase> _itemRewardList = new List<ItemUIComponentBase>();

	private ActivityExploreChallengeModel.ChallengeInfo _info;

	private CancellationTokenSource _cts;

	private int _index;

	public Action OnGiftCallBack;

	public void SetState(ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState state)
	{
		_state = state;
		btnGo.gameObject.SetActive(value: false);
		btnGift.gameObject.SetActive(value: false);
		btnComplete.SetActive(value: false);
		switch (_state)
		{
		case ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState.UnCompleted:
			btnGo.gameObject.SetActive(value: true);
			break;
		case ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState.Completed:
			btnGift.gameObject.SetActive(value: true);
			break;
		case ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState.Received:
			btnComplete.SetActive(value: true);
			break;
		}
	}

	private void OnGift()
	{
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = 1005;
		evt.status = 3;
		evt.challengeGroupId = _info.GroupId;
		ActivityChallengeGroup data = CoreUtils.GetData(_info.GroupId, RuntimeConfigs.data.activityChallengeGroups);
		evt.challengeId = data.challengeId[_index];
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
		G.service.SendActivityCombinationReward(1005, _info.GroupId, (bool success, ActivityCombinationRewardAck ack) =>
		{
			if (success && ack != null)
			{
				List<Item> list = new List<Item>();
				foreach (Item item in ack.Items)
				{
					list.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
				if (OnGiftCallBack != null)
				{
					OnGiftCallBack();
				}
				GameUtility.RefreshExploreChallengeRedDot();
			}
		});
	}

	private void OnGo()
	{
		if (_info.Data.challengeJump.Length == 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CanNotGoTo);
			return;
		}
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = 1005;
		evt.status = 2;
		evt.challengeGroupId = _info.GroupId;
		ActivityChallengeGroup data = CoreUtils.GetData(_info.GroupId, RuntimeConfigs.data.activityChallengeGroups);
		evt.challengeId = data.challengeId[_index];
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
		GoTo().Forget();
	}

	public async UniTask GoTo()
	{
		int num = _info.Data.challengeJump.FirstOrDefault();
		if (num != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(num);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
				return;
			}
			ExploringChallengeUIScene.Unload();
			runTimeJumpData.FromSystem = SystemType.Mission;
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			result.Release();
		}
	}

	public void Init(int index, ActivityExploreChallengeModel.ChallengeInfo info, Action cb, ImageAssetStation Station)
	{
		_index = index;
		_info = info;
		stageName.GetComponent<TextMeshProUGUI>().text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, info.Data.challengeText);
		text.text = "0" + (index + 1);
		btnGift.SetBtnClick(OnGift, "event:/UI/Interface/Plan/List/Select");
		btnGo.SetBtnClick(OnGo, "event:/UI/Interface/Plan/List/Select");
		OnGiftCallBack = cb;
		List<ItemUnifierProxy> challengeRewardList = Model<ActivityExploreChallengeModel>.Interface.GetChallengeRewardList(info);
		while (_itemRewardList.Count < challengeRewardList.Count)
		{
			ItemUIComponentBase component = UnityEngine.Object.Instantiate(rewardPrefab, rewardRoot).GetComponent<ItemUIComponentBase>();
			_itemRewardList.Add(component);
		}
		if (_itemRewardList.Count > challengeRewardList.Count)
		{
			for (int i = 0; i < _itemRewardList.Count - info.Data.challengeReward.Length; i++)
			{
				_itemRewardList[_itemRewardList.Count - i - 1].gameObject.SetActive(value: false);
			}
		}
		for (int j = 0; j < challengeRewardList.Count; j++)
		{
			ItemUIComponentBase itemUIComponentBase = _itemRewardList[j];
			itemUIComponentBase.Station = Station;
			itemUIComponentBase.SetData(challengeRewardList[j], challengeRewardList[j].Count, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			itemUIComponentBase.UpdatePerformance();
			itemUIComponentBase.gameObject.SetActive(value: true);
		}
		SetState(_info.State);
		PlayShowAnimation();
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = 1005;
		evt.status = 1;
		evt.challengeGroupId = _info.GroupId;
		ActivityChallengeGroup data = CoreUtils.GetData(_info.GroupId, RuntimeConfigs.data.activityChallengeGroups);
		evt.challengeId = data.challengeId[_index];
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
		int num = Model<ActivityExploreChallengeModel>.Interface.GetCompleteCount(info.Id);
		int needCount = Model<ActivityExploreChallengeModel>.Interface.GetNeedCount(info.Id);
		if (num >= needCount)
		{
			num = needCount;
		}
		txtProgress.text = $"({num}/{needCount})";
		ColorUtility.TryParseHtmlString((num == needCount) ? "#d0ff85" : "#bfbcf1", out var color);
		txtProgress.color = color;
		SetPromptVisible(visible: false);
	}

	private void PlayShowAnimation()
	{
		if (betterAnimation == null)
		{
			return;
		}
		betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			if ((bool)this && _info != null)
			{
				SetState(_info.State);
			}
		}).Play();
	}

	public void CancelCurrentShowAnim()
	{
		if ((bool)betterAnimation)
		{
			betterAnimation.StopAnimation();
		}
		if (_cts != null)
		{
			_cts.Cancel();
			_cts.Dispose();
			_cts = new CancellationTokenSource();
		}
	}

	private void OnDestroy()
	{
		if (_cts != null)
		{
			_cts.Cancel();
			_cts.Dispose();
			_cts = null;
		}
	}

	public void OnSubmit(BaseEventData baseEventData)
	{
		if (_state == ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState.Completed)
		{
			OnGift();
		}
		else if (_state == ActivityExploreChallengeModel.ChallengeInfo.ChallengeInfoState.UnCompleted)
		{
			OnGo();
		}
	}

	public void OnSelect(BaseEventData eventData)
	{
		SetPromptVisible(visible: true);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		SetPromptVisible(visible: false);
	}

	public void OnInputDeviceChange(DeviceInputMode type)
	{
		SetPromptVisible(type == DeviceInputMode.Gamepad && EventSystemHelper.CurrentSelected == gameObject);
	}

	private void SetPromptVisible(bool visible)
	{
		for (int i = 0; i < Prompts.Count; i++)
		{
			Prompts[i].SetActive(visible);
		}
	}
}
