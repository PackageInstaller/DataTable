local var_0_0 = class("CatchDuckInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Minicom/SUminiDuckInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.leftBtnController_ = arg_3_0.leftBtnControllerEx_:GetController("state")
	arg_3_0.rightBtnController_ = arg_3_0.rightBtnControllerEx_:GetController("state")

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.leftBtn_, nil, function()
		arg_4_0:SwitchPage(arg_4_0.enterIndex_ - 1)
	end)
	arg_4_0:AddBtnListener(arg_4_0.rightBtn_, nil, function()
		arg_4_0:SwitchPage(arg_4_0.enterIndex_ + 1)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.duckList_ = arg_8_0.params_.duckList

	arg_8_0:SwitchPage(arg_8_0.params_.index)
end

function var_0_0.SwitchPage(arg_9_0, arg_9_1)
	arg_9_0.enterIndex_ = arg_9_1
	arg_9_0.duckId_ = arg_9_0.duckList_[arg_9_1]

	local var_9_0 = ActivityDuckCfg[arg_9_0.duckId_]

	arg_9_0.nameText_.text = var_9_0.name
	arg_9_0.descText_.text = var_9_0.desc
	arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_9_0.icon)
	arg_9_0.leftBtn_.enabled = arg_9_1 > 1
	arg_9_0.rightBtn_.enabled = arg_9_1 < #arg_9_0.duckList_

	arg_9_0.leftBtnController_:SetSelectedState(arg_9_1 > 1 and "on" or "off")
	arg_9_0.rightBtnController_:SetSelectedState(arg_9_1 < #arg_9_0.duckList_ and "on" or "off")
end

return var_0_0
