ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("CORGFlipCardHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return XH3rdFlipCardTool:GetHomeUI()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:BindHelpBtn(XH3rdFlipCardTool:GetHelpTips(XH3rdFlipCardData:GetActivityID()), arg_4_0.tipsBtn_)
	arg_4_0:AddBtnListener(arg_4_0.playBtn_, nil, function()
		if not arg_4_0:IsActivityTime() then
			ShowTips("TIME_OVER")

			return
		end

		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			JumpTools.OpenPageByJump("/xH3rdFlipCardGame_4_5", {
				activityId = XH3rdFlipCardData:GetActivityID()
			})
		else
			JumpTools.OpenPageByJump("/xH3rdFlipCardGame", {
				activityId = XH3rdFlipCardData:GetActivityID()
			})
		end

		XH3rdFlipCardAction.hasEnterGame = true
	end)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	if arg_7_1 then
		arg_7_0:UpdatePreview()
		manager.redPoint:bindUIandKey(arg_7_0.playBtn_.transform, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_7_0.activityID_))
		arg_7_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_7_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_7_0.playBtn_.transform, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_7_0.activityID_))
		arg_7_0:RemoveAllEventListener()
	end
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
end

return var_0_0
