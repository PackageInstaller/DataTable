local ActivityOathDrawMainView = class("ActivityOathDrawMainView", ReduxView)

function ActivityOathDrawMainView:UIName()
	return OathDrawTools.GetMainUIName(self.params_.activityID)
end

function ActivityOathDrawMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityOathDrawMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityOathDrawMainView:InitUI()
	self:BindCfgUI()

	self.rewardCon_ = self.controllerEx_:GetController("reward")
	self.poolList_ = LuaList.New(handler(self, self.IndexItem), self.poolListGo_, ActivitySkinDrawPoolItem)
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.sceneReward_ = ActivitySkinDrawItem.New(self.sceneReward_1)
	self.skinGiftReward_ = ActivityOathGiftItem.New(self.giftRewardObj_)
	self.discountInfo_ = ActivityOathDiscountInfo.New(self.couponObj_)
end

function ActivityOathDrawMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.poolDataList_[arg_5_1], arg_5_1)
	arg_5_2:RegisterClickFunc(handler(self, self.OnPoolItemClick))

	if arg_5_1 == self.curIndex_ then
		arg_5_2:SelectItem(true)

		self.selectItem_ = arg_5_2
	else
		arg_5_2:SelectItem(false)
	end
end

function ActivityOathDrawMainView:OnPoolItemClick(arg_6_1)
	if self.selectItem_ then
		if self.selectItem_ == arg_6_1 then
			return
		end

		self.selectItem_:SelectItem(false)
	end

	self.selectItem_ = arg_6_1

	self.selectItem_:SelectItem(true)

	self.curPoolID_ = arg_6_1.poolId_
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]

	self:RefreshCurPool()
end

function ActivityOathDrawMainView:AddUIListeners()
	self:AddBtnListener(self.btnInfo_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfo", {
			isOath = true,
			poolID = self.curPoolID_,
			mainActivity = self.activityID_,
			poolActivityID = self.curPoolActivityId_
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("activityOathDrawGameView", {
			poolID = self.curPoolID_,
			activityID = self.activityID_,
			isGetBestReward = self:IsGetBestReward()
		})
	end)
	self:AddBtnListener(self.portraitBtn_, nil, function()
		if self.isSkinPool_ then
			self:Go("heroPortrait", {
				skinID = self.skinID_
			})
		else
			self:Go("heroPortraitFull", {
				skinID = self.skinID_
			})
		end
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		local var_11_0 = 0
		local var_11_1 = SkinTagCfg[self.skinID_].trial_activity[1]

		for iter_11_0, iter_11_1 in ipairs(SkinTagCfg[self.skinID_].trial_activity) do
			if ActivityData:GetActivityIsOpen(ActivitySkinTrialCfg[iter_11_1].activity_id) then
				var_11_0 = ActivitySkinTrialCfg[iter_11_1].activity_id
				var_11_1 = iter_11_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_11_1)
		self:Go("/sectionSelectHero", {
			activityID = var_11_0,
			section = SkinTagCfg[self.skinID_].trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
end

function ActivityOathDrawMainView:AddEventListeners()
	self:RegistEventListener(ACTIVITY_OATH_SKIN_DRAW_OPEN, handler(self, self.UpdateDrawCntShow))
end

function ActivityOathDrawMainView:UpdateDrawCntShow()
	self:UpdateRemainCountShow()
	self:RefreshMainReward()
	self.discountInfo_:RefreshUI()
end

function ActivityOathDrawMainView:OnEnter()
	self:AddEventListeners()
	self:InitData()
	self:RefreshUI()
end

function ActivityOathDrawMainView:OnEnterOver()
	self:AddCheckRewardTimer()
end

function ActivityOathDrawMainView:DelCheckRewardTimer()
	if self.checkRewardTimer_ then
		self.checkRewardTimer_:Stop()

		self.checkRewardTimer_ = nil
	end
end

function ActivityOathDrawMainView:AddCheckRewardTimer()
	self:DelCheckRewardTimer()

	self.checkRewardTimer_ = Timer.New(function()
		self:CheckHadDrawed()
	end, 0.033)

	self.checkRewardTimer_:Start()
end

function ActivityOathDrawMainView:CheckHadDrawed()
	if (getData("activity_check_had", "activity_" .. tostring(self.activityID_)) or 0) == 0 and self:CheckReward() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WEDDING_REWARD_TIPS1"),
			OkCallback = function()
				saveData("activity_check_had", "activity_" .. tostring(self.activityID_), 1)
			end
		})
	end
