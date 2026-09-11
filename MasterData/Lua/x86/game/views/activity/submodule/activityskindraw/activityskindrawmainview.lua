local ActivitySkinDrawMainView = class("ActivitySkinDrawMainView", ReduxView)

function ActivitySkinDrawMainView:UIName()
	return ActivitySkinDrawTools.GetMainUIName(self.params_.activityID)
end

function ActivitySkinDrawMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawMainView:InitUI()
	self:BindCfgUI()

	self.skinPoolItem_ = {}
	self.scenePoolItem_ = {}
	self.drawCon_ = self.controllerEx_:GetController("draw")
	self.rewardCon_ = self.controllerEx_:GetController("reward")
	self.scenePreviewCon_ = self.controllerEx_:GetController("scenePreview")
	self.giftController_ = self.controllerEx_:GetController("gift")
	self.poolList_ = LuaList.New(handler(self, self.IndexItem), self.poolListGo_, ActivitySkinDrawPoolItem)
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.sceneReward_ = ActivitySkinDrawItem.New(self.sceneReward_1)
	self.dlcRewardList_ = {}

	for iter_4_0 = 1, 2 do
		if self["dlcReward_" .. iter_4_0] then
			self.dlcRewardList_[iter_4_0] = ActivitySkinDrawItem.New(self["dlcReward_" .. iter_4_0])
		end
	end

	self.skinRewardList_ = {}

	for iter_4_1 = 1, 2 do
		self.skinRewardList_[iter_4_1] = ActivitySkinDrawItem.New(self["skinReward_" .. iter_4_1])
	end

	if self.giftRewardGo_ then
		self.giftReward_ = ActivitySkinDrawGiftItem.New(self.giftRewardGo_)
	end

	self.storyList_ = {}

	for iter_4_2 = 1, 4 do
		self.storyList_[iter_4_2] = {}

		ComponentBinder.GetInstance():BindCfgUI(self.storyList_[iter_4_2], self["storyGo_" .. iter_4_2])

		self.storyList_[iter_4_2].lockController = self.storyList_[iter_4_2].tranCon_:GetController("Story")
	end

	self.storyIdList_ = {}
end

