local SummerRaceEquipSlotItemView = class("SummerRaceEquipSlotItemView", ReduxView)
local var_0_1 = "UI_icon_cx"

local function var_0_2(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

local function var_0_3(arg_3_0)
	local var_3_1 = arg_3_0.slotState or "normal"

	if var_3_1 ~= "dragging" and var_3_1 ~= "hover" and var_3_1 ~= "blocked" and var_3_1 ~= "replace" then
		var_3_1 = arg_3_0.isEmpty ~= true and arg_3_0.isLocked ~= true and "equipped" or "normal"
	end

	return ((arg_3_0.slotVisualType or arg_3_0.slotType) == SummerRaceConst.FILTER.EQUIP and "weapon_" or "parts_") .. var_3_1
end

local function var_0_4(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 == nil or arg_4_1 == nil then
		return
	end

	arg_4_0.enabled = true

	arg_4_0:Play(arg_4_1, -1, arg_4_2 or 0)
	arg_4_0:Update(0)
end

local function var_0_5(arg_5_0, arg_5_1)
	if arg_5_1 ~= true then
		var_0_4(arg_5_0.partAni_, var_0_1, 1)
		var_0_4(arg_5_0.weaponAni_, var_0_1, 1)
		SetActive(arg_5_0.partsEquipBloomGo_, false)
		SetActive(arg_5_0.weaponEquipBloomGo_, false)

		return
	end

	SetActive(arg_5_0.partsEquipBloomGo_, true)
	SetActive(arg_5_0.weaponEquipBloomGo_, true)
	var_0_4(arg_5_0.partAni_, var_0_1, 0)
	var_0_4(arg_5_0.weaponAni_, var_0_1, 0)
end

local function var_0_6(arg_6_0, arg_6_1)
	if arg_6_1 ~= true then
		var_0_5(arg_6_0, false)

		arg_6_0.equipAnimActive_ = false

		return
	end

	if arg_6_0.equipAnimActive_ ~= true then
		var_0_5(arg_6_0, true)
	end

	arg_6_0.equipAnimActive_ = true
end

local function var_0_7(arg_7_0, arg_7_1)
	if arg_7_0 == nil or arg_7_1 == nil or arg_7_0.slotType == arg_7_1.typeText or arg_7_0.isEmpty ~= true then
		return nil
	end

	return arg_7_0.slotType == SummerRaceConst.FILTER.EQUIP and "weapon_grey" or "parts_grey"
end

function SummerRaceEquipSlotItemView:OnCtor(arg_8_1)
	self.gameObject_ = arg_8_1
	self.transform_ = arg_8_1.transform

	self:Init()
end

function SummerRaceEquipSlotItemView:Init()
	self:BindCfgUI()

	self.appearanceController_ = self.controllerEx_ and self.controllerEx_:GetController("appearance") or nil

	var_0_2(self, self.icon_.gameObject, function()
		if self.clickHandler_ ~= nil and self.slotData_ ~= nil and self.slotData_.itemClickEnabled == true then
			self.clickHandler_(self.index_, self.slotData_, "select")
		end
	end)
	var_0_2(self, self.dragAreaObj_, function()
		if self.clickHandler_ ~= nil and self.slotData_ ~= nil and self.slotData_.itemClickEnabled == true then
			self.clickHandler_(self.index_, self.slotData_, "select")
		end
	end)
end

function SummerRaceEquipSlotItemView:SetData(arg_12_1, arg_12_2, arg_12_3)
	self.slotData_ = arg_12_1
	self.index_ = arg_12_2
	self.clickHandler_ = arg_12_3

	self:RefreshView()
end

function SummerRaceEquipSlotItemView:SetDragOptionData(arg_13_1)
	self.dragOptionData_ = arg_13_1

	self:RefreshView()
end

function SummerRaceEquipSlotItemView:SetAppearanceState(arg_14_1, arg_14_2)
	if self.appearanceController_ == nil or arg_14_1 == nil then
		return
	end

	if arg_14_2 ~= true and self.currentAppearanceState_ == arg_14_1 then
		return
	end

	self.currentAppearanceState_ = arg_14_1

	self.appearanceController_:SetSelectedState(arg_14_1)
end

function SummerRaceEquipSlotItemView:RefreshView()
	local var_15_0 = self.slotData_.isLocked ~= true and self.slotData_.isEmpty ~= true
	local var_15_1 = var_0_7(self.slotData_, self.dragOptionData_) or var_0_3(self.slotData_)
	local var_15_2 = self.slotData_.isEmpty == true or self.slotData_.slotState ~= "normal"
	local var_15_3 = self.slotData_.isLocked ~= true and self.slotData_.isEmpty ~= true and self.slotData_.playEquipAnim == true

	if self.icon_ ~= nil then
		local var_15_4 = var_15_0 and not var_15_2

		if not var_15_0 or var_15_2 then
			self:SetAppearanceState(var_15_1)
			var_0_6(self, var_15_3)
		elseif var_15_4 then
			self:SetAppearanceState(var_15_1, var_15_3)
			var_0_6(self, var_15_3)
		else
			var_0_6(self, false)

			self.icon_.color = Color.New(1, 1, 1, 1)
		end
	end
end

function SummerRaceEquipSlotItemView:Dispose()
	self.slotData_ = nil
	self.clickHandler_ = nil
	self.dragOptionData_ = nil
	self.currentAppearanceState_ = nil
	self.equipAnimActive_ = nil

	SummerRaceEquipSlotItemView.super.Dispose(self)
end

return SummerRaceEquipSlotItemView
