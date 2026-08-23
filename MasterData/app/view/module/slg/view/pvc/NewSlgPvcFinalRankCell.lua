local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgPvcFinalRankCell = class("NewSlgPvcFinalRankCell")

function NewSlgPvcFinalRankCell:ctor()
	self._curRank = self:getChild("Img_curRank")
	self._rewardList = self:getChild("List_reward")

	self._rewardList:setVirtual()
	self._rewardList:setItemRenderer(handler(self, self._onRewardItemRender))

	self._rewardList2 = self:getChild("List_reward2")

	if self._rewardList2 then
		self._rewardList2:setVirtual()
		self._rewardList2:setItemRenderer(handler(self, self._onRewardItemRender2))
	end

	self._rankRange = {
		-1,
		-1
	}
	self._isSelfCtrl = self:getController("is_self")
end

function NewSlgPvcFinalRankCell:updateNewSlgFinalRewardCell(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = tostring(arg_2_1.min_rank)

	if arg_2_1.max_rank ~= arg_2_1.min_rank then
		var_2_0 = arg_2_1.min_rank .. "-" .. arg_2_1.max_rank
	end

	self._rankRange = {
		arg_2_1.min_rank,
		arg_2_1.max_rank
	}

	self:getChild("Txt_rank"):setText(g.core.lang:get(428946, {
		rank = var_2_0
	}))

	local var_2_1 = {}

	for iter_2_0 = 1, 7 do
		if arg_2_1["reward_size_" .. iter_2_0] > 0 then
			table.insert(var_2_1, {
				type = arg_2_1["reward_type_" .. iter_2_0],
				value = arg_2_1["reward_value_" .. iter_2_0],
				size = arg_2_1["reward_size_" .. iter_2_0]
			})
		end
	end

	self._rewardData = var_2_1

	self._rewardList:setNumItems(#self._rewardData)

	if arg_2_2 and arg_2_2 == var_0_0.RANK_TYPE.PERSONAL_ALL then
		self:setCtrlState("type", {
			index = 1
		})

		self._exRewardList = {}

		for iter_2_1 = 1, 3 do
			if arg_2_1["extra_reward_size_" .. iter_2_1] > 0 then
				table.insert(self._exRewardList, {
					type = arg_2_1["extra_reward_type_" .. iter_2_1],
					value = arg_2_1["extra_reward_value_" .. iter_2_1],
					size = arg_2_1["extra_reward_size_" .. iter_2_1]
				})
			end
		end

		if self._rewardList2 then
			self._rewardList2:setNumItems(#self._exRewardList)
		end
	else
		self:setCtrlState("type", {
			index = 0
		})
	end
end

function NewSlgPvcFinalRankCell:setCurRank(arg_3_1)
	if self._curRank then
		if arg_3_1 >= self._rankRange[1] and arg_3_1 <= self._rankRange[2] then
			self._curRank:setVisible(true)
		else
			self._curRank:setVisible(false)
		end
	end
end

function NewSlgPvcFinalRankCell:_onRewardItemRender(arg_4_1, arg_4_2)
	arg_4_2:setScaleIndex(1)
	arg_4_2:updateIcon(self._rewardData[arg_4_1 + 1], true)
end

function NewSlgPvcFinalRankCell:setSelf()
	self._isSelfCtrl:setSelectedIndex(1)
	self._curRank:setVisible(false)
end

function NewSlgPvcFinalRankCell:_onRewardItemRender2(arg_6_1, arg_6_2)
	if self._exRewardList then
		arg_6_2:setScaleIndex(1)
		arg_6_2:updateIcon(self._exRewardList[arg_6_1 + 1], true)
	end
end

return NewSlgPvcFinalRankCell
