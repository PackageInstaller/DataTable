local TaskDailyGiftItem = class("TaskDailyGiftItem", ReduxView)
local ActivityPtConst = import("game.const.ActivityPtConst")

function TaskDailyGiftItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.parent_ = arg_1_2

	SetActive(self.gameObject_, true)

	self.index_ = arg_1_3
	self.pointType_ = arg_1_4

	self:Init()
end

function TaskDailyGiftItem:SetIndex(arg_2_1)
	self.index_ = arg_2_1

	self:RefrshUI()
	self:RefreshGift()
end

function TaskDailyGiftItem:Init()
	self:InitUI()
	self:AddListeners()
	self:RefrshUI()
	self:RefreshGift()
end

function TaskDailyGiftItem:Dispose()
	self:RemoveListeners()
	self:RemoveAllEventListener()
	TaskDailyGiftItem.super.Dispose(self)
end

function TaskDailyGiftItem:InitUI()
	self.valueText_ = self:FindCom(typeof(Text), "value")
	self.giftBtn_ = self.gameObject_:GetComponent(typeof(Button))
	self.canReceiveGo_ = self:FindGo("lizi")
	self.alreadyReceiveGo_ = self:FindGo("unlock")
	self.lockReceiveGo_ = self:FindGo("lock")
end

function TaskDailyGiftItem:AddListeners()
	self:AddBtnListener(self.giftBtn_, nil, function()
		local var_7_0 = ActivityPtCfg[self.pointType_].reward[self.index_]

		if self:GetIsReceived() then
			-- block empty
		elseif self:GetCanReceive() then
			ActivityPtAction:TaskDailyGetReward(self.index_, self.pointType_)

			return
		end

		OperationRecorder.Record(self.class.__cname, "rewardPreview")
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_7_0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
end

function TaskDailyGiftItem:RemoveListeners()
	self.giftBtn_.onClick:RemoveAllListeners()
end

function TaskDailyGiftItem:GetCanReceive()
	return ActivityPtCfg[self.pointType_].target[self.index_] <= ActivityPtData:GetCurrentActivityPt(self.pointType_)
end

function TaskDailyGiftItem:GetIsReceived()
	if ActivityPtData:GetDailyGetRewardList()[self.pointType_][ActivityPtCfg[self.pointType_].target[self.index_]] then
		return true
	end

	return false
end

function TaskDailyGiftItem:RefrshUI()
	local var_11_0 = ActivityPtData:GetTotalPt(self.pointType_)

	self.valueText_.text = ActivityPtData:GetGiftPt(self.pointType_, self.index_)
end

function TaskDailyGiftItem:RefreshGift()
	local var_12_0 = false
	local var_12_1 = false
	local var_12_2 = false

	if self:GetIsReceived() then
		var_12_1 = true
	elseif self:GetCanReceive() then
		var_12_2 = true
		var_12_0 = true
	else
		var_12_2 = true
	end

	SetActive(self.canReceiveGo_, var_12_0)
	SetActive(self.alreadyReceiveGo_, var_12_1)
	SetActive(self.lockReceiveGo_, var_12_2)
end

return TaskDailyGiftItem
