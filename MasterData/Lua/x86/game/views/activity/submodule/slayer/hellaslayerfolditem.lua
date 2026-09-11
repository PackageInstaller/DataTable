local HellaSlayerFoldItem = class("HellaSlayerFoldItem", ReduxView)

function HellaSlayerFoldItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaSlayerFoldItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaSlayerFoldItem:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItem)
	self.buttonController = ControllerUtil.GetController(self.m_btnController, "stateBtn")
end

function HellaSlayerFoldItem:AddUIListener()
	self:AddBtnListener(self.m_receiveBtn, nil, function()
		SlayerAction.QueryPointReward(self.slayer_activity_id, self.pointRewardId)
	end)
end

function HellaSlayerFoldItem:SetData(arg_6_1, arg_6_2)
	self.slayer_activity_id = arg_6_1
	self.pointRewardId = arg_6_2

	local var_6_0 = ActivitySlayerPointRewardCfg[arg_6_2]

	if ActivitySlayerPointRewardCfg[arg_6_2] then
		self.m_pointLab.text = var_6_0.need or ""
	end

	if var_6_0 then
		self.rewards = var_6_0.reward_item_list or {}
	end

	self.list:StartScroll(#self.rewards)

	if SlayerData:GetReceivedReward(arg_6_1, arg_6_2) then
		self.buttonController:SetSelectedIndex(2)
	elseif SlayerData:GetPoint(arg_6_1, var_6_0.activity_id) >= var_6_0.need then
		self.buttonController:SetSelectedIndex(0)
	else
		self.buttonController:SetSelectedIndex(1)
	end
end

function HellaSlayerFoldItem:IndexItem(arg_7_1, arg_7_2)
	local var_7_0 = self.rewards[arg_7_1]

	arg_7_2:RefreshData(formatReward(self.rewards[arg_7_1]))
	arg_7_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_7_0)
	end)
end

function HellaSlayerFoldItem:Dispose()
	self.list:Dispose()
	HellaSlayerFoldItem.super.Dispose(self)
end

return HellaSlayerFoldItem
