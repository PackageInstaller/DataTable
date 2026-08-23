local DebugTowerDungeonComp = class("DebugTowerDungeonComp", require("app.fairyGUI.debug.UI_DebugTowerDungeonComp"))
local var_0_1 = g.core.model.User.towerData
local var_0_2 = g.core.model.User.towerHardData
local var_0_3 = g.core.const.ConstMgr.TowerConst
local var_0_4 = g.core.model.User
local var_0_5 = g.core.config.tower_stage_info

function DebugTowerDungeonComp:ctor()
	self._knightPosList = {}
	self.curSelectStage = 1

	self:_init()
end

function DebugTowerDungeonComp:_init()
	self.m_btn_challenge:addClickListener(handler(self, self._onClickAutoBattle))
	self.m_btn_challengeMain:addClickListener(handler(self, self._onClickAutoBattleMain))
	self.m_btn_hard_challenge:addClickListener(handler(self, self._onClickAutoHardBattle))
	self.m_btn_hard_challengeMain:addClickListener(handler(self, self._onClickAutoBattleHardMain))

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(var_0_4.knightsData:getFormation() or {}) do
		if iter_2_1 > 0 then
			local var_2_1 = var_0_4.knightsData:getKnight({
				id = iter_2_1
			})

			table.insert(var_2_0, {
				id = iter_2_1,
				fightValue = var_2_1:getInfo().fight_value
			})

			if table.nums(var_2_0) >= 6 then
				break
			end
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.fightValue > arg_3_1.fightValue
	end)

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		table.insert(self._knightPosList, iter_2_3.id)
	end
end

function DebugTowerDungeonComp:_onClickAutoBattle()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER) then
		self:showLog("功能未解锁")

		return
	end

	local var_4_0 = tonumber(self.m_selectBox:getValues()[self.m_selectBox:getSelectedIndex() + 1] or 0)

	if var_4_0 < 2 or var_4_0 > 5 then
		self:showLog("请选择正确的值")

		return
	end

	self.curSelectStage = var_4_0

	g.core.battle.BattleShowResult:disableAll()

	if not var_0_1:getIsInitGetInfo() then
		g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({})
	else
		self:doAutoBattle()
	end
end

function DebugTowerDungeonComp:_onClickAutoBattleMain()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER) then
		self:showLog("功能未解锁")

		return
	end

	self.curSelectStage = var_0_3.STAGE_TYPE.MAIN

	g.core.battle.BattleShowResult:disableAll()

	if not var_0_1:getIsInitGetInfo() then
		g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({})
	else
		self:doAutoBattleMain()
	end
end

function DebugTowerDungeonComp:onGetInfo()
	if var_0_3.STAGE_TYPE.JIAO_GUO <= self.curSelectStage and self.curSelectStage <= var_0_3.STAGE_TYPE.LI_JIN then
		self:doAutoBattle()
	elseif var_0_3.STAGE_TYPE_HARD.JIAO_GUO <= self.curSelectStage and self.curSelectStage <= var_0_3.STAGE_TYPE_HARD.LI_JIN then
		self:doAutoBattleHard()
	elseif self.curSelectStage == var_0_3.STAGE_TYPE.MAIN then
		self:doAutoBattleMain()
	elseif self.curSelectStage == var_0_3.STAGE_TYPE_HARD.MAIN then
		self:doAutoBattleHardMain()
	else
		self:showLog("为什么类型是:" .. self.curSelectStage)
	end
end

function DebugTowerDungeonComp:showProgress(arg_7_1)
	self.m_challenge_progress:setText(arg_7_1)
end

function DebugTowerDungeonComp:showLog(arg_8_1)
	self.m_challenge_log:setText(arg_8_1)
end

function DebugTowerDungeonComp:doAutoBattle()
	if var_0_1:debugGetSubTowerIsOpen(self.curSelectStage) then
		self:showLog("副塔,id =  " .. self.curSelectStage .. ",挑战中")

		local var_9_0, var_9_1, var_9_2 = var_0_1:getCurTowerIdByType(self.curSelectStage)

		if not var_9_2 then
			g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
				play_type = 3,
				id = var_9_1
			})

			return
		else
			self:showLog("已经通关")
		end
	else
		self:showLog("副塔 " .. self.curSelectStage - 1 .. ",type = " .. self.curSelectStage .. "未开启")
	end
end

function DebugTowerDungeonComp:_getKnightPos(arg_10_1)
	local var_10_0 = var_0_5.get(arg_10_1)

	return {}
end

function DebugTowerDungeonComp:doAutoBattleMain()
	if self.curSelectStage ~= 1 then
		self:showLog("请重新开始")
		self.m_challenge_input:setText("")

		return
	end

	if var_0_1:getMainTowerIsOpen() then
		self:showLog("主塔,挑战中")

		local var_11_0, var_11_1, var_11_2 = var_0_1:getCurTowerIdByType(1)

		if not var_11_2 then
			g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
				id = var_11_1,
				formation_knight_ids = {
					0,
					0,
					0,
					0,
					0,
					0
				}
			})

			return
		else
			self:showLog("已经通关")
		end
	else
		self:showLog("主塔未开启，可能是副塔总关数不同")
	end
