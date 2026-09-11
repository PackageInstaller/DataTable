local SummerRaceEquipItemView = class("SummerRaceEquipItemView", ReduxView)
local var_0_1 = Vector2.New(488, 268)
local var_0_2 = Vector3.New(0.2, 0.2, 0.2)

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:GetOrAddComponent(arg_1_1, typeof(EventTriggerListener))

	var_1_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function()
		arg_1_2()
	end))
	arg_1_0:SetListener(var_1_0)
end

local function var_0_5(arg_4_0)
	local var_4_0 = arg_4_0.slotVisualType or arg_4_0.slotType

	if var_4_0 == SummerRaceConst.FILTER.BODY then
		return "disable"
	end

	return var_4_0 == SummerRaceConst.FILTER.EQUIP and "using" or "enable"
end

function SummerRaceEquipItemView:OnCtor(arg_5_1)
	self.gameObject_ = arg_5_1
	self.transform_ = arg_5_1.transform

	self:Init()
end

function SummerRaceEquipItemView:Init()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_ and self.controllerEx_:GetController("state") or nil
	self.lockController_ = self.controllerEx_ and self.controllerEx_:GetController("mask") or nil
	self.selectController_ = self.controllerEx_ and self.controllerEx_:GetController("select") or nil
	self.appearanceController_ = self.controllerEx_ and self.controllerEx_:GetController("type") or nil
	self.emptyController_ = self.controllerEx_ and self.controllerEx_:GetController("empty") or nil
	self.iconRectTransform_ = self.icon_ ~= nil and self.icon_.transform:GetComponent("RectTransform") or nil

	if self.iconRectTransform_ ~= nil then
		self.defaultIconSizeDelta_ = self.iconRectTransform_.sizeDelta or nil
	end

	if self.iconRectTransform_ ~= nil then
		self.defaultIconLocalScale_ = self.iconRectTransform_.localScale or nil
	end

	var_0_3(self, self.icon_.gameObject, function()
		if self.clickHandler_ ~= nil and self.slotData_ ~= nil and self.slotData_.itemClickEnabled == true then
			self.clickHandler_(self.index_, self.slotData_, "select", self)
		end
	end)
end

function SummerRaceEquipItemView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.slotData_ = arg_8_1
	self.index_ = arg_8_2
	self.clickHandler_ = arg_8_3

	self:RefreshView()
end

function SummerRaceEquipItemView:RefreshIconTransform(arg_9_1)
	if self.iconRectTransform_ == nil then
		return
	end

	if (arg_9_1.slotVisualType or arg_9_1.slotType) == SummerRaceConst.FILTER.BODY then
		self.iconRectTransform_.sizeDelta = var_0_1
		self.iconRectTransform_.localScale = var_0_2

		return
	end

	if self.defaultIconSizeDelta_ ~= nil then
		self.iconRectTransform_.sizeDelta = self.defaultIconSizeDelta_
	end

	if self.defaultIconLocalScale_ ~= nil then
		self.iconRectTransform_.localScale = self.defaultIconLocalScale_
	end
end

function SummerRaceEquipItemView:RefreshView()
	local var_10_0 = self.slotData_.isLocked == true
	local var_10_1 = self.slotData_.isEmpty == true
	local var_10_2 = self.slotData_.isSelected == true
	local var_10_3 = self.slotData_.isLocked ~= true and not var_10_1
	local var_10_4 = var_0_5(self.slotData_)
	local var_10_5 = self.slotData_.isEmpty == true or self.slotData_.slotState ~= "normal"
	local var_10_6 = tostring(self.slotData_.iconPath or "")

	if self.stateController_ ~= nil then
		self.stateController_:SetSelectedState(var_10_3 and "filled" or "empty")
	end

	if self.lockController_ ~= nil then
		self.lockController_:SetSelectedState(var_10_0 and "lock" or "unlock")
	end

	if self.selectController_ ~= nil then
		self.selectController_:SetSelectedState(var_10_2 and "true" or "false")
	end

	if self.emptyController_ ~= nil then
		self.emptyController_:SetSelectedState(var_10_1 and "true" or "NotCostShow")
	end

	if self.icon_ ~= nil then
		self:RefreshIconTransform(self.slotData_)

		local var_10_7 = var_10_3 and not var_10_5
		local var_10_8 = var_10_3 and not var_10_5 and (self.slotData_.showEquippedIcon == true or self.slotData_.interactionMode == "inspect")

		if not var_10_3 or var_10_5 then
			self.icon_.color = Color.New(1, 1, 1, 1)
			self.icon_.raycastTarget = true
			self.icon_.spriteSync = nil

			if self.appearanceController_ ~= nil then
				self.appearanceController_:SetSelectedState(var_10_4)
			end
		elseif var_10_7 then
			if self.appearanceController_ ~= nil then
				self.appearanceController_:SetSelectedState(var_10_4)
			end

			SetActive(self.icon_.gameObject, true)

			self.icon_.spriteSync = var_10_6 ~= "" and var_10_6 or nil
			self.icon_.color = var_10_8 and Color.New(1, 1, 1, 1) or Color.New(1, 1, 1, 0)
			self.icon_.raycastTarget = true
		else
			self.icon_.color = Color.New(1, 1, 1, 1)
			self.icon_.raycastTarget = true
		end
	end
end

function SummerRaceEquipItemView:Dispose()
	self.slotData_ = nil
	self.clickHandler_ = nil
	self.iconRectTransform_ = nil
	self.defaultIconSizeDelta_ = nil
	self.defaultIconLocalScale_ = nil

	SummerRaceEquipItemView.super.Dispose(self)
end

return SummerRaceEquipItemView
