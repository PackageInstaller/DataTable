local var_0_0 = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local var_0_1 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceOptionTipsView")
local var_0_2 = "Widget/System/Activity_SummerRace/com/propertiesItem"
local var_0_3 = class("SummerRaceBattleInfoPopEquipItemView", ReduxView)
local var_0_4 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEquipSlotItemView")

local function var_0_5(arg_1_0, arg_1_1)
	local var_1_0 = tonumber(arg_1_0)

	if var_1_0 == nil then
		return arg_1_1 or 0
	end

	if math.floor(var_1_0) == var_1_0 then
		return var_1_0
	end

	return string.format("%.1f", var_1_0)
end

local function var_0_6(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = tonumber(arg_2_1) or 0
	local var_2_1 = tonumber(arg_2_2) or 0

	if var_2_1 <= 0 then
		error("[SummerRaceBattleInfoPopView] invalid property max value for `" .. tostring(arg_2_0) .. "`")
	end

	return {
		type = arg_2_0,
		value = tostring(arg_2_3 ~= nil and arg_2_3 or var_2_0),
		currentValue = var_2_0,
		maxValue = var_2_1
	}
end

local function var_0_7(arg_3_0)
	if arg_3_0 == nil then
		return nil
	end

	if arg_3_0.typeText == SummerRaceConst.FILTER.EQUIP then
		return {
			title = arg_3_0.itemName,
			cost = arg_3_0.cost,
			desc = arg_3_0.desc,
			properties = {
				var_0_6("Skill", arg_3_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_3_0.typeText), var_0_5(arg_3_0.energyCost, 0))
			}
		}
	end

	return {
		title = arg_3_0.itemName,
		cost = arg_3_0.cost,
		desc = arg_3_0.desc,
		properties = {
			var_0_6("ATK", arg_3_0.damage, SummerRaceData:GetPropertyMax("ATK", arg_3_0.typeText), var_0_5(arg_3_0.damage, 0)),
			var_0_6("ROF", arg_3_0.rof, SummerRaceData:GetPropertyMax("ROF", arg_3_0.typeText), var_0_5(arg_3_0.rof, 0)),
			var_0_6("Skill", arg_3_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_3_0.typeText), var_0_5(arg_3_0.energyCost, 0))
		}
	}
end

local function var_0_8(arg_4_0)
	if arg_4_0 == nil or arg_4_0.gameObject == nil then
		return nil
	end

	return arg_4_0.gameObject:GetComponent(typeof(CanvasGroup))
end

local function var_0_9(arg_5_0, arg_5_1)
	if arg_5_0 == nil then
		return
	end

	arg_5_0.alpha = arg_5_1 and 1 or 0
end

local function var_0_10(arg_6_0)
	if arg_6_0 == nil then
		return nil
	end

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		var_6_0[iter_6_0] = iter_6_1
	end

	return var_6_0
end

local function var_0_11(arg_7_0)
	local var_7_0 = arg_7_0.slotVisualType or arg_7_0.slotType

	if var_7_0 == SummerRaceConst.FILTER.BODY then
		return "disable"
	end

	return var_7_0 == SummerRaceConst.FILTER.EQUIP and "using" or "enable"
end

function var_0_3.OnCtor(arg_8_0, arg_8_1)
	arg_8_0.gameObject_ = arg_8_1
	arg_8_0.transform_ = arg_8_1.transform

	arg_8_0:Init()
end

