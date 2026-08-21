local var_0_0 = class("TowerGameRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/snakeactive/MarduksnakeRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshItem), arg_4_0.listgo_, TowerGameRewardBlock)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = TowerGameCfg.all[arg_8_1]

	arg_8_2:Refresh(var_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.list_:StartScroll(#TowerGameCfg.all, TowerGameData:GetFirstCanGetRewardIndex())

	arg_9_0.gettext_.text = TowerGameData:GetRewardsNum()
	arg_9_0.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()
end

function var_0_0.OnTowerGameGetReward(arg_10_0)
	arg_10_0.gettext_.text = TowerGameData:GetRewardsNum()
	arg_10_0.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()

	arg_10_0.list_:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.list_ then
		arg_11_0.list_:Dispose()

		arg_11_0.list_ = nil
	end
end

return var_0_0
