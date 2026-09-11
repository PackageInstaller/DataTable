local HellaParkourRewardInfoItem = class("HellaParkourRewardInfoItem", ReduxView)

function HellaParkourRewardInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaParkourRewardInfoItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItem)
	self.rewardController = ControllerUtil.GetController(self.transform_, "reward")
	self.stateController = ControllerUtil.GetController(self.m_stateController, "stateBtn")
end

function HellaParkourRewardInfoItem:InitUI()
	self:BindCfgUI()
end

function HellaParkourRewardInfoItem:AddUIListener()
	self:AddBtnListener(self.m_receiveBtn, nil, function()
		ParkourAction.QueryParkourStarReward(self.entrust_activity_id, self.index)
	end)
end

function HellaParkourRewardInfoItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_1
	self.entrust_activity_id = arg_6_2
	self.rewards = arg_6_3

	self.rewardController:SetSelectedIndex(math.min(3, arg_6_1 - 1))
	self.list:StartScroll(#self.rewards)

	local var_6_0 = ParkourData:GetParkourEntrustData(arg_6_2)

	if not var_6_0 then
		self.stateController:SetSelectedIndex(1)

		return
	end

	local var_6_1 = ParkourData:GetStarCount(arg_6_2)

	if table.indexof(var_6_0.rewards, arg_6_1) then
		self.stateController:SetSelectedIndex(2)
	elseif arg_6_1 == 4 and table.indexof(var_6_0.stars, 4) then
		self.stateController:SetSelectedIndex(0)
	elseif arg_6_1 ~= 4 and arg_6_1 <= var_6_1 then
		self.stateController:SetSelectedIndex(0)
	else
		self.stateController:SetSelectedIndex(1)
	end
end

function HellaParkourRewardInfoItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

function HellaParkourRewardInfoItem:IndexItem(arg_8_1, arg_8_2)
	local var_8_0 = self.rewards[arg_8_1]

	arg_8_2:RefreshData(formatReward(self.rewards[arg_8_1]))
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function HellaParkourRewardInfoItem:Dispose()
	self.list:Dispose()
	HellaParkourRewardInfoItem.super.Dispose(self)
end

return HellaParkourRewardInfoItem
