local PolyhedronRankView = class("PolyhedronRankView", ReduxView)

function PolyhedronRankView:UIName()
	return "Widget/System/Polyhedron/PolyhedronRankUI"
end

function PolyhedronRankView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronRankView:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.subTypeController = ControllerUtil.GetController(self.m_subTypeController, "subType")
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
end

function PolyhedronRankView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, PolyhedronRankItem)
	self.heroList_ = LuaList.New(handler(self, self.IndexHeroItem), self.heroListGo_, PolyhedronRankHeroItem)
	self.heroClickHandler_ = handler(self, self.OnClickHero)
end

function PolyhedronRankView:AddListeners()
	self:AddBtnListener(self.m_scoreBtn, nil, function()
		if self.subType == PolyhedronConst.RANK_SUB_TYPE.SCORE then
			return
		end

		self:SwitchRank(self.rankType, PolyhedronConst.RANK_SUB_TYPE.SCORE, self.heroID)
	end)
	self:AddBtnListener(self.m_heroBtn, nil, function()
		if self.subType == PolyhedronConst.RANK_SUB_TYPE.HERO then
			return
		end

		if self.heroIDList_ == nil then
			PolyhedronAction.QueryCurRank(PolyhedronConst.RANK_SUB_TYPE.HERO, function()
				self:SelectHeroRank()
			end)
		else
			self:SelectHeroRank()
		end
	end)
	self:AddBtnListener(self.m_guildBtn, nil, function()
		if self.rankType == PolyhedronConst.RANK_TYPE.GUILD then
			return
		end

		self:SwitchRank(PolyhedronConst.RANK_TYPE.GUILD, self.subType, self.heroID)
	end)
	self:AddBtnListener(self.m_allBtn, nil, function()
		if self.rankType == PolyhedronConst.RANK_TYPE.ALL then
			return
		end

		self:SwitchRank(PolyhedronConst.RANK_TYPE.ALL, self.subType, self.heroID)
	end)
end

