local SummerRaceVehicleDisplayView = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceVehicleDisplayView")
local SummerRaceOptionTipsView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceOptionTipsView")
local var_0_2 = "Widget/System/Activity_SummerRace/com/propertiesItem"
local SummerRaceBattleInfoPopEquipItemView = class("SummerRaceBattleInfoPopEquipItemView", ReduxView)
local SummerRaceEquipSlotItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEquipSlotItemView")

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

function SummerRaceBattleInfoPopEquipItemView:OnCtor(arg_8_1)
	self.gameObject_ = arg_8_1
	self.transform_ = arg_8_1.transform

	self:Init()
end

function SummerRaceBattleInfoPopEquipItemView:Init()
	self:BindCfgUI()

	self.typeController_ = self.controllerEx_ and self.controllerEx_:GetController("type") or nil
	self.emptyController_ = self.controllerEx_ and self.controllerEx_:GetController("empty") or nil

	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ ~= nil and self.slotData_ ~= nil and self.slotData_.itemClickEnabled == true then
			self.clickHandler_(self.index_, self.slotData_, "select")
		end
	end)
end

function SummerRaceBattleInfoPopEquipItemView:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.slotData_ = arg_11_1
	self.index_ = arg_11_2
	self.clickHandler_ = arg_11_3

	self:RefreshView()
end

function SummerRaceBattleInfoPopEquipItemView:RefreshView()
	local var_12_0 = self.slotData_ or {}
	local var_12_1 = var_12_0.isEmpty ~= true and var_12_0.itemId ~= nil and var_12_0.itemId ~= ""
	local var_12_2 = tostring(var_12_0.iconPath or "")
	local var_12_3 = self.labelText_

	if var_12_1 then
		var_12_3.text = tostring(var_12_0.itemName or var_12_0.labelText or "") or ""
	end

	local var_12_6 = self.costText_

	if var_12_1 then
		var_12_6.text = tostring(var_12_0.cost or 0) or ""
	end

	self.btn_.interactable = var_12_1

	if self.typeController_ ~= nil then
		self.typeController_:SetSelectedState(var_0_11(var_12_0))
	end

	if self.emptyController_ ~= nil then
		self.emptyController_:SetSelectedState(var_12_1 and "NotCostShow" or "true")
	end

	if var_12_1 and var_12_2 ~= "" then
		self.icon_.spriteSync = var_12_2
		self.icon_.color = Color.New(1, 1, 1, 1)
	else
		self.icon_.spriteSync = nil
		self.icon_.color = Color.New(1, 1, 1, 0)
	end
end

function SummerRaceBattleInfoPopEquipItemView:Dispose()
	self.slotData_ = nil
	self.clickHandler_ = nil
	self.typeController_ = nil
	self.emptyController_ = nil

	SummerRaceBattleInfoPopEquipItemView.super.Dispose(self)
end

local SummerRaceBattleInfoPopView = class("SummerRaceBattleInfoPopView", ReduxView)

function SummerRaceBattleInfoPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_BattleUI/Activity_SummerRace_BattleInfoPopUI"
end

function SummerRaceBattleInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceBattleInfoPopView:Init()
	self:BindCfgUI()

	self.vehicleDisplayView_ = SummerRaceVehicleDisplayView.New(self.carRootGo_)
	self.equipItemList_ = LuaList.New(handler(self, self.IndexEquipItem), self.equipListGo_, SummerRaceBattleInfoPopEquipItemView)
	self.propertiesItemPrefab_ = Asset.Load(var_0_2)
	self.optionTipsView_ = SummerRaceOptionTipsView.New(self.optionTipsGo_, self.propertiesItemPrefab_)
	self.equipSlotList_ = {}
	self.prevBtnCanvasGroup_ = var_0_8(self.prevBtn_)
	self.nextBtnCanvasGroup_ = var_0_8(self.nextBtn_)
	self.modelTypeController_ = self.controller_:GetController("modelType")

	self:AddUIListener()
end

function SummerRaceBattleInfoPopView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.prevBtn_, nil, function()
		self:HideOptionTips()
		self:SwitchStageWave(-1)
	end)
	self:AddBtnListener(self.nextBtn_, nil, function()
		self:HideOptionTips()
		self:SwitchStageWave(1)
	end)
	self:AddBtnListener(self.tipMaskBtn_, nil, function()
		self:HideOptionTips()
	end)
end

function SummerRaceBattleInfoPopView:HideOptionTips()
	if self.optionTipsView_ ~= nil then
		self.optionTipsView_:SetData(nil)
	end

	if self.tipsRootGo_ ~= nil then
		SetActive(self.tipsRootGo_, false)
	end
