local MainEducateSpinePainting = class("MainEducateSpinePainting", import(".MainSpinePainting"))
local var_0_1

function MainEducateSpinePainting:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainEducateSpinePainting.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	var_0_1 = pg.AssistantInfo

	return
end

function MainEducateSpinePainting:OnLoad(arg_2_1)
	seriesAsync({
		function(arg_3_0)
			MainEducateSpinePainting.super.OnLoad(self, arg_3_0)

			return
		end
	}, function()
		self:InitTellTimeService()
		arg_2_1()

		return
	end)

	return
end

function MainEducateSpinePainting:OnFirstTimeTriggerEvent()
	local var_5_0, var_5_1, var_5_2 = ChineseCalendar.GetCurrYearMonthDay((pg.TimeMgr.GetInstance():GetServerTime()))

	local function var_5_3(arg_6_0)
		self:DisplayWord(arg_6_0)
		getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

		return
	end

	local function var_5_4()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end

	if ChineseCalendar.IsNewYear(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_NEWYEAR)
	elseif ChineseCalendar.IsLunarNewYear(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_LUNARNEWYEAR)
	elseif ChineseCalendar.IsValentineDay(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_VALENTINE)
	elseif ChineseCalendar.IsMidAutumnFestival(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_MIDAUTUMNFESTIVAL)
	elseif ChineseCalendar.AllHallowsDay(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_ALLHALLOWSDAY)
	elseif ChineseCalendar.IsChristmas(var_5_0, var_5_1, var_5_2) and not var_5_4() then
		var_5_3(EducateCharWordHelper.WORD_KEY_CHRISTMAS)
	elseif not getProxy(PlayerProxy):getFlag("tb_activity") and self:ExistImportantActivity() then
		getProxy(PlayerProxy):setFlag("tb_activity", true)
		self:DisplayWord(EducateCharWordHelper.WORD_KEY_ACT)
	elseif getProxy(PlayerProxy):getFlag("change_tb") then
		getProxy(PlayerProxy):setFlag("change_tb", nil)
		self:DisplayWord(EducateCharWordHelper.WORD_KEY_CHANGE_TB)
	else
		MainEducateSpinePainting.super.OnFirstTimeTriggerEvent(self)
	end

	return
end

function MainEducateSpinePainting:ExistImportantActivity()
	local var_8_0 = getProxy(ActivityProxy)

	return _.any(pg.gameset.secretary_special_ship_event_type.description, function(arg_9_0)
		local var_9_0 = var_8_0:getActivityByType(arg_9_0)

		return var_9_0 and not var_9_0:isEnd()
	end)
end

function MainEducateSpinePainting:InitTellTimeService()
	self:RemoveTellTimeTimer()

	local var_10_0 = GetNextHour(1)
	local var_10_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_10_0 - var_10_1 >= 0 then
		self:TriggerTellTime(var_10_1)
	else
		self:AddTellTimeTimer(var_10_0, var_10_0 - var_10_1)
	end

	return
end

function MainEducateSpinePainting:AddTellTimeTimer(arg_11_1, arg_11_2)
	self.tellTimeTimer = Timer.New(function()
		if self.chatting then
			self.waitForCharEnd = arg_11_1

			return
		end

		self:DisplayTellTimeWord(arg_11_1)
		self:RemoveTellTimeTimer()

		return
	end, arg_11_2, 1)

	self.tellTimeTimer:Start()

	return
end

function MainEducateSpinePainting:RemoveTellTimeTimer()
	if self.tellTimeTimer then
		self.tellTimeTimer:Stop()

		self.tellTimeTimer = nil
	end

	return
end

function MainEducateSpinePainting:DisplayTellTimeWord(arg_14_1)
	self:DisplayWord(EducateCharWordHelper.WORD_KEY_TELL_TIME .. tonumber(string.split(pg.TimeMgr.GetInstance():STimeDescC(arg_14_1, "%Y:%m:%d:%H:%M:%S"), ":")[4]))

	return
end

function MainEducateSpinePainting:TriggerPersonalTask()
	if self.isFoldState then
		return
	end

	self:TriggerInterActionTask()

	return
end

function MainEducateSpinePainting:OnLongPress()
	return
end

function MainEducateSpinePainting:OnDisplayWorld(arg_17_1)
	if expressionAnimName ~= "" then
		self.spinePainting:SetAction(EducateCharWordHelper.GetExpression(self.ship.educateCharId, arg_17_1), 1)
		self.spinePainting:displayWord(true)
	end

	return
