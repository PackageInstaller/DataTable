local SailMainView = class("SailMainView", ReduxView)

function SailMainView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGameUI"
end

function SailMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SailMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailMainView:InitUI()
	self:BindCfgUI()

	self.buildingList_ = {}

	for iter_4_0 = 1, self.buildingContentTrans_.childCount do
		self.buildingList_[iter_4_0] = SailBuildingItem.New(self.buildingContentTrans_:GetChild(iter_4_0 - 1).gameObject)
	end

	self.sailCountController_ = ControllerUtil.GetController(self.transform_, "sailCount")
	self.gameStatusCountController_ = ControllerUtil.GetController(self.transform_, "gameStatus")
	self.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	self.animTimerList_ = {}
end

function SailMainView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SailGameData:SetSelectedSailBtn(self.activityID_)

		if SailGameData:GetCurGameData(self.activityID_).gameState ~= SailGameConst.GAME_STATUS.RUNNING then
			if 1 > SailGameData:GetSailCount(self.activityID_) then
				ShowTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_NOT_ENOUGH")

				return
			end

			SailGameAction.StartGame(self.activityID_)
		else
			SailGameTools.GoToGameView(self.activityID_)
		end
	end)
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if SailGameData:GetIslandLevel(self.activityID_) >= #SailGameIslandLevelCfg.get_id_list_by_activity_id[self.activityID_] then
			ShowTips("ACTIVITY_SKADI_SEA_LEVEL_MAX_TIP")

			return
		end

		JumpTools.OpenPageByJump("sailUpgradeIsland", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.islandRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("sailIslandReward", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.coinBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id,
			0
		})
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.mainBtn_, nil, function()
		gameContext:Go("/home", nil, nil, true)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")
		})
	end)
end

function SailMainView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	self:RefreshUI()
	self:BindRedPoint()
	SetActive(self.coinVaryGo_, false)
end

function SailMainView:OnTop()
	self.coinNumText_.text = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

function SailMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:StopSailTimer()
	self:StopAllAnimTimer()

	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end

	self:UnBindRedPoint()
end

function SailMainView:Dispose()
	for iter_16_0, iter_16_1 in ipairs(self.buildingList_) do
		iter_16_1:Dispose()
	end

	self.buildingList_ = nil

	self:StopTimer()
	self:StopSailTimer()
	self:StopAllAnimTimer()

	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end

	SailMainView.super.Dispose(self)
end

function SailMainView:RefreshUI()
	self:RefreshBuilding()
	self:RefreshIslandLevel()
	self:RefreshSailCount()
	self.gameStatusCountController_:SetSelectedState(SailGameData:GetCurGameData(self.activityID_).gameState == SailGameConst.GAME_STATUS.RUNNING and "on" or "off")
end

function SailMainView:RefreshBuilding()
	for iter_18_0, iter_18_1 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[self.activityID_]) do
		self.buildingList_[iter_18_0]:SetData(iter_18_1, self.activityID_)
	end
end

function SailMainView:RefreshIslandLevel()
	self.islandLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_LEVEL_TIP"), NumberTools.IntToRomam((SailGameData:GetIslandLevel(self.activityID_))))
end

function SailMainView:RefreshSailCount()
	local var_20_0 = false
	local var_20_1 = SailGameData:GetSailCount(self.activityID_)

	self.sailCountText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), var_20_1, GameSetting.activity_skadi_sea_be_out_num_max.value[1])
	self.sailCountText2_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), var_20_1, GameSetting.activity_skadi_sea_be_out_num_max.value[1])

	if var_20_1 < GameSetting.activity_skadi_sea_be_out_num_max.value[1] then
		self.nextRefreshSailCountTime_ = SailGameTools.GetNextRecoverTimeStep(self.activityID_)

		if self.nextRefreshSailCountTime_ ~= -1 and manager.time:GetServerTime() < self.stopTime_ then
			var_20_0 = true

			self:AddSailTimer()
		else
			var_20_0 = false
		end
	else
		var_20_0 = false

		self:StopSailTimer()
	end

	self.sailCountController_:SetSelectedState(var_20_0 and "on" or "off")
