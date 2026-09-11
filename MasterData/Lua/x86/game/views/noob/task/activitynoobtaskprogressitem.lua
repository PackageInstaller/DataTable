local ActivityNoobTaskProgressItem = class("ActivityNoobTaskProgressItem", ReduxView)
local var_0_1 = {
	"uncomplete",
	"complete",
	"received"
}

function ActivityNoobTaskProgressItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function ActivityNoobTaskProgressItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.need_ > self.progress_ then
			ShowPopItem(POP_ITEM, self.rewardCfg_)

			return
		end

		ActivityNoobAction.ReceiveAccumulateReward(self.index_)
	end)
end

function ActivityNoobTaskProgressItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.needText_.text = arg_4_2[1]
	self.rewardCfg_ = arg_4_2[2]
	self.numText_.text = "x" .. self.rewardCfg_[2]
	self.index_ = arg_4_1
	self.progress_ = arg_4_3
	self.need_ = arg_4_2[1]

	self:RefreshState()
end

function ActivityNoobTaskProgressItem:RefreshState()
	self.stateCon_:SetSelectedState((self:GetItemState()))
end

function ActivityNoobTaskProgressItem:GetItemState()
	if self.need_ > self.progress_ then
		return var_0_1[1]
	elseif not ActivityNoobData:GetAccumulateReceivedList()[self.index_] then
		return var_0_1[2]
	else
		return var_0_1[3]
	end
end

return ActivityNoobTaskProgressItem