end

function MainEducateSpinePainting:OnDisplayWordEnd()
	self:RemoveDelayTellTimeTimer()

	if self.waitForCharEnd then
		self.delayTellTimeTimer = Timer.New(function()
			self:DisplayTellTimeWord(self.waitForCharEnd)
			self:RemoveDelayTellTimeTimer()
			MainEducateSpinePainting.super.OnDisplayWordEnd(self)

			return
		end, math.random(1, 3), 1)

		self.delayTellTimeTimer:Start()

		self.waitForCharEnd = nil
	else
		MainEducateSpinePainting.super.OnDisplayWordEnd(self)
	end

	return
end

function MainEducateSpinePainting:RemoveDelayTellTimeTimer()
	if self.delayTellTimeTimer then
		self.delayTellTimeTimer:Stop()

		self.delayTellTimeTimer = nil
	end

	return
end

function MainEducateSpinePainting:GetWordAndCv(arg_21_1, arg_21_2)
	local var_21_0, var_21_1, var_21_2 = EducateCharWordHelper.GetWordAndCV(arg_21_1.educateCharId, arg_21_2)

	return var_21_0, var_21_1, var_21_2
end

function MainEducateSpinePainting:PlayCV(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = EducateCharWordHelper.RawGetCVKey(self.ship.educateCharId)

	if not var_22_0 or var_22_0 == "" then
		arg_22_4()

		return
	end

	self.cvLoader:Load(var_22_0, arg_22_3, 0, arg_22_4)

	return
end

function MainEducateSpinePainting:CollectIdleEvents(arg_23_1)
	local var_23_0 = {}

	if getProxy(EventProxy):hasFinishState() and arg_23_1 ~= "event_complete" then
		table.insert(var_23_0, "event_complete")
	else
		if getProxy(TaskProxy):getCanReceiveCount() > 0 and arg_23_1 ~= "mission_complete" then
			table.insert(var_23_0, "mission_complete")
		end

		if getProxy(MailProxy):GetUnreadCount() > 0 and arg_23_1 ~= "mail" then
			table.insert(var_23_0, "mail")
		end

		if #var_23_0 == 0 then
			var_23_0 = self:FilterExistEvents(var_0_1.GetShipMainEvents(self.ship:getSkinId(), self.ship:getCVIntimacy()))

			if getProxy(TaskProxy):getNotFinishCount() then
				if getProxy(TaskProxy):getNotFinishCount() > 0 and arg_23_1 ~= "mission" then
					table.insert(var_23_0, "mission")
				end
			end
		end
	end

	return var_23_0
end

function MainEducateSpinePainting:FilterExistEvents(arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		local var_24_1 = pg.AssistantInfo.GetAssistantEvents(iter_24_1)

		if var_24_1 and var_24_1.dialog and EducateCharWordHelper.ExistWord(self.ship.educateCharId, var_24_1.dialog) then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function MainEducateSpinePainting:CollectTouchEvents()
	return (self:FilterExistEvents(var_0_1.GetShipTouchEvents(self.ship:getSkinId(), self.ship:getCVIntimacy())))
end

function MainEducateSpinePainting:EnableOrDisableMove(arg_26_1)
	MainEducateSpinePainting.super.EnableOrDisableMove(self, arg_26_1)

	if arg_26_1 then
		self.waitForCharEnd = nil

		self:RemoveTellTimeTimer()
		self:RemoveDelayTellTimeTimer()
	else
		self:InitTellTimeService()
	end

	return
end

function MainEducateSpinePainting:OnPause()
	MainEducateSpinePainting.super.OnPause(self)

	self.waitForCharEnd = nil

	self:RemoveTellTimeTimer()
	self:RemoveDelayTellTimeTimer()

	return
end

function MainEducateSpinePainting:OnResume()
	MainEducateSpinePainting.super.OnResume(self)
	self:RemoveTellTimeTimer()
	self:RemoveDelayTellTimeTimer()
	self:InitTellTimeService()

	return
end

function MainEducateSpinePainting:OnUnload()
	MainEducateSpinePainting.super.OnUnload(self)

	self.waitForCharEnd = nil

	self:RemoveTellTimeTimer()
	self:RemoveDelayTellTimeTimer()

	return
end

function MainEducateSpinePainting:Dispose()
	MainEducateSpinePainting.super.Dispose(self)

	self.waitForCharEnd = nil

	self:RemoveTellTimeTimer()
	self:RemoveDelayTellTimeTimer()

	return
end

return MainEducateSpinePainting
