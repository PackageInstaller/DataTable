local ActivityAttributeArenaRoundView = class("ActivityAttributeArenaRoundView", ReduxView)

function ActivityAttributeArenaRoundView:UIName()
	return AttributeArenaTools.GetRoundUI(self.params_.activityID)
end

function ActivityAttributeArenaRoundView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityAttributeArenaRoundView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaRoundView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityAttributeArenaRoundItem)
end

function ActivityAttributeArenaRoundView:AddUIListener()
	self:AddBtnListener(nil, self.m_mask, function()
		self:Back()
	end)
end

function ActivityAttributeArenaRoundView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ActivityAttributeArenaRoundView:OnEnter()
	self.activity_id = self.params_.activityID
	self.listData = ActivityAttributeArenaRoundCfg.get_id_list_by_activity_id[self.activity_id] or {}

	local var_8_0 = ActivityAttributeArenaData:GetRound(self.activity_id)

	table.sort(self.listData, function(arg_9_0, arg_9_1)
		local var_9_0 = ActivityAttributeArenaRoundCfg[arg_9_0].round
		local var_9_1 = ActivityAttributeArenaRoundCfg[arg_9_1].round

		if var_9_0 == var_8_0 then
			return true
		elseif var_9_1 == var_8_0 then
			return false
		elseif var_9_0 > var_8_0 and var_9_1 > var_8_0 then
			return var_9_0 < var_9_1
		elseif var_9_0 < var_8_0 and var_9_1 < var_8_0 then
			return var_9_0 < var_9_1
		else
			return var_9_0 > var_8_0
		end
	end)
	self.list:StartScroll(#self.listData)
end

function ActivityAttributeArenaRoundView:OnExit()
	return
end

function ActivityAttributeArenaRoundView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.listData[arg_11_1], self.activity_id)
end

function ActivityAttributeArenaRoundView:Dispose()
	self.list:Dispose()
	ActivityAttributeArenaRoundView.super.Dispose(self)
end

return ActivityAttributeArenaRoundView
