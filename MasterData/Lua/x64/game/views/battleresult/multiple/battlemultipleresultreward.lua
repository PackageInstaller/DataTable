local BattleMultipleResultReward = class("BattleMultipleResultReward", ReduxView)

function BattleMultipleResultReward:OnCtor(arg_1_1)
	self.gameObejct_ = arg_1_1
	self.transform_ = self.gameObejct_.transform

	self:BindCfgUI(self.gameObejct_)

	self.rewardUIList_ = LuaList.New(handler(self, self.RefreshRenderer), self.uiList_, CommonItemView)
end

function BattleMultipleResultReward:Dispose()
	if self.rewardUIList_ then
		self.rewardUIList_:Dispose()

		self.rewardUIList_ = nil
	end

	BattleMultipleResultReward.super.Dispose(self)

	self.gameObejct_ = nil
end

function BattleMultipleResultReward:SetRewardList(arg_3_1, arg_3_2)
	if self.index_ ~= arg_3_1 then
		self.index_ = arg_3_1
		self.rewardList_ = arg_3_2

		self:RefreshUI()
	end
end

function BattleMultipleResultReward:RefreshUI()
	self.indexText_.text = self.index_

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.rewardList_) do
		table.insert(var_4_0, iter_4_1)
	end

	local var_4_1 = sortReward((mergeReward((formatRewardCfgList(var_4_0)))))

	self.rewardList_ = var_4_1

	self.rewardUIList_:StartScroll(#var_4_1, 1)
end

function BattleMultipleResultReward:RefreshRenderer(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.rewardList_[arg_5_1].id
	var_5_0.number = self.rewardList_[arg_5_1].num

	if ItemCfg[self.rewardList_[arg_5_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[self.rewardList_[arg_5_1].id].type then
		if EquipCfg[self.rewardList_[arg_5_1].id] then
			var_5_0.race = EquipCfg[self.rewardList_[arg_5_1].id].race or 0
		end
	end

	function var_5_0:clickFun()
		ShowPopItem(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_5_2:SetData(var_5_0)
end

return BattleMultipleResultReward
