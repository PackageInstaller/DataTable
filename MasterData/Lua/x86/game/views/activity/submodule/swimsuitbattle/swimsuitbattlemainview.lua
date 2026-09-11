local SwimsuitBattleMainView = class("SwimsuitBattleMainView", ReduxView)

function SwimsuitBattleMainView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_SwimsuitUI/SummerUI_3_4_SwimsuitBattleUI"
end

function SwimsuitBattleMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SwimsuitBattleMainView:Init()
	self:InitUI()
	self:AddUIListeners()
	self:AddEventListeners()
end

function SwimsuitBattleMainView:InitUI()
	self:BindCfgUI()

	self.heroInfoList_ = {}
	self.curTabIndex_ = 0
	self.startTime_ = nil
	self.stopTime_ = nil
	self.tabItemList_ = {}
	self.greyController_ = self.mainControllerEx_:GetController("grey")
end

function SwimsuitBattleMainView:AddUIListeners()
	self:AddBtnListener(self.baseBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = SwimsuitBattleHeroCfg[self.heroInfoList_[self.curTabIndex_].activityID].stage_id[1],
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			activityID = self.heroInfoList_[self.curTabIndex_].activityID,
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.SWIMSUIT_BATTLE, self.curTabIndex_, nil, {
				stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
				stageID = SwimsuitBattleHeroCfg[self.heroInfoList_[self.curTabIndex_].activityID].stage_id[1],
				activityID = self.heroInfoList_[self.curTabIndex_].activityID
			}),
			heroDataType = HeroConst.HERO_DATA_TYPE.SWIMSUITBATTLE
		})
	end)
	self:AddBtnListener(self.hardBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = SwimsuitBattleHeroCfg[self.heroInfoList_[self.curTabIndex_].activityID].stage_id[2],
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
			activityID = self.heroInfoList_[self.curTabIndex_].activityID,
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.SWIMSUIT_BATTLE, self.curTabIndex_, nil, {
				stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE,
				stageID = SwimsuitBattleHeroCfg[self.heroInfoList_[self.curTabIndex_].activityID].stage_id[2],
				activityID = self.heroInfoList_[self.curTabIndex_].activityID
			}),
			heroDataType = HeroConst.HERO_DATA_TYPE.SWIMSUITBATTLE
		})
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[282951]) do
			if not table.indexof(var_8_0, iter_8_1) then
				table.insert(var_8_0, iter_8_1)
			end
		end

		JumpTools.OpenPageByJump("summerQuestRewardPop", {
			activityIDList = var_8_0
		})
	end)
end

function SwimsuitBattleMainView:AddEventListeners()
	return
end

function SwimsuitBattleMainView:OnEnter()
	local var_10_0, var_10_1, var_10_2 = SwimsuitBattleData:GetVoteTicketInfo(self.params_.activity)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanAdd(var_10_0, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_SWIMSUIT_EXPLAIN_BATTLE")

	self.heroInfoList_ = SwimsuitBattleData:GetUseHeroList(self.params_.activity)

	local var_10_3 = SwimsuitBattleData:GetLastUseHeroID()

	if var_10_3 ~= 0 then
		self.curTabIndex_ = var_10_3
	else
		for iter_10_0 = #self.heroInfoList_, 1, -1 do
			if ActivityData:GetActivityData(self.heroInfoList_[iter_10_0].activityID).startTime <= manager.time:GetServerTime() then
				self.curTabIndex_ = iter_10_0

				break
			end
		end
	end

	if self.curTabIndex_ == 0 then
		self.curTabIndex_ = 1
	end

	if #self.tabItemList_ == 0 then
		for iter_10_1 = 1, #self.heroInfoList_ do
			local var_10_4 = Object.Instantiate(self.tabGo_, self.tabRootTrs_)

			SetActive(var_10_4, true)

			self.tabItemList_[iter_10_1] = SwimsuitBattleTabItem.New(var_10_4)

			self.tabItemList_[iter_10_1]:SetData(self.heroInfoList_[iter_10_1].heroID, self.heroInfoList_[iter_10_1].skinID, self.heroInfoList_[iter_10_1].activityID, iter_10_1 == self.curTabIndex_, function()
				if self.curTabIndex_ == iter_10_1 then
					return
				end

				self.tabItemList_[self.curTabIndex_]:Select(false)
				self.tabItemList_[iter_10_1]:Select(true)

				self.curTabIndex_ = iter_10_1

				self:UpdateView()
				self.changeAni_:Play("role_change", -1, 0)
			end)
		end
	else
		for iter_10_2 = 1, #self.tabItemList_ do
			self.tabItemList_[iter_10_2]:RefreshLock()
		end
	end

	self.tabRootTrs_:SetAnchoredPositionY((self.curTabIndex_ - 1) * 144)

	self.voteImg_.sprite = ItemTools.getItemSprite(var_10_0)
	self.voteText_.text = var_10_1 .. "/" .. var_10_2

	local var_10_5 = ActivityData:GetActivityData(self.params_.activity)

	self.startTime_ = var_10_5.startTime
	self.stopTime_ = var_10_5.stopTime

	self:AddTimer()
	self:UpdateView()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD)
end

function SwimsuitBattleMainView:UpdateView()
	self.AvatarImg_.spriteAsync = "TextureConfig/Swimsuit/" .. SwimsuitVoteHeroCfg[SwimsuitVoteHeroCfg.get_id_list_by_hero_id[self.heroInfoList_[self.curTabIndex_].heroID][1]].show_image

	if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, self.heroInfoList_[self.curTabIndex_].activityID)) == 1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, self.heroInfoList_[self.curTabIndex_].activityID), 0)
		saveData("SwimsuitBattleHeroRedPoint", "battle" .. self.heroInfoList_[self.curTabIndex_].activityID, 1)
	end

	if ActivityData:GetActivityData(self.heroInfoList_[self.curTabIndex_].activityID).startTime > manager.time:GetServerTime() then
		self.greyController_:SetSelectedState("true")
	else
		self.greyController_:SetSelectedState("false")
	end
end

function SwimsuitBattleMainView:AddTimer()
	self:StopTimer()

	self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end, 1, -1)

	self.timer_:Start()
end

function SwimsuitBattleMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SwimsuitBattleMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	SwimsuitBattleData:SetLastUseHeroID(self.curTabIndex_)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD)
end

function SwimsuitBattleMainView:Dispose()
	self:RemoveAllListeners()

	for iter_17_0 = 1, #self.tabItemList_ do
		self.tabItemList_[iter_17_0]:Dispose()

		self.tabItemList_[iter_17_0] = nil
	end

	SwimsuitBattleMainView.super.Dispose(self)
end

return SwimsuitBattleMainView
