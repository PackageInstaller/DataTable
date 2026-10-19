using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TargetGuideCell : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler
{
	public ActButton jumpBtn;

	public ActButton rewardBtn;

	public GameObject completedRoot;

	public GameObject buttonRoot;

	public GameObject progressingRoot;

	public TextMeshProUGUI guideMissionName;

	public List<ItemUIComponentBase> rewardCells;

	public TargetGuidView parentView;

	public GameObject btnPrompt_Confirm;

	public TextMeshProUGUI missionProgressLeft;

	public TextMeshProUGUI missionProgressRight;

	public BetterAnimation betterAnimation;

	public Transform rewardRoot;

	private int _progressLeftNum;

	private int _progressRightNum;

	private bool _curMissionCanJump;

	public override void Init(object param)
	{
		base.Init(param);
		TargetGuideCellData data = param as TargetGuideCellData;
		if (data == null)
		{
			return;
		}
		rewardBtn.SetBtnClick(() =>
		{
			Model<TargetGuideModel>.Interface.AwardGuideMissionReward(data.belongChapter, () =>
			{
				foreach (ItemUIComponentBase rewardCell in rewardCells)
				{
					rewardCell.IsComplete = true;
					rewardCell.UpdatePerformance();
					SetRewardState(isReward: true);
					if (parentView != null)
					{
						parentView.RefreshChapterDisplay();
					}
				}
			});
		});
		int missionJumpId = GetMissionJumpId(data.missionGroupId);
		RuntimeJumpData jumpData = ItemJumpHelper.GetRunTimeJumpData(missionJumpId);
		JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(jumpData);
		_curMissionCanJump = jumpResult.ShowType == JumpResult.JumpShowType.CanJump;
		jumpResult.Release();
		jumpData.FromSystem = SystemType.SystemGuide;
		jumpBtn.SetBtnClick(() =>
		{
			if (_curMissionCanJump && jumpBtn.gameObject.activeInHierarchy)
			{
				Model<JumpModel>.Interface.JumpTo(jumpData);
			}
		});
		UpdateDisplay(data);
	}

	public override void Hide()
	{
		rewardBtn.Interactable(active: true);
	}

	public ActButton GetActiveButton()
	{
		if (rewardBtn != null && rewardBtn.gameObject.activeInHierarchy)
		{
			return rewardBtn;
		}
		if (jumpBtn != null && jumpBtn.gameObject.activeInHierarchy)
		{
			return jumpBtn;
		}
		return null;
	}

	private void UpdateDisplay(TargetGuideCellData curData)
	{
		bool guideMissionRewardState = Model<TargetGuideModel>.Interface.GetGuideMissionRewardState(curData.missionGroupId);
		bool flag = Model<TargetGuideModel>.Interface.CurGudieMissionCanReward(curData.missionGroupId);
		SetRewardState(guideMissionRewardState);
		bool flag2 = !guideMissionRewardState && !flag && _curMissionCanJump;
		bool flag3 = !guideMissionRewardState & flag;
		jumpBtn.gameObject.SetActive(flag2);
		rewardBtn.gameObject.SetActive(flag3);
		btnPrompt_Confirm.gameObject.SetActive(flag2 | flag3);
		progressingRoot.SetActive(!guideMissionRewardState && !flag && !_curMissionCanJump);
		string guideMissionContentText = GetGuideMissionContentText(curData.missionGroupId);
		if (!string.IsNullOrEmpty(guideMissionContentText))
		{
			guideMissionName.SetText(guideMissionContentText);
		}
		(int, int) guideMissionProgress = Model<TargetGuideModel>.Interface.GetGuideMissionProgress(curData.missionGroupId);
		missionProgressLeft.SetText(guideMissionProgress.Item1.FastToString());
		missionProgressRight.SetText(guideMissionProgress.Item2.FastToString());
		Collection data = CoreUtils.GetData(curData.missionRewardCollectionId, RuntimeConfigs.data.collections);
		List<ItemKv> certain = data.certain;
		if (certain == null || certain.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < data.certain.Count; i++)
		{
			ItemKv itemKv = data.certain[i];
			Item item = new Item
			{
				Id = itemKv.id,
				Count = itemKv.count
			};
			rewardCells[i]?.SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			if (rewardCells[i] != null)
			{
				rewardCells[i].IsComplete = guideMissionRewardState;
			}
			rewardCells[i]?.UpdatePerformance();
		}
	}

	private void SetRewardState(bool isReward)
	{
		buttonRoot.SetActive(!isReward);
		completedRoot.SetActive(isReward);
	}

	private string GetGuideMissionContentText(int missionGroupId)
	{
		MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data == null)
		{
			return string.Empty;
		}
		int num = data.missionId.FirstOrDefault();
		if (num == 0)
		{
			return string.Empty;
		}
		ACT.Config.Mission data2 = CoreUtils.GetData(num, RuntimeConfigs.data.missions);
		return CustomTagParser.ReplacePreconditionText(data2, data2.number, data2.param);
	}

	private int GetMissionJumpId(int missionGroupId)
	{
		MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data == null)
		{
			return 0;
		}
		return CoreUtils.GetData(data.missionId.FirstOrDefault(), RuntimeConfigs.data.missions).missionId;
	}

	public void OnSelect(BaseEventData eventData)
	{
		GameObject gameObject = (EventSystemHelper.Available ? EventSystemHelper.CurrentSelected : null);
		if (gameObject != null && gameObject == base.gameObject)
		{
			ViewControlLayer component = rewardRoot.GetComponent<ViewControlLayer>();
			if (component != null)
			{
				parentView?.SetCurrentCellViewControlLayer(component, rewardRoot);
			}
		}
	}
}
