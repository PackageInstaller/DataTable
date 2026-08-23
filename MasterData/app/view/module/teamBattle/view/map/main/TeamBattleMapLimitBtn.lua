local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.model.User.teamBattleData
local TeamBattleMapLimitBtn = class("TeamBattleMapLimitBtn", require("app.fairyGUI.teamBattle.UI_TeamBattleMapLimitBtn"))

function TeamBattleMapLimitBtn:ctor()
	self._curBossEvent = nil
	self._timer = nil

	self:addClickListener(handler(self, self._onClick))
end

function TeamBattleMapLimitBtn:updateComp()
	self._curBossEvent = nil

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs((var_0_1:getMapData():getBossList())) do
		if iter_2_1:getState() ~= TeamBattleConst.EVENT_STATE.WAIT_TRIGGER then
			if iter_2_1:getState() == TeamBattleConst.EVENT_STATE.TRIGGER then
				for iter_2_2, iter_2_3 in ipairs((iter_2_1:getAllBindBossEvent())) do
					if iter_2_3:getState() == TeamBattleConst.EVENT_STATE.FINISH and iter_2_3:getBindUid() == g.core.model.User:getId() then
						var_2_0[iter_2_3:getBelongRoom()] = false

						break
					end
				end

				local var_2_2 = iter_2_1:getBelongRoom()
				local var_2_3 = iter_2_1:getEndTime()

				if not var_2_1[var_2_2] and var_2_0[var_2_2] ~= false then
					var_2_0[iter_2_1:getEventType()] = {
						bossEvent = iter_2_1,
						endTime = var_2_3
					}

					if iter_2_1:getBindUid() == g.core.model.User:getId() then
						var_2_1[var_2_2] = true
					end
				end
			end
		end
	end

	if var_2_0[TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1] then
		self._curBossEvent = var_2_0[TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1].bossEvent
	elseif var_2_0[TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2] then
		self._curBossEvent = var_2_0[TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2].bossEvent
	end

	if not self._curBossEvent then
		self:_onStopTimer()
		self:setVisible(false)

		return
	end

	self:_onBossEventTimeCountDown()
	self:_onStartTimer()
	self:setVisible(true)
	self.m_enterTransition:play()
end

function TeamBattleMapLimitBtn:_onBossEventTimeCountDown()
	local var_3_0 = self._curBossEvent:getEndTime()

	if var_3_0 - g.core.common.ServerTime:getTime() > 0 then
		self.m_timeTxt:setText(g.core.common.ServerTime:getLeftSecondsString(var_3_0))
	else
		self:_onStopTimer()
		self:setVisible(false)
		self._curBossEvent:isInTime()
	end
end

function TeamBattleMapLimitBtn:_onStartTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._onBossEventTimeCountDown), 1)
end

function TeamBattleMapLimitBtn:_onStopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function TeamBattleMapLimitBtn:onLoad()
	self:updateComp()
end

function TeamBattleMapLimitBtn:onUnload()
	self:_onStopTimer()
end

function TeamBattleMapLimitBtn:_onClick()
	local var_8_0 = self._curBossEvent:getEventInfo().room

	if var_8_0 ~= var_0_1:getMapData():getPlayerStruct():getRoomId() then
		g.core.module.ModuleManager:tip(g.core.lang:get(427128, {
			name = var_0_1:getMapData():getRoomStructByRoomId(var_8_0):getCfg().name
		}))

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.teamBattle.view.pop.TeamBattleLimitBossPop").new(self._curBossEvent, true), {
		touchDisappear = true
	})
end

return TeamBattleMapLimitBtn
