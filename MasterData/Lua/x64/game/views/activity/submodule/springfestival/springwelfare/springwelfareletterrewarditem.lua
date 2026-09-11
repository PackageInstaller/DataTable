local SpringWelfareLetterRewardItem = class("SpringWelfareLetterRewardItem", ReduxView)

function SpringWelfareLetterRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SpringWelfareLetterRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.id_ = 0
end

function SpringWelfareLetterRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function SpringWelfareLetterRewardItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_()
		end
	end)
	self.commonItem_:RegistCallBack(function(arg_6_0)
		if self.onClickHandler_ then
			self:onClickHandler_()
		end
	end)
end

function SpringWelfareLetterRewardItem:SetClickHandler(arg_7_1)
	if arg_7_1 then
		self.onClickHandler_ = arg_7_1
	end
end

function SpringWelfareLetterRewardItem:OnEnter()
	return
end

function SpringWelfareLetterRewardItem:OnExit()
	return
end

function SpringWelfareLetterRewardItem:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	self.super.Dispose(self)
end

function SpringWelfareLetterRewardItem:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.itemID_ = arg_11_1
	self.num_ = arg_11_2
	self.acquired_ = arg_11_3

	self:RefreshUI()
end

function SpringWelfareLetterRewardItem:RefreshUI()
	self.stateController_:SetSelectedState(self.acquired_ and "acquired" or "normal")
	self:RefreshItemUI()
end

function SpringWelfareLetterRewardItem:RefreshItemUI()
	if self.itemID_ == 0 then
		SetActive(self.commonItemGo_, false)

		return
	end

	self.commonItem_:RefreshData({
		id = self.itemID_,
		number = self.num_
	})
	SetActive(self.commonItemGo_, true)
end

return SpringWelfareLetterRewardItem
