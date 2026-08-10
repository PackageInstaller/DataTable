local var_0_0 = class("FishingInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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

	arg_5_0.bgController_ = ControllerUtil.GetController(arg_5_0.talkBgTransform_, "talkbg")
	arg_5_0.unlockController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "unlock")
	arg_5_0.rareController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "rare")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()

	arg_11_0.rect_ = arg_11_0.params_.rect
	arg_11_0.id_ = arg_11_0.params_.id
	arg_11_0.cfg_ = RareFishCfg[arg_11_0.params_.id]

	arg_11_0:UpdateView()
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = FishingData:GetFish(arg_12_0.id_)
	local var_12_1 = 0

	if var_12_0 ~= nil then
		arg_12_0.unlockController_:SetSelectedState("true")

		var_12_1 = var_12_0.len
	else
		arg_12_0.unlockController_:SetSelectedState("false")
	end

	arg_12_0.nameLabel_.text = GetI18NText(arg_12_0.cfg_.name)
	arg_12_0.descLabel_.text = GetI18NText(arg_12_0.cfg_.desc)

	arg_12_0.rareController_:SetSelectedState(FishingData:GetRareLabel(arg_12_0.cfg_.rare))

	arg_12_0.tipLabel_.text = GetI18NText(arg_12_0.cfg_.talk)
	arg_12_0.sizeDescLabel_.text = string.format("%d-%dcm", arg_12_0.cfg_.size[1], arg_12_0.cfg_.size[2])
	arg_12_0.maxSizeLabel_.text = string.format("%dcm", var_12_1)

	local var_12_2 = 1080 / Screen.height
	local var_12_3 = arg_12_0.params_.rect.x * var_12_2 + arg_12_0.params_.rect.width * var_12_2
	local var_12_4 = arg_12_0.params_.rect.y * var_12_2 - arg_12_0.params_.rect.height * var_12_2
	local var_12_5 = arg_12_0.container_.transform.localPosition

	var_12_5.x = var_12_3 + 5

	arg_12_0.bgController_:SetSelectedState("leftBg")

	if var_12_5.x + arg_12_0.container_.transform.rect.width > Screen.width * var_12_2 then
		var_12_5.x = arg_12_0.params_.rect.x * var_12_2 - arg_12_0.container_.transform.rect.width - 5

		arg_12_0.bgController_:SetSelectedState("rightBg")
	end

	var_12_5.y = var_12_4
	arg_12_0.container_.transform.localPosition = var_12_5

	CustomLog.Log(string.format("%s", tostring(arg_12_0.params_.rect)))
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