function ActivitySkinDrawMainView:AddUIListeners()
	for iter_5_0, iter_5_1 in ipairs(self.storyList_) do
		self:AddBtnListener(iter_5_1.btn_, nil, function()
			if iter_5_0 <= self.openStoryIndex_ then
				gameContext:Go("/blank")

				local var_6_0 = ActivitySkinDrawData:GetStoryActivityId()

				manager.story:StartStoryById(self.storyIdList_[iter_5_0], function()
					ActivitySkinDrawData:FinishedStory(self.storyIdList_[iter_5_0])
					manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW, 0, RedPointStyle.SHOW_NEW_TAG)
					gameContext:Back()
				end)
			else
				ShowTips(GetTips("SKIN_DRAE_STORY_LOCK_TIPS"))
			end
		end)
	end

	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activitySkinDrawTask", {
			activityID = self.activityID_,
			taskActivityID = self.taskActiivtyID_
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_9_0 = ActivitySkinDrawTools.GetActivityShopID(self.activityID_)

		if not ShopTools.IsShopOpen(var_9_0) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.GoToSystem("/activityShop", {
			shopId = var_9_0,
			showShops = {
				var_9_0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.btnAnim_1, nil, function()
		self:JumpToVideo(1)
	end)
	self:AddBtnListener(self.btnAnim_2, nil, function()
		self:JumpToVideo(2)
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		local var_12_0 = HomeSceneSettingData:SetPreviewScene(self.sceneIDList_[self.curPoolID_], 1084)

		HomeSceneSettingData:SetPreviewSceneParams(var_12_0)

		self.isPreview_ = true

		OpenPageUntilLoaded("/homePreview", var_12_0)
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		local var_13_0 = not self.isSkinPool_ and #self.poolStageCount_[self.curPoolID_] > 1 and self:GetPoolNowStage(self.curPoolID_) == 1
		local var_13_1 = "skinDrawInfo"
		local var_13_2 = {
			poolID = self.curPoolID_,
			mainActivity = self.activityID_,
			poolActivityID = self.curPoolActivityId_,
			checkPoolStage = var_13_0 and 1 or nil
		}

		var_13_2.isShowTips = var_13_0 and string.format(GetTips("T0_SKIN_DRAW_TIPS_1"), ItemCfg[self.mainReward_[self.curPoolID_][1].itemId].name) or ""
		var_13_2.tabText_1 = GetTips("T0_SKIN_DRAW_TIPS_2")

		JumpTools.OpenPageByJump(var_13_1, var_13_2)
	end)
	self:AddBtnListener(self.oneBtn_, nil, function()
		self:DrawCheck(1)
	end)
	self:AddBtnListener(self.tenBtn_, nil, function()
		self:DrawCheck(10)
	end)

	if self.dlcBtn_ then
		self:AddBtnListener(self.dlcBtn_, nil, function()
			JumpTools.OpenPageByJump("activitySkinDrawDLCPopView", {
				sceneID = self.sceneIDList_[self.curPoolID_],
				activityID = self.activityID_
			})
		end)
	end
end

function ActivitySkinDrawMainView:OnEnter()
	self:InitData()
	self:BindRedPoint()
	self:RefreshUI()
	self:CheckHadDrawed()
	self:CheckSceneDrawed()
	ActivitySkinDrawData:ShowGetMemoryCoin(self.skinID_)
	self:RegistEventListener(ACTIVITY_SKIN_MEMORY_COIN_POP, handler(self, self.OnSkinMemoryCoinPop))
	self:RegistEventListener(ACTIVITY_SKIN_DRAW_SELECT_POOL, handler(self, self.OnSelectPool))
end

function ActivitySkinDrawMainView:OnSkinMemoryCoinPop()
	ActivitySkinDrawData:ShowGetMemoryCoin(self.skinID_)
end

function ActivitySkinDrawMainView:InitData()
	if self.isPreview_ then
		manager.ui:SetMainCamera("home")

		self.isPreview_ = false
	end

	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.taskActiivtyID_ = ActivitySkinDrawTools.GetTaskActivityID(self.activityID_)
	self.poolIdList_ = ActivitySkinDrawTools.GetPoolIdList(self.activityID_)
	self.sceneIDList_ = {}
	self.lastCount_ = {}
	self.totalCount_ = {}
	self.mainReward_ = {}
	self.poolStageCount_ = {}

	self:InitPoolData()
end

function ActivitySkinDrawMainView:InitPoolData()
	self.poolDataList_ = {}

	for iter_20_0, iter_20_1 in ipairs(self.poolIdList_) do
		self.poolDataList_[#self.poolDataList_ + 1] = clone(ActivityLimitedDrawPoolListCfg[iter_20_1])
		self.totalCount_[iter_20_1] = 0
		self.poolStageCount_[iter_20_1] = {}

		for iter_20_2, iter_20_3 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[iter_20_1] or {}) do
			self.poolStageCount_[iter_20_1][ActivityLimitedDrawPoolCfg[iter_20_3].pool_stage] = self.poolStageCount_[iter_20_1][ActivityLimitedDrawPoolCfg[iter_20_3].pool_stage] or self.poolStageCount_[iter_20_1][ActivityLimitedDrawPoolCfg[iter_20_3].pool_stage - 1] or 0
			self.poolStageCount_[iter_20_1][ActivityLimitedDrawPoolCfg[iter_20_3].pool_stage] = self.poolStageCount_[iter_20_1][ActivityLimitedDrawPoolCfg[iter_20_3].pool_stage] + ActivityLimitedDrawPoolCfg[iter_20_3].total
			self.totalCount_[iter_20_1] = self.totalCount_[iter_20_1] + ActivityLimitedDrawPoolCfg[iter_20_3].total
		end
	end
end

function ActivitySkinDrawMainView:RefreshUI()
	SetActive(self.MovieBtnGo_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
	self:RefreshTime()
	self:RefreshPool()
end

function ActivitySkinDrawMainView:RefreshTime()
	local var_22_0

	self:StopTimer()

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
		self.timer_ = Timer.New(function()
			self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
			var_22_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_22_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function ActivitySkinDrawMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivitySkinDrawMainView:RefreshStroy()
	local var_25_0 = ActivitySkinDrawData:GetFinishedStory()

	self.openStoryIndex_ = #var_25_0 + 1

	for iter_25_0, iter_25_1 in ipairs(SkinCfg[self.skinID_].plot_title) do
		self.storyList_[iter_25_0].titleText_.text = GetI18NText(iter_25_1)
		self.storyIdList_[iter_25_0] = ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.activityID_] and ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.activityID_][iter_25_0]] and (ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.activityID_] and ActivityLimitedSkinStoryCfg[ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[self.activityID_][iter_25_0]]).story_id

		local var_25_1 = iter_25_0 <= self.openStoryIndex_

		self.storyList_[iter_25_0].lockController:SetSelectedState(tostring(iter_25_0 <= self.openStoryIndex_))

		if var_25_1 and not table.indexof(var_25_0, self.storyIdList_[iter_25_0]) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW .. iter_25_0, 1, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_DRAW .. iter_25_0, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