function var_0_3.Init(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.typeController_ = arg_9_0.controllerEx_ and arg_9_0.controllerEx_:GetController("type") or nil
	arg_9_0.emptyController_ = arg_9_0.controllerEx_ and arg_9_0.controllerEx_:GetController("empty") or nil

	arg_9_0:AddBtnListener(arg_9_0.btn_, nil, function()
		if arg_9_0.clickHandler_ ~= nil and arg_9_0.slotData_ ~= nil and arg_9_0.slotData_.itemClickEnabled == true then
			arg_9_0.clickHandler_(arg_9_0.index_, arg_9_0.slotData_, "select")
		end
	end)
end

function var_0_3.SetData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.slotData_ = arg_11_1
	arg_11_0.index_ = arg_11_2
	arg_11_0.clickHandler_ = arg_11_3

	arg_11_0:RefreshView()
end

function var_0_3.RefreshView(arg_12_0)
	local var_12_0 = arg_12_0.slotData_ or {}
	local var_12_1 = var_12_0.isEmpty ~= true and var_12_0.itemId ~= nil and var_12_0.itemId ~= ""
	local var_12_2 = tostring(var_12_0.iconPath or "")

	arg_12_0.labelText_.text = var_12_1 and tostring(var_12_0.itemName or var_12_0.labelText or "") or ""
	arg_12_0.costText_.text = var_12_1 and tostring(var_12_0.cost or 0) or ""
	arg_12_0.btn_.interactable = var_12_1

	if arg_12_0.typeController_ ~= nil then
		arg_12_0.typeController_:SetSelectedState(var_0_11(var_12_0))
	end

	if arg_12_0.emptyController_ ~= nil then
		arg_12_0.emptyController_:SetSelectedState(var_12_1 and "NotCostShow" or "true")
	end

	if var_12_1 and var_12_2 ~= "" then
		arg_12_0.icon_.spriteSync = var_12_2
		arg_12_0.icon_.color = Color.New(1, 1, 1, 1)
	else
		arg_12_0.icon_.spriteSync = nil
		arg_12_0.icon_.color = Color.New(1, 1, 1, 0)
	end
end

function var_0_3.Dispose(arg_13_0)
	arg_13_0.slotData_ = nil
	arg_13_0.clickHandler_ = nil
	arg_13_0.typeController_ = nil
	arg_13_0.emptyController_ = nil

	var_0_3.super.Dispose(arg_13_0)
end

local var_0_12 = class("SummerRaceBattleInfoPopView", ReduxView)

function var_0_12.UIName(arg_14_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleInfoPopUI"
end

function var_0_12.UIParent(arg_15_0)
	return manager.ui.uiPop.transform
end

function var_0_12.Init(arg_16_0)
	arg_16_0:BindCfgUI()

	arg_16_0.vehicleDisplayView_ = var_0_0.New(arg_16_0.carRootGo_)
	arg_16_0.equipItemList_ = LuaList.New(handler(arg_16_0, arg_16_0.IndexEquipItem), arg_16_0.equipListGo_, var_0_3)
	arg_16_0.propertiesItemPrefab_ = Asset.Load(var_0_2)
	arg_16_0.optionTipsView_ = var_0_1.New(arg_16_0.optionTipsGo_, arg_16_0.propertiesItemPrefab_)
	arg_16_0.equipSlotList_ = {}
	arg_16_0.prevBtnCanvasGroup_ = var_0_8(arg_16_0.prevBtn_)
	arg_16_0.nextBtnCanvasGroup_ = var_0_8(arg_16_0.nextBtn_)
	arg_16_0.modelTypeController_ = arg_16_0.controller_:GetController("modelType")

	arg_16_0:AddUIListener()
end

function var_0_12.AddUIListener(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.closeBtn_, nil, function()
		arg_17_0:Back()
	end)
	arg_17_0:AddBtnListener(arg_17_0.prevBtn_, nil, function()
		arg_17_0:HideOptionTips()
		arg_17_0:SwitchStageWave(-1)
	end)
	arg_17_0:AddBtnListener(arg_17_0.nextBtn_, nil, function()
		arg_17_0:HideOptionTips()
		arg_17_0:SwitchStageWave(1)
	end)
	arg_17_0:AddBtnListener(arg_17_0.tipMaskBtn_, nil, function()
		arg_17_0:HideOptionTips()
	end)
end

function var_0_12.HideOptionTips(arg_22_0)
	if arg_22_0.optionTipsView_ ~= nil then
		arg_22_0.optionTipsView_:SetData(nil)
	end

	if arg_22_0.tipsRootGo_ ~= nil then
		SetActive(arg_22_0.tipsRootGo_, false)
	end
end

function var_0_12.OnEnter(arg_23_0)
	arg_23_0:ResetRuntimeStateDisplay()

	if arg_23_0.params_ ~= nil and arg_23_0.params_.source == "rankDetail" then
		arg_23_0.stageBattleInfoParams_ = nil

		arg_23_0:RefreshByModel(SummerRaceData:GetBattleInfoPopModel(arg_23_0.params_))
		arg_23_0.modelTypeController_:SetSelectedState("chanllge")

		return
	end

	if arg_23_0.params_ ~= nil and arg_23_0.params_.source == "stageDetail" then
		arg_23_0.stageBattleInfoParams_ = {
			source = "stageDetail",
			stageId = arg_23_0.params_.stageId,
			waveIndex = arg_23_0.params_.waveIndex,
			enemyId = arg_23_0.params_.enemyId
		}

		arg_23_0:RefreshStageWave(arg_23_0.stageBattleInfoParams_.waveIndex)
		arg_23_0.modelTypeController_:SetSelectedState("normal")

		return
	end

	arg_23_0.stageBattleInfoParams_ = nil
	arg_23_0.runtimeUpdateHandler_ = handler(arg_23_0, arg_23_0.RefreshByRuntimeState)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), arg_23_0.runtimeUpdateHandler_)
	SummerRaceData:ReplayRuntimeState(arg_23_0.runtimeUpdateHandler_)
end

function var_0_12.OnExit(arg_24_0)
	if arg_24_0.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), arg_24_0.runtimeUpdateHandler_)

		arg_24_0.runtimeUpdateHandler_ = nil
	end
