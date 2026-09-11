local RankBaseView = class("RankBaseView", ReduxView)

function RankBaseView:UIName()
	return "Widget/System/Polyhedron/PolyhedronRankUI"
end

function RankBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function RankBaseView:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.rankTypeController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.subTypeController_ = ControllerUtil.GetController(self.m_subTypeController, "subType")
end

function RankBaseView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, RankItemBase)
	self.heroList_ = LuaList.New(handler(self, self.IndexHeroItem), self.heroListGo_, RankHeroItemBase)
	self.heroClickHandler_ = handler(self, self.OnClickHero)
end

function RankBaseView:OnEnter()
	self.panelAnim_:Update(0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.initCache_ = {}
	self.heroCache_ = {}

	self:RefreshGuildRankGo()
	RankAction.QueryActivityAllRank(self:GetRankID(), function()
		RankAction.QueryActivityRankWitchCallBack(self:GetRankID(), 0, function()
			self.heroIDList_, self.trialIDList_ = self:GetHeroList()
			self.rankType_ = self.params_.type or RankBaseConst.RANK_TYPE.ALL
			self.subType_ = self.params_.subType or RankBaseConst.SUB_TYPE.BASE
			self.heroID_ = self.params_.heroID or self.heroIDList_[1]

			self:Refresh(self.rankType_, self.subType_, self.heroID_)
			self:AddTimer()
		end)
	end)
end

function RankBaseView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
end

function RankBaseView:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end

	self.heroClickHandler_ = nil

	RankBaseView.super.Dispose(self)
end

function RankBaseView:AddListeners()
	self:AddBtnListener(self.m_scoreBtn, nil, function()
		if self.subType_ == RankBaseConst.SUB_TYPE.SCORE then
			return
		end

		self:SwitchRank(self.rankType_, RankBaseConst.SUB_TYPE.SCORE, self.heroID_)
	end)
	self:AddBtnListener(self.m_heroBtn, nil, function()
		if self.subType_ == RankBaseConst.SUB_TYPE.HERO then
			return
		end

		RankAction.QueryActivityRankWitchCallBack(self:GetRankID(), self:GetSendSeverHeroID(self.heroID_), function()
			self:SwitchRank(self.rankType_, RankBaseConst.SUB_TYPE.HERO, self.heroID_ or self.heroIDList_[1])
			self.heroList_:StartScroll(#self.heroIDList_)
		end)
	end)
	self:AddBtnListener(self.m_guildBtn, nil, function()
		if self.rankType_ == RankBaseConst.RANK_TYPE.GUILD then
			return
		end

		self:SwitchRank(RankBaseConst.RANK_TYPE.GUILD, self.subType_, self.heroID_)
	end)
	self:AddBtnListener(self.m_allBtn, nil, function()
		if self.rankType_ == RankBaseConst.RANK_TYPE.ALL then
			return
		end

		self:SwitchRank(RankBaseConst.RANK_TYPE.ALL, self.subType_, self.heroID_)
	end)
end

function RankBaseView:SwitchRank(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = true

	if self.initCache_[arg_16_1] and self.initCache_[arg_16_1][arg_16_2] then
		if arg_16_2 == RankBaseConst.SUB_TYPE.HERO and not self.initCache_[arg_16_1][arg_16_2][arg_16_3] then
			var_16_0 = false
		end
	else
		var_16_0 = false
	end

	if var_16_0 == true then
		self:Refresh(arg_16_1, arg_16_2, arg_16_3)
	else
		local var_16_1 = 0

		var_16_1 = arg_16_2 == RankBaseConst.SUB_TYPE.HERO and self:GetSendSeverHeroID(arg_16_3) or 0

		if arg_16_1 == RankBaseConst.RANK_TYPE.GUILD then
			RankAction.QueryGuildActivityRankWitchCallBack(self:GetRankID(), var_16_1, function()
				self:Refresh(arg_16_1, arg_16_2, arg_16_3)
			end)
		else
			RankAction.QueryActivityRankWitchCallBack(self:GetRankID(), var_16_1, function()
				self:Refresh(arg_16_1, arg_16_2, arg_16_3)
			end)
		end
	end
end

function RankBaseView:OnClickHero(arg_19_1)
	if self.heroID_ == arg_19_1 then
		return
	end

	for iter_19_0, iter_19_1 in pairs((self.heroList_:GetItemList())) do
		iter_19_1:SetSelect(arg_19_1)
	end

	self:SwitchRank(self.rankType_, self.subType_, arg_19_1)
end

function RankBaseView:Refresh(arg_20_1, arg_20_2, arg_20_3)
	self.initCache_[arg_20_1] = self.initCache_[arg_20_1] or {}

	if arg_20_2 == RankBaseConst.SUB_TYPE.SCORE then
		self.initCache_[arg_20_1][arg_20_2] = true
	else
		self.initCache_[arg_20_1][arg_20_2] = self.initCache_[arg_20_1][arg_20_2] or {}
		self.initCache_[arg_20_1][arg_20_2][arg_20_3] = true
	end

	self.rankType_ = arg_20_1
	self.subType_ = arg_20_2

	if arg_20_2 == RankBaseConst.SUB_TYPE.HERO then
		arg_20_3 = arg_20_3 or self.heroIDList_[1]
		self.heroID_ = arg_20_3
	end

	local var_20_1 = 0

	var_20_1 = self.subType_ == RankBaseConst.SUB_TYPE.HERO and self:GetSendSeverHeroID(self.heroID_) or 0

	if self.rankType_ == RankBaseConst.RANK_TYPE.ALL then
		local var_20_2 = RankData:GetActivityRank(self:GetRankID(), var_20_1)

		if var_20_2 then
			self.rankList_ = var_20_2.rankList or {}
		end

		if var_20_2 then
			local var_20_3, var_20_4 = var_20_2:GetCurRankDes()

			self.m_rank.text = var_20_3
			self.m_score.text = var_20_4
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	else
		local var_20_5 = RankData:GetGuildActivityRank(self:GetRankID(), var_20_1)

		if var_20_5 then
			self.rankList_ = var_20_5.rankList or {}
		end

		if var_20_5 then
			local var_20_6, var_20_7 = var_20_5:GetCurRankDes()

			self.m_rank.text = var_20_6
			self.m_score.text = var_20_7
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	end

	self.list_:StartScroll(#self.rankList_)

	if arg_20_2 == RankBaseConst.SUB_TYPE.SCORE then
		local var_20_8 = PlayerData:GetPlayerInfo()

		self.commonPortrait_:RenderHead(var_20_8 and var_20_8.portrait)
		self.commonPortrait_:RenderFrame(var_20_8 and var_20_8.icon_frame)

		if self.playerAnimator_ then
			SetActive(self.playerIconGo_, false)
			self.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_20_9 = HeroCfg[arg_20_3]

		self.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. self:GetHeroSkinID(arg_20_3))
		self.m_heroNameText_.text = string.format("%s·%s", var_20_9.name, var_20_9.suffix)

		if self.heroAnimator_ then
			SetActive(self.heroIconGo_, false)
			self.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	if self.tabConState_ == nil then
		self.tabConState_ = {
			"all",
			"club"
		}
	end

	self.rankTypeController_:SetSelectedState(self.tabConState_[self.rankType_])
	self.subTypeController_:SetSelectedIndex(self.subType_ - 1)
end

function RankBaseView:IndexItem(arg_21_1, arg_21_2)
	arg_21_2:Refresh(self.rankList_[arg_21_1])
end

function RankBaseView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")
	else
		self.tabNumController_:SetSelectedState("02")
	end
end

function RankBaseView:IndexHeroItem(arg_23_1, arg_23_2)
	arg_23_2:SetData(self.heroIDList_[arg_23_1], self:GetRankID(), self:GetHeroSkinID(self.heroIDList_[arg_23_1]), self:GetSendSeverHeroID(self.heroIDList_[arg_23_1]))
	arg_23_2:SetClickHandler(self.heroClickHandler_)
	arg_23_2:SetSelect(self.heroID_)
end

function RankBaseView:AddTimer()
	self.activityID_ = self:GetActivityID()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:StopTimer()

	self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)
end

function RankBaseView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = nil
end

function RankBaseView:GetRankID()
	return self.params_.rankID or self:GetActivityID()
end

function RankBaseView:GetActivityID()
	return self.params_.activityID
end

function RankBaseView:GetHeroList()
	return RankTools.GetRankHeroList(self:GetRankID(), self:GetActivityID())
end

function RankBaseView:GetHeroSkinID(arg_30_1)
	local var_30_0 = self.trialIDList_[table.keyof(self.heroIDList_, arg_30_1)]

	if var_30_0 == nil or var_30_0 == 0 then
		return HeroTools.HeroUsingSkinInfo(arg_30_1).id
	else
		return HeroStandardSystemCfg[var_30_0].skin_id
	end
end

function RankBaseView:GetSendSeverHeroID(arg_31_1)
	local var_31_0 = table.keyof(self.heroIDList_, arg_31_1)

	if self.trialIDList_[var_31_0] and self.trialIDList_[var_31_0] ~= 0 then
		return self.trialIDList_[var_31_0]
	end

	return arg_31_1
end

return RankBaseView
