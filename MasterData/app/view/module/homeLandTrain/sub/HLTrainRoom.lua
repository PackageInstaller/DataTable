local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local KsMath = require("app.core.utils.KsMath")
local var_0_2 = g.core.model.User
local HLTrainRoom = class("HLTrainRoom", require("app.fairyGUI.homeLandTrain.UI_HLTrainRoom"))

function HLTrainRoom:ctor()
	self._spine = nil
	self._roleCompArr = {}
	self._isOpened = false
	self._offXRange = (self:getWidth() - display.width) / 2
	self._roomStruct = nil

	self.m_doorTypeController:setSelectedIndex(1)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
end

function HLTrainRoom:setRoomOpen(arg_2_1)
	self._isOpened = arg_2_1

	if self._isOpened then
		self.m_blackController:setSelectedIndex(1)
		self.m_openTransition:play()
		self:enterRoomSpineEffect(self._roomStruct.refCfgBaseInfo.res)
	else
		self.m_closeTransition:play()
		self.m_effPosComp:removeAllEffect()

		self._spine = nil

		self.m_bgImg:setX(0)
		self.m_effPosComp:setX(0)
		self.m_roleNodeComp:setX(0)
		self.m_blackController:setSelectedIndex(0)
	end
end

function HLTrainRoom:enterRoomSpineEffect(arg_3_1)
	if string.len(arg_3_1) > 0 then
		self._spine = self.m_effPosComp:addEffectSpine({
			isLoop = false,
			anim = "open",
			name = arg_3_1,
			x = self.m_effPosComp:getWidth(),
			y = self.m_effPosComp:getHeight() / 2,
			eventHandler = handler(self, self._onSpineEvent)
		})
	end
end

function HLTrainRoom:_onSpineEvent(arg_4_1)
	if arg_4_1.type == "complete" then
		self._spine:setAnimation(0, "normal1", true)
		self._spine:setAnimation(1, "normal2", true)
		self._spine:setAnimation(2, "normal3", true)
	end
end

function HLTrainRoom:refreshRoom(arg_5_1)
	local var_5_0 = var_0_2.hlTrainData:getRoomStruct(arg_5_1)

	self._roomStruct = var_5_0

	self.m_bgImg:setURL("bg/homeland/" .. var_5_0.refCfgBaseInfo.mini_res .. ".jpg")
	self:_refreshRoomRole()
end

function HLTrainRoom:_refreshRoomRole()
	self:_cleanAllRole()
	self:_buildWorkingRole()
end

function HLTrainRoom:_buildWorkingRole()
	self._roleCompArr = {}

	for iter_7_0, iter_7_1 in ipairs(self._roomStruct.knightIdArr) do
		local var_7_0 = fgui.UIPackage:createObject("homeLandTrain", "HLTrainRoomRoleComp", self)

		var_7_0:initWithKnightId(iter_7_1)
		self.m_roleNodeComp:addChildBase(var_7_0)
		var_7_0:setPosition(self._roomStruct.refCfgBaseInfo["pos_start_x_" .. iter_7_0], self.m_roleNodeComp:getHeight() - self._roomStruct.refCfgBaseInfo["pos_start_y_" .. iter_7_0])
		table.insert(self._roleCompArr, var_7_0)
	end

	self:runFGAction(fgui.FRepeatForever:create((fgui.FSequence:create({
		fgui.FCallFunc:create(handler(self, function()
			self:onWorkingMove()
		end)),
		fgui.FDelayTime:create(HLTrainConst.WORK_DELAY_MOVE)
	}))))
end

function HLTrainRoom:onWorkingMove()
	if #self._roleCompArr < 1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(self._roleCompArr) do
		local var_9_0 = self:getGoBackRoute(iter_9_0)

		if iter_9_1 and var_9_0 and math.random(10) < 3 then
			require("app.core.common.Route"):new(var_9_0):moveContinue({
				speed = 0.8,
				isReverse = true,
				isAnim = true,
				startIndex = #var_9_0
			})
		end
	end
end

function HLTrainRoom:getGoBackRoute(arg_10_1)
	if arg_10_1 > 3 then
		return
	end

	local var_10_0 = self._roomStruct.refCfgBaseInfo
	local var_10_1 = {}

	table.insert(var_10_1, {
		x = self._roomStruct.refCfgBaseInfo["pos_start_x_" .. arg_10_1],
		y = self.m_roleNodeComp:getHeight() - self._roomStruct.refCfgBaseInfo["pos_start_y_" .. arg_10_1]
	})
	table.insert(var_10_1, {
		x = var_10_0["pos_end_x_" .. arg_10_1],
		y = self.m_roleNodeComp:getHeight() - var_10_0["pos_end_y_" .. arg_10_1]
	})

	for iter_10_0 = #var_10_1, 1, -1 do
		table.insert(var_10_1, var_10_1[iter_10_0])
	end

	return var_10_1
end

function HLTrainRoom:_cleanAllRole()
	if #self._roleCompArr < 1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self._roleCompArr) do
		iter_11_1:removeFromParent()
	end

	self._roleCompArr = {}
end

function HLTrainRoom:_onTouchBegin(arg_12_1)
	if self._isOpened then
		arg_12_1:captureTouch()
	end
end

function HLTrainRoom:_onTouchMove(arg_13_1)
	if not self._isOpened then
		return
	end

	local var_13_0 = KsMath.rangeIn(self.m_bgImg:getPosition().x + arg_13_1:getInput():getTouch():getDelta().x, -self._offXRange, self._offXRange)

	self.m_bgImg:setX(var_13_0)
	self.m_effPosComp:setX(var_13_0)
	self.m_roleNodeComp:setX(var_13_0)
end

function HLTrainRoom:updateRolesMobility()
	if self._isOpened then
		for iter_14_0, iter_14_1 in ipairs(self._roleCompArr) do
			iter_14_1:updateMobilityBar()
		end
	end
end

return HLTrainRoom