end

function ActivitySkinDrawMainView:RefreshPool()
	self:RefreshPoolData(self.poolIdList_)

	self.curPoolID_ = ActivitySkinDrawData:GetCurDrawPool(self.activityID_) or self.poolIdList_[1]
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]

	self:RefreshCurPool()
	self.poolList_:StartScroll(#self.poolDataList_)
end

function ActivitySkinDrawMainView:RefreshPoolData(arg_27_1)
	self.mainReward_ = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		self.lastCount_[iter_27_1] = self.lastCount_[iter_27_1] or {}
		self.lastCount_[iter_27_1] = self:CaculateCount(iter_27_1, ActivityLimitedDrawPoolListCfg[iter_27_1].activity_id[1])
		self.mainReward_[iter_27_1] = self.mainReward_[iter_27_1] or {}

		for iter_27_2, iter_27_3 in ipairs(ActivityLimitedDrawPoolListCfg[iter_27_1].main_icon_info) do
			local var_27_0 = ActivitySkinDrawData:GetDrawInfo(ActivityLimitedDrawPoolListCfg[iter_27_1].activity_id[1], iter_27_3[1])
			local var_27_1 = ActivityLimitedDrawPoolCfg[iter_27_3[1]].reward[1][1]
			local var_27_2 = {
				itemId = ActivityLimitedDrawPoolCfg[iter_27_3[1]].reward[1][1]
			}

			if var_27_0 then
				var_27_2.count = var_27_0.num or ActivityLimitedDrawPoolCfg[iter_27_3[1]].total
			end

			table.insert(self.mainReward_[iter_27_1], var_27_2)

			if ItemCfg[var_27_1].type == ItemConst.ITEM_TYPE.FRAME then
				self.frameID_ = var_27_1
			elseif ItemCfg[var_27_1].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				self.skinID_ = var_27_1
			elseif ActivitySkinDrawTools.GetIsSkinGift(var_27_1) then
				self.skinID_ = ItemCfg[var_27_1].param[1][1]
			elseif ItemCfg[var_27_1].type == ItemConst.ITEM_TYPE.SCENE then
				self.sceneIDList_[iter_27_1] = var_27_1
			end
		end
	end

	local var_27_3 = PlayerData:GetFrame(self.frameID_)

	self.frameUnlock_ = var_27_3 and var_27_3.unlock == 1 and var_27_3.lasted_time == 0
	self.skinUnlock_ = HeroTools.GetHasOwnedSkin(self.skinID_)
	self.sceneUnlock_ = self:IsSceneHad()
end

function ActivitySkinDrawMainView:CaculateCount(arg_28_1, arg_28_2)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_28_1] or {}) do
		local var_28_1 = ActivitySkinDrawData:GetDrawInfo(arg_28_2, iter_28_1)

		var_28_0 = var_28_1 and var_28_0 + var_28_1.num or var_28_0 + ActivityLimitedDrawPoolCfg[iter_28_1].total
	end

	return var_28_0
end