end

function SummerRaceBattleInfoPopView:OnEnter()
	self:ResetRuntimeStateDisplay()

	if self.params_ ~= nil and self.params_.source == "rankDetail" then
		self.stageBattleInfoParams_ = nil

		self:RefreshByModel(SummerRaceData:GetBattleInfoPopModel(self.params_))
		self.modelTypeController_:SetSelectedState("chanllge")

		return
	end

	if self.params_ ~= nil and self.params_.source == "stageDetail" then
		self.stageBattleInfoParams_ = {
			source = "stageDetail",
			stageId = self.params_.stageId,
			waveIndex = self.params_.waveIndex,
			enemyId = self.params_.enemyId
		}

		self:RefreshStageWave(self.stageBattleInfoParams_.waveIndex)
		self.modelTypeController_:SetSelectedState("normal")

		return
	end

	self.stageBattleInfoParams_ = nil
	self.runtimeUpdateHandler_ = handler(self, self.RefreshByRuntimeState)

	manager.notify:RegistListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)
	SummerRaceData:ReplayRuntimeState(self.runtimeUpdateHandler_)
end

function SummerRaceBattleInfoPopView:OnExit()
	if self.runtimeUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventRuntimeUpdated(), self.runtimeUpdateHandler_)

		self.runtimeUpdateHandler_ = nil
	end
end

function SummerRaceBattleInfoPopView:IndexEquipItem(arg_25_1, arg_25_2)
	arg_25_2:SetData(self.equipSlotList_[arg_25_1], arg_25_1, handler(self, self.OnEquipSlotAction))
end

