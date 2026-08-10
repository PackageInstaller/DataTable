local var_0_0 = class("WhackMoleDescView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Minicom/SUminiDuckInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.leftBtnController_ = arg_3_0.leftBtnControllerEx_:GetController("state")
	arg_3_0.rightBtnController_ = arg_3_0.rightBtnControllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.backBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.leftBtn_, nil, function()
		arg_4_0:Switch(arg_4_0.index_ - 1)
	end)
	arg_4_0:AddBtnListener(arg_4_0.rightBtn_, nil, function()
		arg_4_0:Switch(arg_4_0.index_ + 1)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.idList_ = arg_8_0.params_.idList

	arg_8_0:Switch(arg_8_0.params_.index or 1)
end

function var_0_0.Switch(arg_9_0, arg_9_1)
	arg_9_0.index_ = arg_9_1
	arg_9_0.id_ = arg_9_0.idList_[arg_9_1]

	local var_9_0 = arg_9_0:GetSprite()

	if var_9_0 then
		arg_9_0.icon_.sprite = var_9_0
	end

	arg_9_0.nameText_.text = arg_9_0:GetName()
	arg_9_0.descText_.text = arg_9_0:GetDesc()

	arg_9_0.leftBtnController_:SetSelectedState(arg_9_1 > 1 and "on" or "off")

	arg_9_0.leftBtn_.interactable = arg_9_1 > 1

	arg_9_0.rightBtnController_:SetSelectedState(arg_9_1 < #arg_9_0.idList_ and "on" or "off")

	arg_9_0.rightBtn_.interactable = arg_9_1 < #arg_9_0.idList_
end

function var_0_0.GetName(arg_10_0)
	return ActivityMoleCfg[arg_10_0.id_].name
end

function var_0_0.GetDesc(arg_11_0)
	return ActivityMoleCfg[arg_11_0.id_].desc
end

function var_0_0.GetSprite(arg_12_0)
	return pureGetSpriteWithoutAtlas(ActivityMoleCfg[arg_12_0.id_].pitcture_path)
end

return var_0_0
