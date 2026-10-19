using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent.GetActivePointView;

public class GetActivePointItem : LoopScrollBaseItem
{
	[SerializeField]
	private LocalizeStringEvent _missionName;

	[SerializeField]
	private TMP_Text _activePointNumber;

	[SerializeField]
	private ActButton _jumpButton;

	[SerializeField]
	private GameObject _lockRoot;

	private int _activePointDailyMissionID;

	private ActivePointDailyMission _activePointDailyMissionData;

	public int ActivePointDailyMissionID
	{
		get
		{
			return _activePointDailyMissionID;
		}
		set
		{
			if (_activePointDailyMissionID != value)
			{
				_activePointDailyMissionID = value;
				UpdateStyle();
			}
		}
	}

	private void Awake()
	{
		_jumpButton.SetBtnClick(Jump);
	}

	private void OnDestroy()
	{
		_jumpButton.OnClick.RemoveListener(Jump);
	}

	private void UpdateStyle()
	{
		_activePointDailyMissionData = CoreUtils.GetData(_activePointDailyMissionID, RuntimeConfigs.data.activePointDailyMissions);
		_missionName.SetTable("shortcommon");
		_missionName.StringReference.TableEntryReference = _activePointDailyMissionData.name;
		_activePointNumber.SetText(_activePointDailyMissionData.activePointDailyReward.First().count.FastToString());
		if (Singleton<SystemUnlockManager>.instance.IsUnlock(_activePointDailyMissionData.preconditionParam))
		{
			_jumpButton.gameObject.SetActive(_activePointDailyMissionData.navigation.Length != 0);
			_lockRoot.SetActive(value: false);
		}
		else
		{
			_jumpButton.gameObject.SetActive(value: false);
			_lockRoot.SetActive(value: true);
		}
	}

	private void Jump()
	{
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_activePointDailyMissionData.navigation.FirstOrDefault());
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
		{
			GameUtility.OpenJumpResultTips(result);
			result.Release();
		}
		else
		{
			runTimeJumpData.FromSystem = SystemType.DailyMission;
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			result.Release();
		}
	}
}
