using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.Model.MissionModel;

public class MissionModel : Model<MissionModel>, IJumpable
{
	public LuminModelType JumpSourceType => LuminModelType.Missions;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		int num = jumpData.Params[1];
		if (num == 0)
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		bool flag;
		bool flag2;
		if (RuntimeConfigs.data.missionRGroups.ContainsKey(num))
		{
			flag = IsMissionGroupAccepting(num);
			flag2 = Singleton<MissionManager>.instance.IsMissionGroupFinished(num);
		}
		else
		{
			int missionId = Singleton<MissionManager>.instance.ResolveJumpMissionId(num);
			flag = Singleton<MissionManager>.instance.IsAccepting(missionId);
			flag2 = Singleton<MissionManager>.instance.IsFinished(missionId);
		}
		if (flag2)
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
		if (!flag)
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.MissionNotAccepted)
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	private bool IsMissionGroupAccepting(int missionGroupId)
	{
		foreach (MissionBase value in RuntimeConfigs.data.missionBases.Values)
		{
			if (value.groupID == missionGroupId && Singleton<MissionManager>.instance.IsAccepting(value.id))
			{
				return true;
			}
		}
		return false;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		int missionId = Singleton<MissionManager>.instance.ResolveJumpMissionId(jumpData.Params[1]);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TASK, new TaskViewV3Data
		{
			missionId = missionId
		});
	}
}
