local NewWarChessDiceItem = class("NewWarChessDiceItem", ReduxView)

function NewWarChessDiceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessDiceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessDiceItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "point")
	self.maskController_ = ControllerUtil.GetController(self.transform_, "mask")
end

function NewWarChessDiceItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_)
		end
	end)
end

function NewWarChessDiceItem:SetStatus(arg_6_1)
	self.stateController_:SetSelectedIndex(arg_6_1)
end

function NewWarChessDiceItem:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.diceData_ = arg_7_2
	self.dicePoint_ = self.diceData_[1]

	self:RefreshUI()
end

function NewWarChessDiceItem:RefreshUI()
	if self.diceData_.IsNew == true then
		self.animator_:Play("ani")
	else
		self.animator_:Play("empty")
	end

	self.stateController_:SetSelectedIndex(self.dicePoint_)

	if self.diceData_.hasInput then
		self.maskController_:SetSelectedState("true")
	else
		self.maskController_:SetSelectedState("false")
	end
end

function NewWarChessDiceItem:SetClickCallBack(arg_9_1)
	self.clickHandler_ = arg_9_1
end

function NewWarChessDiceItem:Dispose()
	self.clickHandler_ = nil

	Object.Destroy(self.gameObject_)
	NewWarChessDiceItem.super.Dispose(self)
end

return NewWarChessDiceItem
