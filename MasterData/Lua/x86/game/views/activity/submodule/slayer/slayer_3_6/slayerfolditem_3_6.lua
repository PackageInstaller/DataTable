local SlayerFoldItem_3_6 = class("SlayerFoldItem_3_6", ReduxView)

function SlayerFoldItem_3_6:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SlayerFoldItem_3_6:Init()
	self:InitUI()
	self:AddUIListener()
end

function SlayerFoldItem_3_6:InitUI()
	self:BindCfgUI()
	self:InitRewardItem()

	self.buttonController = ControllerUtil.GetController(self.m_btnController, "stateBtn")
end

function SlayerFoldItem_3_6:InitRewardItem()
	self.rewardItemList = {}
	self.itemDataList = {}

	for iter_4_0 = 1, self.m_rewardPanelTrans.childCount do
		self.rewardItemList[iter_4_0] = CommonItemView.New(self.m_rewardPanelTrans:GetChild(iter_4_0 - 1).gameObject)
		self.itemDataList[iter_4_0] = clone(ItemTemplateData)
		self.itemDataList[iter_4_0].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function SlayerFoldItem_3_6:AddUIListener()
	self:AddBtnListener(self.m_receiveBtn, nil, function()
		SlayerAction.QueryPointReward(self.slayer_activity_id, self.pointRewardId)
	end)
end

function SlayerFoldItem_3_6:SetData(arg_8_1, arg_8_2)
	self.slayer_activity_id = arg_8_1
	self.pointRewardId = arg_8_2

	self:RefreshDesc()
	self:RefreshRewardItem()
	self:RefreshState()
end

function SlayerFoldItem_3_6:RefreshRewardItem()
	local var_9_0 = SlayerData:GetReceivedReward(self.slayer_activity_id, self.pointRewardId)

	for iter_9_0, iter_9_1 in ipairs(ActivitySlayerPointRewardCfg[self.pointRewardId].reward_item_list) do
		self.itemDataList[iter_9_0].id = iter_9_1[1]
		self.itemDataList[iter_9_0].number = iter_9_1[2]

		self.rewardItemList[iter_9_0]:SetData(self.itemDataList[iter_9_0])
		self.rewardItemList[iter_9_0]:RefreshGray(var_9_0)
	end

	for iter_9_2 = #ActivitySlayerPointRewardCfg[self.pointRewardId].reward_item_list + 1, #self.rewardItemList do
		self.rewardItemList[iter_9_2]:SetData(nil)
	end
end

function SlayerFoldItem_3_6:RefreshState()
	if SlayerData:GetReceivedReward(self.slayer_activity_id, self.pointRewardId) then
		self.buttonController:SetSelectedIndex(2)
	elseif SlayerData:GetPoint(self.slayer_activity_id, ActivitySlayerPointRewardCfg[self.pointRewardId].activity_id) >= ActivitySlayerPointRewardCfg[self.pointRewardId].need then
		self.buttonController:SetSelectedIndex(0)
	else
		self.buttonController:SetSelectedIndex(1)
	end
end

function SlayerFoldItem_3_6:RefreshDesc()
	if ActivitySlayerPointRewardCfg[self.pointRewardId] then
		self.m_pointLab.text = ActivitySlayerPointRewardCfg[self.pointRewardId].need or ""
	end
end

function SlayerFoldItem_3_6:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.rewardItemList) do
		iter_12_1:Dispose()
	end

	self.rewardItemList = nil

	SlayerFoldItem_3_6.super.Dispose(self)
end

return SlayerFoldItem_3_6
