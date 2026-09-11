local SummerChessBoardChessPhaseItem = class("SummerChessBoardChessPhaseItem", ReduxView)

function SummerChessBoardChessPhaseItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.activeController_ = self.controllerEx_:GetController("active")
	self.isHeadController_ = self.controllerEx_:GetController("isHead")

	if arg_1_3 == 1 then
		self.isHeadController_:SetSelectedState("true")
	else
		self.isHeadController_:SetSelectedState("false")
	end

	self.rewardItems_ = CommonItemView.New(self.commonItem_)

	SetActive(self.gameObject_, true)
end

function SummerChessBoardChessPhaseItem:Dispose()
	SummerChessBoardChessPhaseItem.super.Dispose(self)
	self.rewardItems_:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerChessBoardChessPhaseItem:AddListeners()
	return
end

function SummerChessBoardChessPhaseItem:SetData(arg_4_1, arg_4_2)
	self.id_ = arg_4_1
	self.idList_ = arg_4_2

	self:RefreshUI()
end

function SummerChessBoardChessPhaseItem:RefreshUI()
	local var_5_0 = ActivityPointRewardCfg[self.id_]
	local var_5_2 = table.keyof(self.idList_, self.id_)
	local var_5_3 = 0

	if var_5_2 > 1 then
		var_5_3 = ActivityPointRewardCfg[self.idList_[var_5_2 - 1]].need
	end

	local var_5_4 = ItemTools.getItemNum(var_5_0.need_item_id)

	self.slider_.value = (var_5_4 - var_5_3) / (var_5_0.need - var_5_3)
	self.numText_.text = var_5_0.need

	if var_5_4 >= var_5_0.need then
		self.activeController_:SetSelectedState("true")
	else
		self.activeController_:SetSelectedState("false")
	end

	local var_5_5 = var_5_0.reward_item_list[1]
	local var_5_6 = clone(ItemTemplateData)

	var_5_6.id = var_5_0.reward_item_list[1][1]
	var_5_6.number = var_5_5[2]

	local var_5_7 = ActivityPointData:IsCompleteID(self.id_)

	if var_5_7 then
		var_5_6.completedFlag = true
	else
		var_5_6.highLight = var_5_4 >= var_5_0.need
	end

	function var_5_6:clickFun()
		if not var_5_7 and var_5_4 >= var_5_0.need then
			ActivitySummerChessBoardAction.ReceiveAllExplorePhaseReward()
		else
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.rewardItems_:SetData(var_5_6)
end

function SummerChessBoardChessPhaseItem:GetLocalPosition()
	return self.transform_.localPosition
end

return SummerChessBoardChessPhaseItem
