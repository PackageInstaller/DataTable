local ActivityPt2View = class("ActivityPt2View", ReduxView)

function ActivityPt2View:UIName()
	return ActivityPt2Tools.GetMainUIName(self.params_.mainActivityId)
end

function ActivityPt2View:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPt2View:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPt2View:InitUI()
	self:BindCfgUI()
	self:RefreshShop()

	self.normalBtn_ = {}
	self.challengeBtn_ = {}
	self.hardBtn_ = {}
	self.normalCon_ = {}
	self.challengeCon_ = {}
	self.hardCon_ = {}
	self.normalAni_ = {}
	self.challengeAni_ = {}
	self.hardAni_ = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.params_.mainActivityId].sub_activity_list[1]]) do
		table.insert(self.normalBtn_, self["normalBtn_" .. iter_4_0])
		table.insert(self.normalCon_, ControllerUtil.GetController(self["normalBtn_" .. iter_4_0].transform, "status"))
		table.insert(self.normalAni_, self["normalAni_" .. iter_4_0])
	end

	for iter_4_2, iter_4_3 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.params_.mainActivityId].sub_activity_list[2]]) do
		table.insert(self.challengeBtn_, self["challengeBtn_" .. iter_4_2])
		table.insert(self.challengeCon_, ControllerUtil.GetController(self["challengeBtn_" .. iter_4_2].transform, "status"))
		table.insert(self.challengeAni_, self["challengeAni_" .. iter_4_2])
	end

	for iter_4_4, iter_4_5 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.params_.mainActivityId].sub_activity_list[3]]) do
		table.insert(self.hardBtn_, self["hardBtn_" .. iter_4_4])
		table.insert(self.hardCon_, ControllerUtil.GetController(self["hardBtn_" .. iter_4_4].transform, "status"))
		table.insert(self.hardAni_, self["hardAni_" .. iter_4_4])
	end

	self.tgl_ = {
		self.tgl_1,
		self.tgl_2,
		self.tgl_3
	}
	self.lockCon_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
	self.typeCon_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
	self.indexCon_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
end

function ActivityPt2View:AddUIListeners()
	self:AddBtnListener(self.shopBtn_, nil, function()
		if self:IsOpenSectionView() then
			self:BlankAni()
			JumpTools.Back()
			self.indexCon_:SetSelectedIndex(0)

			self.selectLevel_ = 0
		end

		local var_6_0 = ActivityShopCfg[self.activityID_]
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[self.activityID_].activity_theme]) do
			local var_6_2 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)

			if var_6_2 and var_6_2:IsActivitying() then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_3, var_6_4 = ShopTools.IsShopOpen(var_6_0.shop_id)

		if var_6_3 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_6_0.shop_id,
				showShops = var_6_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self:Go("/activityRaceRank", {
			activityID = self.rankID_
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self:IsOpenSectionView() then
			self:BlankAni()
			JumpTools.Back()
			self.indexCon_:SetSelectedIndex(0)

			self.selectLevel_ = 0
		end
	end)

	for iter_5_0, iter_5_1 in ipairs(self.tgl_) do
		self:AddToggleListener(iter_5_1, function(arg_9_0)
			if arg_9_0 then
				if self:IsOpenSectionView() then
					self.tgl_[self.index_].isOn = true

					return
				end

				if iter_5_0 ~= self.index_ then
					if self.changeAni_ then
						self.changeCanvas_.alpha = 0
						self.changeAni_.enabled = false
					end

					self:ToggleOnAni(iter_5_0)

					local var_9_0, var_9_1, var_9_2 = ActivityPt2Tools.GetToggleClickEffect(self.params_.mainActivityId, iter_5_0)

					if var_9_0 ~= "" and var_9_1 ~= "" then
						manager.audio:StopEffect()
						manager.audio:PlayEffect(var_9_0, var_9_1, var_9_2)
					end

					self.index_ = iter_5_0
				end

				self.indexCon_:SetSelectedState(0)
				self.typeCon_:SetSelectedStateWithCallback(iter_5_0, function()
					if self.changeAni_ then
						self.changeAni_.enabled = true

						self.changeAni_:Play("eff_middle_cx", 0, 0)
					end
				end)
				ActivityPt2Data:SetLastStage(self.activityID_, iter_5_0, 1)
			end
		end)
	end

	for iter_5_2, iter_5_3 in ipairs(self.normalBtn_) do
		self:AddBtnListener(iter_5_3, nil, function()
			self:EnterLevel(1, iter_5_2)
		end)
	end

	for iter_5_4, iter_5_5 in ipairs(self.challengeBtn_) do
		self:AddBtnListener(iter_5_5, nil, function()
			self:EnterLevel(2, iter_5_4)
		end)
	end

	for iter_5_6, iter_5_7 in ipairs(self.hardBtn_) do
		self:AddBtnListener(iter_5_7, nil, function()
			self:EnterLevel(3, iter_5_6)
		end)
	end

	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips(string.format(GetTips("ACTIVITY_XUHENG_PT_EXLOCK"), ActivityPt2Cfg[ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.activityID_].sub_activity_list[3]][1]].pre_stage].time, BattleActivityPtStageV2ChallengeCfg[ActivityPt2Cfg[ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.activityID_].sub_activity_list[3]][1]].pre_stage].stage_id].name))
	end)

	if self.eventTrigger_ then
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
			if self:IsOpenSectionView() then
				JumpTools.Back()
			end

			self.drag_ = true
		end))
		self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
			self.drag_ = false
		end))
	end
