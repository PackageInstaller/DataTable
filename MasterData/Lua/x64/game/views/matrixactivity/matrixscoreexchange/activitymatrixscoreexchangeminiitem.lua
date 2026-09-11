local ActivityMatrixScoreExchangeItem = class("ActivityMatrixScoreExchangeItem", ReduxView)

function ActivityMatrixScoreExchangeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityMatrixScoreExchangeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixScoreExchangeItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.lockController_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
	self.itemList = LuaList.New(handler(self, self.indexItem), self.bonusListGo_, CommonItem)
end

function ActivityMatrixScoreExchangeItem:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		return
	end)
end

function ActivityMatrixScoreExchangeItem:SetData(arg_6_1, arg_6_2)
	self.rewardId = arg_6_1
	self.matrix_activity_id = arg_6_2
	self.scoreText_.text = string.format("%d", ActivityPointRewardCfg[arg_6_1].need)
	self.items = ActivityPointRewardCfg[arg_6_1].reward_item_list

	self.itemList:StartScroll(#self.items)
	self:UpdateView()
end

function ActivityMatrixScoreExchangeItem:UpdateView()
	if ActivityMatrixData:GetMatrixPointRewardState(self.matrix_activity_id, self.rewardId) then
		self.statusController_:SetSelectedState("haveGet")
	elseif ActivityMatrixData:GetMatrixScore(self.matrix_activity_id) >= ActivityPointRewardCfg[self.rewardId].need then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("cannotGet")
	end

	self.lockController_:SetSelectedIndex(0)
end

function ActivityMatrixScoreExchangeItem:indexItem(arg_8_1, arg_8_2)
	local var_8_0 = self.items[arg_8_1]

	arg_8_2:RefreshData(formatReward(self.items[arg_8_1]))
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function ActivityMatrixScoreExchangeItem:Dispose()
	if self.itemList then
		self.itemList:Dispose()

		self.itemList = nil
	end

	ActivityMatrixScoreExchangeItem.super.Dispose(self)
end

return ActivityMatrixScoreExchangeItem
