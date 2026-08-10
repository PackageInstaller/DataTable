local var_0_0 = class("EquipBreakThroughMaterialMapView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipBreakThroughMaterialMapUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_)
	arg_3_0.itemList_ = {}
	arg_3_0.lineList_ = {}
	arg_3_0.affixItemList_ = {}
	arg_3_0.updateHandler_ = handler(arg_3_0, arg_3_0.UpdateBreakThroughData)
	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
	arg_3_0.refreshItemHandler_ = handler(arg_3_0, arg_3_0.RefreshItem)
	arg_3_0.showController_ = ControllerUtil.GetController(arg_3_0.transform_, "show")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_BREAK_THROUGH_INFO")
	EquipBreakThroughMaterialAction.CheckTimeout()
	arg_4_0:RefreshUI()
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_4_0.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, arg_4_0.refreshHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, arg_4_0.refreshItemHandler_)
	manager.redPoint:bindUIandKey(arg_4_0.rewardBtn_.transform, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	arg_5_0.selectMapStageID_ = nil

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemList_) do
		iter_5_1:OnTop()
	end

	SetActive(arg_5_0.difficultyPanel_, true)
end

function var_0_0.OnUpdate(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.itemList_) do
		iter_6_1:OnBehind()
	end

	if arg_6_0:IsOpenSectionInfo() then
		arg_6_0:RefreshScroll()
	else
		arg_6_0.scrollView_.enabled = true
	end
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(arg_7_0.difficultyPanel_, false)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, arg_8_0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, arg_8_0.refreshHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, arg_8_0.refreshItemHandler_)
	manager.redPoint:unbindUIandKey(arg_8_0.rewardBtn_.transform, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.itemList_) do
		iter_8_1:OnExit()
	end

	arg_8_0.scrollMoveView_:OnExit()
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	arg_9_0.scrollMoveView_:Dispose()

	arg_9_0.scrollMoveView_ = nil
	arg_9_0.updateHandler_ = nil
	arg_9_0.refreshHandler_ = nil
	arg_9_0.refreshItemHandler_ = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.itemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.itemList_ = nil

	for iter_9_2, iter_9_3 in pairs(arg_9_0.lineList_) do
		iter_9_3:Dispose()
	end

	arg_9_0.lineList_ = nil

	for iter_9_4, iter_9_5 in pairs(arg_9_0.affixItemList_) do
		iter_9_5:Dispose()
	end

	arg_9_0.affixItemList_ = nil
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EQUIP_BREAK_THROUGH_RESET_MAP"),
			OkCallback = function()
				EquipBreakThroughMaterialAction.ResetMap(function(arg_13_0)
					if isSuccess(arg_13_0.result) then
						ShowTips("ASTROLABE_RESET")
						arg_10_0:RefreshUI()
					end
				end)
			end
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.difficultyBtn_, nil, function()
		if arg_10_0:IsOpenSectionInfo() then
			JumpTools.Back()
			arg_10_0:RefreshScroll()

			return
		end

		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			arg_10_0:Go("equipBreakThroughMaterialMode")
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.teamInfoBtn_, nil, function()
		if arg_10_0:IsOpenSectionInfo() then
			JumpTools.Back()
			arg_10_0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.buffInfoBtn_, nil, function()
		if arg_10_0:IsOpenSectionInfo() then
			JumpTools.Back()
			arg_10_0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.rewardBtn_, nil, function()
		if arg_10_0:IsOpenSectionInfo() then
			JumpTools.Back()
			arg_10_0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialTask", {})
	end)
	arg_10_0:AddBtnListener(arg_10_0.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
	end)
end

