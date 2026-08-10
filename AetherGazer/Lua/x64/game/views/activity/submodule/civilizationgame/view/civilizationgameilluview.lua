local var_0_0 = class("CivilizationGameIlluView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_illustrationUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.selectID_ = 1
	arg_3_0.selectType = 1
	arg_3_0.allItems = {}
	arg_3_0.gridItemList_ = {}
	arg_3_0.hexItemList_1 = {}
	arg_3_0.hexItemList_2 = {}
	arg_3_0.techItemList_ = {}
	arg_3_0.lockController_ = arg_3_0.mainControllerEx_:GetController("lock")
	arg_3_0.typeController_ = arg_3_0.typeControllerEx_:GetController("card")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.gridIlluIDList_ = {}
	arg_5_0.hexIlluIDList_1 = {}
	arg_5_0.hexIlluIDList_2 = {}
	arg_5_0.techIlluIDList_ = {}
	arg_5_0.illuIDList_ = CivilizationGameData:GetDataByPara("illu_list")

	arg_5_0:ParseData()
	arg_5_0:RefreshItem()
	arg_5_0:ChooseItem(arg_5_0.selectType, arg_5_0.selectID_)
	arg_5_0:RefreshUI(arg_5_0.selectType)
end

function var_0_0.ParseData(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.illuIDList_) do
		if table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[1], iter_6_1) then
			table.insert(arg_6_0.gridIlluIDList_, iter_6_1)
		elseif table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[2], iter_6_1) then
			table.insert(arg_6_0.hexIlluIDList_1, iter_6_1)
		elseif table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[3], iter_6_1) then
			table.insert(arg_6_0.hexIlluIDList_2, iter_6_1)
		else
			table.insert(arg_6_0.techIlluIDList_, iter_6_1)
		end
	end
end

local function var_0_1(arg_7_0)
	table.sort(arg_7_0, function(arg_8_0, arg_8_1)
		local var_8_0 = ActivityCivilizationIlluCfg[arg_8_0]
		local var_8_1 = ActivityCivilizationIlluCfg[arg_8_1]

		return var_8_0.group_display_order < var_8_1.group_display_order
	end)

	return arg_7_0
end

function var_0_0.RefreshItem(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[1])) do
		if not arg_9_0.gridItemList_[iter_9_0] then
			local var_9_0 = Object.Instantiate(arg_9_0.cardItemGo_, arg_9_0.gridContentTrs_)

			arg_9_0.gridItemList_[iter_9_0] = CivilizationIlluItem.New(var_9_0)
		end

		arg_9_0.gridItemList_[iter_9_0]:SetData(1, iter_9_1, function(arg_10_0)
			arg_9_0:ChooseItem(1, arg_10_0)
		end)
		arg_9_0.gridItemList_[iter_9_0]:SetActive(true)
		table.insert(arg_9_0.allItems, arg_9_0.gridItemList_[iter_9_0])
	end

	for iter_9_2, iter_9_3 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[2])) do
		if not arg_9_0.hexItemList_1[iter_9_2] then
			local var_9_1 = Object.Instantiate(arg_9_0.cardItemGo_, arg_9_0.hex1ContentTrs_)

			arg_9_0.hexItemList_1[iter_9_2] = CivilizationIlluItem.New(var_9_1)
		end

		arg_9_0.hexItemList_1[iter_9_2]:SetData(2, iter_9_3, function(arg_11_0)
			arg_9_0:ChooseItem(2, arg_11_0)
		end)
		arg_9_0.hexItemList_1[iter_9_2]:SetActive(true)
		table.insert(arg_9_0.allItems, arg_9_0.hexItemList_1[iter_9_2])
	end

	for iter_9_4, iter_9_5 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[3])) do
		if not arg_9_0.hexItemList_2[iter_9_4] then
			local var_9_2 = Object.Instantiate(arg_9_0.cardItemGo_, arg_9_0.hex2ContentTrs_)

			arg_9_0.hexItemList_2[iter_9_4] = CivilizationIlluItem.New(var_9_2)
		end

		arg_9_0.hexItemList_2[iter_9_4]:SetData(3, iter_9_5, function(arg_12_0)
			arg_9_0:ChooseItem(3, arg_12_0)
		end)
		arg_9_0.hexItemList_2[iter_9_4]:SetActive(true)
		table.insert(arg_9_0.allItems, arg_9_0.hexItemList_2[iter_9_4])
	end

	for iter_9_6, iter_9_7 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[4])) do
		if not arg_9_0.techItemList_[iter_9_6] then
			local var_9_3 = Object.Instantiate(arg_9_0.cardItemGo_, arg_9_0.techContentTrs_)

			arg_9_0.techItemList_[iter_9_6] = CivilizationIlluItem.New(var_9_3)
		end

		arg_9_0.techItemList_[iter_9_6]:SetData(arg_9_0.type_, iter_9_7, function(arg_13_0)
			arg_9_0:ChooseItem(4, arg_13_0)
		end)
		arg_9_0.techItemList_[iter_9_6]:SetActive(true)
		table.insert(arg_9_0.allItems, arg_9_0.techItemList_[iter_9_6])
	end
end

function var_0_0.ChooseItem(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.selectID_ == arg_14_2 then
		return
	end

	arg_14_0.rightAnimator_:Play("UI_GodEaterUI_Com_rightbg01_cx", 0, 0)

	arg_14_0.selectID_ = arg_14_2
	arg_14_0.selectType = arg_14_1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.allItems) do
		if iter_14_1:GetID() == arg_14_0.selectID_ then
			iter_14_1:SetSelect(true)
		else
			iter_14_1:SetSelect(false)
		end
	end

	arg_14_0:RefreshUI(arg_14_1)
end

function var_0_0.RefreshUI(arg_15_0, arg_15_1)
	local var_15_0 = ActivityCivilizationIlluCfg[arg_15_0.selectID_]

	if arg_15_1 == 1 then
		arg_15_0.typeController_:SetSelectedState("grid")

		arg_15_0.gridImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)
		arg_15_0.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_1")
	elseif arg_15_1 == 4 then
		arg_15_0.typeController_:SetSelectedState("skill")

		arg_15_0.techImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)
		arg_15_0.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
	else
		arg_15_0.typeController_:SetSelectedState("Hekes")

		arg_15_0.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)

		if arg_15_1 == 2 then
			arg_15_0.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4")
		else
			arg_15_0.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
		end
	end

	if table.indexof(arg_15_0.illuIDList_, arg_15_0.selectID_) then
		arg_15_0.lockController_:SetSelectedState("unlock")
	else
		arg_15_0.lockController_:SetSelectedState("lock")
	end

	arg_15_0.titleText_.text = var_15_0.name
	arg_15_0.descText_.text = var_15_0.desc
	arg_15_0.gridTitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_1")
	arg_15_0.hex1TitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4")
	arg_15_0.hex2TitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
	arg_15_0.techTitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.allItems) do
		iter_18_1:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
	Object.Destroy(arg_18_0.gameObject_)
end

return var_0_0
