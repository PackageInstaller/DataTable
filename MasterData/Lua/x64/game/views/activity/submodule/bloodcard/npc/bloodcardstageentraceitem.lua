local BloodCardEntraceItem = class("BloodCardEntraceItem", ReduxView)

function BloodCardEntraceItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
	self:InitUI()
end

function BloodCardEntraceItem:InitUI()
	self.stateController_ = self.controller_:GetController("deck")
end

function BloodCardEntraceItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			if not BloodCardData:GetStageHasUnlock(self.cfg_.id) then
				ShowTips("ACTIVITY_BLOOD_CARD_GAME_CARD_LOCK")

				return
			end

			self.clickCallBack_(self.stageID_)
		end
	end)
end

function BloodCardEntraceItem:SetData(arg_5_1)
	self.stageID_ = arg_5_1
	self.cfg_ = BloodCardGameStageCfg[self.stageID_]

	self:RefreshUI()
end

function BloodCardEntraceItem:RefreshUI()
	local var_6_0 = BloodCardData:GetStageHasUnlock(self.cfg_.id) and ActivityData:GetActivityIsOpen(self.cfg_.activity_id)

	if BloodCardData:GetStageHasPass(self.cfg_.id) then
		self.stateController_:SetSelectedState("clear")
	elseif var_6_0 then
		self.stateController_:SetSelectedState("normal")
	else
		self.stateController_:SetSelectedState("lock")
	end

	self.name_.text = self.cfg_.name
end

function BloodCardEntraceItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

function BloodCardEntraceItem:Dispose()
	self.clickCallBack_ = nil

	BloodCardEntraceItem.super.Dispose(self)
end

return BloodCardEntraceItem
