local CoreActivityMainScene = class("CoreActivityMainScene", import("view.activity.ActivityMainScene"))

function CoreActivityMainScene:getUIName()
	return nil
end

CoreActivityMainScene.optionsPath = {
	"adapt/top/btn_home"
}

function CoreActivityMainScene:PlayBGM()
	return
end

function CoreActivityMainScene:init()
	self.btnBack = self._tf:Find("adapt/top/btn_back")
	self.btnSkin = self._tf:Find("adapt/btn_skin")
	self.pageContainer = self._tf:Find("page_list")
	self.tabs = self._tf:Find("adapt/tabs")
	self.windowList = {}
	self.awardWindow = AwardWindow.New(self._tf, self.event)
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)
	self.tabsList = UIItemList.New(self.tabs, self.tabs:GetChild(0))

	self.tabsList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = underscore.detect(self.activities, function(arg_5_0)
				return tostring(arg_5_0:getConfig("is_show")) == arg_4_2.name
			end)

			if not var_4_0 or var_4_0:isEnd() then
				setActive(arg_4_2, false)
			elseif not self.pageDic[var_4_0.id] then
				warning(string.format("without page in act:", var_4_0.id))
			else
				local var_4_1 = arg_4_2:Find("tip")
				local var_4_2 = self.pageDic[var_4_0.id]:IsShowReminder()

				if var_4_2 == nil then
					setActive(var_4_1, var_4_0:readyToAchieve())
				else
					setActive(var_4_1, var_4_2)
				end

				onToggle(self, arg_4_2, function(arg_6_0)
					if arg_6_0 then
						self:selectActivity(var_4_0)
					end

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	self.switchCount = 0

	return
end

function CoreActivityMainScene:didEnter()
	self:bind(CoreActivityMainScene.UPDATE_ACTIVITY, function(arg_8_0, arg_8_1)
		self:updateActivity(arg_8_1)

		return
	end)
	self:bind(CoreActivityMainScene.GET_PAGE_BGM, function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_2.bgm = self:getBGM(arg_9_1) or self:getBGM()

		return
	end)
	self:bind(CoreActivityMainScene.FLUSH_TABS, function()
		self:flushTabs()

		return
	end)
	onButton(self, self.btnBack, function()
		self:emit(CoreActivityMainScene.ON_BACK)

		return
	end, SOUND_BACK)

	if self.btnSkin then
		onButton(self, self.btnSkin, function()
			self:emit(ActivityMediator.GO_CHANGE_SHOP)

			return
		end, SFX_PANEL)
	end

	self:emit(ActivityMediator.SHOW_NEXT_ACTIVITY, self.contextData.coreName)

	return
end

function CoreActivityMainScene:setActivities(arg_13_1)
	self.activities = underscore.filter(arg_13_1 or {}, function(arg_14_0)
		return not arg_14_0:isEnd()
	end)
	self.shareData = self.shareData or ActivityShareData.New()
	self.pageDic = self.pageDic or {}

	for iter_13_0, iter_13_1 in ipairs(self.activities) do
		self:instanceActivityPage(iter_13_1)
	end

	table.sort(self.activities, CompareFuncs({
		function(arg_15_0)
			return arg_15_0:getShowPriority()
		end,
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))
	self:flushTabs()

	return
end

function CoreActivityMainScene:updateActivity(arg_17_1)
	if ActivityConst.PageIdLink[arg_17_1.id] then
		arg_17_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_17_1.id])
	end

	if arg_17_1:isShow() and arg_17_1:isCorePage(self.contextData.coreName) and not arg_17_1:isEnd() then
		self.activities[self:getActivityIndex(arg_17_1.id) or #self.activities + 1] = arg_17_1

		table.sort(self.activities, CompareFuncs({
			function(arg_18_0)
				return -arg_18_0:getShowPriority()
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if not self.pageDic[arg_17_1.id] then
			self:instanceActivityPage(arg_17_1)
		end

		self:flushTabs()

		if self.activity and self.activity.id == arg_17_1.id then
			self.activity = arg_17_1

			self.pageDic[arg_17_1.id]:ActionInvoke("Flush", arg_17_1)
			self:verifyTabs(self.activity.id)
		end
	end

	return
end

function CoreActivityMainScene:instanceActivityPage(arg_20_1)
	CoreActivityMainScene.super.instanceActivityPage(self, arg_20_1)

	for iter_20_0, iter_20_1 in pairs(self.pageDic) do
		iter_20_1:SetCoreActivityUI(self)
	end

	return
end

function CoreActivityMainScene:updateEntrances()
	return
end

function CoreActivityMainScene:flushTabs()
	self.tabsList:align(self.tabs.childCount)

	return
end

function CoreActivityMainScene:IsImageTgName()
	return false
end

function CoreActivityMainScene:OnToggleName(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2:getConfig("title_res_tag")
	local var_24_1 = "coreactivityuitable/" .. var_24_0 .. "_text"
	local var_24_2 = "coreactivityuitable/" .. var_24_0 .. "_text_selected"

	setText(arg_24_1:Find("on/name"), i18n(var_24_0))
	setText(arg_24_1:Find("off/name"), i18n(var_24_0))

	local var_24_3 = self:IsImageTgName()
	local var_24_4 = checkABExist(var_24_1)
	local var_24_5 = checkABExist(var_24_2)

	setActive(arg_24_1:Find("off/imgName"), var_24_3 and var_24_4)
	setActive(arg_24_1:Find("off/name"), not var_24_3 or not var_24_4)
	setActive(arg_24_1:Find("on/imgName"), var_24_3 and var_24_5)
	setActive(arg_24_1:Find("on/name"), not var_24_3 or not var_24_5)

	if self:IsImageTgName() then
		local var_24_6 = string.lower(var_24_0)

		if var_24_4 then
			setImageSprite(arg_24_1:Find("off/imgName"), GetSpriteFromAtlas(var_24_1, ""), true)
		end

		if var_24_5 then
			setImageSprite(arg_24_1:Find("on/imgName"), GetSpriteFromAtlas(var_24_2, ""), true)
		end
	end

	return
end

function CoreActivityMainScene:selectActivity(arg_25_1)
	if self.nextActivity == arg_25_1 or not self.nextActivity and self.activity and arg_25_1.id == self.activity.id then
		return
	end

	local var_25_0 = {}

	if self.activity and not self.nextActivity then
		self.switchCount = self.switchCount + 1

		table.insert(var_25_0, function(arg_26_0)
			self.pageDic[self.activity.id]:ActionInvoke("SwitchOut", function()
				self.switchCount = self.switchCount - 1

				arg_26_0()

				return
			end)

			return
		end)
	end

	if not self.activity or self.activity.id ~= arg_25_1.id then
		local var_25_1 = self.pageDic[arg_25_1.id]

		assert(self.pageDic[arg_25_1.id], "找不到id:" .. arg_25_1.id .. "的活动页，请检查")

		self.switchCount = self.switchCount + 1

		table.insert(var_25_0, function(arg_28_0)
			var_25_1:Load()
			var_25_1:ActionInvoke("ShowOrHide", false)
			var_25_1:CallbackInvoke(function()
				self.switchCount = self.switchCount - 1

				arg_28_0()

				return
			end)

			return
		end)
	end

	self.nextActivity = arg_25_1

	parallelAsync(var_25_0, function()
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

		return
	end)

	return
end

function CoreActivityMainScene:verifyTabs(arg_31_1)
	if self.activities[self:getActivityIndex(arg_31_1) or self:getActivityIndex(self:GetActiveActivity()) or 1] == nil then
		return
	end

	local var_31_0 = self.tabs:Find(tostring((self.activities[self:getActivityIndex(arg_31_1) or self:getActivityIndex(self:GetActiveActivity()) or 1]:getConfig("is_show"))))

	if var_31_0 then
		triggerToggle(var_31_0, true)
	end

	return
end

function CoreActivityMainScene:GetActiveActivity()
	for iter_32_0, iter_32_1 in ipairs(self.activities) do
		if not iter_32_1:isEnd() then
			return iter_32_1.id
		end
	end

	return
end

function CoreActivityMainScene:GetActivityIdByPageClass(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(self.activities or {}) do
		local var_33_1 = iter_33_1:getConfig("page_info")

		if var_33_1 and var_33_1.class_name == arg_33_1 then
			return iter_33_1.id
		end
	end

	return nil
end

function CoreActivityMainScene:onBackPressed()
	if self.pageDic[self.activity.id]:IsShowingPopWindow() then
		self.pageDic[self.activity.id]:ClosePopWindow()

		return
	end

	CoreActivityMainScene.super.onBackPressed(self)

	return
end

function CoreActivityMainScene:getActClass(arg_35_1)
	return _G[arg_35_1]
end

return CoreActivityMainScene
