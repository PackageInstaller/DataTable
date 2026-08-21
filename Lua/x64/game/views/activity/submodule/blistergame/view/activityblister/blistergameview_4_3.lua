BlisterGameView = import("game.views.activity.Submodule.BlisterGame.View.BlisterGameView")

local var_0_0 = class("BlisterGameView_4_3", BlisterGameView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGame01"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.taskbtnBtn_, nil, "OnTask")

	for iter_2_0 = 1, 2 do
		arg_2_0:AddBtnListener(arg_2_0[string.format("nextbtn0%sBtn_", iter_2_0)], nil, function()
			if arg_2_0.nowIndex == iter_2_0 then
				return
			end

			arg_2_0:ChangeTab(iter_2_0)
		end)
	end

	arg_2_0:AddBtnListener(arg_2_0.maskBtn_, nil, function()
		if gameContext:IsOpenRoute("blisterChapterSectionInfo_4_3") then
			JumpTools.Back(1)
			SetActive(arg_2_0.maskBtn_.gameObject, false)
		end
	end)
end

function var_0_0.OnEnter(arg_5_0)
	BlisterGameData:SetActivityId(ActivityConst.ACTIVITY_BLISTER_4_3)
	var_0_0.super.OnEnter(arg_5_0)
	arg_5_0:RegistEventListener(BLISTERGAME_STAGE_INFO, function()
		SetActive(arg_5_0.maskBtn_.gameObject, true)
	end)
end

function var_0_0.ChangeBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLISTER_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1)
		SetActive(arg_7_0.maskBtn_.gameObject, false)
	end)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.super.OnExit(arg_9_0)
	SetActive(arg_9_0.maskBtn_.gameObject, false)
end

function var_0_0.OnTask(arg_10_0)
	JumpTools.OpenPageByJump("blisterTaskView", {
		taskActivityID = ActivityConst.ACTIVITY_BLISTER_TASK_4_3
	})
end

return var_0_0
