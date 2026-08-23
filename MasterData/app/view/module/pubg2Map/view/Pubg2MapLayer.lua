local var_0_0 = math.floor
local var_0_1 = g.core.const.ConstMgr.PubgConst
local var_0_2 = g.core.const.ConstMgr.PubgConst.fsm
local Pubg2MapLayer = class("Pubg2MapLayer", require("app.fairyGUI.pubg.UI_Pubg2MapLayer"), function()
	return fgui.GComponent:create({
		resName = "Pubg2MapLayer",
		pkgPath = "ui/pubg/pubg",
		isFullScreen = true,
		pkgName = "pubg"
	}, ...)
end)
local var_0_4 = 100
local var_0_5 = 350

function Pubg2MapLayer:ctor(arg_2_1)
	self._floorComp = nil
	self._lastSendTime = 0
	self._lastGetMoveTime = 0
	self._myId = g.core.model.User:getId()
	self._ctrlComp = nil

	self:_initView()
end

function Pubg2MapLayer:_initEcs()
	self._ecs = ECS.EcsSystemRoot.new()

	self._ecs:init()
end

function Pubg2MapLayer:_initView()
	self.m_mapComp:setStage(self)

	self._ctrlComp = self.m_mapComp.m_ctrlComp

	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
	self.m_playerIcon:addClickListener(handler(self, self._onClickPlayerIcon))
	self.m_scaleSlide:addEventListener(fgui.UIEventType.Changed, handler(self, self._onScaleChange))
	self.m_scaleSlide:setValue(100)
	self.m_asyncBtn:addClickListener(handler(self, self._asyncLoader))
	self:_asyncLoader()
	self.m_obstacleBtn:addClickListener(handler(self, self._showObstacle))
	self:_showObstacle()
end

function Pubg2MapLayer:_asyncLoader()
	self:getFloorComp():setAsyncLoad(self.m_asyncBtn:isSelected())
end

function Pubg2MapLayer:_showObstacle()
	self:getFloorComp():setShowObstacle(self.m_obstacleBtn:isSelected())
end

function Pubg2MapLayer:_onScaleChange()
	self.m_mapComp:setScale(math.floor(self.m_scaleSlide:getValue()) * 0.01)
end

function Pubg2MapLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, handler(self, self._onMoveNotify), self)

	self._osTime = os.clock()

	self:newSchedule(handler(self, self._updateTick))
end

function Pubg2MapLayer:_onMoveNotify(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	for iter_9_0, iter_9_1 in ipairs(arg_9_4.list or {}) do
		self:getFloorComp():setUserMovePosTo(iter_9_1)
	end

	self._lastGetMoveTime = var_0_2.Time.curT
end

function Pubg2MapLayer:getFloorComp()
	self._floorComp = self._floorComp or self.m_mapComp:getFloorComp()

	return self._floorComp
end

function Pubg2MapLayer:_updateTick()
	local var_11_0 = os.clock()
	local var_11_1 = var_0_0((var_11_0 - self._osTime) * 1000)

	self._osTime = var_11_0
	var_0_2.Time.lastT = var_0_2.Time.curT
	var_0_2.Time.curT = var_0_2.Time.curT + var_11_1
	var_0_2.Time.deltaT = var_11_1
	var_0_2.Time.averageDuration = var_0_2.Time.averageDuration * 0.9 + var_11_1 * 0.1
	var_0_2.Time.lowDuration = math.max(var_11_1, var_0_2.Time.lowDuration)

	local var_11_2 = {
		string.format("updateCurPos耗时: %s", var_0_1.fsm.Time.updateCurPosConsume),
		string.format("updateCurPos最大耗时: %f", var_0_1.fsm.Time.updateCurPosConsumeMax),
		string.format("平均帧时长: %f", var_0_1.fsm.Time.averageDuration),
		(string.format("最大帧时长: %f", var_0_1.fsm.Time.lowDuration))
	}

	var_11_2[5] = string.format("玩家位置: %f,%f", self:getFloorComp():getMyCompPos().x, self:getFloorComp():getMyCompPos().y)

	self.m_logTest:setText(table.concat(var_11_2, "\n"))
	self:checkUserMove()
	self.m_mapComp:tickMapUpdate(self._ctrlComp:getAngle() ~= 0)
end

function Pubg2MapLayer:onUnload()
	return
end

function Pubg2MapLayer:onRemoved()
	self:getFloorComp():clearConfig(1)
end

function Pubg2MapLayer:_onClickQuitBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self._quitGame),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(430937)
	})))
end

function Pubg2MapLayer:_quitGame()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function Pubg2MapLayer:calcBorderAngle()
	if not self._angle then
		local function var_16_0(arg_17_0, arg_17_1)
			return (math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_17_1, arg_17_0)))) + 360) % 360
		end

		self._angle = {
			right = {
				var_16_0(cc.p(display.cx, display.cy), cc.p(display.width, 0)),
				var_16_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height))
			},
			left = {
				var_16_0(cc.p(display.cx, display.cy), cc.p(0, display.height)),
				var_16_0(cc.p(display.cx, display.cy), cc.p(0, 0))
			},
			top = {
				var_16_0(cc.p(display.cx, display.cy), cc.p(0, 0)),
				var_16_0(cc.p(display.cx, display.cy), cc.p(display.width, 0))
			},
			bottom = {
				var_16_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height)),
				var_16_0(cc.p(display.cx, display.cy), cc.p(0, display.height))
			}
		}
	end
