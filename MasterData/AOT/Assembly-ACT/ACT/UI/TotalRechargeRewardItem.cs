using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TotalRechargeRewardItem : MonoBehaviour
{
	public enum DisplayType
	{
		Normal,
		Choice,
		Appearance
	}

	private const int SkipIconExtraParam = 999;

	[SerializeField]
	private DisplayType displayType;

	[SerializeField]
	private ActButton clickButton;

	[SerializeField]
	private BImage rewardIcon;

	[SerializeField]
	private TextMeshProUGUI rewardCountText;

	[SerializeField]
	private TextMeshProUGUI rewardNameText;

	[SerializeField]
	private GameObject requiredRechargeRoot;

	[SerializeField]
	private TextMeshProUGUI requiredRechargeText;

	[SerializeField]
	private GameObject countRoot;

	[SerializeField]
	private GameObject appearancePreviewRoot;

	[SerializeField]
	private GameObject claimableCircle;

	[SerializeField]
	private GameObject claimedCheck;

	[SerializeField]
	private RedDotItem redDot;

	private int _rewardId;

	private int _rewardCount;

	private int _challengeJumpId;

	private int _activityId;

	private int _activityGroupId;

	private int _challengeId;

	private bool _isClaimable;

	private bool _isRequesting;

	public int RequiredRecharge { get; private set; }

	public void Refresh(ActivityTotalRechargeInfo activityInfo, int groupId, int challengeId, bool isWelcomeReward, ImageAssetStation station)
	{
		ActivityChallengeData data = CoreUtils.GetData(challengeId, RuntimeConfigs.data.activityChallengeDatas);
		if (data?.extraParm == null || data.extraParm.Length == 0 || data.challengeReward == null || data.challengeReward.Length == 0)
		{
			gameObject.SetActive(value: false);
			return;
		}
		Collection data2 = CoreUtils.GetData(data.challengeReward[0], RuntimeConfigs.data.collections);
		if (data2?.certain == null || data2.certain.Count != 1)
		{
			gameObject.SetActive(value: false);
			return;
		}
		RequiredRecharge = data.extraParm[0];
		_activityId = activityInfo.ActivityId;
		_activityGroupId = groupId;
		_challengeId = challengeId;
		_rewardId = data2.certain[0].id;
		_rewardCount = data2.certain[0].count;
		int[] challengeJump = data.challengeJump;
		_challengeJumpId = ((challengeJump != null && challengeJump.Length > 0) ? data.challengeJump[0] : 0);
		bool shouldLoadIcon = data.extraParm.Length <= 1 || data.extraParm[1] != 999;
		RefreshRewardContent(isWelcomeReward, station, shouldLoadIcon);
		RefreshState(activityInfo, groupId, challengeId);
		RefreshRedDot(challengeId);
		clickButton?.SetBtnClick(OnClick);
	}

	private void RefreshRedDot(int challengeId)
	{
		if (!(redDot == null))
		{
			redDot.displayAction = new SelfNodeActive();
			redDot.InitRedDot(string.Format(RedDotPathDefine.Activity_TotalRechargeItem, challengeId));
		}
	}

	private void RefreshRewardContent(bool isWelcomeReward, ImageAssetStation station, bool shouldLoadIcon)
	{
		requiredRechargeText.text = RequiredRecharge.ToString();
		requiredRechargeRoot?.gameObject.SetActive(!isWelcomeReward);
		countRoot?.SetActive(displayType != DisplayType.Appearance);
		appearancePreviewRoot?.SetActive(displayType == DisplayType.Appearance);
		rewardNameText?.gameObject.SetActive(displayType != DisplayType.Normal && !isWelcomeReward);
		ItemData data = CoreUtils.GetData(_rewardId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			if (shouldLoadIcon)
			{
				station.LoadItemIconAsync(data.iconAddress, rewardIcon).Forget();
			}
			rewardCountText?.SetText($"x{_rewardCount}");
			rewardNameText?.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal));
		}
	}

	private void RefreshState(ActivityTotalRechargeInfo activityInfo, int groupId, int challengeId)
	{
		bool flag = false;
		foreach (ActivityGroup item in activityInfo.GainedActivityGroup)
		{
			if (item.ActivityGroupId == groupId && item.ActivityChallengeIds.Contains(challengeId))
			{
				flag = true;
				break;
			}
		}
		_isClaimable = !flag && activityInfo.TotalRecharge >= RequiredRecharge;
		claimableCircle?.SetActive(_isClaimable);
		claimedCheck?.SetActive(flag);
	}

	public void OnGamepadSubmit()
	{
		clickButton?.OnSubmit(null);
	}

	private void OnClick()
	{
		if (_isClaimable)
		{
			ReceiveReward();
		}
		else if (displayType == DisplayType.Appearance)
		{
			if (_challengeJumpId != 0)
			{
				RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_challengeJumpId);
				JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
				if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
				{
					Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				}
				jumpResult.Release();
			}
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = _rewardId,
				Count = _rewardCount
			});
		}
	}

	private void ReceiveReward()
	{
		if (_isRequesting)
		{
			return;
		}
		_isRequesting = true;
		G.service.SendActivityTotalRechargeRewardReq(_activityId, _activityGroupId, (ActivityTotalRechargeRewardAck ack) =>
		{
			_isRequesting = false;
			if (ack != null)
			{
				GameUtility.OpenPopReward(ack.Items);
			}
		});
	}
}
