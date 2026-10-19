using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.InputController;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class RaidDoubleRewardItem : LoopScrollBaseItem
{
	[SerializeField]
	private TextMeshProUGUI raidName;

	[SerializeField]
	private TextMeshProUGUI coreProduct;

	[SerializeField]
	private ActButton gotoActButton;

	[SerializeField]
	private GamePadSelectComponent gamePadSelectComponent;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptA;

	private int jumpID;

	private int challengeId;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		List<int> challengeList = Model<ActivityCenterModel>.Interface.GetChallengeList(Model<ActivityCenterModel>.Interface.SelectActivityId);
		challengeId = challengeList[idx];
		ActivityChallengeData data = CoreUtils.GetData(challengeId, RuntimeConfigs.data.activityChallengeDatas);
		if (data != null)
		{
			jumpID = data.challengeJump[0];
			raidName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data.challengeText);
			coreProduct.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, 10490);
			gotoActButton.SetBtnClick(GotoRaid);
		}
		RefreshGamepadSelectedState();
	}

	public void SetGamepadSelected(bool selected)
	{
		gamePadSelectComponent?.SetSelectState(selected);
		operateBtnPromptA.gameObject.SetActive(selected);
	}

	public GameObject GetSelectableGameObject()
	{
		if (gotoActButton != null)
		{
			return gotoActButton.gameObject;
		}
		return gameObject;
	}

	public void GotoRaid()
	{
		if (jumpID != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpID);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
				return;
			}
			runTimeJumpData.FromSystem = SystemType.Raid;
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			result.Release();
			ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
			evt.activityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
			evt.challengeGroupId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonChallengeGroup(Model<ActivityCenterModel>.Interface.SelectActivityId);
			evt.challengeId = challengeId;
			evt.status = 2;
			evt.isPopup = false;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public override void OnUnLoad()
	{
		base.OnUnLoad();
		SetGamepadSelected(selected: false);
	}

	private void RefreshGamepadSelectedState()
	{
		RaidDoubleReward componentInParent = GetComponentInParent<RaidDoubleReward>();
		bool flag = componentInParent != null && componentInParent.SelectedIndex == index && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetGamepadSelected(flag);
		if (flag && EventSystemHelper.Available)
		{
			EventSystemHelper.SetSelectedGameObject(GetSelectableGameObject());
		}
	}
}
