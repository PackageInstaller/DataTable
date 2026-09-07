local MainLanternFestivalBtn = class("MainLanternFestivalBtn", import(".MainBaseActivityBtn"))

function MainLanternFestivalBtn:GetEventName()
	return "event_LanternFestival"
end

function MainLanternFestivalBtn:GetActivityID()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LANTERNFESTIVAL)

	return var_2_0 and var_2_0.id
end

function MainLanternFestivalBtn:OnInit()
	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LANTERNFESTIVAL)
	local var_3_1 = false

	if var_3_0 and not var_3_0:isEnd() then
		local var_3_2 = getProxy(MiniGameProxy):GetHubByHubId(var_3_0:getConfig("config_id"))

		var_3_1 = var_3_2.count > 0 and var_3_2.usedtime < 7
	end

	setActive(self._tf:Find("Tip"), var_3_1)

	return
end

function MainLanternFestivalBtn:CustomOnClick()
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LANTERNFESTIVAL)

	if var_4_0 then
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_4_0:getConfig("config_client").miniGame)
	end

	return
end

return MainLanternFestivalBtn
