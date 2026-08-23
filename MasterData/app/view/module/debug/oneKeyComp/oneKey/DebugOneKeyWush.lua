local var_0_0 = g.core.config.dead_battle_floor_info
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.wushData
local DebugOneKeyWush = class("DebugOneKeyWush", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyWush:initData()
	self._oneKeyName = "一键深入黑渊扫荡"
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_DEAD_BATTLE_GETINFO] = handler(self, self._onS2CGetInfo),
		[var_0_1.EVENT_NET_S2C_DEAD_BATTLE_ALLCHALLENGE] = handler(self, self._onRcvAllBlitz)
	}
end

function DebugOneKeyWush:doOneKey()
	if not var_0_2:hasData() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
		end)

		return
	elseif var_0_2:isExpired() then
		var_0_2:resetExpired()
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
		end)

		return
	end

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WUSHUANG_ONCE_WIPE_OUT) then
		self._isFinish = true

		return "一键扫荡功能尚未开启"
	end

	if var_0_2:isFinish() then
		self._isFinish = true

		return "到达撤离临界点(没次数了)"
	end

	local var_2_0 = var_0_2:getCurStageIndex()
	local var_2_1 = var_0_0.fetch((var_0_2:getCurFloorId()))

	if var_2_1.type == 2 then
		if var_2_0 >= 1 then
			self._isFinish = true

			return "在领奖或者buff阶段不能扫荡"
		end
	elseif var_2_0 > 2 then
		self._isFinish = true

		return "在领奖或者buff阶段不能扫荡"
	end

	if var_0_2:isWushCanSwapeLevel(var_2_1["stage" .. var_2_0 + 1], var_2_1.type == 2) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DeadBattle_AllChallenge({})
		end)

		return
	else
		self._isFinish = true

		return "完美探索的区域才可进行委托作战"
	end
end

function DebugOneKeyWush:_onS2CGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return "信息更新中"
end

function DebugOneKeyWush:_onRcvAllBlitz(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "委托作战成功"
end

return DebugOneKeyWush
