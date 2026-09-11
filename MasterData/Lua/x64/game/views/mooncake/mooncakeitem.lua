local MoonCakeItem = class("MoonCakeItem", ReduxView)

function MoonCakeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
	SetActive(self.gameObject_, true)
end

function MoonCakeItem:InitUI()
	self:BindCfgUI()

	self.selecteController_ = ControllerUtil.GetController(self.transform_, "select")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.enoughController_ = ControllerUtil.GetController(self.transform_, "enough")
	self.unlockController_ = ControllerUtil.GetController(self.transform_, "unlock")
end

function MoonCakeItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.ID_, self)
		end
	end)
end

function MoonCakeItem:Dispose()
	self.clickHandler_ = nil

	MoonCakeItem.super.Dispose(self)
end

function MoonCakeItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.itemID_ = arg_6_1
	self.ID_ = arg_6_2

	if arg_6_3 ~= true then
		self:RefreshUI()
	end

	self:SetActive(true)
end

function MoonCakeItem:RefreshUI()
	self:RefreshNum()
	self:RefreshName()
	self:RefreshIcon()
end

function MoonCakeItem:RefreshNum(arg_8_1)
	arg_8_1 = arg_8_1 or ItemTools.getItemNum(self.itemID_)
	self.numText_.text = arg_8_1
end

function MoonCakeItem:RefreshName()
	self.nameText_.text = ItemTools.getItemName(self.itemID_)
end

function MoonCakeItem:RefreshIcon()
	self.icon_.sprite = ItemTools.getItemSprite(self.itemID_)
end

function MoonCakeItem:SetUnlock(arg_11_1)
	self.unlockController_:SetSelectedState(arg_11_1 == true and "on" or "off")
end

function MoonCakeItem:SetSelect(arg_12_1)
	self.selecteController_:SetSelectedState(self.ID_ == arg_12_1 and "on" or "off")
end

function MoonCakeItem:SetEnough(arg_13_1)
	self.enoughController_:SetSelectedState(arg_13_1 == true and "on" or "off")
end

function MoonCakeItem:SetMakeTimes(arg_14_1)
	self.makeTimesText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_PREVIEW"), arg_14_1)
end

function MoonCakeItem:SetType(arg_15_1)
	self.type_ = arg_15_1

	self.typeController_:SetSelectedIndex(self.type_)
end

function MoonCakeItem:SetClickHandler(arg_16_1)
	self.clickHandler_ = arg_16_1
end

function MoonCakeItem:SetActive(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)
end

return MoonCakeItem