function PolyhedronRankView:SelectHeroRank()
	self.heroIDList_ = PolyhedronData:GetSortRankHeroIDList()

	self:SwitchRank(self.rankType, PolyhedronConst.RANK_SUB_TYPE.HERO, self.heroID or self.heroIDList_[1])
	self.heroList_:StartScroll(#self.heroIDList_)
end

function PolyhedronRankView:SwitchRank(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = true

	if self.initCache[arg_12_1] and self.initCache[arg_12_1][arg_12_2] then
		if arg_12_2 == PolyhedronConst.RANK_SUB_TYPE.HERO and not self.initCache[arg_12_1][arg_12_2][arg_12_3] then
			var_12_0 = false
		end
	else
		var_12_0 = false
	end

	if var_12_0 == true then
		self:Refresh(arg_12_1, arg_12_2, arg_12_3)
	elseif arg_12_1 == PolyhedronConst.RANK_TYPE.GUILD then
		PolyhedronAction.QueryGuildRankList(arg_12_2, arg_12_3)
	else
		PolyhedronAction.QueryRankList(arg_12_2, arg_12_3)
	end
end

function PolyhedronRankView:OnClickHero(arg_13_1)
	if self.heroID == arg_13_1 then
		return
	end

	for iter_13_0, iter_13_1 in pairs((self.heroList_:GetItemList())) do
		iter_13_1:SetSelect(arg_13_1)
	end

	self:SwitchRank(self.rankType, self.subType, arg_13_1)
end

function PolyhedronRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronRankView:OnUpdate()
	if self.params_.type == nil then
		return
	end

	self.params_.type = nil
	self.params_.subType = nil
	self.params_.heroID = nil

	self:Refresh(self.params_.type, self.params_.subType, self.params_.heroID)
end

function PolyhedronRankView:OnEnter()
	self.panelAnim_:Update(0)

	self.initCache = {}
	self.heroCache = {}

	if self.params_.subType ~= PolyhedronConst.RANK_SUB_TYPE.HERO then
		self.heroIDList_ = nil
	else
		self.heroList_:StartScroll(#self.heroIDList_, table.indexof(self.heroIDList_, self.heroID) or 1)
	end

	self:RefreshGuildRankGo()
	self:OnUpdate()
	self:AddTimer()
end

function PolyhedronRankView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
end

function PolyhedronRankView:Refresh(arg_18_1, arg_18_2, arg_18_3)
	self.initCache[arg_18_1] = self.initCache[arg_18_1] or {}

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		self.initCache[arg_18_1][arg_18_2] = true
	else
		self.initCache[arg_18_1][arg_18_2] = self.initCache[arg_18_1][arg_18_2] or {}
		self.initCache[arg_18_1][arg_18_2][arg_18_3] = true
	end

	self.rankType = arg_18_1
	self.subType = arg_18_2

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		arg_18_3 = arg_18_3 or self.heroIDList_[1]
		self.heroID = arg_18_3
	end

	local var_18_1 = 0

	var_18_1 = self.subType == PolyhedronConst.RANK_SUB_TYPE.HERO and self.heroID or 0

	if self.rankType == PolyhedronConst.RANK_TYPE.ALL then
		local var_18_2 = RankData:GetCommonRank(RankConst.RANK_ID.POLYHERON, var_18_1)

		if var_18_2 then
			self.rankList = var_18_2.rankList or {}
		end

		if var_18_2 then
			local var_18_3, var_18_4 = var_18_2:GetCurRankDes()

			self.m_rank.text = var_18_3
			self.m_score.text = var_18_4
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	else
		local var_18_5 = RankData:GetGuildCommonRank(RankConst.RANK_ID.POLYHERON, var_18_1)

		if var_18_5 then
			self.rankList = var_18_5.rankList or {}
		end

		if var_18_5 then
			local var_18_6, var_18_7 = var_18_5:GetCurRankDes()

			self.m_rank.text = var_18_6
			self.m_score.text = var_18_7
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	end

	self.list_:StartScroll(#self.rankList)

	if arg_18_2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		local var_18_8 = PlayerData:GetPlayerInfo()

		self.commonPortrait_:RenderHead(var_18_8 and var_18_8.portrait)
		self.commonPortrait_:RenderFrame(var_18_8.icon_frame)

		if self.playerAnimator_ then
			SetActive(self.playerIconGo_, false)
			self.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		local var_18_9 = HeroCfg[arg_18_3]

		self.m_heroIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. PolyhedronData:GetHeroUsingSkinInfo(arg_18_3).id)
		self.m_heroNameText_.text = string.format("%s·%s", GetI18NText(var_18_9.name), GetI18NText(var_18_9.suffix))

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

	self.tabController_:SetSelectedState(self.tabConState_[self.rankType])
	self.subTypeController:SetSelectedIndex(self.subType - 1)
end

function PolyhedronRankView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:Refresh(self.rankList[arg_19_1])
end

function PolyhedronRankView:Dispose()
	self.commonPortrait_:Dispose()
	self.list_:Dispose()

	self.list_ = nil

	self.heroList_:Dispose()

	self.heroList_ = nil
	self.heroClickHandler_ = nil

	PolyhedronAction.ResetRankCache()
	PolyhedronRankView.super.Dispose(self)
end

function PolyhedronRankView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")
	else
		self.tabNumController_:SetSelectedState("02")
	end
end

function PolyhedronRankView:IndexHeroItem(arg_22_1, arg_22_2)
	arg_22_2:SetData(self.heroIDList_[arg_22_1])
	arg_22_2:SetClickHandler(self.heroClickHandler_)
	arg_22_2:SetSelect(self.heroID)
end

function PolyhedronRankView:AddTimer()
	self.activityID_ = PolyhedronData:GetActivityID()
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

function PolyhedronRankView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = nil
end

function PolyhedronRankView:AdaptLeft()
	if self.leftTrs_ == nil then
		self.leftGo_ = self:FindGo("RankList_01/panel/left")
		self.leftTrs_ = self.leftGo_:GetComponent(typeof(RectTransform))
		self.needAdaptLeft_ = false
	end

	PolyhedronRankView.super.AdaptLeft(self)
end

function PolyhedronRankView:AdaptRight()
	if self.rightTrs_ == nil then
		self.rightGo_ = self:FindGo("RankList_01/panel/right_adapt")
		self.rightTrs_ = self.rightGo_:GetComponent(typeof(RectTransform))
		self.needAdaptRight_ = true
	end

	PolyhedronRankView.super.AdaptRight(self)
end

return PolyhedronRankView
