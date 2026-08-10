local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("SnowballGameMainView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballMainUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_0:GetActivityID())
end

local function var_0_2(arg_3_0)
	local var_3_0 = arg_3_0.id
	local var_3_1 = AssignmentCfg[var_3_0]

	return var_3_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY or var_3_1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE
end

function var_0_1.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.questSubView = ActivityQuestSubView.New(arg_4_0.gameObject_, SnowballGameData.activityID, var_0_2, SnowballQuestItem, true)
	arg_4_0.stateControler = ControllerUtil.GetController(arg_4_0.transform_, "state")

	arg_4_0:AddBtnListener(arg_4_0.startBtn_, nil, function()
		if arg_4_0:IsActivityTime() then
			DormMinigame.Launch("HZ07_xueqiu1")
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.tipsBtn_, nil, function()
		local var_6_0 = "ACTIVITY_SNOWBALL_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
end

function var_0_1.Dispose(arg_7_0)
	arg_7_0.questSubView:Dispose()
	var_0_1.super.Dispose(arg_7_0)
end

function var_0_1.OnEnter(arg_8_0)
	var_0_1.super.OnEnter(arg_8_0)
	arg_8_0.questSubView:OnEnter()

	local var_8_0 = SnowballGameData.activityID

	manager.redPoint:bindUIandKey(arg_8_0.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function var_0_1.OnExit(arg_9_0)
	var_0_1.super.OnExit(arg_9_0)
	arg_9_0.questSubView:OnExit()

	local var_9_0 = SnowballGameData.activityID

	manager.redPoint:unbindUIandKey(arg_9_0.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function var_0_1.GetActivityID(arg_10_0)
	return SnowballGameData.activityID
end

function var_0_1.RefreshUI(arg_11_0)
	arg_11_0:RefreshTimeText()

	if ActivityTools.GetActivityStatus(arg_11_0:GetActivityID()) == 1 then
		arg_11_0.stateController:SetSelectedState("unlock")
	else
		arg_11_0.stateController:SetSelectedState("close")
	end
end

function var_0_1.UpdateBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
end

return var_0_1
