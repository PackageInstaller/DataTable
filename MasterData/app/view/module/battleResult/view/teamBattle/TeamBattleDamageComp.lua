local var_0_0 = g.core.model.User.teamBattleData
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_2 = g.core.config.knight_info
local TeamBattleDamageComp = class("TeamBattleDamageComp", require("app.fairyGUI.battleResult.UI_TeamBattleDamageComp"))

function TeamBattleDamageComp:ctor()
	self._rewardItems = {}

	self.m_otherKnightList:setVirtual()
	self.m_otherKnightList:setItemRenderer(handler(self, self._onOtherKnightRenderer))
	self.m_mineKnightList:setVirtual()
	self.m_mineKnightList:setItemRenderer(handler(self, self._onMineKnightRenderer))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))
	self.m_quitBtn:addClickListener(handler(self, self._onCancelBtnClicked))
end

function TeamBattleDamageComp:onLoad()
	self:_addNetStateLister()

	if require("app.view.module.teamBattle.const.TeamBattleConst").ACTIVITY_STATE.OPEN ~= g.core.model.User.teamBattleData:getCurStage() then
		self:dispatchCompEvent("BattleResult_giveUp")

		return
	end

	local var_2_0 = g.core.config.team_battle_parameter_info.get(require("app.view.module.teamBattle.const.TeamBattleConst").PARAMETER_ID.DAILY_RESET_MONSTER_ID).parameter - g.core.model.User.teamBattleData:getMapData():getPlayerStruct():getExtData().daily_give_up_times

	self.m_giveUpTimeTxt:setText(g.core.lang:get(427152, {
		times = var_2_0
	}))

	if var_2_0 < 1 then
		self.m_noTimesController:setSelectedIndex(1)
		self:newScheduleOnce(handler(self, function(arg_3_0)
			arg_3_0:dispatchCompEvent("maskHide")
		end), 2)
	else
		self:newScheduleOnce(handler(self, function(arg_4_0)
			g.core.model.User.teamBattleData:getMapData():clearMapResult(true)
			arg_4_0:dispatchCompEvent("BattleResult_giveUp")
		end), 300)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_OPCHALLENGERESULT, self._onS2CTeamBattleOpChallengeResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TEAM_BATTLE_OP_RESULT_ERROR, self._onOpError, self)
end

function TeamBattleDamageComp:update(arg_5_1)
	self._mineKnightHpList = arg_5_1.knight_hp_list or {}
	self._otherKnightHpList = arg_5_1.enemy_hp_list or {}
	self._enemyList = {}
	self._hasKnightDead = false

	local var_5_0 = var_0_0:getMapData():getTiledStruct(arg_5_1.grid_id):getEventInfo()
	local var_5_1 = var_5_0:getEventInfo().monsterInfo.knightList

	if not var_5_0 then
		self._enemyList = {}
	end

	if #self._enemyList > 0 then
		self.m_otherKnightList:setNumItems(#self._otherKnightHpList)
		self.m_mineKnightList:setNumItems(#self._mineKnightHpList)
	end
end

function TeamBattleDamageComp:_onOtherKnightRenderer(arg_6_1, arg_6_2)
	local var_6_0 = var_0_2.get(self._enemyList[arg_6_1 + 1])
	local var_6_1 = KnightStruct.new(var_6_0.advance_id)

	var_6_1:addCfgInfo(var_6_0)
	arg_6_2:updateKnightIcon({
		knightData = var_6_1,
		hpTh = self._otherKnightHpList[arg_6_1 + 1]
	})
end

function TeamBattleDamageComp:_onMineKnightRenderer(arg_7_1, arg_7_2)
	if self._mineKnightHpList[arg_7_1 + 1].num < 1 then
		self._hasKnightDead = true
	end

	local var_7_0 = var_0_0:getFormationData()

	arg_7_2:updateKnightIcon({
		knightData = var_7_0:getGuardById(self._mineKnightHpList[arg_7_1 + 1].id),
		hpTh = self._mineKnightHpList[arg_7_1 + 1].num
	})
end

function TeamBattleDamageComp:_onConfirmBtnClicked()
	if not self._hasKnightDead then
		self:_sendConfirmMsg()
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(427155),
			onConfirm = handler(self, self._sendConfirmMsg)
		})
	end
end

function TeamBattleDamageComp:_sendConfirmMsg()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_OpChallengeResult({
		is_give_up = false
	})
end

function TeamBattleDamageComp:_onCancelBtnClicked()
	local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")

	if not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TEAM_BATTLE_GIVE_UP_TIP) then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(427156),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_TeamBattle_OpChallengeResult({
					is_give_up = true
				})
			end,
			tip = {
				isChecked = false,
				txt = g.core.lang:get(408110)
			},
			onCheck = function(arg_12_0)
				g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TEAM_BATTLE_GIVE_UP_TIP, arg_12_0)
			end
		}), {
			touchDisappear = true
		})
	else
		g.core.network.GameNetProxy:send_C2S_TeamBattle_OpChallengeResult({
			is_give_up = true
		})
	end
end

function TeamBattleDamageComp:_onS2CTeamBattleOpChallengeResult(arg_13_1, arg_13_2, arg_13_3)
	self.m_noTimesController:setSelectedIndex(1)

	if arg_13_3.is_give_up then
		self:dispatchCompEvent("BattleResult_giveUp")
	else
		self:dispatchCompEvent("teamBattle_confirm")
	end
end

function TeamBattleDamageComp:_onOpError()
	self:dispatchCompEvent("BattleResult_giveUp")
end

function TeamBattleDamageComp:_addNetStateLister()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_REPEAT, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_G2C_OFFLINE_NEW, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOGIN_OFFINE, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_FAIL, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_CONNECT_BROKEN, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_DISCONNECTED, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_EXPIRED, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_SERVER_BROKEN, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_RECONNECT, self._onNetBroken, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self._onNetBroken, self)
end

function TeamBattleDamageComp:_onNetBroken()
	g.core.model.User.teamBattleData:setNetBroken(true)
end

return TeamBattleDamageComp