function var_0_0.UpdateBreakThroughData(arg_19_0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0:RefreshDifficultyBtn()

	arg_20_0.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	arg_20_0:RefreshItem()
	arg_20_0:CreateLineItemList()
	arg_20_0:RefreshAffix()
	arg_20_0:RefreshScroll()
	arg_20_0:RefreshButton()
end

function var_0_0.RefreshScroll(arg_21_0)
	arg_21_0.selectMapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()

	if arg_21_0.selectMapStageID_ == nil then
		local var_21_0 = EquipBreakThroughMaterialData:GetFinishStageList()
		local var_21_1 = var_21_0[#var_21_0]

		if var_21_1 == nil then
			local var_21_2 = EquipBreakThroughMaterialData:GetMapID()

			var_21_1 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[var_21_2][1]
		end

		arg_21_0.selectMapStageID_ = var_21_1
	end

	local var_21_3 = arg_21_0:GetScrollPos()
	local var_21_4 = arg_21_0:GetScrollWidth()

	arg_21_0.scrollMoveView_:RefreshUI(var_21_3, var_21_4)
end

function var_0_0.RefreshDifficultyBtn(arg_22_0)
	local var_22_0 = EquipBreakThroughMaterialData:GetSelectModeID()
	local var_22_1 = EquipBreakThroughMaterialDifficultyCfg[var_22_0]

	arg_22_0.difficultyText_.text = GetI18NText(var_22_1.name)
	arg_22_0.difficultyBtn_.interactable = table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0
	arg_22_0.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", var_22_0))
end

function var_0_0.RefreshItem(arg_23_0)
	local var_23_0 = EquipBreakThroughMaterialData:GetMapID()
	local var_23_1 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[var_23_0]

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		arg_23_0.itemList_[iter_23_0] = arg_23_0.itemList_[iter_23_0] or EquipBreakThroughMaterialMapItem.New(arg_23_0.item_, arg_23_0.itemParent_)

		arg_23_0.itemList_[iter_23_0]:SetData(iter_23_1)
	end

	for iter_23_2 = #arg_23_0.itemList_, #var_23_1 + 1, -1 do
		arg_23_0.itemList_[iter_23_2]:Dispose()

		arg_23_0.itemList_[iter_23_2] = nil
	end
end

function var_0_0.RefreshButton(arg_24_0)
	if table.length(EquipBreakThroughMaterialData:GetFinishStageList()) > 0 then
		arg_24_0.showController_:SetSelectedState("true")
	else
		arg_24_0.showController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshAffix(arg_25_0)
	local var_25_0 = EquipBreakThroughMaterialData:GetGlobalAffixList()

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if arg_25_0.affixItemList_[iter_25_0] then
			arg_25_0.affixItemList_[iter_25_0]:SetData(iter_25_1)
		else
			arg_25_0.affixItemList_[iter_25_0] = AffixItemView.New(arg_25_0.affixItem_, arg_25_0.affixPanel_, iter_25_1)
		end
	end

	for iter_25_2 = #arg_25_0.affixItemList_, #var_25_0 + 1, -1 do
		arg_25_0.affixItemList_[iter_25_2]:Show(false)
	end
end

function var_0_0.GetScrollWidth(arg_26_0)
	local var_26_0 = EquipBreakThroughMaterialData:GetMapID()
	local var_26_1 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[var_26_0]
	local var_26_2 = EquipBreakThroughMaterialMapCfg[var_26_1[#var_26_1]]

	return EquipBreakThroughMaterialStagePositionCfg[0].row_position * var_26_2.col
end

function var_0_0.GetScrollPos(arg_27_0)
	return EquipBreakThroughMaterialMapCfg[arg_27_0.selectMapStageID_].col * EquipBreakThroughMaterialStagePositionCfg[0].row_position
end

function var_0_0.CreateLineItemList(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.lineList_) do
		iter_28_1:Show(false)
	end

	local var_28_0 = 1
	local var_28_1 = EquipBreakThroughMaterialData:GetMapID()
	local var_28_2 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[var_28_1]

	for iter_28_2, iter_28_3 in pairs(var_28_2) do
		local var_28_3 = arg_28_0.itemList_[iter_28_2]:GetLocalPosition() + Vector3(50, 10, 0)

		for iter_28_4, iter_28_5 in ipairs(EquipBreakThroughMaterialMapCfg[iter_28_3].next_id_list) do
			local var_28_4 = table.keyof(var_28_2, iter_28_5)
			local var_28_5 = arg_28_0.itemList_[var_28_4]:GetLocalPosition() + Vector3(-50, 10, 0)

			arg_28_0.lineList_[var_28_0] = arg_28_0.lineList_[var_28_0] or EquipBreakThroughMaterialLine.New(arg_28_0.lineGo_, arg_28_0.itemParent_, arg_28_0.pointGo_)

			arg_28_0.lineList_[var_28_0]:Show(true)
			arg_28_0.lineList_[var_28_0]:RefreshUI(var_28_3, var_28_5)

			var_28_0 = var_28_0 + 1
		end
	end
end

function var_0_0.IsOpenSectionInfo(arg_29_0)
	return arg_29_0:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return var_0_0
