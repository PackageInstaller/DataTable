local LimitTimeTaskBaseTabItem = class("LimitTimeTaskBaseTabItem", ReduxView)

function LimitTimeTaskBaseTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LimitTimeTaskBaseTabItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function LimitTimeTaskBaseTabItem:InitUI()
	self:BindCfgUI()
end

function LimitTimeTaskBaseTabItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self:OnSelectBtnClick()
	end)
end

function LimitTimeTaskBaseTabItem:OnSelectBtnClick()
	self.onClick_(self.index_)
end

function LimitTimeTaskBaseTabItem:SetSelectedState(arg_7_1)
	self.selectController_:SetSelectedState(self.index_ == arg_7_1 and "select" or "upselect")
end

function LimitTimeTaskBaseTabItem:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.subActivityID_ = arg_8_2
	self.onClick_ = arg_8_3

	self:UpdateView()
end

function LimitTimeTaskBaseTabItem:SetTabRedPointKey(arg_9_1)
	self.redPointKey_ = arg_9_1

	manager.redPoint:bindUIandKey(self.transform_, self.redPointKey_ .. self.subActivityID_)
end

function LimitTimeTaskBaseTabItem:UpdateView()
	if not LimitTimeTaskCfg[self.subActivityID_] then
		return
	end

	self.upsText_.text = LimitTimeTaskCfg[self.subActivityID_].name
	self.sText_.text = LimitTimeTaskCfg[self.subActivityID_].name
	self.upsImg_.sprite = getSpriteWithoutAtlas(LimitTimeTaskCfg[self.subActivityID_].icon)
	self.sImg_.sprite = getSpriteWithoutAtlas(LimitTimeTaskCfg[self.subActivityID_].icon)
end

function LimitTimeTaskBaseTabItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function LimitTimeTaskBaseTabItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function LimitTimeTaskBaseTabItem:GetActivityID()
	return self.subActivityID_
end

function LimitTimeTaskBaseTabItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	LimitTimeTaskBaseTabItem.super.Dispose(self)
end

return LimitTimeTaskBaseTabItem
