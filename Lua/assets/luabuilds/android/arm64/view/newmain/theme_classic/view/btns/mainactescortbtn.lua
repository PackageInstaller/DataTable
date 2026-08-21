local var_0_0 = class("MainActEscortBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_escort"
end

function var_0_0.GetActivityID(arg_2_0)
	return nil
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = getProxy(ChapterProxy)

	arg_3_0.maxTimes = var_3_0:getMaxEscortChallengeTimes()

	setActive(arg_3_0._tf:Find("Tip"), var_3_0.escortChallengeTimes < arg_3_0.maxTimes)

	return
end

function var_0_0.CustomOnClick(arg_4_0)
	local var_4_0, var_4_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "Escort")

	if not var_4_0 then
		pg.TipsMgr.GetInstance():ShowTips(var_4_1)

		return
	end

	local var_4_2 = getProxy(ChapterProxy)

	if var_4_2:getMaxEscortChallengeTimes() == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	arg_4_0:emit(NewMainMediator.SKIP_ESCORT)

	return
end

return var_0_0
