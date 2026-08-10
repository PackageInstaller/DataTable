local var_0_0 = class("DormLinkGameFailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGPlayResult2"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

local function var_0_1(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = DormLinkGameTools:ChecklevelUnLock(arg_6_0)

	if var_6_0 then
		return nil
	else
		if var_6_1 == DormLinkGameConst.LevelLockType.time then
			local var_6_3 = ActivityLinkGameCfg[arg_6_0].activity_id
			local var_6_4 = ActivityData:GetActivityData(var_6_3)

			return GetOpenTimeTips(var_6_4.startTime)
		elseif var_6_1 == DormLinkGameConst.LevelLockType.stop then
			return "TIME_OVER"
		elseif var_6_1 == DormLinkGameConst.LevelLockType.preLevel then
			return GetLevelNeedUnlockTips(arg_6_0)
		end

		return ""
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListenerScale(arg_7_0.restartBtn_, nil, function()
		local var_8_0 = var_0_1(DormLinkGameData:GetCurLevelID())

		if var_8_0 == nil then
			DormLinkGameData:ResetRunGameInfo()
			manager.notify:Invoke(LIANLIANKAN_GAME_RESET)
			JumpTools.OpenPageByJump("/dormLinkGamePlayView")
		else
			ShowTips(var_8_0)
		end
	end)
	arg_7_0:AddBtnListenerScale(arg_7_0.backBtn_, nil, function()
		DormLinkGameTools:ExitGame()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
