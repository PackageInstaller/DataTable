local var_0_0 = g.core.config.dead_battle_buff_info
local var_0_1 = g.core.config.dead_battle_floor_info
local var_0_2 = g.core.model.User.wushData
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr
local DebugWushComp = class("DebugWushComp", require("app.fairyGUI.debug.UI_DebugWushComp"))
local var_0_6 = 2

function DebugWushComp:ctor()
	self._logList = {}
	self._challengeType = 2
	self._isStop = false

	self:_init()
end

function DebugWushComp:_init()
	self.m_wushChallengeBtn:addClickListener(handler(self, self._onClickChallenge))
	self.m_stop:addClickListener(handler(self, self._onStop))
	self.m_logList:setVirtual()
	self.m_logList:setItemRenderer(handler(self, self._onLogListRender))
end

function DebugWushComp:_onLogListRender(arg_3_1, arg_3_2)
	arg_3_2:setTitle(arg_3_1 + 1 .. "." .. self._logList[arg_3_1 + 1])
end

function DebugWushComp:onGetInfo()
	self:showLog("拉取info信息")
	self:doAutoBattle()
end

function DebugWushComp:_onRcvReset()
	var_0_2:reset()
	g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
end

function DebugWushComp:showLog(arg_6_1)
	table.insert(self._logList, arg_6_1)
	self.m_logList:setNumItems(#self._logList)
	self.m_logList:scrollToView(#self._logList - 1)
end

function DebugWushComp:_onRcvBattleBegin(arg_7_1, arg_7_2, arg_7_3)
	g.core.battle.BattleProxy:fastBattle(arg_7_3.battle_id)
end

function DebugWushComp:_onRcvBattleFinish(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_4.is_win then
		self:newScheduleOnce(handler(self, function()
			self:doAutoBattle()
		end), 0.5)
	else
		self._challengeType = self._challengeType - 1

		if self._challengeType < 0 then
			self:showLog("最低挑战难度失败，停止挑战")

			return
		end

		self:showLog("挑战失败，降低挑战难度，当前难度为" .. self._challengeType + 1)
		self:newScheduleOnce(handler(self, function()
			self:doAutoBattle()
		end), 0.5)
	end
end

function DebugWushComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEFINISH, handler(self, self._onRcvBattleFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_GETINFO, self.onGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._onRcvReset, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_ALLCHALLENGE, self.doAutoBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_PICKBUFF, handler(self, self.doAutoBattle), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_BOXAWARD, self.doAutoBattle, self)
	self.m_logList:setNumItems(0)
end

function DebugWushComp:onShow()
	self:setVisible(true)
end

function DebugWushComp:onHide()
	self:setVisible(false)
end

function DebugWushComp:_onStop()
	self._isStop = true

	self:showLog("停止")
end

function DebugWushComp:_onClickChallenge()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_TRIAL) then
		self:showLog("功能未解锁")

		return
	end

	g.core.battle.BattleShowResult:disableAll()

	self._logList = {}
	self._isStop = false
	self._challengeType = 2

	self:showLog("开始深入黑渊")

	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.WUSH) > 0 then
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_0_4.ShopConst.PLAY_TYPE.WUSH
		})
		self:showLog("重置次数")
	else
		g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
	end
end

function DebugWushComp:autoBlitz()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WUSHUANG_ONCE_WIPE_OUT) then
		self:showLog("一键扫荡功能尚未开启")

		return false
	end

	if var_0_2:isFinish() then
		self:showLog("没次数或者最高层了")

		return true
	end

	local var_16_0 = var_0_2:getCurStageIndex()
	local var_16_1 = var_0_1.fetch((var_0_2:getCurFloorId()))

	if var_16_1.type == var_0_6 then
		if var_16_0 >= 1 then
			return false
		end
	elseif var_16_0 > 2 then
		return false
	end

	if var_0_2:isWushCanSwapeLevel(var_16_1["stage" .. var_16_0 + 1], var_16_1.type == var_0_6) then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_AllChallenge({})
		self:showLog("委托作战")

		return true
	end

	return false
end

function DebugWushComp:doAutoBattle()
	if self._isStop then
		return
	end

	if self:autoBlitz() then
		return
	end

	local var_17_0 = var_0_2:getCurStageIndex()
	local var_17_1 = var_0_2:getCurFloorId()

	if var_0_1.fetch(var_17_1).type == var_0_6 then
		if var_17_0 >= 1 then
			self:choseBuffAndBox(true)

			return
		end
	elseif var_17_0 > 2 then
		self:choseBuffAndBox(false)

		return
	end

	g.core.network.GameNetProxy:send_C2S_DeadBattle_ChallengeBegin({
		index = self._challengeType
	})
	self:showLog("挑战第" .. var_17_1 .. "层，关卡" .. var_17_0 + 1 .. "难度" .. self._challengeType + 1)
end

function DebugWushComp:choseBuffAndBox(arg_18_1)
	if var_0_2:isNeedReceiveBox(arg_18_1) then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_BoxAward({})
		self:showLog("领宝箱")

		return
	end

	local var_18_0 = var_0_2:getCurLeftStar()

	if var_0_2:isNeedReceiveBuff() then
		local var_18_1

		for iter_18_0, iter_18_1 in pairs((var_0_2:getFloorBuffArray())) do
			local var_18_2 = var_0_0.get(iter_18_1)

			if var_18_0 < var_18_2.star then
				break
			else
				var_18_1 = var_18_2
			end
		end

		if var_18_1 then
			g.core.network.GameNetProxy:send_C2S_DeadBattle_PickBuff({
				id = var_18_1.id
			})
			self:showLog("选buff消耗星数" .. var_18_1.star)
		end
	end

	if var_0_2:getCurFloorId() == var_0_1.getLength() then
		self:showLog("最高层了")

		return
	end
end

return DebugWushComp
