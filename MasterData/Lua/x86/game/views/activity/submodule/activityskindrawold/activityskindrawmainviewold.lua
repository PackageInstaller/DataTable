local ActivitySkinDrawMainViewOld = class("ActivitySkinDrawMainViewOld", ReduxView)

function ActivitySkinDrawMainViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetMainUIName(self.params_.activityID)
end

function ActivitySkinDrawMainViewOld:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawMainViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawMainViewOld:InitUI()
	self:BindCfgUI()

	self.skinPoolItem_ = {}
	self.scenePoolItem_ = {}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.drawCon_ = ControllerUtil.GetController(self.transform_, "draw")
	self.skinCon_ = ControllerUtil.GetController(self.transform_, "skin")
	self.frameCon_ = ControllerUtil.GetController(self.transform_, "frame")
	self.sceneCon_ = ControllerUtil.GetController(self.transform_, "scene")
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
end

function ActivitySkinDrawMainViewOld:AddUIListeners()
	self:AddBtnListener(self.storyBtn_, nil, function()
		manager.story:StartStoryById(ActivitySkinDrawToolsOld.GetStoryID(self.activityID_), function()
			return
		end)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activitySkinDrawTaskOld", {
			activityID = self.activityID_,
			taskActivityID = self.taskActiivtyID_
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_9_0 = ActivitySkinDrawToolsOld.GetActivityShopID(self.activityID_)

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
	self:AddBtnListener(self.pvBtn_, nil, function()
		if not SkinCfg[self.skinID_].video_url[1] or SkinCfg[self.skinID_].video_url[1] == "" then
			return
		end

		Application.OpenURL(SkinCfg[self.skinID_].video_url[1])
	end)
	self:AddBtnListener(self.sceneTrailBtn_, nil, function()
		JumpTools.OpenPageByJump("/customCenter", {
			selectType = CustomCenterView.SELECT_SCENE,
			sceneID = self.sceneID_
		})
	end)
	self:AddBtnListener(self.infoSkinBtn_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfoOld", {
			poolID = self.skinPoolID_,
			mainActivity = self.activityID_,
			poolActivityID = self.skinDrawActivityID_
		})
	end)
	self:AddBtnListener(self.infoSceneBtn_, nil, function()
		JumpTools.OpenPageByJump("skinDrawInfoOld", {
			poolID = self.scenePoolID_,
			mainActivity = self.activityID_,
			poolActivityID = self.sceneDrawActivityID_
		})
	end)
	self:AddBtnListener(self.skinSelectBtn_, nil, function()
		self.curPoolID_ = self.skinPoolID_

		self:RefreshCurPool()
	end)
	self:AddBtnListener(self.sceneSelectBtn_, nil, function()
		self.curPoolID_ = self.scenePoolID_

		self:RefreshCurPool()
	end)
	self:AddBtnListener(self.oneBtn_, nil, function()
		self:DrawCheck(1)
	end)
	self:AddBtnListener(self.tenBtn_, nil, function()
		self:DrawCheck(10)
	end)
	self:AddBtnListener(self.frameBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			self.frameID_
		})
	end)
	self:AddBtnListener(self.skinBtn, nil, function()
		ShowPopItem(POP_ITEM, {
			self.skinID_
		})
	end)
	self:AddBtnListener(self.sceneBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			self.sceneID_
		})
	end)
end

function ActivitySkinDrawMainViewOld:OnEnter()
	self:InitData()
	self:RefreshUI()
	self:BindRedPoint()
	self:CheckHadDrawed()
	self:CheckSceneDrawed()
end

function ActivitySkinDrawMainViewOld:InitData()
	self.activityID_ = self.params_.activityID
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
	self.taskActiivtyID_ = ActivitySkinDrawToolsOld.GetTaskActivityID(self.activityID_)
	self.skinDrawActivityID_ = ActivitySkinDrawToolsOld.GetSkinPoolActivityID(self.activityID_)
	self.sceneDrawActivityID_ = ActivitySkinDrawToolsOld.GetScenePoolActivityID(self.activityID_)
	self.skinPoolID_ = ActivitySkinDrawToolsOld.GetPoolID(self.skinDrawActivityID_)
	self.scenePoolID_ = ActivitySkinDrawToolsOld.GetPoolID(self.sceneDrawActivityID_)
