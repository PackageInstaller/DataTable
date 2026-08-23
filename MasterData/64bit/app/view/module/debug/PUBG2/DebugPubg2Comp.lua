g.core.const.ConstMgr.PubgConst.fsm = g.core.const.ConstMgr.PubgConst.fsm or require("app.view.module.debug.PUBG2.fsm.FsmConst")

local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local DebugPubg2Comp = class("DebugPubg2Comp", require("app.fairyGUI.debug.UI_DebugPubg2Comp"))

function DebugPubg2Comp:ctor()
	self._allUser = {}
	self._myUser = nil

	self:addUser(var_0_0.test.myId)

	self._myUser = self._allUser[var_0_0.test.myId]
	var_0_0.Time.startTime = 0
	var_0_0.Time.curT = var_0_0.Time.startTime
	var_0_0.Time.lastT = var_0_0.Time.curT
	self._lastSendTime = 0
	self._lastGetMoveTime = 0

	self.m_resetPosBtn:addClickListener(handler(self, self._onClickResetPos))
end

function DebugPubg2Comp:_onClickResetPos()
	self._myUser:setPosition(cc.p(0, 0))
	self._myUser:setMovePosTo({
		x = 0,
		y = 0,
		time = var_0_0.Time.curT + var_0_0.Time.serverDeltaT,
		user_id = var_0_0.test.myId
	})
end

function DebugPubg2Comp:addUser(arg_3_1)
	local var_3_0 = fgui.UIPackage:createObject("debug", "DebugPubg2User")

	var_3_0:setId(arg_3_1)

	self._allUser[arg_3_1] = var_3_0

	self.m_origin:addChild(var_3_0)
end

function DebugPubg2Comp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, handler(self, self._onMoveNotify), self)
	self:displayObject():scheduleUpdateWithPriorityLua(handler(self, self._pubgScheduleUpdate), 0)
end

function DebugPubg2Comp:_onMoveNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	for iter_5_0, iter_5_1 in ipairs(arg_5_4.list or {}) do
		if self._allUser[iter_5_1.user_id] then
			self._allUser[iter_5_1.user_id]:setMovePosTo(iter_5_1)
		end
	end

	self._lastGetMoveTime = var_0_0.Time.curT
end

function DebugPubg2Comp:_pubgScheduleUpdate(arg_6_1)
	arg_6_1 = math.floor(arg_6_1 * 1000)
	var_0_0.Time.lastT = var_0_0.Time.curT
	var_0_0.Time.curT = var_0_0.Time.curT + arg_6_1
	var_0_0.Time.deltaT = arg_6_1

	for iter_6_0, iter_6_1 in pairs(self._allUser) do
		iter_6_1:tickUpdate(arg_6_1)
	end

	self.m_logText:setText(table.concat({
		"帧时间: " .. var_0_0.Time.deltaT .. "ms\n",
		"服务器延迟: " .. var_0_0.Time.serverDeltaT .. "ms\n",
		"发送间隔: " .. var_0_0.Time.lastSendDelayT .. "ms\n",
		"tick最小间隔: " .. var_0_0.test.minTick .. "ms"
	}, ""))
	self.m_posText:setText(string.format("(%.2f, %.2f)", self._myUser:getPosition().x, self._myUser:getPosition().y))
	self:checkUserMove()
end

function DebugPubg2Comp:onUnload()
	self:displayObject():unscheduleUpdate()
end

function DebugPubg2Comp:checkUserMove()
	local var_8_0 = self.m_ctrlComp:getAngle()

	if not self.m_ctrlComp:isTouching() then
		self._lastSendTime = 0

		return
	end

	local var_8_1 = var_0_0.test.minTick
	local var_8_2 = false

	if self._lastSendTime > 0 then
		var_8_1 = var_0_0.Time.curT - self._lastSendTime

		if self._lastGetMoveTime > 0 then
			var_0_0.test.onProtoGetTick = (self._lastGetMoveTime - self._lastSendTime) * 0.5
			var_8_2 = var_0_0.Time.curT - self._lastGetMoveTime - var_0_0.test.onProtoGetTick >= 0
		end
	else
		var_0_0.test.onProtoGetTick = 0
		var_8_2 = true
	end

	if var_8_1 < var_0_0.test.minTick then
		return
	end

	if var_8_2 then
		local var_8_3, var_8_4 = self._myUser:getMoveData()
		local var_8_5 = var_8_4
		local var_8_6 = var_0_0.test.moveSpeed * var_8_1 * 0.001

		var_0_0.Time.lastSendDelayT = var_8_1
		var_0_0.Time.serverDeltaT = math.random(60, 100)

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, false, 0, {
				list = {
					{
						time = var_0_0.Time.curT + var_0_0.Time.serverDeltaT,
						x = var_8_5.x + var_8_6 * math.cos(var_8_0),
						y = var_8_5.y + var_8_6 * math.sin(var_8_0),
						user_id = var_0_0.test.myId
					}
				}
			})
		end, var_0_0.Time.serverDeltaT * 0.001)

		self._lastSendTime = var_0_0.Time.curT
		self._lastGetMoveTime = 0
	end
end

return DebugPubg2Comp
