local SnapShotCacheService = class("SnapShotCacheService")

function SnapShotCacheService:ctor()
	self._waitRequestMap = {
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER] = {
			netMsgKey = "send_C2S_GetUserSnapShot",
			netMsgParamKey = "user_ids",
			waitIdDic = {}
		},
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD] = {
			netMsgKey = "send_C2S_GetGuildSnapShot",
			netMsgParamKey = "guild_ids",
			waitIdDic = {}
		},
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE] = {
			netMsgKey = "send_C2S_GuildAlliance_GetSnapshot",
			netMsgParamKey = "alliance_ids",
			waitIdDic = {}
		}
	}
end

function SnapShotCacheService:reset()
	self._waitRequestMap = {
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER] = {
			netMsgKey = "send_C2S_GetUserSnapShot",
			netMsgParamKey = "user_ids",
			waitIdDic = {}
		},
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD] = {
			netMsgKey = "send_C2S_GetGuildSnapShot",
			netMsgParamKey = "guild_ids",
			waitIdDic = {}
		},
		[g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE] = {
			netMsgKey = "send_C2S_GuildAlliance_GetSnapshot",
			netMsgParamKey = "alliance_ids",
			waitIdDic = {}
		}
	}

	if self._scheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function SnapShotCacheService:_onStartTimer()
	self._scheduleHandler = self._scheduleHandler or g.core.common.Scheduler:newSchedule(handler(self, self._checkWaitSnapShot), 0.5)
end

function SnapShotCacheService:addWaitSnapShot(arg_4_1, arg_4_2)
	self._waitRequestMap[arg_4_1].waitIdDic[arg_4_2] = true

	if not self._scheduleHandler then
		self:_onStartTimer()
	end
end

function SnapShotCacheService:_checkWaitSnapShot()
	for iter_5_0, iter_5_1 in pairs(self._waitRequestMap) do
		if next(iter_5_1.waitIdDic) then
			self:_sendRequestIdList(iter_5_1)
		end
	end

	g.core.model.User.snapShotCacheData:checkExpireData()
end

function SnapShotCacheService:_sendRequestIdList(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1.waitIdDic) do
		if #var_6_0 >= 50 then
			var_6_1[iter_6_0] = true
		else
			var_6_0[#var_6_0 + 1] = iter_6_0
		end
	end

	g.core.network.GameNetProxy[arg_6_1.netMsgKey](g.core.network.GameNetProxy, {
		[arg_6_1.netMsgParamKey] = var_6_0
	})

	arg_6_1.waitIdDic = var_6_1
end

function SnapShotCacheService:_onReceiveSnapList(arg_7_1)
	return
end

return SnapShotCacheService