end

function ActivitySkinDrawMainViewOld:RefreshUI()
	self:RefreshMovie()
	self:RefreshTime()
	self:RefreshPool()
	self:RefreshBar()

	if SDKTools.GetIsOverSea() then
		SetActive(self.pvBtn_.gameObject, false)
	else
		SetActive(self.pvBtn_.gameObject, true)
	end
end

function ActivitySkinDrawMainViewOld:RefreshMovie()
	self.criMovie_:Stop()

	local var_24_0 = deepClone(ObtainSkinBackgroundMovieCfg[self.activityID_].start_path)
	local var_24_1
	local var_24_2 = ActivitySkinDrawDataOld:GetLastFile(self.activityID_)

	if var_24_2 then
		local var_24_3 = math.random(#var_24_0 - 1)

		if var_24_3 >= table.indexof(var_24_0, var_24_2) then
			var_24_3 = var_24_3 + 1
		end

		var_24_1 = var_24_0[var_24_3] or var_24_0[1]
	else
		var_24_1 = var_24_0[math.random(#var_24_0)] or var_24_0[1]
	end

	self:StopFrameTimer()

	self.frameTimer_ = FrameTimer.New(function()
		if tostring(self.criplayer_.status) == "Stop" then
			self.criplayer_:SetFile(nil, var_24_1, CriMana.Player.SetMode.New)
			ActivitySkinDrawDataOld:SetLastFile(self.activityID_, var_24_1)
			self.criMovie_:Play()
			self:StopFrameTimer()
		end
	end, 1, -1)

	self.frameTimer_:Start()
end

function ActivitySkinDrawMainViewOld:StopFrameTimer()
	if self.frameTimer_ then
		self.frameTimer_:Stop()

		self.frameTimer_ = nil
	end
end

function ActivitySkinDrawMainViewOld:RefreshTime()
	local var_27_0

	self:StopTimer()

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
		self.timer_ = Timer.New(function()
			self.timeText_.text = GetTips("REMAINING_TIME") .. GetI18NText(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
			var_27_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_27_0 <= 0 then
				self:StopTimer()
				self:RefreshTime()
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeText_.text = GetI18NText(GetTips("TIME_OVER"))
	end
end

function ActivitySkinDrawMainViewOld:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivitySkinDrawMainViewOld:RefreshPool()
	self:RefreshSkinPool()
	self:RefreshScenePool()
	self:GetCurPoolID()
	self:RefreshCurPool()
end

function ActivitySkinDrawMainViewOld:RefreshSkinPool()
	self.skinLastCnt_ = 0
	self.skinTotalCnt_ = 0

	for iter_31_0, iter_31_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[self.skinPoolID_] or {}) do
		self.skinTotalCnt_ = self.skinTotalCnt_ + ActivityLimitedDrawPoolCfg[iter_31_1].total

		local var_31_0 = ActivitySkinDrawDataOld:GetDrawInfo(self.skinDrawActivityID_, iter_31_1)

		if var_31_0 then
			self.skinLastCnt_ = self.skinLastCnt_ + var_31_0.num or self.skinLastCnt_ + ActivityLimitedDrawPoolCfg[iter_31_1].total
		end
	end

	local var_31_1 = ActivityLimitedDrawPoolListCfg[self.skinPoolID_].main_icon_info
	local var_31_2 = ActivityLimitedDrawPoolCfg[ActivityLimitedDrawPoolListCfg[self.skinPoolID_].main_icon_info[1][1]]
	local var_31_3 = ActivitySkinDrawDataOld:GetDrawInfo(self.skinDrawActivityID_, ActivityLimitedDrawPoolListCfg[self.skinPoolID_].main_icon_info[1][1])

	if var_31_3 then
		self.frameCnt_ = var_31_3.num or var_31_2.total
	end

	self.frameCon_:SetSelectedState(self.frameCnt_ > 0 and "on" or "off")

	self.frameSelectIcon_.sprite = ItemTools.getItemSprite(var_31_1[1][2])
	self.frameUnselectIcon_.sprite = ItemTools.getItemSprite(var_31_1[1][2])

	local var_31_4 = ActivityLimitedDrawPoolCfg[var_31_1[2][1]]
	local var_31_5 = ActivitySkinDrawDataOld:GetDrawInfo(self.skinDrawActivityID_, var_31_1[2][1])

	if var_31_5 then
		self.skinCnt_ = var_31_5.num or var_31_4.total
	end

	self.skinCon_:SetSelectedState(self.skinCnt_ > 0 and "on" or "off")

	self.skinSelectIcon_.sprite = ItemTools.getItemSprite(var_31_1[2][2])
	self.skinUnselectIcon_.sprite = ItemTools.getItemSprite(var_31_1[2][2])
	self.frameID_ = var_31_2.reward[1][1]
	self.skinID_ = var_31_4.reward[1][1]

	for iter_31_2, iter_31_3 in ipairs(ActivityLimitedDrawPoolListCfg[self.skinPoolID_].icon_info) do
		self.skinPoolItem_[iter_31_2] = self.skinPoolItem_[iter_31_2] or ActivitySkinDrawItemOld.New((Object.Instantiate(self.templateItem_, self.skinRewardContent_)))

		self.skinPoolItem_[iter_31_2]:SetData(self.skinDrawActivityID_, iter_31_3)
		self.skinPoolItem_[iter_31_2]:SetValue(true)
	end

	for iter_31_4 = #ActivityLimitedDrawPoolListCfg[self.skinPoolID_].icon_info + 1, #self.skinPoolItem_ do
		self.skinPoolItem_[iter_31_4]:SetValue(false)
	end
end

function ActivitySkinDrawMainViewOld:RefreshScenePool()
	self.sceneLastCnt_ = 0
	self.sceneTotalCnt_ = 0

	for iter_32_0, iter_32_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[self.scenePoolID_] or {}) do
		self.sceneTotalCnt_ = self.sceneTotalCnt_ + ActivityLimitedDrawPoolCfg[iter_32_1].total

		local var_32_0 = ActivitySkinDrawDataOld:GetDrawInfo(self.sceneDrawActivityID_, iter_32_1)

		if var_32_0 then
			self.sceneLastCnt_ = self.sceneLastCnt_ + var_32_0.num or self.sceneLastCnt_ + ActivityLimitedDrawPoolCfg[iter_32_1].total
		end
	end

	local var_32_1 = ActivityLimitedDrawPoolCfg[ActivityLimitedDrawPoolListCfg[self.scenePoolID_].main_icon_info[1][1]]
	local var_32_2 = ActivitySkinDrawDataOld:GetDrawInfo(self.sceneDrawActivityID_, ActivityLimitedDrawPoolListCfg[self.scenePoolID_].main_icon_info[1][1])

	if var_32_2 then
		self.sceneCnt_ = var_32_2.num or var_32_1.total
	end

	self.sceneCon_:SetSelectedState(self.sceneCnt_ > 0 and "on" or "off")

	self.sceneID_ = var_32_1.reward[1][1]

	for iter_32_2, iter_32_3 in ipairs(ActivityLimitedDrawPoolListCfg[self.scenePoolID_].icon_info) do
		self.scenePoolItem_[iter_32_2] = self.scenePoolItem_[iter_32_2] or ActivitySkinDrawItemOld.New((Object.Instantiate(self.templateItem_, self.sceneRewardContent_)))

		self.scenePoolItem_[iter_32_2]:SetData(self.sceneDrawActivityID_, iter_32_3)
		self.scenePoolItem_[iter_32_2]:SetValue(true)
	end

	for iter_32_4 = #ActivityLimitedDrawPoolListCfg[self.scenePoolID_].icon_info + 1, #self.scenePoolItem_ do
		self.scenePoolItem_[iter_32_4]:SetValue(false)
	end
end

function ActivitySkinDrawMainViewOld:GetCurPoolID()
	self.curPoolID_ = ActivitySkinDrawDataOld:GetCurDrawPool(self.activityID_) or self.skinPoolID_
end

function ActivitySkinDrawMainViewOld:RefreshCurPool()
	local var_34_0 = 0

	if self.curPoolID_ == self.skinPoolID_ then
		self.typeCon_:SetSelectedState("skin")

		var_34_0 = self.skinLastCnt_
	else
		self.typeCon_:SetSelectedState("scene")

		var_34_0 = self.sceneLastCnt_
	end

	ActivitySkinDrawDataOld:SetCurDrawPool(self.activityID_, self.curPoolID_)

	if var_34_0 >= 10 then
		self.drawCon_:SetSelectedState("ten")
	elseif var_34_0 > 0 then
		self.drawCon_:SetSelectedState("one")
	else
		self.drawCon_:SetSelectedState("none")
	end

	local var_34_1 = ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1]

	self.drawIcon_1.sprite = ItemTools.getItemSprite(ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1])
	self.drawIcon_2.sprite = ItemTools.getItemSprite(var_34_1)

	self.btnAni_:Play("btn_show", -1, 0)
end

function ActivitySkinDrawMainViewOld:CheckHadDrawed()
	if not self.params_.checkReward then
		return
	end

	if (getData("activity_check_had", "activity_" .. tostring(self.activityID_)) or 0) == 0 then
		local var_35_0 = PlayerData:GetFrame(self.frameID_)

		if var_35_0 and var_35_0.unlock == 1 and var_35_0.lasted_time == 0 and self.frameCnt_ > 0 or HeroTools.IsSkinUnlock(self.skinID_) and self.skinCnt_ > 0 or HomeSceneSettingData:IsUnlockScene(self.sceneID_) and self.sceneCnt_ > 0 then
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
end

function ActivitySkinDrawMainViewOld:CheckSceneDrawed()
	if self.params_.isSceneDrawed then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("GENGCHEN_SWIMWEAR_CHANGE_SCENE"), ItemTools.getItemName(self.sceneID_)),
			OkCallback = function()
				JumpTools.OpenPageByJump("/customCenter", {
					selectType = CustomCenterView.SELECT_SCENE,
					sceneID = self.sceneID_
				})
			end
		})
	end

	self.params_.isSceneDrawed = false
