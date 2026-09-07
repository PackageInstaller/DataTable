local ActivityMainScene = class("ActivityMainScene", import("..base.BaseUI"))

ActivityMainScene.LOCK_ACT_MAIN = "ActivityMainScene:LOCK_ACT_MAIN"
ActivityMainScene.UPDATE_ACTIVITY = "ActivityMainScene:UPDATE_ACTIVITY"
ActivityMainScene.GET_PAGE_BGM = "ActivityMainScene.GET_PAGE_BGM"
ActivityMainScene.FLUSH_TABS = "ActivityMainScene.FLUSH_TABS"

function ActivityMainScene:preload(arg_1_1)
	arg_1_1()

	return
end

function ActivityMainScene:getUIName()
	return "ActivityMainUI"
end

function ActivityMainScene:PlayBGM()
	return
end

function ActivityMainScene:onBackPressed()
	if self.locked then
		return
	end

	for iter_4_0, iter_4_1 in pairs(self.windowList) do
		if isActive(iter_4_1._tf) then
			self:HideWindow(iter_4_1.class)

			return
		end
	end

	if self.awardWindow and self.awardWindow:GetLoaded() and self.awardWindow:isShowing() then
		self.awardWindow:Hide()

		return
	end

	for iter_4_2, iter_4_3 in pairs(self.pageDic) do
		if iter_4_3.onBackPressed and iter_4_3:onBackPressed() then
			return
		end
	end

	self:emit(ActivityMainScene.ON_BACK_PRESSED)

	return
end

local var_0_1

