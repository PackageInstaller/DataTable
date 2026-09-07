local LinerLogSchedulePage = class("LinerLogSchedulePage", import("view.base.BaseSubView"))

LinerLogSchedulePage.SHOW_TIME_LIST = {
	{
		3,
		8
	},
	{
		8,
		12
	},
	{
		12,
		14
	},
	{
		14,
		18
	},
	{
		18,
		20
	},
	{
		20,
		25
	},
	{
		25,
		27
	}
}

function LinerLogSchedulePage:getUIName()
	return "LinerLogSchedulePage"
end

function LinerLogSchedulePage:OnLoaded()
	self.togglesTF = self._tf:Find("toggles")
	self.contentTF = self._tf:Find("content")
	self.anim = self.contentTF:GetComponent(typeof(Animation))
	self.awardTF = self._tf:Find("award/mask/IconTpl")
	self.awardDesc = self._tf:Find("award/Text")
	self.goBtn = self._tf:Find("award/go")
	self.getBtn = self._tf:Find("award/get")
	self.gotTF = self._tf:Find("award/got")

	return
end

function LinerLogSchedulePage:OnInit()
	self:UpdateActivity()
	onButton(self, self.getBtn, function()
		self:emit(LinerLogBookMediator.GET_SCHEDULE_AWARD, self.activity.id, self.curIdx, self.groups[self.curIdx]:GetDrop())

		return
	end, SFX_CONFIRM)
	onButton(self, self.goBtn, function()
		self:emit(LinerLogBookMediator.ON_CLOSE)

		return
	end, SFX_CONFIRM)

	self.groupIds = self.activity:getConfig("config_data")[1]
	self.groups = {}

	for iter_3_0, iter_3_1 in ipairs(self.groupIds) do
		self.groups[iter_3_0] = LinerTimeGroup.New(iter_3_1)
	end

	self.itemUIList = UIItemList.New(self.contentTF, self.contentTF:Find("tpl"))

	self.itemUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_6_1, arg_6_2)
		end

		return
	end)

	self.toggleUIList = UIItemList.New(self.togglesTF, self.togglesTF:Find("tpl"))

	self.toggleUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventInit then
			local var_7_0 = arg_7_1 + 1

			arg_7_2.name = arg_7_1 + 1

			local var_7_1 = "DAY " .. string.format("%02d", arg_7_1 + 1)

			setText(arg_7_2:Find("Text"), var_7_1)
			setText(arg_7_2:Find("selected/Text"), var_7_1)
			onToggle(self, arg_7_2, function(arg_8_0)
				if arg_8_0 then
					if self.curIdx and self.curIdx == var_7_0 then
						return
					end

					self.curIdx = var_7_0

					self:FlushPage(true)
				end

				return
			end, SFX_CONFIRM)
		elseif arg_7_0 == UIItemList.EventUpdate then
			local var_7_2 = tonumber(arg_7_2.name) > self.curDay

			setActive(arg_7_2:Find("lock"), var_7_2)
			SetCompomentEnabled(arg_7_2, typeof(Toggle), not var_7_2)

			if var_7_2 then
				setActive(arg_7_2:Find("selected"), false)
				setActive(arg_7_2:Find("tip"), false)
			else
				setActive(arg_7_2:Find("tip"), LinerLogSchedulePage.IsTipWithGroupId(self.activity, self.groups[arg_7_1 + 1].id))
			end
		end

		return
	end)
	self.toggleUIList:align(#self.groupIds)
	triggerToggle(self._tf:Find(tostring(self.curDay), self.toggleUIList.container), true)

	return
end

function LinerLogSchedulePage:UpdateActivity(arg_9_1)
	self.activity = arg_9_1 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(self.activity and not self.activity:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	self.finishTimeIds = self.activity:GetFinishTimeIds()
	self.timeId2ExploredIds = self.activity:GetTimeId2ExploredIds()
	self.curDay = self.activity:GetDayByIdx(self.activity:GetCurIdx())

	return
end

function LinerLogSchedulePage:_getLogDesc(arg_10_1)
	local var_10_0 = arg_10_1[1]
	local var_10_1 = arg_10_1[2] - 1

	if arg_10_1[1] >= 24 then
		var_10_0 = var_10_0 - 24
	end

	if var_10_1 >= 24 then
		var_10_1 = var_10_1 - 24
	end

	local var_10_2

	if var_10_0 > 12 then
		var_10_2 = var_10_0 - 12 or var_10_0

		if var_10_1 > 12 and not (var_10_1 - 12) then
			-- block empty
		end
	end

	return string.format("%d:00 %s~%d:59 %s", var_10_2, var_10_0 < 12 and "AM" or "PM", var_10_1, var_10_1 < 12 and "AM" or "PM")
end

function LinerLogSchedulePage:_getReallyTime(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.times) do
		local var_11_0 = iter_11_1:GetTime()[1]
		local var_11_1 = iter_11_1:GetTime()[2]

		if var_11_0 < 3 then
			var_11_0 = var_11_0 + 24
		end

		if var_11_1 <= 3 then
			var_11_1 = var_11_1 + 24
		end

		if var_11_0 <= arg_11_1[1] and var_11_1 >= arg_11_1[2] then
			return iter_11_1
		end
	end

	return
end

function LinerLogSchedulePage:UpdateItem(arg_12_1, arg_12_2)
	setText(arg_12_2:Find("time/Text"), self:_getLogDesc(LinerLogSchedulePage.SHOW_TIME_LIST[arg_12_1 + 1]))

	local var_12_0 = self:_getReallyTime(LinerLogSchedulePage.SHOW_TIME_LIST[arg_12_1 + 1])
	local var_12_1 = table.contains(self.finishTimeIds, var_12_0.id)
	local var_12_2 = arg_12_2:Find("desc")
	local var_12_3 = var_12_1 and var_12_0:GetAfterDesc(arg_12_1 + 1) or var_12_0:GetBeforDesc(arg_12_1 + 1)

	if var_12_1 and var_12_0:GetType() == LinerTime.TYPE.EXPLORE then
		var_12_3 = string.gsub(var_12_3, "$1", table.concat(underscore.map(self.timeId2ExploredIds[var_12_0.id], function(arg_13_0)
			return pg.activity_liner_room[arg_13_0].name
		end), "、"))
	end

	setText(var_12_2, var_12_3)
	setActive(arg_12_2:Find("time/finish"), var_12_1)
	setActive(var_12_2, self.curIdx <= self.curDay)

	return
end

function LinerLogSchedulePage:FlushPage()
	self.anim:Play()
	self.toggleUIList:align(#self.groupIds)

	self.times = self.groups[self.curIdx]:GetTimeList()

	table.sort(self.times, CompareFuncs({
		function(arg_15_0)
			return arg_15_0.id
		end
	}))
	self.itemUIList:align(#LinerLogSchedulePage.SHOW_TIME_LIST)

	local var_14_0 = self.groups[self.curIdx]:GetDrop()

	updateDrop(self.awardTF, var_14_0)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_14_0)

		return
	end, SFX_PANEL)

	local var_14_1 = self.activity:IsGotTimeAward(self.curIdx)
	local var_14_2 = LinerLogSchedulePage.IsTipWithGroupId(self.activity, self.groups[self.curIdx].id)

	setActive(self.goBtn, not var_14_1 and not var_14_2)
	setActive(self.gotTF, var_14_1)
	setActive(self.awardTF:Find("mask"), var_14_1)
	setText(self.awardDesc, var_14_1 and i18n("liner_schedule_award_tip2", self.curIdx) or i18n("liner_schedule_award_tip1"))
	setActive(self.getBtn, var_14_2)
	self:Show()

	return
end

function LinerLogSchedulePage:OnDestroy()
	return
end

function LinerLogSchedulePage:IsTipWithGroupId(arg_18_1)
	if self:IsGotTimeAward((table.indexof(self:GetTimeGroupIds(), arg_18_1))) then
		return false
	end

	local var_18_0 = self:GetFinishTimeIds()

	return underscore.all(pg.activity_liner_time_group[arg_18_1].ids, function(arg_19_0)
		return table.contains(var_18_0, arg_19_0)
	end)
end

function LinerLogSchedulePage.IsTip()
	local var_20_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_20_0 and not var_20_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return underscore.any(var_20_0:GetTimeGroupIds(), function(arg_21_0)
		return LinerLogSchedulePage.IsTipWithGroupId(var_20_0, arg_21_0)
	end)
end

return LinerLogSchedulePage
