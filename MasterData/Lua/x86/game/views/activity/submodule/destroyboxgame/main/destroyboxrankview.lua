RankBaseView = import("game.views.rank.RankBaseView")

local DestroyBoxRankView = class("DestroyBoxRankView", RankBaseView)

function DestroyBoxRankView:UIName()
	return "Widget/Version/BaichaoUI_3_8/BaichaoUI_3_8_BoxUI/BaichaoUI_3_8_BoxRankUI"
end

function DestroyBoxRankView:InitUI()
	self:BindCfgUI()
end

function DestroyBoxRankView:Init()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.tabController_ = self.ndtabControllerexcollection_:GetController("tab")
	self.tabNumController_ = self.ndtabControllerexcollection_:GetController("num")

	self:AddUIListener()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, DestroyBoxRankItem)
	self.subTypeController_ = self.conExCollection_:GetController("subType")
	self.rankTypeController_ = self.toggleConEx:GetController("tab")
end

function DestroyBoxRankView:AddUIListener()
	self:AddBtnListener(self.m_easyBtn, nil, function()
		local var_5_0 = ActivityData:GetActivityData((self:GetRankActivityID(1)))
		local var_5_1 = manager.time:GetServerTime()

		if var_5_1 < var_5_0.startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_5_0.startTime, nil, true)))

			return
		elseif var_5_1 >= var_5_0.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		self.rankIndex_ = 1

		self:SwitchRank(RankBaseConst.RANK_TYPE.ALL, self.subType_, self.heroID_)
	end)
	self:AddBtnListener(self.m_hardBtn, nil, function()
		local var_6_0 = ActivityData:GetActivityData((self:GetRankActivityID(2)))
		local var_6_1 = manager.time:GetServerTime()

		if var_6_1 < var_6_0.startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_6_0.startTime, nil, true)))

			return
		elseif var_6_1 >= var_6_0.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		self.rankIndex_ = 2

		self:SwitchRank(RankBaseConst.RANK_TYPE.ALL, self.subType_, self.heroID_)
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

function DestroyBoxRankView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.rankIndex_ = 1
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

function DestroyBoxRankView:GetRankID()
	self.id_ = DestroyBoxGameData:GetDifficultList(self:GetActivityID())[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][self.rankIndex_]

	return ActivityCfg[DestroyBoxGameCfg[self.id_].activity_id].sub_activity_list[1]
end

function DestroyBoxRankView:GetRankActivityID(arg_13_1)
	return ActivityCfg[DestroyBoxGameCfg[DestroyBoxGameData:GetDifficultList(self:GetActivityID())[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][arg_13_1]].activity_id].sub_activity_list[1]
end

function DestroyBoxRankView:SwitchRank(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = 0

	var_14_0 = arg_14_2 == RankBaseConst.SUB_TYPE.HERO and self:GetSendSeverHeroID(arg_14_3) or 0

	if arg_14_1 == RankBaseConst.RANK_TYPE.GUILD then
		RankAction.QueryGuildActivityRankWitchCallBack(self:GetRankID(), var_14_0, function()
			self:Refresh(arg_14_1, arg_14_2, arg_14_3)
		end)
	else
		RankAction.QueryActivityRankWitchCallBack(self:GetRankID(), var_14_0, function()
			self:Refresh(arg_14_1, arg_14_2, arg_14_3)
		end)
	end
end

function DestroyBoxRankView:Refresh(arg_17_1, arg_17_2, arg_17_3)
	self.initCache_[arg_17_1] = self.initCache_[arg_17_1] or {}

	if arg_17_2 == RankBaseConst.SUB_TYPE.SCORE then
		self.initCache_[arg_17_1][arg_17_2] = true
	else
		self.initCache_[arg_17_1][arg_17_2] = self.initCache_[arg_17_1][arg_17_2] or {}
		self.initCache_[arg_17_1][arg_17_2][arg_17_3] = true
	end

	self.rankType_ = arg_17_1
	self.subType_ = arg_17_2

	if arg_17_2 == RankBaseConst.SUB_TYPE.HERO then
		arg_17_3 = arg_17_3 or self.heroIDList_[1]
		self.heroID_ = arg_17_3
	end

	local var_17_1 = 0

	var_17_1 = self.subType_ == RankBaseConst.SUB_TYPE.HERO and self:GetSendSeverHeroID(self.heroID_) or 0

	if self.rankType_ == RankBaseConst.RANK_TYPE.ALL then
		local var_17_2 = RankData:GetActivityRank(self:GetRankID(), var_17_1)

		if var_17_2 then
			self.rankList_ = var_17_2.rankList or {}
		end

		if var_17_2 then
			local var_17_3, var_17_4 = var_17_2:GetCurRankDes()

			self.m_rank.text = var_17_3
			self.m_score.text = var_17_4
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	else
		local var_17_5 = RankData:GetGuildActivityRank(self:GetRankID(), var_17_1)

		if var_17_5 then
			self.rankList_ = var_17_5.rankList or {}
		end

		if var_17_5 then
			local var_17_6, var_17_7 = var_17_5:GetCurRankDes()

			self.m_rank.text = var_17_6
			self.m_score.text = var_17_7
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	end

	self.list_:StartScroll(#self.rankList_)

	if arg_17_2 == RankBaseConst.SUB_TYPE.SCORE then
		local var_17_8 = PlayerData:GetPlayerInfo()

		self.commonPortrait_:RenderHead(var_17_8 and var_17_8.portrait)
		self.commonPortrait_:RenderFrame(var_17_8 and var_17_8.icon_frame)

		if self.playerAnimator_ then
			SetActive(self.playerIconGo_, false)
			self.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_17_9 = HeroCfg[arg_17_3]

		self.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. self:GetHeroSkinID(arg_17_3))
		self.m_heroNameText_.text = string.format("%s·%s", var_17_9.name, var_17_9.suffix)

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
	self.subTypeController_:SetSelectedState(tostring(self.rankIndex_))
end

function DestroyBoxRankView:Dispose()
	DestroyBoxRankView.super.Dispose(self)
end

return DestroyBoxRankView
