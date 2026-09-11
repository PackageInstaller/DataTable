local LimitedCalculationRankView = class("LimitedCalculationRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function LimitedCalculationRankView:UIName()
	return LimitedCalculationTools.GetRankUIName(self.params_.activityID)
end

function LimitedCalculationRankView:UIParent()
	return manager.ui.uiMain.transform
end

function LimitedCalculationRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, LimitedCalculationRankItem)
end

function LimitedCalculationRankView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.rankList_[arg_5_1])
end

function LimitedCalculationRankView:AddUIListeners()
	self:AddToggleListener(self.allToggle_, function(arg_7_0)
		if arg_7_0 then
			self.curRankType_ = var_0_1.ALL

			self:RefreshUI()
		end
	end)
	self:AddToggleListener(self.guildToggle_, function(arg_8_0)
		if arg_8_0 then
			self.curRankType_ = var_0_1.GUILD

			self:RefreshUI()
		end
	end)
end

function LimitedCalculationRankView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.guildToggle_.isOn = true
	self.allToggle_.isOn = true

	if GuildData:GetGuildInfo().id == nil then
		SetActive(self.guildToggleGo_, false)

		self.curRankType_ = var_0_1.ALL
	else
		SetActive(self.guildToggleGo_, true)
	end

	self:RefreshUI()
end

function LimitedCalculationRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function LimitedCalculationRankView:RefreshSelfRank()
	local var_11_0 = PlayerData:GetPlayerInfo()

	self.icon_.sprite = ItemTools.getItemSprite(var_11_0 and var_11_0.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_11_0.icon_frame)
	self.name_.text = GetI18NText(var_11_0.nick)

	if self.curRankType_ == var_0_1.ALL then
		local var_11_1 = RankData:GetActivityRank(self.activityID_)

		if var_11_1 then
			local var_11_2, var_11_3 = var_11_1:GetCurRankDes()

			self.rank_.text = var_11_2
			self.score_.text = var_11_3
		else
			self.rank_.text = ""
			self.score_.text = ""
		end
	else
		local var_11_4 = RankData:GetGuildActivityRank(self.activityID_)

		if var_11_4 then
			local var_11_5, var_11_6 = var_11_4:GetCurRankDes()

			self.rank_.text = var_11_5
			self.score_.text = var_11_6
		else
			self.rank_.text = ""
			self.score_.text = ""
		end
	end
end

function LimitedCalculationRankView:RefreshNone()
	self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function LimitedCalculationRankView:RefreshList()
	if self.curRankType_ == var_0_1.ALL then
		local var_13_0 = RankData:GetActivityRank(self.activityID_)

		if var_13_0 then
			self.rankList_ = var_13_0.rankList or {}
		end
	else
		local var_13_1 = RankData:GetGuildActivityRank(self.activityID_)

		if var_13_1 then
			self.rankList_ = var_13_1.rankList or {}
		end
	end

	table.sort(self.rankList_, function(arg_14_0, arg_14_1)
		return arg_14_0.rank < arg_14_1.rank
	end)
	self.scrollHelper_:StartScroll(#self.rankList_)
end

function LimitedCalculationRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function LimitedCalculationRankView:OnExit()
	manager.windowBar:HideBar()

	self.allToggle_.isOn = true
end

function LimitedCalculationRankView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	LimitedCalculationRankView.super.Dispose(self)
end

return LimitedCalculationRankView