end

function var_0_12.IndexEquipItem(arg_25_0, arg_25_1, arg_25_2)
	arg_25_2:SetData(arg_25_0.equipSlotList_[arg_25_1], arg_25_1, handler(arg_25_0, arg_25_0.OnEquipSlotAction))
end

function var_0_12.OnEquipSlotAction(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3 ~= "select" or arg_26_2 == nil or arg_26_2.itemId == nil or arg_26_2.itemId == "" then
		return
	end

	arg_26_0.selectedSlotIndex_ = arg_26_1

	arg_26_0:RefreshSlotSelection()
	arg_26_0:RefreshOptionTips(arg_26_2.itemId)
	arg_26_0:RefreshOptionTipsPosition()
end

function var_0_12.SwitchStageWave(arg_27_0, arg_27_1)
	if arg_27_0.stageBattleInfoParams_ == nil or arg_27_0.currentModel_ == nil then
		return
	end

	local var_27_0 = (tonumber(arg_27_0.currentModel_.waveIndex) or 0) + arg_27_1

	if arg_27_1 < 0 and arg_27_0.currentModel_.prevEnabled ~= true then
		return
	end

	if arg_27_1 > 0 and arg_27_0.currentModel_.nextEnabled ~= true then
		return
	end

	arg_27_0:RefreshStageWave(var_27_0)
end

function var_0_12.RefreshStageWave(arg_28_0, arg_28_1)
	arg_28_0.stageBattleInfoParams_.waveIndex = arg_28_1
	arg_28_0.stageBattleInfoParams_.enemyId = nil
	arg_28_0.selectedSlotIndex_ = nil

	local var_28_0 = SummerRaceData:GetBattleInfoPopModel(arg_28_0.stageBattleInfoParams_)

	arg_28_0.stageBattleInfoParams_.stageId = var_28_0.stageId
	arg_28_0.stageBattleInfoParams_.waveIndex = var_28_0.waveIndex

	arg_28_0:RefreshByModel(var_28_0)
end

function var_0_12.RefreshByRuntimeState(arg_29_0, arg_29_1)
	if arg_29_1 == nil then
		arg_29_0:ResetRuntimeStateDisplay()

		return
	end

	local var_29_0 = SummerRaceData:GetBattleInfoPopModel(arg_29_1)

	arg_29_0:RefreshByModel(var_29_0)
end

function var_0_12.BuildEquipSlotList(arg_30_0, arg_30_1)
	local var_30_0 = {}
	local var_30_1 = arg_30_0.selectedSlotIndex_

	for iter_30_0 = 1, #(arg_30_1.slotSummary or {}) do
		local var_30_2 = var_0_10(arg_30_1.slotSummary[iter_30_0])

		if var_30_2 ~= nil then
			var_30_2.itemClickEnabled = var_30_2.isEmpty ~= true and var_30_2.itemId ~= nil and tostring(var_30_2.itemId) ~= ""
			var_30_2.isSelected = false
			var_30_0[#var_30_0 + 1] = var_30_2
		end
	end

	if var_30_1 ~= nil and (var_30_0[var_30_1] == nil or var_30_0[var_30_1].itemClickEnabled ~= true) then
		var_30_1 = nil
	end

	if var_30_1 == nil then
		for iter_30_1 = 1, #var_30_0 do
			if var_30_0[iter_30_1].itemClickEnabled == true then
				var_30_1 = iter_30_1

				break
			end
		end
	end

	if var_30_1 ~= nil and var_30_0[var_30_1] ~= nil then
		var_30_0[var_30_1].isSelected = true
	end

	arg_30_0.selectedSlotIndex_ = var_30_1

	return var_30_0
end

function var_0_12.RefreshSlotSelection(arg_31_0)
	for iter_31_0 = 1, #arg_31_0.equipSlotList_ do
		arg_31_0.equipSlotList_[iter_31_0].isSelected = iter_31_0 == arg_31_0.selectedSlotIndex_
	end

	arg_31_0.equipItemList_:StartScroll(#arg_31_0.equipSlotList_)
end

function var_0_12.RefreshOptionTips(arg_32_0, arg_32_1)
	local var_32_0 = SummerRaceData:GetOptionDefById(arg_32_1)

	if var_32_0 == nil then
		arg_32_0:HideOptionTips()

		return
	end

	SetActive(arg_32_0.tipsRootGo_, true)
	arg_32_0.optionTipsView_:SetData(var_0_7(var_32_0))
end

function var_0_12.RefreshOptionTipsPosition(arg_33_0)
	if arg_33_0.selectedSlotIndex_ == nil or arg_33_0.equipItemList_ == nil then
		return
	end

	local var_33_0 = arg_33_0.equipItemList_:GetItemByIndex(arg_33_0.selectedSlotIndex_)

	if var_33_0 == nil or var_33_0.transform_ == nil or arg_33_0.tipsRootGo_ == nil then
		return
	end

	local var_33_1 = var_33_0.transform_:TransformPoint(Vector3(0, 0, 0))
	local var_33_2 = arg_33_0.tipsRootGo_.transform.parent

	if var_33_2 == nil then
		return
	end

	local var_33_3 = var_33_2:InverseTransformPoint(var_33_1)
	local var_33_4 = var_33_0.transform_:GetComponent("RectTransform")
	local var_33_5 = arg_33_0.tipsRootGo_.transform:GetComponent("RectTransform")
	local var_33_6 = (var_33_4 ~= nil and var_33_4.rect.width * 0.5 or 0) + 500

	arg_33_0.tipsRootGo_.transform.localPosition = Vector3(var_33_3.x - var_33_6, var_33_3.y, 0)
end

function var_0_12.RefreshArrowState(arg_34_0, arg_34_1)
	arg_34_1 = arg_34_1 or {}

	local var_34_0 = arg_34_1.source == "stageDetail"

	var_0_9(arg_34_0.prevBtnCanvasGroup_, var_34_0 and arg_34_1.prevEnabled == true)
	var_0_9(arg_34_0.nextBtnCanvasGroup_, var_34_0 and arg_34_1.nextEnabled == true)
end

function var_0_12.RefreshByModel(arg_35_0, arg_35_1)
	arg_35_0.currentModel_ = arg_35_1 or {}
	arg_35_0.titleText_.text = tostring(arg_35_0.currentModel_.titleText or "")
	arg_35_0.summaryText_.text = GetTips("ACTIVITY_TANK_HP")
	arg_35_0.valueText_.text = tostring(arg_35_0.currentModel_.hpText or "")
	arg_35_0.hpText_.text = tostring(arg_35_0.currentModel_.hpText or "")

	if arg_35_0.roleIcon_ ~= nil then
		local var_35_0 = tostring(arg_35_0.currentModel_.enemyAvatarPath or "")

		if var_35_0 == "" and arg_35_0.currentModel_.enemyId ~= nil then
			var_35_0 = SummerRaceData:GetEnemyAvatarPath(arg_35_0.currentModel_.enemyId)
		end

		arg_35_0.roleIcon_.spriteSync = var_35_0 ~= "" and var_35_0 or nil
	end

	arg_35_0.vehicleDisplayView_:AttachHost(arg_35_0.carRootGo_)
	arg_35_0.vehicleDisplayView_:SetData(arg_35_0.currentModel_.vehicleDisplay)

	arg_35_0.equipSlotList_ = arg_35_0:BuildEquipSlotList(arg_35_0.currentModel_)

	arg_35_0.equipItemList_:StartScroll(#arg_35_0.equipSlotList_)

	if arg_35_0.tipsRootGo_ ~= nil and arg_35_0.tipsRootGo_.activeSelf == true then
		local var_35_1 = arg_35_0.selectedSlotIndex_ ~= nil and arg_35_0.equipSlotList_[arg_35_0.selectedSlotIndex_] or nil

		arg_35_0:RefreshOptionTips(var_35_1 and var_35_1.itemId or nil)
		arg_35_0:RefreshOptionTipsPosition()
	else
		arg_35_0:HideOptionTips()
	end

	arg_35_0:RefreshArrowState(arg_35_0.currentModel_)
end

function var_0_12.ResetRuntimeStateDisplay(arg_36_0)
	arg_36_0.currentModel_ = nil
	arg_36_0.selectedSlotIndex_ = nil
	arg_36_0.titleText_.text = ""
	arg_36_0.summaryText_.text = ""
	arg_36_0.valueText_.text = ""
	arg_36_0.hpText_.text = ""
	arg_36_0.equipSlotList_ = {}

	arg_36_0.equipItemList_:StartScroll(0)
	arg_36_0:HideOptionTips()
	arg_36_0.vehicleDisplayView_:AttachHost(arg_36_0.carRootGo_)
	arg_36_0.vehicleDisplayView_:SetData(nil)
end

function var_0_12.Dispose(arg_37_0)
	if arg_37_0.vehicleDisplayView_ then
		arg_37_0.vehicleDisplayView_:Dispose()

		arg_37_0.vehicleDisplayView_ = nil
	end

	if arg_37_0.equipItemList_ then
		arg_37_0.equipItemList_:Dispose()

		arg_37_0.equipItemList_ = nil
	end

	if arg_37_0.optionTipsView_ then
		arg_37_0.optionTipsView_:Dispose()

		arg_37_0.optionTipsView_ = nil
	end

	if arg_37_0.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_2)

		arg_37_0.propertiesItemPrefab_ = nil
	end

	var_0_12.super.Dispose(arg_37_0)
end

return var_0_12
