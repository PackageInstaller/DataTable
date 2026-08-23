local SuperSdkService = class("SuperSdkService")

function SuperSdkService:ctor()
	self._isLaunching = true
	self._isNeedCreate = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SUPERSDK_STATS, self._onReciveStats, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGIN_FINISH, self._onGameLoginFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CREATE_ROLE, self._onCreateRole, self)
end

function SuperSdkService:_onCreateRole(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 and arg_2_3.uid == 0 then
		self._isNeedCreate = true
	end
end

function SuperSdkService:reset()
	self._isLaunching = true
	self._isNeedCreate = false
end

function SuperSdkService:_onReciveStats(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2 and tonumber(arg_4_2.event_id) or nil
	local var_4_1 = arg_4_2.errMsg
	local var_4_2 = ""
	local var_4_3 = ""
	local var_4_4 = g.core.config.guide_log_info.fetch(var_4_0)

	if var_4_4 then
		var_4_2 = var_4_4.des
		var_4_3 = var_4_4.extra_1
	end

	if var_4_0 == g.core.const.ConstMgr.SuperSdkConst.THEME_BIO_VOTE_END_STORY then
		var_4_2 = "黄金周活动_查看结局剧情"
		var_4_3 = arg_4_2.extra
	end

	if not var_4_0 or #var_4_2 < 1 then
		return
	end

	g.core.log:info(string.format("SuperSdkService：%s %s", tostring(var_4_0), tostring(var_4_2)))
	g.core.platform.PlatformProxy:startStatsData(var_4_0, var_4_2, var_4_3, var_4_1)
end

function SuperSdkService:_onGameLoginFinish()
	if self._isLaunching then
		self._isLaunching = false

		g.core.platform.PlatformProxy:enterGame()

		if self._isNeedCreate then
			g.core.platform.PlatformProxy:createRole()
		end
	end
end

return SuperSdkService
