local PushSnowBallRankView = class("PushSnowBallRankView", ReduxView)

function PushSnowBallRankView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRankUI"
end

function PushSnowBallRankView:UIParent()
	return manager.ui.uiMain.transform
end

function PushSnowBallRankView:Init()
	self.rankTypeConst_ = PushSnowBallData:GetRankTypeConst()

	self:InitUI()

	self.modeController_ = ControllerUtil.GetController(self.transform_, "mode")
	self.guildController_ = ControllerUtil.GetController(self.guildBtn_.transform, "toggle")
	self.allController_ = ControllerUtil.GetController(self.allBtn_.transform, "toggle")
	self.bossController_ = ControllerUtil.GetController(self.bossModelBtn_.transform, "toggle")
	self.survivalController_ = ControllerUtil.GetController(self.survivalModelBtn_.transform, "toggle")

	self:AddListeners()
end

function PushSnowBallRankView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.rankList_, PushSnowBallRankItem)
end

function PushSnowBallRankView:AddListeners()
	self:AddBtnListener(self.allBtn_, nil, function()
		if PushSnowBallData:GetCurRankType() ~= self.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(self.activityID_, self.index)
		end

		PushSnowBallData:SetCurRankType(self.rankTypeConst_.ALL)
		self.allController_:SetSelectedState("on")
		self.guildController_:SetSelectedState("off")
		self:Refresh()
	end)
	self:AddBtnListener(self.guildBtn_, nil, function()
		if PushSnowBallData:GetCurRankType() ~= self.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(self.activityID_, self.index)
		end

		PushSnowBallData:SetCurRankType(self.rankTypeConst_.GUILD)
		self.guildController_:SetSelectedState("on")
		self.allController_:SetSelectedState("off")
		self:Refresh()
	end)
	self:AddBtnListener(self.bossModelBtn_, nil, function()
		self:OnClickSubType(1)
		self.bossController_:SetSelectedState("on")
		self.survivalController_:SetSelectedState("off")
	end)
	self:AddBtnListener(self.survivalModelBtn_, nil, function()
		self:OnClickSubType(2)
		self.survivalController_:SetSelectedState("on")
		self.bossController_:SetSelectedState("off")
	end)
end

function PushSnowBallRankView:OnClickSubType(arg_10_1)
	local var_10_0 = PushSnowBallData:GetCurRankType()

	if self.index ~= arg_10_1 then
		if var_10_0 == self.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(self.activityID_, arg_10_1)
		elseif var_10_0 == self.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(self.activityID_, arg_10_1)
		end
	end

	self.index = arg_10_1

	self:Refresh()
end

function PushSnowBallRankView:OnEnter()
	self.activityID_ = PushSnowBallData:GetTeamRankActivtyID()

	local var_11_0 = ActivityData:GetActivityData(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.startTime_ = var_11_0.startTime
	self.stopTime_ = var_11_0.stopTime
	self.index = 1

	RankAction.QueryActivityRank(self.activityID_, self.index)
	self.bossController_:SetSelectedState("on")
	self.survivalController_:SetSelectedState("off")
	self:Refresh()
	self:AddTimer()
end

function PushSnowBallRankView:OnExit()
	self.pos_ = self.list_:GetScrolledPosition()

	self:StopTimer()
	manager.windowBar:HideBar()
	PushSnowBallData:SetCurRankType(self.rankTypeConst_.ALL)
end

function PushSnowBallRankView:Refresh()
	local var_13_0 = PushSnowBallData:GetCurRankType()

	if self.index == 1 then
		self.modeController_:SetSelectedState("boss")
	else
		self.modeController_:SetSelectedState("necking")
	end

	if var_13_0 == self.rankTypeConst_.ALL then
		local var_13_1 = RankData:GetActivityRank(self.activityID_, self.index)

		if var_13_1 then
			self.rankList = var_13_1.rankList or {}
		end

		if var_13_1 then
			local var_13_2, var_13_3 = var_13_1:GetCurRankDes()

			self.rankText_.text = var_13_2
			self.scoreText_.text = var_13_3
		else
			self.rankText_.text = ""
			self.scoreText_.text = ""
		end
	else
		local var_13_4 = RankData:GetGuildActivityRank(self.activityID_, self.index)

		if var_13_4 then
			self.rankList = var_13_4.rankList or {}
		end

		if var_13_4 then
			local var_13_5, var_13_6 = var_13_4:GetCurRankDes()

			self.rankText_.text = var_13_5
			self.scoreText_.text = var_13_6
		else
			self.rankText_.text = ""
			self.scoreText_.text = ""
		end
	end

	self.list_:StartScroll(#self.rankList)

	if self.pos_ then
		self.list_:SetScrolledPosition(self.pos_)
	end

	local var_13_7 = PlayerData:GetPlayerInfo()

	self.nameText_.text = var_13_7 and var_13_7.nick
	self.iconImg_.sprite = ItemTools.getItemSprite(var_13_7 and var_13_7.portrait)
	self.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_13_7.icon_frame)

	self:RefreshGuildRankGo()
end

function PushSnowBallRankView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:Refresh(self.rankList[arg_14_1], self.index)
end

function PushSnowBallRankView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	PushSnowBallRankView.super.Dispose(self)
end

function PushSnowBallRankView:AddTimer()
	self:StopTimer()

	self.leftTimeText_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.leftTimeText_.text = manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end, 1, -1)

	self.timer_:Start()
end

function PushSnowBallRankView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PushSnowBallRankView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		SetActive(self.guildBtn_.gameObject, false)
	else
		SetActive(self.guildBtn_.gameObject, true)
	end
end

function PushSnowBallRankView:OnRankUpdate()
	self:Refresh()
end

return PushSnowBallRankView
