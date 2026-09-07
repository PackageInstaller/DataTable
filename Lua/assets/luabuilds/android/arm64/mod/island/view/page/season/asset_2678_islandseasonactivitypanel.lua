local IslandSeasonActivityPanel = class("IslandSeasonActivityPanel", import("view.base.BaseSubView"))

function IslandSeasonActivityPanel:getUIName()
	return "IslandSeasonActivityPanel"
end

function IslandSeasonActivityPanel:OnLoaded()
	return
end

function IslandSeasonActivityPanel:OnInit()
	self.tabsList = UIItemList.New(self.rtTabsContent, self.rtTabsTpl)

	self.tabsList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = self.activities[arg_4_1]
			local var_4_1

			if self.activities[arg_4_1] then
				var_4_1 = var_4_0.id or 0
			end

			arg_4_2.name = var_4_1

			local function var_4_2(arg_5_0)
				setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipActivity(arg_5_0))

				return
			end

			if var_4_0 then
				local var_4_3 = var_4_0:getIslandConfig("title_res_tag")

				setText(arg_4_2:Find("on/Text"), var_4_3)
				setText(arg_4_2:Find("off/Text"), var_4_3)
				var_4_2(var_4_0)
			else
				setText(arg_4_2:Find("on/Text"), i18n("island_no_activity"))
				setText(arg_4_2:Find("on/Text/en"), i18n("island_activity_decorative_word"))
				setText(arg_4_2:Find("off/Text"), i18n("island_no_activity"))
			end

			local var_4_4 = self.pageDic[var_4_1]

			onToggle(self, arg_4_2, function(arg_6_0)
				if var_4_4 and arg_6_0 then
					self:selectActivity(var_4_0)
					var_4_2(var_4_0)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.switchCount = 0

	return
end

function IslandSeasonActivityPanel:Show()
	IslandSeasonActivityPanel.super.Show(self)
	self:Flush()
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_14")

	return
end

function IslandSeasonActivityPanel:Flush()
	if not self:isShowing() then
		return
	end

	if not self.activities then
		self:setActivities(getProxy(ActivityProxy):getIslandPanelActivities())
	end

	if self.activity then
		self.pageDic[self.activity.id]:ExecuteAction("ShowOrHide", true)
	else
		self:verifyTabs()
	end

	return
end

function IslandSeasonActivityPanel:verifyTabs(arg_9_1)
	if #self.activities > 0 then
		triggerToggle(self.rtTabsContent:GetChild((self:getActivityIndex(arg_9_1) or 1) - 1), true)
	end

	return
end

function IslandSeasonActivityPanel:getActivityIndex(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.activities) do
		if iter_10_1.id == arg_10_1 then
			return iter_10_0
		end
	end

	return nil
end

function IslandSeasonActivityPanel:setActivities(arg_11_1)
	self.activities = arg_11_1 or {}
	self.shareData = self.shareData or ActivityShareData.New()
	self.pageDic = self.pageDic or {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		self:instanceActivityPage(iter_11_1)
	end

	self.activity = nil

	table.sort(self.activities, CompareFuncs({
		function(arg_12_0)
			return -arg_12_0:getIslandConfig("is_show")
		end,
		function(arg_13_0)
			return -arg_13_0.id
		end
	}))
	self:flushTabs()

	return
end

function IslandSeasonActivityPanel:OnTaskUpdate(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self.activities) do
		if iter_14_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_TASK_LIST and _.any(_.flatten(iter_14_1:getIslandConfig("config_data")), function(arg_15_0)
			return arg_15_0 == arg_14_1
		end) then
			self:updateActivity(iter_14_1)
		end
	end

	return
end

function IslandSeasonActivityPanel:updateActivity(arg_16_1)
	if ActivityConst.IslandPageIdLinks[arg_16_1.id] then
		for iter_16_0, iter_16_1 in ipairs(ActivityConst.IslandPageIdLinks[arg_16_1.id]) do
			self:_updateActivity(getProxy(ActivityProxy):getActivityById(iter_16_1))
		end
	else
		self:_updateActivity(arg_16_1)
	end

	return
end

function IslandSeasonActivityPanel:_updateActivity(arg_17_1)
	if arg_17_1:isIslandShow() and not arg_17_1:isEnd() then
		self.activities[self:getActivityIndex(arg_17_1.id) or #self.activities + 1] = arg_17_1

		table.sort(self.activities, CompareFuncs({
			function(arg_18_0)
				return -arg_18_0:getIslandConfig("is_show")
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if not self.pageDic[arg_17_1.id] then
			self:instanceActivityPage(arg_17_1)
		end

		self:flushTabs()

		if self:isShowing() and self.activity and self.activity.id == arg_17_1.id then
			self.activity = arg_17_1

			self.pageDic[arg_17_1.id]:ActionInvoke("Flush", arg_17_1)
		end
	end

	return
end

function IslandSeasonActivityPanel:removeActivity(arg_20_1)
	local var_20_0 = self:getActivityIndex(arg_20_1)

	if var_20_0 then
		table.remove(self.activities, var_20_0)
		self.pageDic[arg_20_1]:Destroy()

		self.pageDic[arg_20_1] = nil

		self:flushTabs()

		if self.activity and self.activity.id == arg_20_1 then
			self.activity = nil

			self:verifyTabs()
		end
	end

	return
end

function IslandSeasonActivityPanel:getActClass(arg_21_1)
	return import("Mod.Island.View.page.activity." .. arg_21_1)
end

function IslandSeasonActivityPanel:instanceActivityPage(arg_22_1)
	local var_22_0 = arg_22_1:getIslandConfig("page_info")

	if var_22_0.class_name and not self.pageDic[arg_22_1.id] and not arg_22_1:isEnd() then
		local var_22_1 = self:getActClass(var_22_0.class_name).New(self.rtPages, self.event, self.contextData)

		if var_22_1:UseSecondPage(arg_22_1) then
			var_22_1:SetUIName(var_22_0.ui_name2)
		else
			var_22_1:SetUIName(var_22_0.ui_name)
		end

		var_22_1:SetShareData(self.shareData)

		self.pageDic[arg_22_1.id] = var_22_1
	end

	return
end

function IslandSeasonActivityPanel:flushTabs()
	setActive(self.rtPagesEmpty, #self.activities == 0)
	self.tabsList:align(math.max(#self.activities, 1))

	return
end

function IslandSeasonActivityPanel:selectActivity(arg_24_1)
	if self.nextActivity == arg_24_1 or not self.nextActivity and self.activity and arg_24_1.id == self.activity.id then
		return
	end

	IslandSeasonRedDotHelper.UpdateActEnterTip(arg_24_1)
	self:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_ACTIVITY)

	local var_24_0 = {}

	if self.activity and not self.nextActivity then
		self.switchCount = self.switchCount + 1

		table.insert(var_24_0, function(arg_25_0)
			self.pageDic[self.activity.id]:ActionInvoke("SwitchOut", function()
				self.switchCount = self.switchCount - 1

				arg_25_0()

				return
			end)

			return
		end)
	end

	if not self.activity or self.activity.id ~= arg_24_1.id then
		local var_24_1 = self.pageDic[arg_24_1.id]

		assert(self.pageDic[arg_24_1.id], "找不到id:" .. arg_24_1.id .. "的活动页，请检查")

		self.switchCount = self.switchCount + 1

		table.insert(var_24_0, function(arg_27_0)
			var_24_1:Load()
			var_24_1:ActionInvoke("ShowOrHide", false)
			var_24_1:CallbackInvoke(function()
				self.switchCount = self.switchCount - 1

				arg_27_0()

				return
			end)

			return
		end)
	end

	self.nextActivity = arg_24_1

	parallelAsync(var_24_0, function()
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

function IslandSeasonActivityPanel:OnDestroy()
	self.shareData = nil

	for iter_30_0, iter_30_1 in pairs(self.pageDic) do
		iter_30_1:Destroy()
	end

	self.pageDic = nil
	self.activities = nil
	self.switchCount = nil

	return
end

function IslandSeasonActivityPanel:OnHide()
	self:UnOverlayPanel(self._tf, self._parentTf)

	for iter_31_0, iter_31_1 in pairs(self.pageDic) do
		if iter_31_1 and iter_31_1:isShowing() then
			iter_31_1:Hide()
		end
	end

	return
end

return IslandSeasonActivityPanel
