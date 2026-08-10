local var_0_0 = class("HanafudaSelectFirstPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.typeController_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.enemyFirstBtn_, nil, function()
		if arg_5_0.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.COMPUTER_TURN)
			arg_5_0:Back()
		elseif arg_5_0.type_ == 2 then
			HanafudaData:SetComputerDiffculty(1)
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_enemy", "")
			arg_5_0:Back()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.playerFirstBtn_, nil, function()
		if arg_5_0.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.PLAYER_TURN)
			arg_5_0:Back()
		elseif arg_5_0.type_ == 2 then
			HanafudaData:SetComputerDiffculty(2)
			arg_5_0:Back()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.callback = arg_8_0.params_.callback
	arg_8_0.type_ = arg_8_0.params_.type

	arg_8_0.typeController_:SetSelectedState(arg_8_0.type_)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.callback()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