function ActivitySkinDrawMainView:RefreshCurPool()
	ActivitySkinDrawData:SetCurDrawPool(self.activityID_, self.curPoolID_)

	local var_29_0 = ActivityLimitedDrawPoolListCfg[self.curPoolID_]
	local var_29_1 = self.lastCount_[self.curPoolID_]

	if self.lastCount_[self.curPoolID_] >= 10 then
		self.drawCon_:SetSelectedState("ten")
	elseif var_29_1 > 0 then
		self.drawCon_:SetSelectedState("one")
	else
		self.drawCon_:SetSelectedState("none")
	end

	local var_29_2, var_29_3 = self:GetPoolNowStage(self.curPoolID_)

	self.textDrawDesc_.text = string.format(GetTips(var_29_2 == 1 and "SKIN_DRAE_DESC" or "SKIN_DRAE_DESC2"), var_29_3, GetI18NText(var_29_0.pool_name))
	self.textDrawTimes_.text = string.format("%s/%s", self.totalCount_[self.curPoolID_] - var_29_1, var_29_3)
	self.isSkinPool_ = var_29_0.pool_type == 1

	self.scenePreviewCon_:SetSelectedState(self.isSkinPool_ and "hide" or "show")

	self.drawIcon_1.sprite = ItemTools.getItemSprite(var_29_0.cost_once[1])
	self.drawIcon_2.sprite = ItemTools.getItemSprite(var_29_0.cost_once[1])
	self.curIndex_ = table.indexof(self.poolIdList_, self.curPoolID_) or 1

	self.rewardCon_:SetSelectedIndex(self.curIndex_ - 1)
	self:RefreshMainReward()
	self:RefreshDLC()
	self:RefreshMovie()
end