end

function DebugTowerDungeonComp:_onRcvBattleBegin(arg_12_1, arg_12_2, arg_12_3)
	g.core.battle.BattleProxy:fastBattle(arg_12_3.battle_id)
end

function DebugTowerDungeonComp:_onRcvBattleEnd(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = g.core.config.tower_stage_info.get(arg_13_3.id)

	self:showProgress("当前类型" .. (self.curSelectStage or "") .. " 第" .. var_13_0.stage_order .. "关")

	if arg_13_3.is_win then
		if (tonumber(self.m_stageOrder_input:getText()) or 9999999) <= var_13_0.stage_order then
			self:showLog("战斗结束，已达目标层数")
			self:newScheduleOnce(function()
				g.core.battle.BattleShowResult:enableAll()
			end, 1)
		elseif var_0_3.STAGE_TYPE.JIAO_GUO <= self.curSelectStage and self.curSelectStage <= var_0_3.STAGE_TYPE.LI_JIN then
			self:newScheduleOnce(function()
				self:doAutoBattle()
			end, 0.1)
		elseif var_0_3.STAGE_TYPE_HARD.JIAO_GUO <= self.curSelectStage and self.curSelectStage <= var_0_3.STAGE_TYPE_HARD.LI_JIN then
			self:newScheduleOnce(function()
				self:doAutoBattleHard()
			end, 0.1)
		elseif self.curSelectStage == var_0_3.STAGE_TYPE.MAIN then
			self:newScheduleOnce(function()
				self:doAutoBattleMain()
			end, 0.1)
		elseif self.curSelectStage == var_0_3.STAGE_TYPE_HARD.MAIN then
			self:newScheduleOnce(function()
				self:doAutoBattleHardMain()
			end, 0.1)
		else
			self:showLog("为什么类型是:" .. self.curSelectStage)
		end
	else
		self:showLog("战斗失败")
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 1)
	end
end

function DebugTowerDungeonComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEFINISH, self._onRcvBattleEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETINFO, self.onGetInfo, self)
end

function DebugTowerDungeonComp:onShow()
	self:setVisible(true)
end

function DebugTowerDungeonComp:onHide()
	self:setVisible(false)
end

function DebugTowerDungeonComp:_onClickAutoHardBattle()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER_HARD) then
		self:showLog("功能未解锁")

		return
	end

	if not tonumber(self.m_challenge_input:getText()) then
		-- block empty
	end

	local var_23_1 = tonumber(self.m_selectBox:getValues()[self.m_selectBox:getSelectedIndex() + 1] or 0)

	if var_23_1 < 2 or var_23_1 > 5 then
		self:showLog("请选择正确的值")

		return
	end

	self.curSelectStage = var_23_1 + 5

	g.core.battle.BattleShowResult:disableAll()

	if not var_0_2:getIsInitGetInfo() then
		g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({
			play_type = 2
		})
	else
		self:doAutoBattleHard()
	end
end

function DebugTowerDungeonComp:doAutoBattleHard()
	if var_0_2:debugGetSubTowerIsOpen(self.curSelectStage) then
		self:showLog("困难副塔,id =  " .. self.curSelectStage .. ",挑战中")

		local var_24_0, var_24_1, var_24_2 = var_0_2:getCurTowerIdByType(self.curSelectStage)

		if not var_24_2 then
			local var_24_3, var_24_4 = var_0_2:getFormationPos(self.curSelectStage)

			g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
				play_type = 2,
				id = var_24_3,
				formation_knight_ids = var_24_4
			})

			return
		else
			self:showLog("困难副塔 已经通关")
		end
	else
		self:showLog("困难副塔 " .. self.curSelectStage - 1 .. ",type = " .. self.curSelectStage .. "未开启")
	end
end

function DebugTowerDungeonComp:_onClickAutoBattleHardMain()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER_HARD) then
		self:showLog("功能未解锁")

		return
	end

	self.curSelectStage = var_0_3.STAGE_TYPE_HARD.MAIN

	g.core.battle.BattleShowResult:disableAll()

	if not var_0_2:getIsInitGetInfo() then
		g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({
			play_type = 2
		})
	else
		self:doAutoBattleHardMain()
	end
end

function DebugTowerDungeonComp:doAutoBattleHardMain()
	if self.curSelectStage ~= var_0_3.STAGE_TYPE_HARD.MAIN then
		self:showLog("请重新开始")
		self.m_challenge_input:setText("")

		return
	end

	if var_0_2:getMainTowerIsOpen() then
		self:showLog("困难主塔,挑战中")

		local var_26_0, var_26_1, var_26_2 = var_0_2:getCurTowerIdByType(self.curSelectStage)

		if not var_26_2 then
			g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
				play_type = 2,
				id = var_26_1,
				formation_knight_ids = {}
			})

			return
		else
			self:showLog("困难主塔 已经通关")
		end
	else
		self:showLog("困难主塔未开启，可能是副塔总关数不同")
	end
end

return DebugTowerDungeonComp
