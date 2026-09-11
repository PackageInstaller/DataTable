local ActivityAttributeArenaRoundItem = class("ActivityAttributeArenaRoundItem", ReduxView)

function ActivityAttributeArenaRoundItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityAttributeArenaRoundItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaRoundItem:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityAttributeArenaTagItem)
	self.stateController = ControllerUtil.GetController(self.transform_, "stateBtn")
end

function ActivityAttributeArenaRoundItem:AddUIListener()
	return
end

function ActivityAttributeArenaRoundItem:SetData(arg_5_1, arg_5_2)
	local var_5_0 = ActivityAttributeArenaRoundCfg[arg_5_1]

	self.m_lab.text = GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND", ActivityAttributeArenaRoundCfg[arg_5_1].round)

	local var_5_1 = ActivityAttributeArenaData:GetRound(arg_5_2)
	local var_5_2 = ActivityData:GetActivityRefreshTime(self.activity_id)

	if var_5_1 == var_5_0.round then
		self.stateController:SetSelectedIndex(0)

		self.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_START")
	elseif var_5_1 < var_5_0.round then
		self.stateController:SetSelectedIndex(1)

		local var_5_3 = ActivityData:GetActivityRefreshTimeList(arg_5_2)

		self.m_timeLab.text = var_5_0.round - var_5_1 <= #var_5_3 and GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND_TIME", manager.time:GetLostTimeStr2(var_5_3[var_5_0.round - var_5_1])) or ""
	else
		self.stateController:SetSelectedIndex(2)

		self.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_OVER")
	end

	self.listData = var_5_0.arena_id_list

	self.list:StartScroll(#self.listData)
end

function ActivityAttributeArenaRoundItem:Dispose()
	self.list:Dispose()
	ActivityAttributeArenaRoundItem.super.Dispose(self)
end

function ActivityAttributeArenaRoundItem:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.listData[arg_7_1])
end

return ActivityAttributeArenaRoundItem
