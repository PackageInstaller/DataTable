local BattleSettlementMultiResultItem = class("BattleSettlementMultiResultItem", ReduxView)

function BattleSettlementMultiResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSettlementMultiResultItem:TryInitScroll(arg_2_1)
	self.parentScrollRect = arg_2_1

	self:BuildEventDispatch()
end

function BattleSettlementMultiResultItem:BuildEventDispatch()
	self.eventTrigger = self.rewardsListObj_.transform:GetComponent(typeof(EventTriggerListener))

	if not isNil(self.eventTrigger) then
		function self.eventTrigger.onBeginDrag(arg_4_0, arg_4_1)
			if not isNil(self.parentScrollRect) then
				self.parentScrollRect:OnBeginDrag(arg_4_1)
			end
		end

		function self.eventTrigger.onEndDrag(arg_5_0, arg_5_1)
			if not isNil(self.parentScrollRect) then
				self.parentScrollRect:OnEndDrag(arg_5_1)
			end
		end

		function self.eventTrigger.onDrag(arg_6_0, arg_6_1)
			if not isNil(self.parentScrollRect) then
				self.parentScrollRect:OnDrag(arg_6_1)
			end
		end
	end
end

function BattleSettlementMultiResultItem:ClearRef()
	if not isNil(self.eventTrigger) then
		self.eventTrigger:RemoveAllListeners()
	end

	self.eventTrigger = nil
	self.parentScrollRect = nil
end

function BattleSettlementMultiResultItem:Init()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.rewardsListObj_, CommonItemView)
end

function BattleSettlementMultiResultItem:OnEnter()
	return
end

function BattleSettlementMultiResultItem:OnExit()
	return
end

function BattleSettlementMultiResultItem:RenderView(arg_11_1, arg_11_2, arg_11_3)
	self.index_ = arg_11_1
	self.rewardList_ = arg_11_2 or {}
	self.extraReward = arg_11_3 or {}

	self:Render()
end

function BattleSettlementMultiResultItem:Render()
	self.indexTxt_.text = self.index_

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.rewardList_) do
		table.insert(var_12_0, iter_12_1)
	end

	self.rewardList_ = sortReward((mergeReward((formatRewardCfgList(var_12_0)))))

	if #self.extraReward > 0 then
		local var_12_1 = {}

		for iter_12_2, iter_12_3 in pairs(self.extraReward) do
			table.insert(var_12_1, iter_12_3)
		end

		self.extraReward = sortReward((mergeReward((formatRewardCfgList(var_12_1)))))

		local var_12_2, var_12_3, var_12_4 = ActivityMultiRewardData:GetLastBattleMultiData()

		if not var_12_4 or not var_12_2 or var_12_2 <= 0 then
			_, _, var_12_4 = RegressionDataNew:GetMultipleValue()
		end

		self.multiRatioText_.text = var_12_4 / 100

		SetActive(self.multiGo_, true)
	else
		SetActive(self.multiGo_, false)
	end

	self.scrollHelper:StartScroll(#self.rewardList_ + #self.extraReward, 1)
end

function BattleSettlementMultiResultItem:RenderItem(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1 > #self.rewardList_ and self.extraReward[arg_13_1 - #self.rewardList_] or self.rewardList_[arg_13_1]
	local var_13_1 = clone(ItemTemplateData)

	var_13_1.id = var_13_0.id
	var_13_1.number = var_13_0.num

	if ItemCfg[var_13_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_13_0.id].type then
		if EquipCfg[var_13_0.id] then
			var_13_1.race = EquipCfg[var_13_0.id].race or 0
		end
	end

	function var_13_1:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_13_2:SetData(var_13_1)
end

function BattleSettlementMultiResultItem:Dispose()
	self.scrollHelper:Dispose()

	self.scrollHelper = nil

	self:ClearRef()
	BattleSettlementMultiResultItem.super.Dispose(self)
end

return BattleSettlementMultiResultItem
