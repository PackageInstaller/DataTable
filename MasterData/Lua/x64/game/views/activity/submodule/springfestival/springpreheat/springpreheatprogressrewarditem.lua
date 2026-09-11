local SpringPreheatProgressRewardItem = class("SpringPreheatProgressRewardItem", ReduxView)

function SpringPreheatProgressRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()

	self.normalizedLocation_ = 0.5
end

function SpringPreheatProgressRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function SpringPreheatProgressRewardItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_()
		end
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		if self.onClickHandler_ then
			self:onClickHandler_()
		end
	end)
end

function SpringPreheatProgressRewardItem:SetClickHandler(arg_6_1)
	if arg_6_1 then
		self.onClickHandler_ = arg_6_1
	end
end

function SpringPreheatProgressRewardItem:SetData(arg_7_1)
	self.id_ = arg_7_1
end

function SpringPreheatProgressRewardItem:SetNormalizeLocation(arg_8_1)
	self.normalizedLocation_ = arg_8_1
end

function SpringPreheatProgressRewardItem:RefreshUI()
	if SpringPreheatData:IsAcquired(self.id_) then
		self.stateController_:SetSelectedState("received")
	elseif SpringPreheatData:CanAcquire(self.id_) then
		self.stateController_:SetSelectedState("complete")
	else
		self.stateController_:SetSelectedState("uncomplete")
	end

	self.needText_.text = ActivityPointRewardCfg[self.id_].need
end

function SpringPreheatProgressRewardItem:Dispose()
	SpringPreheatProgressRewardItem.super.Dispose(self)
end

return SpringPreheatProgressRewardItem