function ActivityMainScene:init()
	self.entranceList = UIItemList.New(self.entranceContent, self.entranceTpl)
	self.windowList = {}
	self.awardWindow = AwardWindow.New(self._tf, self.event)
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	setActive(self.tab, false)
	setActive(self.lockAll, false)
	setActive(self.permanentFinshMask, false)
	setText(self.permanentFinshMask:Find("piece/Text"), i18n("activity_permanent_tips2"))
	onButton(self, self.permanentFinshMask:Find("piece/arrow/Image"), function()
		self:emit(ActivityMediator.FINISH_ACTIVITY_PERMANENT)

		return
	end, SFX_PANEL)

	self.tabsList = UIItemList.New(self.tabs, self.tab)

	self.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = self.activities[arg_7_1 + 1]

			arg_7_2.name = self.activities[arg_7_1 + 1].id

			local var_7_1 = self.activities[arg_7_1 + 1]:getConfig("title_res_tag")

			if var_7_1 then
				local var_7_2 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text", "") or GetSpriteFromAtlas("activityuitable/activity_text", "")
				local var_7_3 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text_selected", "") or GetSpriteFromAtlas("activityuitable/activity_text_selected", "")

				setImageSprite(arg_7_2:Find("off/text"), var_7_2, true)
				setImageSprite(arg_7_2:Find("on/text"), var_7_3, true)
				setActive(arg_7_2:Find("red"), self.activities[arg_7_1 + 1]:readyToAchieve())
				onToggle(self, arg_7_2, function(arg_8_0)
					if arg_8_0 then
						self:selectActivity(var_7_0)
					end

					return
				end, SFX_PANEL)
			end

			local var_7_4 = self.pageDic[self.activities[arg_7_1 + 1].id]

			onToggle(self, arg_7_2, function(arg_9_0)
				if var_7_4 then
					if arg_9_0 then
						self:selectActivity(var_7_0)
					end
				else
					self:loadActivityPanel(arg_9_0, var_7_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.switchCount = 0

	return
end

function ActivityMainScene:didEnter()
	self:bind(ActivityMainScene.LOCK_ACT_MAIN, function(arg_11_0, arg_11_1)
		self.locked = arg_11_1

		setActive(self.lockAll, arg_11_1)

		return
	end)
	self:bind(ActivityMainScene.UPDATE_ACTIVITY, function(arg_12_0, arg_12_1)
		self:updateActivity(arg_12_1)

		return
	end)
	self:bind(ActivityMainScene.GET_PAGE_BGM, function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_2.bgm = self:getBGM(arg_13_1) or self:getBGM()

		return
	end)
	self:bind(ActivityMainScene.FLUSH_TABS, function()
		self:flushTabs()

		return
	end)
	getProxy(CommanderManualProxy):TaskProgressAdd(2020, 1)
	onButton(self, self.btnBack, function()
		self:emit(ActivityMainScene.ON_BACK)

		return
	end, SOUND_BACK)
	self:updateEntrances()
	self:emit(ActivityMediator.SHOW_NEXT_ACTIVITY)

	if self.contextData.event then
		self:emit(self.contextData.event, self.contextData.data)

		self.contextData.event = nil
		self.contextData.data = nil
	end

	pg.CameraFixMgr.GetInstance():Adapt()

	return
end

function ActivityMainScene:setPlayer(arg_16_1)
	self.shareData:SetPlayer(arg_16_1)

	return
end

function ActivityMainScene:setFlagShip(arg_17_1)
	self.shareData:SetFlagShip(arg_17_1)

	return
end

function ActivityMainScene:updateTaskLayers()
	if not self.activity then
		return
	end

	self:updateActivity(self.activity)

	return
end

function ActivityMainScene:getActClass(arg_19_1)
	return import("view.activity.subPages." .. arg_19_1)
end

function ActivityMainScene:instanceActivityPage(arg_20_1)
	local var_20_0 = arg_20_1:getConfig("page_info")

	if var_20_0.class_name and not self.pageDic[arg_20_1.id] and not arg_20_1:isEnd() then
		local var_20_1 = self:getActClass(var_20_0.class_name).New(self.pageContainer, self.event, self.contextData)

		if var_20_1:UseSecondPage(arg_20_1) then
			var_20_1:SetUIName(var_20_0.ui_name2)
		else
			var_20_1:SetUIName(var_20_0.ui_name)
		end

		var_20_1:SetShareData(self.shareData)

		self.pageDic[arg_20_1.id] = var_20_1
	end

	return
end

function ActivityMainScene:setActivities(arg_21_1)
	self.activities = arg_21_1 or {}
	self.shareData = self.shareData or ActivityShareData.New()
	self.pageDic = self.pageDic or {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		self:instanceActivityPage(iter_21_1)
	end

	self.activity = nil

	table.sort(self.activities, CompareFuncs({
		function(arg_22_0)
			return -arg_22_0:getShowPriority()
		end,
		function(arg_23_0)
			return -arg_23_0.id
		end
	}))
	self:flushTabs()

	return
end

function ActivityMainScene:getActivityIndex(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.activities) do
		if iter_24_1.id == arg_24_1 then
			return iter_24_0
		end
	end

	return nil
end

function ActivityMainScene:updateActivity(arg_25_1)
	if ActivityConst.PageIdLink[arg_25_1.id] then
		arg_25_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_25_1.id])
	end

	if arg_25_1:isShow() then
		if arg_25_1:isCorePage(self.contextData.coreName or "") and not arg_25_1:isEnd() then
			self.activities[self:getActivityIndex(arg_25_1.id) or #self.activities + 1] = arg_25_1

			table.sort(self.activities, CompareFuncs({
				function(arg_26_0)
					return -arg_26_0:getShowPriority()
				end,
				function(arg_27_0)
					return -arg_27_0.id
				end
			}))

			if not self.pageDic[arg_25_1.id] then
				self:instanceActivityPage(arg_25_1)
			end

			self:flushTabs()

			if self.activity and self.activity.id == arg_25_1.id then
				self.activity = arg_25_1

				self.pageDic[arg_25_1.id]:ActionInvoke("Flush", arg_25_1)
				setActive(self.permanentFinshMask, pg.activity_task_permanent[arg_25_1.id] and arg_25_1:canPermanentFinish())
			end
		end
	end

	return
end

function ActivityMainScene:removeActivity(arg_28_1)
	local var_28_0 = self:getActivityIndex(arg_28_1)

	if var_28_0 then
		table.remove(self.activities, var_28_0)
		self.pageDic[arg_28_1]:Destroy()

		self.pageDic[arg_28_1] = nil

		self:flushTabs()

		if self.activity and self.activity.id == arg_28_1 then
			self.activity = nil

			self:verifyTabs()
		end
	end

	return
end

function ActivityMainScene.GetOnShowEntranceData()
	var_0_1 = var_0_1 or require("GameCfg.activity.EntranceData")

	assert(var_0_1, "Missing EntranceData.lua!")

	var_0_1 = var_0_1 or {}

	return (_.select(var_0_1, function(arg_30_0)
		return arg_30_0.isShow and arg_30_0.isShow()
	end))
end

function ActivityMainScene:updateEntrances()
	local var_31_0 = ActivityMainScene.GetOnShowEntranceData()

	self.entranceList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			local var_32_0 = var_31_0[arg_32_1 + 1]
			local var_32_1 = "empty"

			removeOnButton(arg_32_2)

			local var_32_2 = false

			if var_31_0[arg_32_1 + 1] and table.getCount(var_31_0[arg_32_1 + 1]) ~= 0 and var_31_0[arg_32_1 + 1].isShow() then
				onButton(self, arg_32_2, function()
					self:emit(var_32_0.event, var_32_0.data[1], var_32_0.data[2])

					return
				end, SFX_PANEL)

				var_32_1 = var_31_0[arg_32_1 + 1].banner

				if var_31_0[arg_32_1 + 1].isTip then
					var_32_2 = var_31_0[arg_32_1 + 1].isTip()
				end
			end

			setActive(arg_32_2:Find("tip"), var_32_2)
			LoadImageSpriteAsync("activitybanner/" .. var_32_1, arg_32_2)
		end

		return
	end)
	self.entranceList:align((math.max(#var_31_0, 5)))

	return
end

function ActivityMainScene:flushTabs()
	self.tabsList:align(#self.activities)

	return
end

function ActivityMainScene:selectActivity(arg_35_1)
	if self.nextActivity == arg_35_1 or not self.nextActivity and self.activity and arg_35_1.id == self.activity.id then
		return
	end

	local var_35_0 = {}

	if self.activity and not self.nextActivity then
		self.switchCount = self.switchCount + 1

		table.insert(var_35_0, function(arg_36_0)
			self.pageDic[self.activity.id]:ActionInvoke("SwitchOut", function()
				self.switchCount = self.switchCount - 1

				arg_36_0()

				return
			end)

			return
		end)
	end

	if not self.activity or self.activity.id ~= arg_35_1.id then
		local var_35_1 = self.pageDic[arg_35_1.id]

		assert(self.pageDic[arg_35_1.id], "找不到id:" .. arg_35_1.id .. "的活动页，请检查")

		self.switchCount = self.switchCount + 1

		table.insert(var_35_0, function(arg_38_0)
			var_35_1:Load()
			var_35_1:ActionInvoke("ShowOrHide", false)
			var_35_1:CallbackInvoke(function()
				self.switchCount = self.switchCount - 1

				arg_38_0()

				return
			end)

			return
		end)
	end

	self.nextActivity = arg_35_1

	parallelAsync(var_35_0, function()
		if self.switchCount > 0 then
			return
		end

		if self.activity then
			self.pageDic[self.activity.id]:ActionInvoke("ShowOrHide", false)
		end

		self.activity = self.nextActivity
		self.contextData.id = self.nextActivity.id
		self.nextActivity = nil

		self.pageDic[self.activity.id]:ActionInvoke("ShowOrHide", true)
		self.pageDic[self.activity.id]:ActionInvoke("Flush", self.activity)
		setActive(self.permanentFinshMask, pg.activity_task_permanent[arg_35_1.id] and arg_35_1:canPermanentFinish())

		return
	end)

	return
end

function ActivityMainScene:checkAutoHideActivity()
	if self.activity and not self.activity:isShow() then
		self:removeActivity(self.activity.id)
	end

	return
end

function ActivityMainScene:verifyTabs(arg_42_1)
	triggerToggle(self.tabs:GetChild((self:getActivityIndex(arg_42_1) or 1) - 1), true)

	return
end

function ActivityMainScene:loadActivityPanel(arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2:getConfig("type")

	if nil and arg_43_1 then
		self:emit(ActivityMediator.OPEN_LAYER, nil)
	elseif nil and not arg_43_1 then
		self:emit(ActivityMediator.CLOSE_LAYER, (nil).mediator)
	else
		originalPrint("------活动id为" .. arg_43_2.id .. "类型为" .. arg_43_2:getConfig("type") .. "的页面不存在")
	end

	return
end

function ActivityMainScene:getBonusWindow(arg_44_1, arg_44_2)
	local var_44_0 = self._tf:Find(arg_44_1)

	if not var_44_0 then
		PoolMgr.GetInstance():GetUI("ActivitybonusWindow", true, function(arg_45_0)
			SetParent(arg_45_0, self._tf, false)

			arg_45_0.name = arg_44_1

			arg_44_2(arg_45_0)

			return
		end)
	else
		arg_44_2(var_44_0)
	end

	return
end

function ActivityMainScene:ShowWindow(arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.__cname

	if not self.windowList[arg_46_1.__cname] then
		self:getBonusWindow(arg_46_1.__cname, function(arg_47_0)
			self.windowList[var_46_0] = arg_46_1.New(tf(arg_47_0), self)

			self.windowList[var_46_0]:Show(arg_46_2)

			return
		end)
	else
		self.windowList[arg_46_1.__cname]:Show(arg_46_2)
	end

	return
end

function ActivityMainScene:HideWindow(arg_48_1)
	if not self.windowList[arg_48_1.__cname] then
		return
	end

	self.windowList[arg_48_1.__cname]:Hide()

	return
end

function ActivityMainScene:ShowAwardWindow(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	self.awardWindow:ExecuteAction("Flush", arg_49_1, arg_49_2, arg_49_3, arg_49_4)

	return
end

function ActivityMainScene:OnChargeSuccess(arg_50_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_50_1)

	return
end

function ActivityMainScene:willExit()
	self.switchCount = nil
	self.shareData = nil

	for iter_51_0, iter_51_1 in pairs(self.pageDic) do
		iter_51_1:Destroy()
	end

	for iter_51_2, iter_51_3 in pairs(self.windowList) do
		iter_51_3:Dispose()
	end

	if self.awardWindow then
		self.awardWindow:Destroy()

		self.awardWindow = nil
	end

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	return
end

return ActivityMainScene