end

function ActivityOathDrawMainView:CheckReward()
	for iter_21_0, iter_21_1 in pairs(self.mainReward_[self.curPoolID_]) do
		local var_21_0
		local var_21_1

		if ItemCfg[iter_21_1.itemId].type == ItemConst.ITEM_TYPE.GIFT then
			var_21_0 = self.skinUnlock_ and iter_21_1.count > 0
		elseif ItemCfg[iter_21_1.itemId].type == ItemConst.ITEM_TYPE.SCENE then
			var_21_1 = self.sceneUnlock_ and iter_21_1.count > 0
		end

		if var_21_0 or var_21_1 then
			return true
		end
	end

	return false
end

function ActivityOathDrawMainView:InitData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.poolIdList_ = OathDrawTools.GetPoolIdList(self.activityID_)
	self.sceneIDList_ = {}

	self:InitPoolData()
	self.discountInfo_:SetData(self.activityID_)
end

function ActivityOathDrawMainView:InitPoolData()
	self.poolDataList_ = {}

	for iter_23_0, iter_23_1 in ipairs(self.poolIdList_) do
		self.poolDataList_[#self.poolDataList_ + 1] = clone(ActivityLimitedDrawPoolListCfg[iter_23_1])
	end
end

function ActivityOathDrawMainView:RefreshUI()
	self:RefreshTime()
	self:RefreshPool()
end

function ActivityOathDrawMainView:RefreshTime()
	local var_25_0

	self:StopTimer()

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
		self.timer_ = Timer.New(function()
			self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
			var_25_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_25_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function ActivityOathDrawMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityOathDrawMainView:RefreshPool()
	self:RefreshPoolData(self.poolIdList_)

	self.curPoolID_ = ActivityOathDrawData:GetCurDrawPool(self.activityID_) or self.poolIdList_[1]
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]

	self:RefreshCurPool()
	self.poolList_:StartScroll(#self.poolDataList_)
end

function ActivityOathDrawMainView:RefreshPoolData(arg_29_1)
	self.mainReward_ = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		self.mainReward_[iter_29_1] = self.mainReward_[iter_29_1] or {}

		for iter_29_2, iter_29_3 in ipairs(ActivityLimitedDrawPoolListCfg[iter_29_1].main_icon_info) do
			local var_29_0 = ActivityOathDrawData:GetDrawInfo(ActivityLimitedDrawPoolListCfg[iter_29_1].activity_id[1], iter_29_3[1])
			local var_29_1 = ActivityLimitedDrawPoolCfg[iter_29_3[1]].reward[1][1]

			if ItemCfg[ActivityLimitedDrawPoolCfg[iter_29_3[1]].reward[1][1]].type == ItemConst.ITEM_TYPE.GIFT then
				local var_29_2 = {
					itemId = var_29_1
				}

				if var_29_0 then
					var_29_2.count = var_29_0.num or ActivityLimitedDrawPoolCfg[iter_29_3[1]].total
				end

				table.insert(self.mainReward_[iter_29_1], var_29_2)

				for iter_29_4, iter_29_5 in pairs(ItemCfg[var_29_1].param) do
					if ItemCfg[iter_29_5[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
						self.skinID_ = iter_29_5[1]
					end
				end
			elseif ItemCfg[var_29_1].type == ItemConst.ITEM_TYPE.SCENE then
				self.sceneIDList_[iter_29_1] = var_29_1

				local var_29_3 = {
					itemId = var_29_1
				}

				if var_29_0 then
					var_29_3.count = var_29_0.num or ActivityLimitedDrawPoolCfg[iter_29_3[1]].total
				end

				table.insert(self.mainReward_[iter_29_1], var_29_3)
			end
		end
	end

	self.skinUnlock_ = HeroTools.GetHasOwnedSkin(self.skinID_)
	self.sceneUnlock_ = self:IsSceneHad()
end

function ActivityOathDrawMainView:IsGetBestReward()
	if self.isSkinPool_ then
		return self.skinUnlock_
	else
		return self.sceneUnlock_
	end
end

function ActivityOathDrawMainView:IsSceneHad()
	for iter_31_0, iter_31_1 in pairs(self.sceneIDList_) do
		if HomeSceneSettingData:IsUnlockScene(iter_31_1) then
			return true
		end
	end

	return false
end

function ActivityOathDrawMainView:RefreshCurPool()
	ActivityOathDrawData:SetCurDrawPool(self.activityID_, self.curPoolID_)

	self.isSkinPool_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].pool_type == 1
	self.curIndex_ = table.indexof(self.poolIdList_, self.curPoolID_) or 1

	self.rewardCon_:SetSelectedIndex(self.curIndex_ - 1)
	self:RefreshMainReward()
	self:RefreshMovie()
	self:UpdateRemainCountShow()
end

function ActivityOathDrawMainView:UpdateRemainCountShow()
	local var_33_0 = OathDrawTools.GetDrawMaxDropCount(self.curPoolID_)

	self.drawText_.text = string.format(GetTips("SKIN_DRAE_DESC"), var_33_0, OathDrawTools.GetPoolBestRewardName(self.curPoolID_))
	self.remainCntText_.text = string.format("%s/%s", var_33_0 - ActivityOathDrawData:GetRemainCanDrawCnt(self.curPoolActivityId_), var_33_0)
end

function ActivityOathDrawMainView:RefreshMainReward()
	if self.isSkinPool_ then
		local var_34_0, var_34_1 = ActivityOathDrawData:GetGiftID()

		self.skinGiftReward_:SetData(var_34_1, self.curPoolActivityId_, nil, self.curPoolID_)
	else
		local var_34_2 = {
			itemId = ActivityOathDrawData:GetSceneID(self.curPoolActivityId_)
		}

		var_34_2.count = ActivityOathDrawData:GetDrawInfo(self.curPoolActivityId_, (ActivityOathDrawData:GetSceneDropID(self.curPoolActivityId_))).num

		self.sceneReward_:RefreshData(var_34_2, self.curPoolID_)
	end
end

function ActivityOathDrawMainView:RefreshMovie()
	self.criMovie_:Stop()

	local var_35_0 = deepClone(ObtainSkinBackgroundMovieCfg[self.curPoolActivityId_].start_path)
	local var_35_1
	local var_35_2 = ActivityOathDrawData:GetLastFile(self.activityID_)

	if var_35_2 then
		local var_35_3 = math.random(#var_35_0 - 1)
		local var_35_4 = table.indexof(var_35_0, var_35_2)

		if var_35_4 and var_35_4 <= var_35_3 then
			var_35_3 = var_35_3 + 1
		end

		var_35_1 = var_35_0[var_35_3] or var_35_0[1]
	else
		var_35_1 = var_35_0[math.random(#var_35_0)] or var_35_0[1]
	end

	self:StopFrameTimer()

	self.frameTimer_ = FrameTimer.New(function()
		if tostring(self.criplayer_.status) == "Stop" then
			SetFile(self.criplayer_, nil, var_35_1, CriMana.Player.SetMode.New)
			ActivityOathDrawData:SetLastFile(self.activityID_, var_35_1)
			self.criMovie_:Play()
			self:StopFrameTimer()
		end
	end, 1, -1)

	self.frameTimer_:Start()
end

function ActivityOathDrawMainView:StopFrameTimer()
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function ActivityOathDrawMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function ActivityOathDrawMainView:OnTop()
	self:RefreshBar()
end

function ActivityOathDrawMainView:OnExit()
	self:DelCheckRewardTimer()
	self:StopTimer()
	self:StopFrameTimer()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ActivityOathDrawMainView:Dispose()
	self.discountInfo_:Dispose()
	self:RemoveAllListeners()

	if self.poolList_ then
		self.poolList_:Dispose()

		self.poolList_ = nil
	end

	if self.skinGiftReward_ then
		self.skinGiftReward_:Dispose()

		self.skinGiftReward_ = nil
	end

	if self.sceneReward_ then
		self.sceneReward_:Dispose()

		self.sceneReward_ = {}
	end

	self.super.Dispose(self)
end

return ActivityOathDrawMainView
