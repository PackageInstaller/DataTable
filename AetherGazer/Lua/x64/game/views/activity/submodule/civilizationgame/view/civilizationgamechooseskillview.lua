local var_0_0 = class("CivilizationGameChooseSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_SelectSkillPopUI"
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

	arg_4_0.btnController_ = arg_4_0.mainControllerEx_:GetController("btn")
	arg_4_0.itemList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.chooseBtn_, nil, function()
		if arg_5_0.type_ == CivilizationGameConst.techType.TECH then
			civilization.CivilizationLuaBridge.ChooseTech(arg_5_0.selectID_)
		elseif CivilizationGameConst.techType.HEX then
			civilization.CivilizationLuaBridge.ChooseHex(arg_5_0.selectID_)
			manager.notify:CallUpdateFunc(CIVILIZATION_GAIN_HEX, arg_5_0.selectID_, arg_5_0.hexIndex_)
		end

		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.selectID_ = 0
	arg_7_0.idList_ = arg_7_0.params_.idList:ToTable()
	arg_7_0.type_ = arg_7_0.params_.chooseType

	if arg_7_0.params_.index then
		arg_7_0.hexIndex_ = arg_7_0.params_.index + 1
	end

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.type_ == CivilizationGameConst.techType.TECH then
		arg_8_0.titleText_.text = GetTips("GODEATER_CIVILIZATION_COMMON_FACTOR_SELECT")
	elseif CivilizationGameConst.techType.HEX then
		arg_8_0.titleText_.text = GetTips("GODEATER_CIVILIZATION_SPECIAL_FACTOR_SELECT")
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.idList_) do
		if arg_8_0.itemList_[iter_8_0] then
			-- block empty
		else
			local var_8_0 = Object.Instantiate(arg_8_0.techGo_, arg_8_0.itemContentTrs_)

			arg_8_0.itemList_[iter_8_0] = CivilizationSkillChooseItem.New(var_8_0)
		end

		arg_8_0.itemList_[iter_8_0]:SetData(arg_8_0.type_, iter_8_1, function(arg_9_0)
			arg_8_0:ChooseItem(arg_9_0)
		end)
		arg_8_0.itemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_2 = #arg_8_0.itemList_, #arg_8_0.idList_ + 1, -1 do
		arg_8_0.itemList_[iter_8_2]:SetActive(false)
	end

	arg_8_0:RefreshBtn()
end

function var_0_0.ChooseItem(arg_10_0, arg_10_1)
	arg_10_0.selectID_ = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList_) do
		if arg_10_0.selectID_ == iter_10_1:GetID() then
			iter_10_1:SetSelected(true)
		else
			iter_10_1:SetSelected(false)
		end
	end

	arg_10_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_11_0)
	if not arg_11_0.selectID_ or arg_11_0.selectID_ == 0 then
		arg_11_0.btnController_:SetSelectedState("no")
	else
		arg_11_0.btnController_:SetSelectedState("select")
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0.selectID_ = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemList_) do
		iter_12_1:SetSelected(false)
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.itemList_) do
		iter_14_1:Dispose()
	end

	var_0_0.super.Dispose(arg_14_0)
	Object.Destroy(arg_14_0.gameObject_)
end

return var_0_0