end

function Pubg2MapLayer:updatePlayerIcon(arg_18_1, arg_18_2)
	if math.abs(arg_18_2.x - arg_18_1.x) < display.cx and math.abs(arg_18_2.y - arg_18_1.y) < display.cy then
		self.m_playerIcon:setVisible(false)
	else
		self:calcBorderAngle()
		self.m_playerIcon:setVisible(true)

		local var_18_0 = self.m_playerIcon:updateArrow(arg_18_1, arg_18_2)
		local var_18_1 = 0
		local var_18_2 = 0
		local var_18_3 = display.cx
		local var_18_4 = display.cy
		local var_18_5 = var_18_0

		if var_18_0 >= self._angle.right[1] and var_18_0 <= 360 or var_18_0 <= self._angle.right[2] and var_18_0 >= 0 then
			var_18_1 = var_18_3 - var_0_5

			if var_18_0 >= self._angle.right[1] then
				var_18_5 = var_18_5 - 360
			end

			var_18_2 = var_18_3 * math.tan(var_18_5 / 180 * math.pi)
		elseif var_18_0 >= self._angle.bottom[1] and var_18_0 <= self._angle.bottom[2] then
			var_18_2 = var_18_4 - var_0_4
			var_18_1 = -var_18_4 * math.tan((var_18_0 - 90) / 180 * math.pi)
		elseif var_18_0 >= self._angle.left[1] and var_18_0 <= self._angle.left[2] then
			var_18_1 = -var_18_3 + var_0_5
			var_18_2 = -var_18_3 * math.tan((var_18_0 - 180) / 180 * math.pi)
		elseif var_18_0 >= self._angle.top[1] and var_18_0 <= self._angle.top[2] then
			var_18_2 = -var_18_4 + var_0_4
			var_18_1 = var_18_4 * math.tan((var_18_0 - 270) / 180 * math.pi)
		end

		if var_18_2 < -var_18_4 + var_0_4 then
			var_18_2 = -var_18_4 + var_0_4
		elseif var_18_2 > var_18_4 - var_0_4 then
			var_18_2 = var_18_4 - var_0_4
		end

		if var_18_1 < -var_18_3 + var_0_5 then
			var_18_1 = -var_18_3 + var_0_5
		elseif var_18_1 > var_18_3 - var_0_5 then
			var_18_1 = var_18_3 - var_0_5
		end

		self.m_playerIcon:setPosition(display.cx + var_18_1, display.cy + var_18_2)
	end
end

function Pubg2MapLayer:_onClickPlayerIcon()
	return
end

function Pubg2MapLayer:checkUserMove()
	local var_20_0 = self._ctrlComp:getAngle()

	if not self._ctrlComp:isTouching() then
		self._lastSendTime = 0

		self:getFloorComp():setMoving(false)

		return
	end

	self:getFloorComp():setMoving(true)

	local var_20_1 = var_0_2.test.minTick
	local var_20_2 = false

	if self._lastSendTime > 0 then
		var_20_1 = var_0_2.Time.curT - self._lastSendTime

		if self._lastGetMoveTime > 0 then
			var_0_2.test.onProtoGetTick = (self._lastGetMoveTime - self._lastSendTime) * 0.5
			var_20_2 = var_0_2.Time.curT - self._lastGetMoveTime - var_0_2.test.onProtoGetTick >= 0
		end
	else
		var_0_2.test.onProtoGetTick = 0
		var_20_2 = true
	end

	if var_20_1 < var_0_2.test.minTick then
		return
	end

	if var_20_2 then
		local var_20_3 = self:getFloorComp():getMyPos()
		local var_20_4 = self._myId
		local var_20_5, var_20_6 = self:getFloorComp():getFinalPos(var_20_3.x, var_20_3.y, var_20_3.x + var_0_2.test.moveSpeed * var_20_1 * 0.001 * math.cos(var_20_0), var_20_3.y + var_0_2.test.moveSpeed * var_20_1 * 0.001 * math.sin(var_20_0), var_0_2.test.moveSpeed * var_20_1 * 0.001)

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUBG_MOVENOTICE, false, 0, {
				list = {
					{
						time = var_0_2.Time.curT + var_0_2.Time.serverDeltaT,
						x = var_20_5,
						y = var_20_6,
						user_id = var_20_4
					}
				}
			})
		end, var_0_2.Time.serverDeltaT * 0.001)

		var_0_2.Time.lastSendDelayT = var_20_1
		var_0_2.Time.serverDeltaT = math.random(60, 100)
		self._lastSendTime = var_0_2.Time.curT
		self._lastGetMoveTime = 0
	end
end

return Pubg2MapLayer