function ActivitySkinDrawMainView:RefreshMovie()
	self.criMovie_:Stop()

	local var_30_0 = deepClone(ObtainSkinBackgroundMovieCfg[self.curPoolActivityId_].start_path)
	local var_30_1
	local var_30_2 = ActivitySkinDrawData:GetLastFile(self.activityID_)

	if var_30_2 then
		local var_30_3 = math.random(#var_30_0 - 1)
		local var_30_4 = table.indexof(var_30_0, var_30_2)

		if var_30_4 and var_30_4 <= var_30_3 then
			var_30_3 = var_30_3 + 1
		end

		var_30_1 = var_30_0[var_30_3] or var_30_0[1]
	else
		var_30_1 = var_30_0[math.random(#var_30_0)] or var_30_0[1]
	end

	self:StopFrameTimer()

	self.frameTimer_ = FrameTimer.New(function()
		if tostring(self.criplayer_.status) == "Stop" then
			SetFile(self.criplayer_, nil, var_30_1, CriMana.Player.SetMode.New)
			ActivitySkinDrawData:SetLastFile(self.activityID_, var_30_1)
			self.criMovie_:Play()
			self:StopFrameTimer()
		end
	end, 1, -1)

	self.frameTimer_:Start()
end

function ActivitySkinDrawMainView:StopFrameTimer()
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function ActivitySkinDrawMainView:RefreshMainReward()
	if self.isSkinPool_ then
		if self.giftController_ then
			self.giftController_:SetSelectedState("false")
		end

		for iter_33_0, iter_33_1 in ipairs(self.mainReward_[self.curPoolID_]) do
			if ActivitySkinDrawTools.GetIsSkinGift(iter_33_1.itemId) and self.giftReward_ then
				self.giftReward_:SetData(iter_33_1.itemId, iter_33_1.count, nil, self.curPoolID_)
				self.giftController_:SetSelectedState("true")
			elseif self.skinID_ == iter_33_1.itemId then
				self.skinRewardList_[iter_33_0]:RefreshData(iter_33_1, self.curPoolID_)
			else
				self.skinRewardList_[iter_33_0]:RefreshData(iter_33_1)
			end
		end
	else
		self.sceneReward_:RefreshData(self.mainReward_[self.curPoolID_][1], self.curPoolID_)

		local var_33_0 = 1
		local var_33_1 = self.mainReward_[self.curPoolID_][1].count > 0

		for iter_33_2 = 2, #self.mainReward_[self.curPoolID_] do
			if self.dlcRewardList_[var_33_0] then
				self.dlcRewardList_[var_33_0]:RefreshData({
					itemId = self.mainReward_[self.curPoolID_][iter_33_2].itemId,
					count = self.mainReward_[self.curPoolID_][iter_33_2].count
				})
				self.dlcRewardList_[var_33_0]:SetLock(var_33_1)
			end

			var_33_0 = var_33_0 + 1
		end
	end
end

function ActivitySkinDrawMainView:RefreshDLC()
	if self.dlcBtn_ then
		if not self.isSkinPool_ then
			SetActive(self.dlcBtn_.gameObject, true)

			local var_34_0 = HomeSceneBundleCfg.get_id_list_by_scene_id[self.sceneIDList_[self.curPoolID_]] or {}
			local var_34_1 = 0

			for iter_34_0, iter_34_1 in ipairs(var_34_0) do
				if ItemTools.getItemNum(HomeSceneBundleCfg[iter_34_1].item_id) > 0 then
					var_34_1 = var_34_1 + 1
				end
			end

			self.dlcNumText_.text = string.format("%s/%s", var_34_1, #var_34_0)
		else
			SetActive(self.dlcBtn_.gameObject, false)
		end
	end
end

function ActivitySkinDrawMainView:CheckHadDrawed()
	if not self.params_.checkReward then
		return
	end

	if (getData("activity_check_had", "activity_" .. tostring(self.activityID_)) or 0) == 0 and self:CheckReward() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("GENGCHEN_SWIMWEAR_DES_1"),
			OkCallback = function()
				saveData("activity_check_had", "activity_" .. tostring(self.activityID_), 1)
			end
		})
	end
end

function ActivitySkinDrawMainView:CheckReward()
	for iter_37_0, iter_37_1 in pairs(self.mainReward_[self.curPoolID_]) do
		local var_37_0
		local var_37_1
		local var_37_2

		if ItemCfg[iter_37_1.itemId].type == ItemConst.ITEM_TYPE.FRAME then
			var_37_0 = self.frameUnlock_ and iter_37_1.count > 0
		elseif ItemCfg[iter_37_1.itemId].type == ItemConst.ITEM_TYPE.HERO_SKIN or ActivitySkinDrawTools.GetIsSkinGift(iter_37_1.itemId) then
			var_37_1 = self.skinUnlock_ and iter_37_1.count > 0
		elseif ItemCfg[iter_37_1.itemId].type == ItemConst.ITEM_TYPE.SCENE then
			var_37_2 = self.sceneUnlock_ and iter_37_1.count > 0
		end

		if var_37_0 or var_37_1 or var_37_2 then
			return true
		end
	end

	return false
end

function ActivitySkinDrawMainView:IsSceneHad()
	for iter_38_0, iter_38_1 in pairs(self.sceneIDList_) do
		if HomeSceneSettingData:IsUnlockScene(iter_38_1) then
			return true
		end
	end

	return false
end

function ActivitySkinDrawMainView:CheckSceneDrawed()
	local var_39_0 = self.sceneIDList_[self.curPoolID_]

	if self.params_.isSceneDrawed and self.sceneIDList_[self.curPoolID_] == self.params_.sceneDrawedId then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("GENGCHEN_SWIMWEAR_CHANGE_SCENE"), ItemTools.getItemName(self.sceneIDList_[self.curPoolID_])),
			OkCallback = function()
				JumpTools.OpenPageByJump("/customCenter", {
					selectType = CustomCenterView.SELECT_SCENE,
					sceneID = var_39_0
				})
			end
		})
	end

	self.params_.isSceneDrawed = false
	self.params_.sceneDrawedId = 0
end

function ActivitySkinDrawMainView:JumpToVideo(arg_41_1)
	if not SkinCfg[self.skinID_].video_url[arg_41_1] or SkinCfg[self.skinID_].video_url[arg_41_1] == "" then
		return
	end

	OperationAction.OpenNormalUrl(SkinCfg[self.skinID_].video_url[arg_41_1])
end

