local var_0_0 = class("CivilizationGameHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_PlayHeroMessagePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemList_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.itemList_[iter_4_0] = CivilizationHeroHexItem.New(arg_4_0["hex" .. iter_4_0 .. "Go_"])
	end

	arg_4_0.heroController_ = arg_4_0.heroControllerEx_:GetController("iconhero")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID_ = arg_7_0.params_.heroID

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ActivityCivilizationHeroCfg[arg_8_0.heroID_]

	arg_8_0.nameText_.text = var_8_0.name
	arg_8_0.descText_.text = var_8_0.description

	if arg_8_0.heroID_ == 1 then
		arg_8_0.heroController_:SetSelectedIndex(1)
	else
		arg_8_0.heroController_:SetSelectedIndex(0)
	end

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.hex_skill_1) do
		table.insert(var_8_1, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0.hex_skill_2) do
		table.insert(var_8_1, iter_8_3)
	end

	for iter_8_4, iter_8_5 in ipairs(var_8_0.hex_skill_3) do
		table.insert(var_8_1, iter_8_5)
	end

	for iter_8_6 = 1, 6 do
		arg_8_0.itemList_[iter_8_6]:SetData(var_8_1[iter_8_6])
	end
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.itemList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.itemList_ = {}

	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

function var_0_0.OnExitInput(arg_12_0)
	JumpTools.Back()

	return true
end

return var_0_0
