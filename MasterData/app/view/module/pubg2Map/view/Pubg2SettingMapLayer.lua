local var_0_0 = math.floor
local var_0_1 = g.core.const.ConstMgr.PubgConst
local var_0_2 = g.core.const.ConstMgr.PubgConst.fsm
local Pubg2SettingMapLayer = class("Pubg2SettingMapLayer", require("app.fairyGUI.pubg.UI_Pubg2SettingMapLayer"), function()
	return fgui.GComponent:create({
		resName = "Pubg2SettingMapLayer",
		pkgPath = "ui/pubg/pubg",
		isFullScreen = true,
		pkgName = "pubg"
	}, ...)
end)
local var_0_4 = 100
local var_0_5 = 350

function Pubg2SettingMapLayer:ctor(arg_2_1)
	self._floorComp = nil
	self._ctrlComp = nil
	self._lastSendTime = 0
	self._lastGetMoveTime = 0
	self._myId = g.core.model.User:getId()

	self:_initView()
end

function Pubg2SettingMapLayer:_initView()
	self.m_mapComp:setStage(self)

	self._ctrlComp = self.m_mapComp.m_ctrlComp

	self.m_quitBtn:addClickListener(handler(self, self._onClickQuitBtn))
	self.m_playerIcon:addClickListener(handler(self, self._onClickPlayerIcon))
	self.m_scaleSlide:addEventListener(fgui.UIEventType.Changed, handler(self, self._onScaleChange))
	self.m_scaleSlide:setValue(100)
end

function Pubg2SettingMapLayer:_onScaleChange()
	self.m_mapComp:setScale(math.floor(self.m_scaleSlide:getValue()) * 0.01)
end

function Pubg2SettingMapLayer:onLoad()
	self._osTime = os.clock()

	self:newSchedule(handler(self, self._updateTick))
end

function Pubg2SettingMapLayer:_onMoveNotify(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	for iter_6_0, iter_6_1 in ipairs(arg_6_4.list or {}) do
		self:getFloorComp():setUserMovePosTo(iter_6_1)
	end

	self._lastGetMoveTime = var_0_2.Time.curT
end

function Pubg2SettingMapLayer:getFloorComp()
	self._floorComp = self._floorComp or self.m_mapComp:getFloorComp()

	return self._floorComp
end

function Pubg2SettingMapLayer:_updateTick()
	local var_8_0 = os.clock()
	local var_8_1 = var_0_0((var_8_0 - self._osTime) * 1000)

	self._osTime = var_8_0
	var_0_2.Time.lastT = var_0_2.Time.curT
	var_0_2.Time.curT = var_0_2.Time.curT + var_8_1
	var_0_2.Time.deltaT = var_8_1
	var_0_2.Time.averageDuration = var_0_2.Time.averageDuration * 0.9 + var_8_1 * 0.1
	var_0_2.Time.lowDuration = math.max(var_8_1, var_0_2.Time.lowDuration)

	if var_0_1.map.MAP_DEBUG_GRID then
		local var_8_2 = {
			string.format("updateCurPos耗时: %s", var_0_1.fsm.Time.updateCurPosConsume),
			string.format("updateCurPos最大耗时: %f", var_0_1.fsm.Time.updateCurPosConsumeMax),
			string.format("平均帧时长: %f", var_0_1.fsm.Time.averageDuration),
			(string.format("最大帧时长: %f", var_0_1.fsm.Time.lowDuration))
		}

		var_8_2[5] = string.format("玩家位置: %f,%f", self:getFloorComp():getMyCompPos().x, self:getFloorComp():getMyCompPos().y)

		self.m_logTest:setText(table.concat(var_8_2, "\n"))
	end

	self.m_mapComp:tickMapUpdate()
end

function Pubg2SettingMapLayer:onUnload()
	return
end

function Pubg2SettingMapLayer:onRemoved()
	self:getFloorComp():clearConfig(1)
end

function Pubg2SettingMapLayer:_onClickQuitBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self._quitGame),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(430937)
	})))
end

function Pubg2SettingMapLayer:_quitGame()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function Pubg2SettingMapLayer:calcBorderAngle()
	if not self._angle then
		local function var_13_0(arg_14_0, arg_14_1)
			return (math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_14_1, arg_14_0)))) + 360) % 360
		end

		self._angle = {
			right = {
				var_13_0(cc.p(display.cx, display.cy), cc.p(display.width, 0)),
				var_13_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height))
			},
			left = {
				var_13_0(cc.p(display.cx, display.cy), cc.p(0, display.height)),
				var_13_0(cc.p(display.cx, display.cy), cc.p(0, 0))
			},
			top = {
				var_13_0(cc.p(display.cx, display.cy), cc.p(0, 0)),
				var_13_0(cc.p(display.cx, display.cy), cc.p(display.width, 0))
			},
			bottom = {
				var_13_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height)),
				var_13_0(cc.p(display.cx, display.cy), cc.p(0, display.height))
			}
		}
	end
end

function Pubg2SettingMapLayer:updatePlayerIcon(arg_15_1, arg_15_2)
	if math.abs(arg_15_2.x - arg_15_1.x) < display.cx and math.abs(arg_15_2.y - arg_15_1.y) < display.cy then
		self.m_playerIcon:setVisible(false)
	else
		self:calcBorderAngle()
		self.m_playerIcon:setVisible(true)

		local var_15_0 = self.m_playerIcon:updateArrow(arg_15_1, arg_15_2)
		local var_15_1 = 0
		local var_15_2 = 0
		local var_15_3 = display.cx
		local var_15_4 = display.cy
		local var_15_5 = var_15_0

		if var_15_0 >= self._angle.right[1] and var_15_0 <= 360 or var_15_0 <= self._angle.right[2] and var_15_0 >= 0 then
			var_15_1 = var_15_3 - var_0_5

			if var_15_0 >= self._angle.right[1] then
				var_15_5 = var_15_5 - 360
			end

			var_15_2 = var_15_3 * math.tan(var_15_5 / 180 * math.pi)
		elseif var_15_0 >= self._angle.bottom[1] and var_15_0 <= self._angle.bottom[2] then
			var_15_2 = var_15_4 - var_0_4
			var_15_1 = -var_15_4 * math.tan((var_15_0 - 90) / 180 * math.pi)
		elseif var_15_0 >= self._angle.left[1] and var_15_0 <= self._angle.left[2] then
			var_15_1 = -var_15_3 + var_0_5
			var_15_2 = -var_15_3 * math.tan((var_15_0 - 180) / 180 * math.pi)
		elseif var_15_0 >= self._angle.top[1] and var_15_0 <= self._angle.top[2] then
			var_15_2 = -var_15_4 + var_0_4
			var_15_1 = var_15_4 * math.tan((var_15_0 - 270) / 180 * math.pi)
		end

		if var_15_2 < -var_15_4 + var_0_4 then
			var_15_2 = -var_15_4 + var_0_4
		elseif var_15_2 > var_15_4 - var_0_4 then
			var_15_2 = var_15_4 - var_0_4
		end

		if var_15_1 < -var_15_3 + var_0_5 then
			var_15_1 = -var_15_3 + var_0_5
		elseif var_15_1 > var_15_3 - var_0_5 then
			var_15_1 = var_15_3 - var_0_5
		end

		self.m_playerIcon:setPosition(display.cx + var_15_1, display.cy + var_15_2)
	end
end

function Pubg2SettingMapLayer:_onClickPlayerIcon()
	return
end

return Pubg2SettingMapLayer
