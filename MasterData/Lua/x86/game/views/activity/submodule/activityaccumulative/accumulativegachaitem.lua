local AccumulativeGachaItem = class("AccumulativeGachaItem", ReduxView)

function AccumulativeGachaItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.drawstateController_ = self.itemControllerexcollection_:GetController("drawstate")
	self.showController_ = self.itemControllerexcollection_:GetController("show")
end

function AccumulativeGachaItem:SetData(arg_2_1, arg_2_2)
	self.data = arg_2_1

	self.showController_:SetSelectedState("state" .. tostring(3))

	self.commonItemView_ = self.commonItemView_ or CommonItemView.New(self.commonItem_)

	local var_2_0 = formatReward(ActivityPointRewardCfg[arg_2_1.id].reward_item_list[1])

	CommonTools.SetCommonData(self.commonItemView_, {
		id = var_2_0.id,
		number = var_2_0.num,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	}, self.CommonData1)

	self.processText_.text = ActivityPointRewardCfg[arg_2_1.id].need

	self.drawstateController_:SetSelectedState(tostring(arg_2_1.state + 1))
end

function AccumulativeGachaItem:Dispose()
	AccumulativeGachaItem.super.Dispose(self)
end

function AccumulativeGachaItem:AddListeners()
	self:AddBtnListener(self.bg01Btn_, nil, function()
		if ActivityPointRewardCfg[self.data.id] and ActivityAccumulativeData:GetNum() < ActivityPointRewardCfg[self.data.id].need then
			ShowTips("ACTIVITY_ACCUMULATIVE_TIPS")

			return
		end

		ActivityAccumulativeAction.GetAccumulateReward(self.data.id)
	end)
end

function AccumulativeGachaItem:RefreshBtnState()
	return
end

function AccumulativeGachaItem:AddTimer()
	return
end

return AccumulativeGachaItem