function ActivitySkinDrawMainView:DrawCheck(arg_42_1)
	if not self.activityData_:IsActivitying() then
		ShowTips("TIME_OVER")

		return
	end

	if not _G.SkipTip.SkipActivitySkinDrawTip then
		local var_42_0 = {}
		local var_42_1 = false
		local var_42_2 = false
		local var_42_3 = false

		if self.isSkinPool_ then
			var_42_0[#var_42_0 + 1] = self.skinID_
			var_42_1 = self.skinUnlock_
			var_42_2 = self.frameUnlock_

			if self.frameUnlock_ then
				var_42_0[#var_42_0 + 1] = self.frameID_
			end
		else
			var_42_0[#var_42_0 + 1] = self.sceneIDList_[self.curPoolID_]
			var_42_3 = HomeSceneSettingData:IsUnlockScene(self.sceneIDList_[self.curPoolID_])
		end

		if var_42_3 or var_42_2 and var_42_1 then
			local var_42_4 = var_42_3 and string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE"), ItemTools.getItemName(var_42_0[1])) or string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE2"), ItemTools.getItemName(var_42_0[1]), ItemTools.getItemName(var_42_0[2]))

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_42_4,
				OkCallback = function()
					_G.SkipTip.SkipActivitySkinDrawTip = self.SkipActivitySkinDrawTip_

					self:AfterCheck(arg_42_1)
				end,
				ToggleCallback = function(arg_44_0)
					self.SkipActivitySkinDrawTip_ = arg_44_0
				end
			})
		else
			self:AfterCheck(arg_42_1)
		end
	else
		self:AfterCheck(arg_42_1)
	end
end

function ActivitySkinDrawMainView:AfterCheck(arg_45_1)
	if arg_45_1 <= ItemTools.getItemNum(ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1]) then
		ActivitySkinDrawAction.StartDraw(self.curPoolActivityId_, self.curPoolID_, arg_45_1)
	else
		local var_45_0 = getShopCfg(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
		local var_45_1 = {}
		local var_45_2 = {}

		table.insert(var_45_1, ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
		table.insert(var_45_2, var_45_0.discount)

		local var_45_3 = ShopData.GetShop(var_45_0.shop_id)[ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1]].buy_times or 0

		for iter_45_0, iter_45_1 in ipairs(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment) do
			local var_45_4 = getShopCfg(iter_45_1)
			local var_45_5 = ShopData.GetShop(var_45_4.shop_id)[iter_45_1]

			if var_45_5 then
				local var_45_7 = var_45_4.limit_num - (var_45_5.buy_times or 0)

				if arg_45_1 <= var_45_4.limit_num - (var_45_5.buy_times or 0) and arg_45_1 <= var_45_0.limit_num - var_45_3 then
					table.insert(var_45_1, iter_45_1)
					table.insert(var_45_2, var_45_4.discount)
					JumpTools.OpenPageByJump("activitySkinDrawPop", {
						mainActivity = self.activityID_,
						poolActivityID = self.curPoolActivityId_,
						poolID = self.curPoolID_,
						cnt = arg_45_1,
						goods = var_45_1,
						discount = var_45_2
					})

					break
				elseif var_45_7 > 0 then
					JumpTools.GoToSystem("/activityShop", {
						goodId = iter_45_1,
						shopId = var_45_4.shop_id,
						showShops = {
							var_45_4.shop_id
						}
					}, ViewConst.SYSTEM_ID.SHOP)

					break
				end
			end
		end
	end
end

function ActivitySkinDrawMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. self.taskActiivtyID_)

	for iter_46_0, iter_46_1 in ipairs(self.storyList_) do
		manager.redPoint:bindUIandKey(iter_46_1.noticeTrans_, RedPointConst.ACTIVITY_SKIN_DRAW .. iter_46_0)
	end
end

function ActivitySkinDrawMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. self.taskActiivtyID_)

	for iter_47_0, iter_47_1 in ipairs(self.storyList_) do
		manager.redPoint:unbindUIandKey(iter_47_1.noticeTrans_, RedPointConst.ACTIVITY_SKIN_DRAW .. iter_47_0)
	end
end