end

function ActivitySkinDrawMainViewOld:DrawCheck(arg_39_1)
	if not self.activityData_:IsActivitying() then
		ShowTips("TIME_OVER")

		return
	end

	if not _G.SkipTip.SkipActivitySkinDrawTip then
		local var_39_0
		local var_39_1 = true

		if self.curPoolID_ == self.skinPoolID_ then
			var_39_0 = self.skinID_
			var_39_1 = HeroTools.IsSkinUnlock(self.skinID_)

			if not var_39_1 then
				local var_39_2 = PlayerData:GetFrame(self.frameID_)

				if var_39_2 and var_39_2.unlock == 1 and var_39_2.lasted_time == 0 then
					var_39_1 = true
					var_39_0 = self.frameID_
				end
			end
		else
			var_39_0 = self.sceneID_
			var_39_1 = HomeSceneSettingData:IsUnlockScene(self.sceneID_)
		end

		if var_39_1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("GENGCHEN_SWIMWEAR_CONTINUE"), ItemTools.getItemName(var_39_0)),
				OkCallback = function()
					_G.SkipTip.SkipActivitySkinDrawTip = self.SkipActivitySkinDrawTip_

					self:AfterCheck(arg_39_1)
				end,
				ToggleCallback = function(arg_41_0)
					self.SkipActivitySkinDrawTip_ = arg_41_0
				end
			})
		else
			self:AfterCheck(arg_39_1)
		end
	else
		self:AfterCheck(arg_39_1)
	end
