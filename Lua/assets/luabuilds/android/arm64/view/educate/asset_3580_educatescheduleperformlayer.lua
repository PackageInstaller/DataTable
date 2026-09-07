local EducateSchedulePerformLayer = class("EducateSchedulePerformLayer", import(".base.EducateBaseUI"))
local var_0_1 = {
	"FFFFFF",
	"79D3FE",
	"818183"
}
local var_0_2 = {
	"39BFFF",
	"39BFFF",
	"2D2E2F"
}

function EducateSchedulePerformLayer:getUIName()
	return "EducateSchedulePerformUI"
end

function EducateSchedulePerformLayer:init()
	self:initData()
	self:findUI()

	return
end

function EducateSchedulePerformLayer:initData()
	self.planCnt = getProxy(EducateProxy):GetCharData():GetNextWeekPlanCnt()
	self.curDay = 1
	self.curIndex = 1
	self.events = self.contextData.events
	self.drops = {}
	self.isSkip = self.contextData.skip
	self.isSkipEvent = self.contextData.skipEvent

	underscore.each(self.contextData.plan_results, function(arg_4_0)
		self.drops[arg_4_0.day] = self.drops[arg_4_0.day] or {}
		self.drops[arg_4_0.day][arg_4_0.index] = {
			plan_drops = arg_4_0.plan_drops,
			event_drops = arg_4_0.event_drops,
			spec_event_drops = arg_4_0.spec_event_drops
		}

		return
	end)

	self.showGrids = self.contextData.gridData
	self.showEventIds = {}

	underscore.each(self.events, function(arg_5_0)
		self.showEventIds[arg_5_0.day] = self.showEventIds[arg_5_0.day] or {}
		self.showEventIds[arg_5_0.day][arg_5_0.index] = arg_5_0.value[1].event_id

		return
	end)

	return
end

function EducateSchedulePerformLayer:findUI()
	self.windowsTF = self._tf:Find("anim_root/window")
	self.leftTF = self.windowsTF:Find("left")

	setText(self.leftTF:Find("title/Text"), i18n("child_plan_perform_title"))

	self.dayUIList = UIItemList.New(self.leftTF:Find("content"), self.leftTF:Find("content/day_tpl"))
	self.rightTF = self.windowsTF:Find("right")
	self.planNameTF = self.rightTF:Find("name")

	return
end

function EducateSchedulePerformLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	pg.PerformMgr.GetInstance():SetParamForUI(self.__cname)
	self:initDayList()
	self:playWeek(function()
		self:emit(EducateSchedulePerformLayer.ON_CLOSE)

		return
	end)

	return
end

function EducateSchedulePerformLayer:initDayList()
	self.dayUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventInit then
			arg_10_2.name = arg_10_1 + 1

			setText(arg_10_2:Find("Text"), EducateHelper.GetWeekStrByNumber(arg_10_1 + 1))

			for iter_10_0 = 1, 3 do
				setActive(arg_10_2:Find("phase" .. iter_10_0), iter_10_0 == self.planCnt)
			end
		elseif arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_10_1 + 1

			setActive(arg_10_2:Find("selected"), self.curDay == arg_10_1 + 1)

			local var_10_1 = "FFFFFF"
			local var_10_2 = "FFFFFF"

			if var_10_0 < self.curDay then
				var_10_1 = var_0_1[1]
				var_10_2 = var_0_2[1]
			elseif self.curDay == var_10_0 then
				var_10_1 = var_0_1[2]
				var_10_2 = var_0_2[3]
			else
				var_10_1 = var_0_1[3]
				var_10_2 = var_0_2[3]
			end

			setTextColor(arg_10_2:Find("Text"), Color.NewHex(var_10_1))

			local var_10_3 = arg_10_2:Find("phase" .. self.planCnt)

			for iter_10_1 = 1, var_10_3.childCount do
				setImageColor(var_10_3:GetChild(iter_10_1 - 1), Color.NewHex((self.curDay == var_10_0 and iter_10_1 <= self.curIndex or nil) and var_0_2[2]))
			end
		end

		return
	end)
	self:updateLeft()

	return
end

function EducateSchedulePerformLayer:updateLeft()
	self.dayUIList:align(6)

	return
end

function EducateSchedulePerformLayer:playWeek(arg_12_1)
	self.curDay = 1
	self.curIndex = 1

	self:emit(EducateSchedulePerformMediator.WEEKDAY_UPDATE, self.curDay)

	local var_12_0 = {}

	for iter_12_0 = 1, 6 do
		for iter_12_1 = 1, 3 do
			local var_12_1 = self.drops[iter_12_0][iter_12_1] or {}
			local var_12_2 = self.showEventIds[iter_12_0]

			if self.showEventIds[iter_12_0] then
				var_12_2 = self.showEventIds[iter_12_0][iter_12_1]

				if self.showEventIds[iter_12_0][iter_12_1] then
					var_12_2 = self.showEventIds[iter_12_0][iter_12_1] ~= 0
				end
			end

			if self.showGrids[iter_12_0] and self.showGrids[iter_12_0][iter_12_1] then
				local var_12_3 = self.showGrids[iter_12_0][iter_12_1]

				table.insert(var_12_0, function(arg_13_0)
					self.curDay = iter_12_0
					self.curIndex = iter_12_1

					self:emit(EducateSchedulePerformMediator.WEEKDAY_UPDATE, self.curDay)
					self:updateLeft()
					setText(self.planNameTF, var_12_3:GetName())

					local var_13_0

					if var_12_3:IsPlan() then
						var_13_0 = var_12_1.plan_drops or var_12_1.spec_event_drops
					end

					if self.isSkip then
						if (not var_12_3:IsPlan() or var_12_2) and not self.isSkipEvent then
							pg.PerformMgr.GetInstance():PlayGroupNoHide(var_12_3:GetPerformance(), arg_13_0, var_13_0 or {})
						else
							arg_13_0()
						end
					elseif not var_12_3:IsPlan() and self.isSkipEvent then
						arg_13_0()
					else
						pg.PerformMgr.GetInstance():PlayGroupNoHide(var_12_3:GetPerformance(), arg_13_0, var_13_0 or {})
					end

					return
				end)
			end

			if var_12_2 and not self.isSkipEvent then
				local var_12_4 = self.showEventIds[iter_12_0][iter_12_1]

				table.insert(var_12_0, function(arg_14_0)
					pg.PerformMgr.GetInstance():PlayGroupNoHide(pg.child_event[var_12_4].performance, arg_14_0, var_12_1.event_drops or {})

					return
				end)
			end
		end
	end

	pg.PerformMgr.GetInstance():Show()
	seriesAsync(var_12_0, function()
		pg.PerformMgr.GetInstance():Hide()
		onNextTick(function()
			if arg_12_1 then
				arg_12_1()
			end

			return
		end)

		return
	end)

	return
end

function EducateSchedulePerformLayer:onBackPressed()
	return
end

function EducateSchedulePerformLayer:willExit()
	self:UnOverlayPanel(self._tf)
	pg.PerformMgr.GetInstance():SetParamForUI("Default")

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateSchedulePerformLayer
