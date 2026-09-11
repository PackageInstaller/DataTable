local LuaSlider = class("LuaSlider", ReduxView)

function LuaSlider:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	if not self.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(self)
	end

	self.ctored_ = true
end

function LuaSlider:Init()
	self:InitUI()
	self:AddUIListener()
	self:Reset()
end

function LuaSlider:Reset()
	self.useNumSlider_.value = 1
	self.selectNum_ = 1
end

function LuaSlider:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.inputTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "inputType")
	self.useNumTriggerListener_ = self.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	self.inputField_ = self.numInputGo_:GetComponent("Input")
end

function LuaSlider:AddUIListener()
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ < self:GetMaxBuyNum() then
			self.selectNum_ = self.selectNum_ + 1

			self:RefreshNum()
			self:UpdateSliderPosition()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum_ > 1 then
			self.selectNum_ = self.selectNum_ - 1

			self:RefreshNum()
			self:UpdateSliderPosition()

			return true
		end

		return false
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		self.selectNum_ = self.useNumSlider_.value

		if self.selectNum_ < 1 then
			self.selectNum_ = 1

			self:UpdateSliderPositionBySelectNum()
		elseif self.selectNum_ > self:GetMaxBuyNum() then
			self.selectNum_ = self:GetMaxBuyNum()
		end

		self:RefreshNum()
	end)
	self.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		self:RefreshNum()
		self:UpdateSliderPosition()
		OperationRecorder.Record("shop", "shop_number_slide")
	end))
end

function LuaSlider:SetNumChangeHandler(arg_10_1)
	self.numChangeHandler_ = arg_10_1
end

function LuaSlider:SetData(arg_11_1, arg_11_2)
	if arg_11_2 < arg_11_1 then
		arg_11_2 = arg_11_1
	end

	self.min_ = arg_11_1
	self.max_ = arg_11_2
	self.useNumSlider_.minValue = arg_11_1
	self.useNumSlider_.maxValue = arg_11_2

	self:UpdateSliderPosition()
	self:RefreshNum()
	self:UpdateSliderPositionBySelectNum()
end

function LuaSlider:UpdateSliderPositionBySelectNum()
	self.useNumSlider_.value = self.selectNum_
end

function LuaSlider:RefreshNum()
	local var_13_0 = self:GetMaxBuyNum()

	if var_13_0 <= self.selectNum_ then
		self:SetBtnEnable(self.addBtn_, false)
	else
		self:SetBtnEnable(self.addBtn_, true)
	end

	if self.selectNum_ <= 1 then
		self:SetBtnEnable(self.delBtn_, false)
	else
		self:SetBtnEnable(self.delBtn_, true)
	end

	self.useNumSlider_.minValue = var_13_0 == 1 and 0 or 1

	if self.numChangeHandler_ ~= nil then
		self.numChangeHandler_(self.selectNum_)
	end
end

function LuaSlider:UpdateSliderPosition()
	self.useNumSlider_.value = self.selectNum_
end

function LuaSlider:GetMaxBuyNum()
	return self.max_
end

function LuaSlider:AddEventListeners()
	return
end

function LuaSlider:UpdateBar()
	return
end

function LuaSlider:OnEnter()
	self:AddEventListeners()
end

function LuaSlider:OnExit()
	self:RemoveAllEventListener()
end

function LuaSlider:OnMainHomeViewTop()
	return
end

function LuaSlider:GetSelectedNum()
	return self.selectNum_
end

function LuaSlider:SetBtnEnable(arg_22_1, arg_22_2)
	arg_22_1.interactable = arg_22_2
end

function LuaSlider:Dispose()
	self.useNumSlider_.onValueChanged:RemoveAllListeners()
	self.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	LuaSlider.super.Dispose(self)
	ReduxFactory.GetInstance():OnManagedObjDisposed(self)
end

return LuaSlider
