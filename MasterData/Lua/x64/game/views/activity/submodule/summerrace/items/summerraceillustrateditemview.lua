local SummerRaceIllustratedItemView = class("SummerRaceIllustratedItemView", ReduxView)

local function var_0_1(arg_1_0)
	local var_1_0 = tostring((arg_1_0 or nil) and (arg_1_0.iconPath or ""))

	return var_1_0 ~= "" and var_1_0 or nil
end

function SummerRaceIllustratedItemView:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform

	self:Init()
end

function SummerRaceIllustratedItemView:Init()
	self:BindCfgUI()
	self:BindRuntime_()
	self:AddUIListener()
end

function SummerRaceIllustratedItemView:BindRuntime_()
	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")

	if self.nameText_ == nil then
		self.viewType_ = "body"
	else
		self.viewType_ = "option"
		self.typeController_ = self.controllerEx_:GetController("type")
		self.costController_ = self.controllerEx_:GetController("cost")
	end
end

function SummerRaceIllustratedItemView:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickHandler_ ~= nil and self.itemData_ ~= nil then
			self.clickHandler_(self.index_, self.itemData_, "select")
		end
	end)
end

function SummerRaceIllustratedItemView:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.itemData_ = arg_7_1
	self.index_ = arg_7_2
	self.clickHandler_ = arg_7_3

	self:RefreshView()
end

function SummerRaceIllustratedItemView:RefreshView()
	if self.itemData_ == nil then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	self.icon_.spriteSync = var_0_1(self.itemData_)

	if self.viewType_ == "body" then
		self.lockController_:SetSelectedState(self.itemData_.isUnlocked and "hide" or "show")
		self.selectController_:SetSelectedState(self.itemData_.isSelected and "show" or "hide")

		return
	end

	if self.nameText_ ~= nil then
		self.nameText_.text = tostring(self.itemData_.itemName or "")
	end

	if self.costText_ ~= nil then
		self.costText_.text = tostring(self.itemData_.cost or "")
	end

	self.typeController_:SetSelectedState(self.itemData_.typeText == SummerRaceConst.FILTER.EQUIP and "parts" or "weapon")
	self.costController_:SetSelectedState(tostring(self.itemData_.costState or "white"))
	self.selectController_:SetSelectedState(self.itemData_.isSelected and "show" or "hide")
	self.lockController_:SetSelectedState(self.itemData_.isUnlocked and "false" or "true")
end

function SummerRaceIllustratedItemView:Dispose()
	self.itemData_ = nil
	self.clickHandler_ = nil

	self:RemoveAllListeners()
	SummerRaceIllustratedItemView.super.Dispose(self)
end

return SummerRaceIllustratedItemView
