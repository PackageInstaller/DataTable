local var_0_0 = false
local var_0_1 = g.core.model.User.richmanData
local var_0_2 = g.core.model.User.shopData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.config.richman_event_info
local var_0_7 = g.core.config.richman_game_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local var_0_9 = g.core.event.enum
local DebugOneKeyRichman = class("DebugOneKeyRichman", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyRichman:initData()
	self._loseTimes = 0
	self._oneKeyName = "一键大富翁"
	self._needAddEventList = {
		[var_0_9.EVENT_NET_S2C_RICH_MAN_GETINFO] = handler(self, self._onS2CGetInfo),
		[var_0_9.EVENT_NET_S2C_RICH_MAN_MAPUPLEVEL] = handler(self, self._onS2CMapLvUp),
		[var_0_9.EVENT_NET_S2C_RICH_MAN_ROLLDICE] = handler(self, self._onS2CDice),
		[var_0_9.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS] = handler(self, self._onS2CEventProcess),
		[var_0_9.EVENT_NET_S2C_RICH_MAN_TASKAWARD] = handler(self, self._onS2CTaskAward),
		[var_0_9.EVENT_NET_S2C_RICH_MAN_CHALLENGEMONSTERFINISH] = handler(self, self._onS2CMonsterFinish)
	}
end

function DebugOneKeyRichman:doOneKey()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.RICH_MAN) then
		self._isFinish = true

		return "大富翁功能尚未开启"
	end

	if not var_0_0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_RichMan_GetInfo({})
		end)

		var_0_0 = true

		return "请求大富翁数据"
	end

	if self._battleId then
		return "挑战怪物中"
	end

	if var_0_1:getMapExp() >= var_0_1:getCurLvMaxExp() and var_0_1:getMapLevel() < var_0_1:getMapMaxLevel() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_RichMan_MapUpLevel({})
		end)

		return "升级地图"
	end

	local var_2_0 = var_0_1:getMonsterEventList()

	if #var_2_0 > 0 and self._loseTimes < 20 then
		self:send(function()
			g.core.battle.BattleShowResult:disableAll()
			g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
				unique_id = var_2_0[1].unique_id
			})
		end)

		return "挑战怪物"
	else
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.2)
	end

	if var_0_2:getLeftCount(var_0_3.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + var_0_4:getOwnNum(var_0_5.TYPE_ITEM, var_0_5.ITEM.RICH_MAN_RUN_DICE) > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_RichMan_RollDice({})
		end)

		return "投骰子"
	end

	for iter_2_0, iter_2_1 in ipairs((var_0_1:getRightEventList())) do
		if next(iter_2_1.list) then
			if iter_2_1.type == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
				self:send(function()
					local var_8_0 = var_0_7.get(var_0_6.get(iter_2_1.list[1].id).event_value1)
					local var_8_1 = {}

					for iter_8_0 = 1, 4 do
						var_8_1[iter_8_0] = var_8_0["parameter_" .. iter_8_0]
					end

					var_8_1[5] = var_8_0.special_time

					g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
						unique_id = iter_2_1.list[1].unique_id,
						params = var_8_1
					})
				end)

				return "红包雨小游戏"
			elseif iter_2_1.type == RichmanConst.EVENT_TYPE.GAME_TURNTABLE then
				self:send(function()
					g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
						unique_id = iter_2_1.list[1].unique_id,
						params = {}
					})
				end)
			elseif iter_2_1.type == RichmanConst.EVENT_TYPE.GAME_TURNCARD then
				self:send(function()
					g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
						unique_id = iter_2_1.list[1].unique_id
					})
				end)
			end
		end
	end

	local var_2_1 = var_0_1:getTaskData():getTaskList()

	var_2_1 = var_2_1 or {}

	local var_2_2 = {}

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
		if iter_2_3.state == RichmanConst.TASK_STATE.FINISH then
			table.insert(var_2_2, iter_2_3.cfg.id)
		end
	end

	if next(var_2_2) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_RichMan_TaskAward({
				ids = var_2_2
			})
		end)

		return "领取任务奖励"
	end

	self._isFinish = true

	return "大富翁完成"
end

function DebugOneKeyRichman:_onS2CGetInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	return "信息更新中"
end

function DebugOneKeyRichman:_onS2CMapLvUp(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	return "地图升级"
end

function DebugOneKeyRichman:_onS2CDice(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	return "完成............."
end

function DebugOneKeyRichman:_onS2CEventProcess(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = ""

	if arg_15_4.battle_id then
		var_15_0 = "挑战怪物....................."

		self:send(function()
			g.core.battle.BattleProxy:fastBattle(arg_15_4.battle_id)
		end)

		self._battleId = arg_15_4.battle_id
	elseif arg_15_4.event.tp == RichmanConst.EVENT_TYPE.GAME_TURNTABLE then
		var_15_0 = "老虎机小游戏....................."
	elseif arg_15_4.event.tp == RichmanConst.EVENT_TYPE.GAME_TURNCARD then
		var_15_0 = "翻牌小游戏....................."
	elseif arg_15_4.event.tp == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
		var_15_0 = "红包雨小游戏....................."
	end

	return var_15_0
end

function DebugOneKeyRichman:_onS2CTaskAward(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	return "任务奖励领取成功....................."
end

function DebugOneKeyRichman:_onS2CMonsterFinish(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = "挑战完成....................."

	if not arg_18_4.is_win then
		self._loseTimes = self._loseTimes + 1
		var_18_0 = "挑战失败.....................当前失败" .. self._loseTimes .. "次(超过20次停止挑战)"
	end

	self._battleId = nil

	return var_18_0
end

return DebugOneKeyRichman
