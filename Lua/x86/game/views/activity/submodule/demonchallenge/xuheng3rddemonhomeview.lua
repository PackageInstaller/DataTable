ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("XuHeng3rdDemonHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdMindDemonUI/XuHeng3rdDemonUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		if not arg_3_0:IsActivityTime() then
			return
		end

		JumpTools.OpenPageByJump("/xuHeng3rddreamDemonChallengeMain", {
			activityId = arg_3_0.activityID_
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.descBtn_, nil, function()
		local var_5_0 = GetTips("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_5_0
		})
	end)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	if arg_7_1 == true then
		manager.redPoint:bindUIandKey(arg_7_0.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, arg_7_0.activityID_))
		arg_7_0:RegistEventListener(OSIRIS_TASK_UPDATE, arg_7_0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(arg_7_0.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, arg_7_0.activityID_))
		arg_7_0:RemoveAllEventListener()
	end
end

function var_0_0.RefreshUI(arg_8_0)
	return
end

function var_0_0.RefreshTimeText(arg_9_0)
	if arg_9_0.timeText_ then
		arg_9_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_9_0.stopTime_, true)
	end
end

return var_0_0
