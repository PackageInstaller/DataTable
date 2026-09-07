local MainActEscortBtn = class("MainActEscortBtn", import(".MainBaseActivityBtn"))

function MainActEscortBtn:GetEventName()
	return "event_escort"
end

function MainActEscortBtn:GetActivityID()
	return nil
end

function MainActEscortBtn:OnInit()
	local var_3_0 = getProxy(ChapterProxy)

	self.maxTimes = var_3_0:getMaxEscortChallengeTimes()

	setActive(self._tf:Find("Tip"), var_3_0.escortChallengeTimes < self.maxTimes)

	return
end

function MainActEscortBtn:CustomOnClick()
	local var_4_0, var_4_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "Escort")

	if not var_4_0 then
		pg.TipsMgr.GetInstance():ShowTips(var_4_1)

		return
	end

	if getProxy(ChapterProxy):getMaxEscortChallengeTimes() == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	self:emit(NewMainMediator.SKIP_ESCORT)

	return
end

return MainActEscortBtn