end

function ActivityPt2View:OnEnter()
	if not self.activityID_ or self.activityID_ ~= self.params_.mainActivityId then
		self.activityID_ = self.params_.mainActivityId

		self:ReLoad()
	end

	self:RefreshUI()
end

function ActivityPt2View:ReLoad()
	if self.gameObject_ then
		self:Dispose()
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPt2View:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
	self:RefreshState()
end

function ActivityPt2View:RefreshData()
	self.activityID_ = self.params_.mainActivityId
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPt2View:RefreshTime()
	local var_21_0
	local var_21_1 = manager.time:GetServerTime()
	local var_21_2 = ActivityData:GetActivityData(self.params_.mainActivityId)
	local var_21_3 = var_21_2.startTime
	local var_21_4 = var_21_2.stopTime
	local var_21_5 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[self.params_.mainActivityId].shop_id].activity_id).stopTime
	local var_21_6 = var_21_5 - var_21_1

	self:StopTimer()

	if var_21_1 < var_21_2.startTime and var_21_2:IsActivitying() == false then
		self.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			var_21_0 = var_21_3 - manager.time:GetServerTime()

			if var_21_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_21_1 < var_21_2.stopTime or var_21_1 < var_21_5 then
		self.timeLabel_.text = var_21_1 < var_21_2.stopTime and manager.time:GetLostTimeStr2(var_21_2.stopTime) or GetTips("TIME_OVER")

		if self.shopTimeGo_ then
			if var_21_6 <= GameSetting.time_remaining_show.value[1] * 86400 then
				self.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_21_5)

				SetActive(self.shopTimeGo_, true)
			else
				SetActive(self.shopTimeGo_, false)
			end
		end

		self.timer_ = Timer.New(function()
			var_21_1 = manager.time:GetServerTime()
			var_21_0 = var_21_4 - var_21_1
			var_21_6 = var_21_5 - var_21_1

			if var_21_0 <= 0 and var_21_6 <= 0 then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLabel_.text = var_21_1 < var_21_4 and manager.time:GetLostTimeStr2(var_21_4) or GetTips("TIME_OVER")

			if self.shopTimeGo_ then
				if var_21_6 <= GameSetting.time_remaining_show.value[1] * 86400 then
					self.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_21_5)

					SetActive(self.shopTimeGo_, true)
				else
					SetActive(self.shopTimeGo_, false)
				end
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLabel_.text = GetTips("TIME_OVER")
		self.shopTimeLabel_.text = GetTips("TIME_OVER")
	end
