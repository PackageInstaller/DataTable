local ActivityInfinityPoolBaseItem = class("ActivityInfinityPoolBaseItem", ReduxView)

function ActivityInfinityPoolBaseItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:BindCfgUI()
	self:AddListeners()
end

function ActivityInfinityPoolBaseItem:SetData(arg_2_1, arg_2_2)
	self.poolID_ = arg_2_1
	self.index_ = arg_2_2

	self:RefreshUI()
end

function ActivityInfinityPoolBaseItem:RefreshUI()
	local var_3_0 = OsirisInfinityPoolData:GetPoolData(self.poolID_)

	if var_3_0.openBoxList[self.index_] then
		if self.rewardItem_ then
			self.rewardItem_:SetData(var_3_0.openBoxList[self.index_])
		else
			self.rewardItem_ = self:GetRewardItem(var_3_0.openBoxList[self.index_])
		end
	elseif self.rewardItem_ then
		self.rewardItem_:Show(false)
	end

	self:Show(true)
end

function ActivityInfinityPoolBaseItem:GetRewardItem(arg_4_1)
	return RewardPoolItem.New(self.goItemParent_, arg_4_1)
end

function ActivityInfinityPoolBaseItem:Dispose()
	ActivityInfinityPoolBaseItem.super.Dispose(self)

	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityInfinityPoolBaseItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_7_0 = OsirisInfinityPoolData:GetPoolData(self.poolID_)

		if var_7_0.openBoxList[self.index_] then
			return
		end

		if ItemTools.getItemNum(ActivityInfinityPoolCfg[self.poolID_].cost_item[1]) < ActivityInfinityPoolCfg[self.poolID_].cost_item[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(ActivityInfinityPoolCfg[self.poolID_].cost_item[1])))

			return
		end

		local var_7_1 = var_7_0.isOpenCoreItem

		OsirisAction.OpenPoolBox(self.poolID_, {
			self.index_
		}, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				self:RefreshUI()
				getReward({
					{
						id = arg_8_0.box_list[1].item.id,
						num = arg_8_0.box_list[2].item.num
					}
				})

				if var_7_1 == false and var_7_0.isOpenCoreItem == true then
					ShowTips(string.format(GetTips("UNLOCK_INFINITY"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(ActivityInfinityPoolCfg[self.poolID_].activity_id)), GetI18NText(ActivityCfg[ActivityInfinityPoolCfg[self.poolID_].activity_id].remark)))
				end
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
end

function ActivityInfinityPoolBaseItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

return ActivityInfinityPoolBaseItem
