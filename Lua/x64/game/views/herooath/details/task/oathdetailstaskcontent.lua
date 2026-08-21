local var_0_0 = class("OathBubbleContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexRewardItem), arg_2_0.uiListGo_, OathDetailsTaskItem)
	arg_2_0.oneClickController_ = arg_2_0.controller_:GetController("oneclick")
	arg_2_0.emptyController_ = arg_2_0.controller_:GetController("empty")

	arg_2_0:InitStageUIList()
end

function var_0_0.InitStageUIList(arg_3_0)
	local var_3_0 = 1

	arg_3_0.stageItemList = {}

	for iter_3_0 = 0, arg_3_0.stageContent_.childCount - 1 do
		local var_3_1 = var_3_0 + iter_3_0
		local var_3_2 = arg_3_0.stageContent_:GetChild(iter_3_0).gameObject
		local var_3_3 = OathDetailsStageItem.New(var_3_2, var_3_1)

		var_3_3:SetClickCallback(function()
			arg_3_0:OnClickStageItem(var_3_1)
		end)
		table.insert(arg_3_0.stageItemList, var_3_3)
	end

	arg_3_0.maxLvRange = #arg_3_0.stageItemList
end

function var_0_0.UpdateStageUI(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.stageItemList or {}) do
		iter_5_1:SetData(arg_5_0.heroID)
	end
end

function var_0_0.OnClickStageItem(arg_6_0, arg_6_1)
	if arg_6_0.selectLevel == arg_6_1 then
		return
	end

	arg_6_0.selectLevel = arg_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_0.stageItemList or {}) do
		if iter_6_1 then
			iter_6_1:SetSelectState(iter_6_1.level == arg_6_1)
		end
	end

	arg_6_0:RefreshTaskList()
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(OATH_TASK_UPDATE, handler(arg_7_0, arg_7_0.OnTaskUpdate))
	arg_7_0:RegistEventListener(OATH_HERO_LV_UPDATE, handler(arg_7_0, arg_7_0.OnLvUpdate))
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.oneClickBtn_, nil, function()
		arg_8_0:OnClickOneClickBtn()
	end)
end

function var_0_0.OnClickOneClickBtn(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.oathTaskList) do
		local var_10_1 = OathAssignmentData:GetOathAssignmentByID(iter_10_1)
		local var_10_2 = WeddingAssignmentCfg[iter_10_1]

		if var_10_1.status == 0 and var_10_1.progress >= var_10_2.need then
			table.insert(var_10_0, iter_10_1)
		end
	end

	OathAssignmentAction.SubmitOathTask(var_10_0)
end

function var_0_0.OnLvUpdate(arg_11_0)
	arg_11_0:UpdateStageUI()

	local var_11_0 = Mathf.Min(arg_11_0.selectLevel + 1, arg_11_0.maxLvRange)

	arg_11_0:OnClickStageItem(var_11_0)
end

function var_0_0.OnTaskUpdate(arg_12_0)
	arg_12_0:RefreshTaskList()
	arg_12_0:UpdateStageUI()
end

function var_0_0.IndexRewardItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.oathTaskList[arg_13_1]

	arg_13_2:SetData(var_13_0, #arg_13_0.oathTaskList)
end

function var_0_0.GetDefaultSelectIndex(arg_14_0)
	local var_14_0, var_14_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_14_0.heroID, 1)

	if var_14_0 < var_14_1 then
		return 1
	else
		local var_14_2, var_14_3 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_14_0.heroID, 2)

		if var_14_3 > var_14_2 then
			return 2
		else
			return 3
		end
	end
end

function var_0_0.RefreshUI(arg_15_0, arg_15_1)
	arg_15_0.heroID = arg_15_1
	arg_15_0.emptyText_.text = GetI18NText(WeddingCfg[arg_15_1].no_task_desc)

	arg_15_0:UpdateStageUI()

	local var_15_0 = arg_15_0:GetDefaultSelectIndex()

	arg_15_0:OnClickStageItem(var_15_0)
end

function var_0_0.RefreshTaskList(arg_16_0)
	if not arg_16_0.selectLevel then
		return
	end

	local var_16_0 = WeddingAssignmentCfg.get_id_list_by_hero_id[arg_16_0.heroID]
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = WeddingAssignmentCfg[iter_16_1]

		if var_16_2 and var_16_2.wedding_level == arg_16_0.selectLevel then
			table.insert(var_16_1, iter_16_1)
		end
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0 < arg_17_1
	end)

	arg_16_0.oathTaskList = var_16_1

	arg_16_0.uiList_:StartScroll(#arg_16_0.oathTaskList)

	local var_16_3 = false

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.oathTaskList) do
		local var_16_4 = OathAssignmentData:GetOathAssignmentByID(iter_16_3)
		local var_16_5 = WeddingAssignmentCfg[iter_16_3]

		if var_16_4.status == 0 and var_16_4.progress >= var_16_5.need then
			var_16_3 = true

			break
		end
	end

	if var_16_3 then
		arg_16_0.oneClickController_:SetSelectedState("show")
	else
		arg_16_0.oneClickController_:SetSelectedState("hide")
	end

	if #arg_16_0.oathTaskList == 0 then
		arg_16_0.emptyController_:SetSelectedState("state1")
	else
		arg_16_0.emptyController_:SetSelectedState("state0")
	end
end

function var_0_0.OnShow(arg_18_0)
	arg_18_0:AddEventListeners()
end

function var_0_0.OnHide(arg_19_0)
	arg_19_0:RemoveAllListeners()
end

function var_0_0.OnEnter(arg_20_0)
	return
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0.selectLevel = nil

	arg_21_0:RemoveAllListeners()
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()

	for iter_22_0, iter_22_1 in pairs(arg_22_0.stageItemList) do
		iter_22_1:Dispose()

		iter_22_1 = nil
	end

	arg_22_0.stageItemList = {}

	if arg_22_0.uiList_ then
		arg_22_0.uiList_:Dispose()

		arg_22_0.uiList_ = nil
	end

	arg_22_0.super.Dispose(arg_22_0)
end

return var_0_0