function SummerRaceBattleInfoPopView:OnEquipSlotAction(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3 ~= "select" or arg_26_2 == nil or arg_26_2.itemId == nil or arg_26_2.itemId == "" then
		return
	end

	self.selectedSlotIndex_ = arg_26_1

	self:RefreshSlotSelection()
	self:RefreshOptionTips(arg_26_2.itemId)
	self:RefreshOptionTipsPosition()
end

function SummerRaceBattleInfoPopView:SwitchStageWave(arg_27_1)
	if self.stageBattleInfoParams_ == nil or self.currentModel_ == nil then
		return
	end

	local var_27_0 = (tonumber(self.currentModel_.waveIndex) or 0) + arg_27_1

	if arg_27_1 < 0 and self.currentModel_.prevEnabled ~= true then
		return
	end

	if arg_27_1 > 0 and self.currentModel_.nextEnabled ~= true then
		return
	end

	self:RefreshStageWave(var_27_0)
end

function SummerRaceBattleInfoPopView:RefreshStageWave(arg_28_1)
	self.stageBattleInfoParams_.waveIndex = arg_28_1
	self.stageBattleInfoParams_.enemyId = nil
	self.selectedSlotIndex_ = nil

	local var_28_0 = SummerRaceData:GetBattleInfoPopModel(self.stageBattleInfoParams_)

	self.stageBattleInfoParams_.stageId = var_28_0.stageId
	self.stageBattleInfoParams_.waveIndex = var_28_0.waveIndex

	self:RefreshByModel(var_28_0)
end

function SummerRaceBattleInfoPopView:RefreshByRuntimeState(arg_29_1)
	if arg_29_1 == nil then
		self:ResetRuntimeStateDisplay()

		return
	end

	self:RefreshByModel((SummerRaceData:GetBattleInfoPopModel(arg_29_1)))
end

function SummerRaceBattleInfoPopView:BuildEquipSlotList(arg_30_1)
	local var_30_0 = {}
	local var_30_1 = self.selectedSlotIndex_

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

	self.selectedSlotIndex_ = var_30_1

	return var_30_0
end

function SummerRaceBattleInfoPopView:RefreshSlotSelection()
	for iter_31_0 = 1, #self.equipSlotList_ do
		self.equipSlotList_[iter_31_0].isSelected = iter_31_0 == self.selectedSlotIndex_
	end

	self.equipItemList_:StartScroll(#self.equipSlotList_)
end

function SummerRaceBattleInfoPopView:RefreshOptionTips(arg_32_1)
	local var_32_0 = SummerRaceData:GetOptionDefById(arg_32_1)

	if var_32_0 == nil then
		self:HideOptionTips()

		return
	end

	SetActive(self.tipsRootGo_, true)
	self.optionTipsView_:SetData(var_0_7(var_32_0))
end

function SummerRaceBattleInfoPopView:RefreshOptionTipsPosition()
	if self.selectedSlotIndex_ == nil or self.equipItemList_ == nil then
		return
	end

	local var_33_0 = self.equipItemList_:GetItemByIndex(self.selectedSlotIndex_)

	if var_33_0 == nil or var_33_0.transform_ == nil or self.tipsRootGo_ == nil then
		return
	end

	local var_33_1 = var_33_0.transform_:TransformPoint(Vector3(0, 0, 0))

	if self.tipsRootGo_.transform.parent == nil then
		return
	end

	local var_33_2 = self.tipsRootGo_.transform.parent:InverseTransformPoint(var_33_1)
	local var_33_3 = var_33_0.transform_:GetComponent("RectTransform")
	local var_33_4 = self.tipsRootGo_.transform:GetComponent("RectTransform")

	self.tipsRootGo_.transform.localPosition = Vector3(var_33_2.x - (((var_33_3 ~= nil or nil) and (var_33_3.rect.width * 0.5 or 0)) + 500), var_33_2.y, 0)
end

function SummerRaceBattleInfoPopView:RefreshArrowState(arg_34_1)
	arg_34_1 = arg_34_1 or {}

	local var_34_0 = arg_34_1.source == "stageDetail"

	var_0_9(self.prevBtnCanvasGroup_, arg_34_1.source == "stageDetail" and arg_34_1.prevEnabled == true)
	var_0_9(self.nextBtnCanvasGroup_, var_34_0 and arg_34_1.nextEnabled == true)
end

function SummerRaceBattleInfoPopView:RefreshByModel(arg_35_1)
	self.currentModel_ = arg_35_1 or {}
	self.titleText_.text = tostring(self.currentModel_.titleText or "")
	self.summaryText_.text = GetTips("ACTIVITY_TANK_HP")
	self.valueText_.text = tostring(self.currentModel_.hpText or "")
	self.hpText_.text = tostring(self.currentModel_.hpText or "")

	if self.roleIcon_ ~= nil then
		local var_35_1 = tostring(self.currentModel_.enemyAvatarPath or "")

		if var_35_1 == "" and self.currentModel_.enemyId ~= nil then
			var_35_1 = SummerRaceData:GetEnemyAvatarPath(self.currentModel_.enemyId)
		end

		self.roleIcon_.spriteSync = var_35_1 ~= "" and var_35_1 or nil
	end

	self.vehicleDisplayView_:AttachHost(self.carRootGo_)
	self.vehicleDisplayView_:SetData(self.currentModel_.vehicleDisplay)

	self.equipSlotList_ = self:BuildEquipSlotList(self.currentModel_)

	self.equipItemList_:StartScroll(#self.equipSlotList_)

	if self.tipsRootGo_ ~= nil and self.tipsRootGo_.activeSelf == true then
		if self.selectedSlotIndex_ ~= nil then
			local var_35_2 = self.equipSlotList_[self.selectedSlotIndex_]

			if not self.equipSlotList_[self.selectedSlotIndex_] then
				var_35_2 = nil

				local var_35_3

				if var_35_2 then
					var_35_3 = var_35_2.itemId or nil
				end
			end
		end

		self:RefreshOptionTips(var_35_3)
		self:RefreshOptionTipsPosition()
	else
		self:HideOptionTips()
	end

	self:RefreshArrowState(self.currentModel_)
end

function SummerRaceBattleInfoPopView:ResetRuntimeStateDisplay()
	self.currentModel_ = nil
	self.selectedSlotIndex_ = nil
	self.titleText_.text = ""
	self.summaryText_.text = ""
	self.valueText_.text = ""
	self.hpText_.text = ""
	self.equipSlotList_ = {}

	self.equipItemList_:StartScroll(0)
	self:HideOptionTips()
	self.vehicleDisplayView_:AttachHost(self.carRootGo_)
	self.vehicleDisplayView_:SetData(nil)
end

function SummerRaceBattleInfoPopView:Dispose()
	if self.vehicleDisplayView_ then
		self.vehicleDisplayView_:Dispose()

		self.vehicleDisplayView_ = nil
	end

	if self.equipItemList_ then
		self.equipItemList_:Dispose()

		self.equipItemList_ = nil
	end

	if self.optionTipsView_ then
		self.optionTipsView_:Dispose()

		self.optionTipsView_ = nil
	end

	if self.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_2)

		self.propertiesItemPrefab_ = nil
	end

	SummerRaceBattleInfoPopView.super.Dispose(self)
end

return SummerRaceBattleInfoPopView