end

function ActivityPt2View:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPt2View:RefreshState()
	self.lockCon_:SetSelectedState(self:IsLockEx() and "true" or "false")

	local var_25_0 = ActivityPt2Data:GetLastStage(self.activityID_)
	local var_25_1 = ActivityCfg[self.params_.mainActivityId].sub_activity_list
	local var_25_2

	if var_25_0 then
		var_25_2 = var_25_0.type or 1
	end

	self.typeCon_:SetSelectedState(var_25_2)

	self.index_ = var_25_2
	self.tgl_[var_25_2].isOn = true

	local var_25_3, var_25_4, var_25_5 = ActivityPt2Tools.GetToggleClickEffect(self.params_.mainActivityId, var_25_2)

	if var_25_3 ~= "" and var_25_4 ~= "" then
		manager.audio:StopEffect()
		manager.audio:PlayEffect(var_25_3, var_25_4, var_25_5)
	end

	self:ToggleOnAni(var_25_2)

	self.selectLevel_ = 0

	if self:IsOpenSectionView() and var_25_0 then
		self.indexCon_:SetSelectedState(var_25_0.type .. "_" .. var_25_0.index)
	else
		self.indexCon_:SetSelectedState(0)
	end

	for iter_25_0, iter_25_1 in ipairs(self.normalCon_) do
		local var_25_6 = ActivityPt2Data:GetNormalData(var_25_1[1], ActivityPt2Cfg.get_id_list_by_activity_id[var_25_1[1]][iter_25_0])

		if var_25_6 then
			if (var_25_6.clear_time or 0) > 0 then
				iter_25_1:SetSelectedState("get")

				goto label_25_0
			end
		end

		iter_25_1:SetSelectedState("nor")

		::label_25_0::
	end

	for iter_25_2, iter_25_3 in ipairs(self.challengeCon_) do
		local var_25_8 = ActivityPt2Data:GetChallengeData(var_25_1[2], ActivityPt2Cfg.get_id_list_by_activity_id[var_25_1[2]][iter_25_2])

		if var_25_8 then
			if (var_25_8.clear_time or 0) > 0 then
				iter_25_3:SetSelectedState("get")

				goto label_25_1
			end
		end

		iter_25_3:SetSelectedState("nor")

		::label_25_1::
	end

	for iter_25_4, iter_25_5 in ipairs(self.hardCon_) do
		local var_25_10 = ActivityPt2Data:GetHardData(var_25_1[3])

		if var_25_10 then
			if (var_25_10.clear_time or 0) > 0 then
				iter_25_5:SetSelectedState("get")

				goto label_25_2
			end
		end

		iter_25_5:SetSelectedState("nor")

		::label_25_2::
	end

	self.rankID_ = var_25_1[4]

	local var_25_12 = ActivityPt2Data:GetHardData(var_25_1[3])

	self.score_.text = var_25_12 and var_25_12.clear_time > 0 and ActivityPt2Data:GetExScore(var_25_1[3]) or GetTips("NO_RECORD")
end

function ActivityPt2View:ToggleOnAni(arg_26_1)
	local var_26_0 = {}

	if arg_26_1 == 1 then
		var_26_0 = self.normalAni_
	elseif arg_26_1 == 2 then
		var_26_0 = self.challengeAni_
	elseif arg_26_1 == 3 then
		var_26_0 = self.hardAni_
	end

	local var_26_1 = ActivityPt2Tools.GetBtnEnterAnimation(self.activityID_)

	if var_26_1 ~= "" then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			iter_26_1:Play(var_26_1, -1, 0)
		end
	end
end

