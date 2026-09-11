local ActivityReforgeTeamView = class("ActivityReforgeTeamView", ReduxView)

function ActivityReforgeTeamView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTeamUI"
end

function ActivityReforgeTeamView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityReforgeTeamView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeTeamView:InitUI()
	self:BindCfgUI()

	self.teamList_ = LuaList.New(handler(self, self.IndexTeamItem), self.listGo_, ActivityReforgeTeamItem)
end

function ActivityReforgeTeamView:IndexTeamItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.chapterActivityID_, self.levelID_, self.curWaveID_, self.teamIDList_[arg_5_1])
end

function ActivityReforgeTeamView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function ActivityReforgeTeamView:OnEnter()
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.levelID_ = self.params_.levelID
	self.curWaveID_ = self.params_.curWaveID
	self.levelCfg_ = ActivityReforgeLevelCfg[self.levelID_]

	self:SortTeam()
	self.teamList_:StartScroll(#self.teamIDList_)
end

function ActivityReforgeTeamView:SortTeam()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = 0

	for iter_9_0, iter_9_1 in pairs(self.levelCfg_.team_list) do
		local var_9_5 = ActivityReforgeData:GetTeamCurUsingWaveID(iter_9_1)

		if var_9_5 > 0 then
			if var_9_5 == self.curWaveID_ then
				var_9_4 = iter_9_1
			elseif table.indexof(ActivityReforgeWaveCfg[self.curWaveID_].recommend_team, iter_9_1) then
				table.insert(var_9_3, iter_9_1)
			else
				table.insert(var_9_2, iter_9_1)
			end
		elseif table.indexof(ActivityReforgeWaveCfg[self.curWaveID_].recommend_team, iter_9_1) then
			table.insert(var_9_1, iter_9_1)
		else
			table.insert(var_9_0, iter_9_1)
		end
	end

	self.teamIDList_ = {}

	if var_9_4 > 0 then
		table.insert(self.teamIDList_, var_9_4)
	end

	for iter_9_2, iter_9_3 in pairs(var_9_1) do
		table.insert(self.teamIDList_, iter_9_3)
	end

	for iter_9_4, iter_9_5 in pairs(var_9_0) do
		table.insert(self.teamIDList_, iter_9_5)
	end

	for iter_9_6, iter_9_7 in pairs(var_9_3) do
		table.insert(self.teamIDList_, iter_9_7)
	end

	for iter_9_8, iter_9_9 in pairs(var_9_2) do
		table.insert(self.teamIDList_, iter_9_9)
	end
end

function ActivityReforgeTeamView:OnActivityReforgeCurLevelUpdate()
	self.teamList_:Refresh()
end

function ActivityReforgeTeamView:Dispose()
	if self.teamList_ then
		self.teamList_:Dispose()

		self.teamList_ = nil
	end

	self.super.Dispose(self)
end

return ActivityReforgeTeamView