end

function ActivitySkinDrawMainViewOld:AfterCheck(arg_42_1)
	if arg_42_1 <= ItemTools.getItemNum(ActivityLimitedDrawPoolListCfg[self.curPoolID_].cost_once[1]) then
		self:StartDraw(arg_42_1)
	else
		local var_42_0 = {}

		table.insert(var_42_0, ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])

		local var_42_1 = getShopCfg(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1])
		local var_42_2 = ShopData.GetShop(var_42_1.shop_id)[ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment_free[1]].buy_times or 0

		for iter_42_0, iter_42_1 in ipairs(ActivityLimitedDrawPoolListCfg[self.curPoolID_].payment) do
			local var_42_3 = getShopCfg(iter_42_1)
			local var_42_4 = ShopData.GetShop(var_42_3.shop_id)[iter_42_1]

			if var_42_4 then
				local var_42_6 = var_42_3.limit_num - (var_42_4.buy_times or 0)

				if arg_42_1 <= var_42_3.limit_num - (var_42_4.buy_times or 0) and arg_42_1 <= var_42_1.limit_num - var_42_2 then
					table.insert(var_42_0, iter_42_1)
					self:GoPopView(arg_42_1, var_42_0)

					break
				elseif var_42_6 > 0 then
					self:GoToShop(iter_42_1, var_42_3.shop_id)

					break
				end
			end
		end
	end