function ActivitySkinDrawMainView:IndexItem(arg_48_1, arg_48_2)
	arg_48_2:SetData(self.poolDataList_[arg_48_1], arg_48_1)
	arg_48_2:RegisterClickFunc(handler(self, self.OnPoolItemClick))

	if arg_48_1 == self.curIndex_ then
		arg_48_2:SelectItem(true)

		self.selectItem_ = arg_48_2
	else
		arg_48_2:SelectItem(false)
	end
end

function ActivitySkinDrawMainView:OnPoolItemClick(arg_49_1)
	if self.selectItem_ then
		if self.selectItem_.poolId_ == arg_49_1.poolId_ then
			return
		end

		self.selectItem_:SelectItem(false)
	end

	self.selectItem_ = arg_49_1

	self.selectItem_:SelectItem(true)

	self.curPoolID_ = arg_49_1.poolId_
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]

	self:RefreshCurPool()
end

function ActivitySkinDrawMainView:OnSelectPool(arg_50_1)
	self.curPoolID_ = arg_50_1
	self.curPoolActivityId_ = ActivityLimitedDrawPoolListCfg[self.curPoolID_].activity_id[1]

	local var_50_0

	for iter_50_0, iter_50_1 in ipairs(self.poolList_:GetItemList()) do
		if iter_50_1.poolId_ == arg_50_1 then
			var_50_0 = iter_50_1

			break
		end
	end

	if self.selectItem_ then
		if self.selectItem_.poolId_ == var_50_0.poolId_ then
			return
		end

		self.selectItem_:SelectItem(false)
	end

	self.selectItem_ = var_50_0

	self.selectItem_:SelectItem(true)
	self:RefreshCurPool()
end

function ActivitySkinDrawMainView:RefreshBar()
	local var_51_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_51_1 = {}

	for iter_51_0, iter_51_1 in ipairs(self.poolDataList_) do
		if not table.indexof(var_51_0, iter_51_1.cost_once[1]) then
			table.insert(var_51_1, iter_51_1.cost_once[1])
		end
	end

	table.insertto(var_51_0, var_51_1)
	table.insertto(var_51_0, {
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SwitchBar(var_51_0)

	for iter_51_2, iter_51_3 in ipairs(var_51_1) do
		manager.windowBar:SetBarCanClick(iter_51_3, true)
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function ActivitySkinDrawMainView:GetPoolNowStage(arg_52_1)
	local var_52_0 = 1

	for iter_52_0, iter_52_1 in ipairs(self.poolStageCount_[arg_52_1]) do
		if iter_52_1 <= self.totalCount_[arg_52_1] - self.lastCount_[arg_52_1] then
			var_52_0 = math.min(iter_52_0 + 1, #self.poolStageCount_[arg_52_1])
		end
	end

	return var_52_0, self.poolStageCount_[arg_52_1][var_52_0]
end

function ActivitySkinDrawMainView:OnTop()
	self:RefreshBar()
	self:RefreshStroy()
end

function ActivitySkinDrawMainView:OnExit()
	self:StopTimer()
	self:StopFrameTimer()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	for iter_54_0, iter_54_1 in ipairs(self.skinPoolItem_) do
		iter_54_1:OnExit()
	end

	for iter_54_2, iter_54_3 in ipairs(self.scenePoolItem_) do
		iter_54_3:OnExit()
	end
end

function ActivitySkinDrawMainView:Dispose()
	self:RemoveAllListeners()

	for iter_55_0, iter_55_1 in ipairs(self.skinRewardList_) do
		iter_55_1:Dispose()
	end

	self.skinRewardList_ = {}

	if self.giftReward_ then
		self.giftReward_:Dispose()

		self.giftReward_ = {}
	end

	if self.sceneReward_ then
		self.sceneReward_:Dispose()

		self.sceneReward_ = {}
	end

	for iter_55_2, iter_55_3 in ipairs(self.dlcRewardList_) do
		iter_55_3:Dispose()
	end

	self.dlcRewardList_ = {}

	if self.poolList_ then
		self.poolList_:Dispose()

		self.poolList_ = nil
	end

	self.super.Dispose(self)
end

return ActivitySkinDrawMainView
