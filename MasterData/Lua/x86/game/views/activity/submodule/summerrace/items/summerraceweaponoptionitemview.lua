local SummerRaceWeaponOptionItemView = class("SummerRaceWeaponOptionItemView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil then
		return
	end

	local var_1_0 = arg_1_0:GetComponent(typeof(Button))

	if var_1_0 ~= nil then
		var_1_0.interactable = false
		var_1_0.enabled = false
	end

	local var_1_1 = arg_1_0:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	if var_1_1 ~= nil then
		for iter_1_0 = 0, var_1_1.Length - 1 do
			if var_1_1[iter_1_0] ~= nil then
				var_1_1[iter_1_0].raycastTarget = false
			end
		end
	end
end

local function var_0_2(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return tostring((arg_2_0 or nil) and (arg_2_0.costState or "white"))
	end

	return (tonumber(arg_2_1) or 0) >= (tonumber(arg_2_0 and arg_2_0.cost) or 0) and "white" or "red"
end

local function var_0_3(arg_3_0)
	local var_3_0 = arg_3_0.clickGo_ or arg_3_0.gameObject_

	return (var_3_0 or nil) and (var_3_0.transform or arg_3_0.transform_)
end

function SummerRaceWeaponOptionItemView:OnCtor(arg_4_1)
	self.gameObject_ = arg_4_1
	self.transform_ = arg_4_1.transform

	self:Init()
end

function SummerRaceWeaponOptionItemView:Init()
	self:BindCfgUI()
	var_0_1(self.clickGo_ or self.gameObject_)

	self.typeController_ = self.controllerEx_:GetController("type")
	self.costController_ = self.controllerEx_:GetController("cost")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
end

function SummerRaceWeaponOptionItemView:BindRedPoint()
	if self.optionData_ ~= nil and self.optionData_.redPointKey ~= nil then
		manager.redPoint:bindUIandKey(var_0_3(self), self.optionData_.redPointKey)
	end
end

function SummerRaceWeaponOptionItemView:UnbindRedPoint()
	if self.optionData_ ~= nil and self.optionData_.redPointKey ~= nil then
		manager.redPoint:unbindUIandKey(var_0_3(self), self.optionData_.redPointKey)
	end
end

function SummerRaceWeaponOptionItemView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self:UnbindRedPoint()

	self.optionData_ = arg_8_1
	self.index_ = arg_8_2
	self.clickHandler_ = arg_8_3

	self:BindRedPoint()
	self:RefreshView()
end

function SummerRaceWeaponOptionItemView:RefreshView()
	if self.optionData_ == nil then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	local var_9_0 = tostring(self.optionData_.iconPath or "")

	self.icon_.spriteSync = var_9_0 ~= "" and var_9_0 or nil

	if self.nameText_ ~= nil then
		self.nameText_.text = tostring(self.optionData_.itemName or "")
	end

	self.costText_.text = tostring(self.optionData_.cost or "")

	self.typeController_:SetSelectedState(self.optionData_.typeText == "equip" and "parts" or "weapon")
	self.costController_:SetSelectedState(var_0_2(self.optionData_, self.availableCost_))
	self.selectController_:SetSelectedState(self.optionData_.isSelected and "show" or "hide")
	self.lockController_:SetSelectedState(self.optionData_.isUnlocked and "false" or "true")
end

function SummerRaceWeaponOptionItemView:RefreshCostStateByAvailableCost(arg_10_1)
	if self.optionData_ == nil or self.costController_ == nil then
		return
	end

	self.availableCost_ = arg_10_1

	local var_10_0 = var_0_2(self.optionData_, self.availableCost_)

	self.optionData_.costState = var_10_0

	self.costController_:SetSelectedState(var_10_0)
end

function SummerRaceWeaponOptionItemView:ClearAvailableCostState()
	self.availableCost_ = nil
end

function SummerRaceWeaponOptionItemView:Dispose()
	self:UnbindRedPoint()

	self.optionData_ = nil
	self.clickHandler_ = nil
	self.availableCost_ = nil

	self:RemoveAllListeners()
	SummerRaceWeaponOptionItemView.super.Dispose(self)
end

return SummerRaceWeaponOptionItemView