end

function ActivitySkinDrawMainViewOld:StartDraw(arg_43_1)
	if self.curPoolID_ == self.skinPoolID_ then
		ActivitySkinDrawActionOld.StartDraw(self.skinDrawActivityID_, self.skinPoolID_, arg_43_1)
	elseif self.curPoolID_ == self.scenePoolID_ then
		ActivitySkinDrawActionOld.StartDraw(self.sceneDrawActivityID_, self.scenePoolID_, arg_43_1)
	end
end

function ActivitySkinDrawMainViewOld:GoPopView(arg_44_1, arg_44_2)
	JumpTools.OpenPageByJump("activitySkinDrawPopOld", {
		mainActivity = self.activityID_,
		poolActivityID = (self.curPoolID_ == self.skinPoolID_ or nil) and (self.skinDrawActivityID_ or self.sceneDrawActivityID_),
		poolID = self.curPoolID_,
		cnt = arg_44_1,
		goods = arg_44_2
	})
end

function ActivitySkinDrawMainViewOld:GoToShop(arg_45_1, arg_45_2)
	JumpTools.GoToSystem("/activityShop", {
		goodId = arg_45_1,
		shopId = arg_45_2,
		showShops = {
			arg_45_2
		}
	}, ViewConst.SYSTEM_ID.SHOP)
end

function ActivitySkinDrawMainViewOld:BindRedPoint()
	manager.redPoint:bindUIandKey(self.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. self.sceneID_)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. self.taskActiivtyID_)
end

function ActivitySkinDrawMainViewOld:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.sceneTrailBtn_.transform, RedPointConst.SCENE .. "_" .. self.sceneID_)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. self.taskActiivtyID_)
end

function ActivitySkinDrawMainViewOld:RefreshBar()
	local var_48_0 = {
		BACK_BAR,
		HOME_BAR
	}

	table.insert(var_48_0, ActivityLimitedDrawPoolListCfg[self.skinPoolID_].cost_once[1])
	table.insert(var_48_0, ActivityLimitedDrawPoolListCfg[self.scenePoolID_].cost_once[1])
	table.insertto(var_48_0, {
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SwitchBar(var_48_0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(ActivityLimitedDrawPoolListCfg[self.skinPoolID_].cost_once[1], true)
	manager.windowBar:SetBarCanAdd(ActivityLimitedDrawPoolListCfg[self.scenePoolID_].cost_once[1], true)
end

function ActivitySkinDrawMainViewOld:OnTop()
	if self.skinPoolID_ and self.scenePoolID_ then
		self:RefreshBar()
	end
end

function ActivitySkinDrawMainViewOld:OnExit()
	self:StopTimer()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	for iter_50_0, iter_50_1 in ipairs(self.skinPoolItem_) do
		iter_50_1:OnExit()
	end

	for iter_50_2, iter_50_3 in ipairs(self.scenePoolItem_) do
		iter_50_3:OnExit()
	end
end

function ActivitySkinDrawMainViewOld:Dispose()
	self:RemoveAllListeners()

	for iter_51_0, iter_51_1 in ipairs(self.skinPoolItem_) do
		iter_51_1:Dispose()
	end

	self.skinPoolItem_ = {}

	for iter_51_2, iter_51_3 in ipairs(self.scenePoolItem_) do
		iter_51_3:Dispose()
	end

	self.scenePoolItem_ = {}

	self.super.Dispose(self)
end

return ActivitySkinDrawMainViewOld