end

function SailMainView:OnBuildingUnlock()
	self:RefreshBuilding()
end

function SailMainView:OnIslandUpgrade()
	self:RefreshBuilding()
	self:RefreshIslandLevel()
end

local var_0_1 = 0.6

function SailMainView:OnReceivedBuildingReward(arg_23_1)
	self:RefreshBuilding()

	self.coinVaryText_.text = "+" .. arg_23_1

	SetActive(self.coinVaryGo_, true)

	self.coinAnim_.enabled = true

	self:PlayAnim("XH3rdVoyagesGameUI_text", self.coinAnim_, function()
		SetActive(self.coinVaryGo_, false)
		self:PlayCurrencyRollAnim(arg_23_1)
		self:PlayAnim("XH3rdVoyagesGameUI_coin", self.coinAnim_, function()
			self.coinAnim_.enabled = false
		end)
	end)
end

function SailMainView:PlayCurrencyRollAnim(arg_26_1)
	local var_26_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id) - arg_26_1

	self.tween_ = LeanTween.value(0, 1, var_0_1):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		self.coinNumText_.text = tostring((math.floor((var_26_0 or 0) + arg_26_1 * arg_27_0)))
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.tween_ then
			self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(self.tween_.id)

			self.tween_ = nil
		end

		self.coinNumText_.text = var_26_0 + arg_26_1
	end)):setEase(LeanTweenType.easeOutQuad)
end

function SailMainView:PlayAnim(arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_2 then
		return
	end

	arg_29_2:Play(arg_29_1, -1, 0)
	arg_29_2:Update(0)
	self:StopAnimTimer(arg_29_1)

	self.animTimerList_[arg_29_1] = Timer.New(function()
		local var_30_0 = arg_29_2:GetCurrentAnimatorStateInfo(0)

		if var_30_0:IsName(arg_29_1) and var_30_0.normalizedTime >= 1 then
			self:StopAnimTimer(arg_29_1)

			if arg_29_3 then
				arg_29_3()
			end
		end
	end, 0.033, -1)

	self.animTimerList_[arg_29_1]:Start()
end

function SailMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

		for iter_32_0, iter_32_1 in ipairs(self.buildingList_) do
			iter_32_1:RefreshTime()
		end
	end, 1, -1)

	self.timer_:Start()
end

function SailMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SailMainView:AddSailTimer()
	if manager.time:GetServerTime() >= self.stopTime_ or manager.time:GetServerTime() >= self.nextRefreshSailCountTime_ then
		return
	end

	self.leftTime_ = self.nextRefreshSailCountTime_ - manager.time:GetServerTime()
	self.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(self.leftTime_))

	self:StopSailTimer()

	self.sailCountTimer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ or manager.time:GetServerTime() >= self.nextRefreshSailCountTime_ then
			self:StopSailTimer()
			self:RefreshSailCount()

			return
		end

		self.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(self.leftTime_))
		self.leftTime_ = self.leftTime_ - 1
	end, 1, -1)

	self.sailCountTimer_:Start()
end

function SailMainView:StopSailTimer()
	if self.sailCountTimer_ then
		self.sailCountTimer_:Stop()

		self.sailCountTimer_ = nil
	end
end

function SailMainView:StopAllAnimTimer()
	for iter_37_0, iter_37_1 in pairs(self.animTimerList_) do
		self.animTimerList_[iter_37_0]:Stop()

		self.animTimerList_[iter_37_0] = nil
	end
end

function SailMainView:StopAnimTimer(arg_38_1)
	if self.animTimerList_[arg_38_1] then
		self.animTimerList_[arg_38_1]:Stop()

		self.animTimerList_[arg_38_1] = nil
	end
end

function SailMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, self.activityID_)))
	manager.redPoint:bindUIandKey(self.islandRewardBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, self.activityID_)))
	manager.redPoint:bindUIandKey(self.upgradeBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, self.activityID_)))
end

function SailMainView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.islandRewardBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.upgradeBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, self.activityID_)))
end

return SailMainView
