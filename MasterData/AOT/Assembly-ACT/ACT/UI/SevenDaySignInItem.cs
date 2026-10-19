using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class SevenDaySignInItem : MonoBehaviour
{
	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	public TextMeshProUGUI ItemNumber;

	public TextMeshProUGUI ItemName;

	public GameObject DefaultIcon;

	public BImage Icon;

	public GameObject WaitingSignIn;

	public GameObject Receive;

	public GameObject Received;

	public ActButton ItemButton;

	public List<SevenDaySignIn.SpriteInfo> SpriteInfos;

	public CanvasGroup CanvasGroup;

	public List<GameObject> GamepadSelect;

	private int _index;

	private ActivitSignInInfo _activitSignInInfo;

	private ActivityData _activityData;

	private int _rewardState;

	private Item _rewardItem;

	private int _facePushId;

	public void RefreshUI(int index, ActivityData activityData, ActivitSignInInfo activitSignInInfo, int facePushId = 0)
	{
		_index = index;
		_activityData = activityData;
		_activitSignInInfo = activitSignInInfo;
		_facePushId = facePushId;
		_rewardState = GetItemRewardState(index, activityData, activitSignInInfo);
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityData.activityChallengGroup[index]];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		ItemKv itemKv = RuntimeConfigs.data.collections[activityChallengeData.challengeReward[0]].certain[0];
		ItemData itemData = RuntimeConfigs.data.itemDatas[itemKv.id];
		_rewardItem = new Item
		{
			Id = itemKv.id,
			Count = itemKv.count
		};
		ItemButton.SetBtnClick(OnClickItemButtonHandle);
		ItemName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, itemData.nameLocal);
		TextMeshProUGUI itemNumber = ItemNumber;
		int count = itemKv.count;
		itemNumber.text = count.ToString();
		if (index != 1 && index != 6)
		{
			this.GetImageStation().LoadItemIconAsync(itemData.iconAddress, Icon).Forget();
		}
		WaitingSignIn.SetActive(_rewardState == 0);
		Receive.SetActive(_rewardState == 1);
		Received.SetActive(_rewardState == 2);
	}

	public void OnClickItemButtonHandle()
	{
		_ = RuntimeConfigs.data.activityChallengeGroups[_activityData.activityChallengGroup[_index]];
		if (_rewardState == 1)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Choise");
			G.service.RequestActivitySignInReward(_activityData.id, 0, 0, (ActivitySignInRewardAck activitySignInRewardAck) =>
			{
				OnActivitySignInRewardAck(activitySignInRewardAck);
			});
			return;
		}
		if (_rewardState == 0)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/Gray_Click");
		}
		OpenRewardDetail();
	}

	private void OnActivitySignInRewardAck(ActivitySignInRewardAck activitySignInRewardAck)
	{
		if (activitySignInRewardAck != null && activitySignInRewardAck.GotItems.Count > 0)
		{
			ReportClaimRewardEvent();
			GameUtility.OpenPopReward(activitySignInRewardAck.GotItems);
		}
	}

	private void ReportClaimRewardEvent()
	{
		int num = _activityData.activityChallengGroup[_index];
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = _activityData.id;
		evt.status = 3;
		evt.challengeGroupId = num;
		ActivityChallengeGroup data = CoreUtils.GetData(num, RuntimeConfigs.data.activityChallengeGroups);
		evt.challengeId = data.challengeId.FirstOrDefault();
		evt.isPopup = _facePushId > 0;
		EventTrackSolver.Instance.Dispatch(evt);
		if (_facePushId > 0)
		{
			PopupEvent evt2 = EventTrackSolver.Instance.GetEvt<PopupEvent>();
			evt2.adId = _facePushId;
			evt2.eventDuration = 0f;
			evt2.type = 3;
			evt2.status = 6;
			evt2.subShopId = 0;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
	}

	private bool CheckRewardIsCharacter(RepeatedField<UniversalItem> universalItems)
	{
		foreach (UniversalItem universalItem in universalItems)
		{
			if (universalItem.Type != UniversalItemType.UniversalItemCharacter)
			{
				return false;
			}
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW, new CommonAcquireCharacterShowData
		{
			universalItems = new List<UniversalItem> { universalItems[0] }
		});
		return true;
	}

	private bool CheckRewardIsCharacterSkin(RepeatedField<UniversalItem> universalItems)
	{
		foreach (UniversalItem universalItem in universalItems)
		{
			if (universalItem.Type != UniversalItemType.UniversalItemSkin)
			{
				return false;
			}
		}
		int index = universalItems[0].Index;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHARACTERSKINACQUIRE, new PopupCharacterSkinAcquireViewData
		{
			SkinId = index
		});
		return true;
	}

	private int GetItemRewardState(int index, ActivityData activityData, ActivitSignInInfo activitSignInInfo)
	{
		int key = activityData.activityChallengGroup[index];
		int num = RuntimeConfigs.data.activityChallengeGroups[key].challengeId[0];
		_ = RuntimeConfigs.data.activityChallengeDatas[num];
		if (!Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(num))
		{
			return 0;
		}
		if (activitSignInInfo.SignInGroups.TryGetValue(key, out var value) && value != null && value.ChallengeInfos[num].IsGained)
		{
			return 2;
		}
		return 1;
	}

	public void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("Show").Play();
	}

	public int GetRewardState()
	{
		return _rewardState;
	}

	public void SetGamepadSelect(bool active)
	{
		foreach (GameObject item in GamepadSelect)
		{
			item?.SetActive(active);
		}
	}

	public void OpenRewardDetail()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = _rewardItem.Id,
			Count = _rewardItem.Count
		});
	}
}