function ActivityPt2View:EnterLevel(arg_27_1, arg_27_2)
	if self.selectLevel_ ~= arg_27_2 then
		self:CheckClickBtnAni(arg_27_2)
	end

	self.selectLevel_ = arg_27_2

	ActivityPt2Data:SetLastStage(self.activityID_, arg_27_1, arg_27_2)
	self.indexCon_:SetSelectedState(arg_27_1 .. "_" .. arg_27_2)

	local var_27_0 = ActivityCfg[self.params_.mainActivityId].sub_activity_list[arg_27_1]
	local var_27_1 = ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.params_.mainActivityId].sub_activity_list[arg_27_1]][arg_27_2]
	local var_27_2 = ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.params_.mainActivityId].sub_activity_list[arg_27_1]][arg_27_2]].stage_id
	local var_27_3 = arg_27_1 == 1 and BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL or arg_27_1 == 2 and BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE or BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD

	JumpTools.OpenPageByJump("activityPt2SectionInfo", {
		section = var_27_2,
		sectionType = var_27_3,
		mainActivityId = self.activityID_,
		activityId = var_27_0,
		repeat_id = var_27_1,
		backCall = function()
			self:BlankAni()
			self.indexCon_:SetSelectedIndex(0)

			self.selectLevel_ = 0
		end
	})
end

function ActivityPt2View:CheckClickBtnAni(arg_29_1)
	local var_29_0
	local var_29_1

	if self.index_ == 1 then
		var_29_1 = self.normalAni_[arg_29_1]
		var_29_0 = self.normalAni_[self.selectLevel_]
	elseif self.index_ == 2 then
		var_29_1 = self.challengeAni_[arg_29_1]
		var_29_0 = self.challengeAni_[self.selectLevel_]
	else
		var_29_1 = self.hardAni_[arg_29_1]
		var_29_0 = self.hardAni_[self.selectLevel_]
	end

	if var_29_0 then
		local var_29_2 = ActivityPt2Tools.GetBtnDisappearAnimation(self.params_.mainActivityId)

		if var_29_2 ~= "" then
			var_29_0:Play(var_29_2, -1, 0)
		end
	end

	if var_29_1 then
		local var_29_3 = ActivityPt2Tools.GetBtnAppearAnimation(self.params_.mainActivityId)

		if var_29_3 ~= "" then
			var_29_1:Play(var_29_3, -1, 0)
		end
	end
end

function ActivityPt2View:BlankAni()
	local var_30_0 = self.index_ == 1 and self.normalAni_[self.selectLevel_] or self.index_ == 2 and self.challengeAni_[self.selectLevel_] or self.hardAni_[self.selectLevel_]

	if var_30_0 then
		local var_30_1 = ActivityPt2Tools.GetBtnDisappearAnimation(self.params_.mainActivityId)

		if var_30_1 ~= "" then
			var_30_0:Play(var_30_1, -1, 0)
		end
	end
end

function ActivityPt2View:IsLockEx()
	local var_31_0 = ActivityPt2Data:GetChallengeData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[2], ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.activityID_].sub_activity_list[3]][1]].pre_stage)
	local var_31_1 = ActivityPt2Cfg[ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[self.activityID_].sub_activity_list[3]][1]].pre_stage]

	if not var_31_0 or var_31_0.clear_time <= 0 then
		return true
	end

	return var_31_0.use_time > var_31_1.time
end

function ActivityPt2View:IsOpenSectionView()
	return self:IsOpenRoute("activityPt2SectionInfo")
end

function ActivityPt2View:RefreshShop()
	self.shopName_.text = ShopListCfg[ActivityShopCfg[self.params_.mainActivityId].shop_id].remark
end

function ActivityPt2View:OnTop()
	local var_34_0 = ActivityPt2Tools.GetHelpKey(self.activityID_)
	local var_34_1 = ActivityPt2Tools.GetChallengeCurrencyID(self.activityID_)

	if var_34_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_34_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(var_34_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			var_34_1,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(var_34_1, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function ActivityPt2View:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
	self.indexCon_:SetSelectedState(-1)
end

function ActivityPt2View:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityPt2View
