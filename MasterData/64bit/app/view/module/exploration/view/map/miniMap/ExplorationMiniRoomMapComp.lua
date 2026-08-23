local var_0_0 = g.core.model.User.explorationData
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationMiniRoomMapComp = class("ExplorationMiniRoomMapComp", require("app.fairyGUI.exploration.UI_ExplorationMiniRoomMapComp"))

function ExplorationMiniRoomMapComp:ctor()
	self._roomData = nil
	self._roomDic = {}
	self._touchPos = nil
	self._roomEffectEnable = true
	self._followFunc = nil
	self._moveRange = {
		height = 0,
		width = 0,
		y = 0,
		x = 0
	}

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function ExplorationMiniRoomMapComp:setRoomEffectEnable(arg_2_1)
	self._roomEffectEnable = arg_2_1
end

function ExplorationMiniRoomMapComp:setRoomTouchEnable(arg_3_1)
	self.m_roomRootNode:setTouchable(arg_3_1)
end

function ExplorationMiniRoomMapComp:updateRoomComp()
	local var_4_0 = var_0_0:getMapData():getCurMapInfo()

	self._roomData = var_4_0.roomTab

	self:updateView(var_4_0.maxX, var_4_0.maxY)
end

function ExplorationMiniRoomMapComp:addFollowFunc(arg_5_1)
	self._followFunc = arg_5_1
end

function ExplorationMiniRoomMapComp:updateView(arg_6_1, arg_6_2)
	local var_6_0 = var_0_0:getMapData()
	local var_6_1 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_6_0:getMirrorCoordinate()))
	local var_6_2 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_6_0:getMainRoleCoordinate()))
	local var_6_3 = self.m_firstPosNode:getPosition()

	for iter_6_0 = 1, arg_6_2 do
		for iter_6_1 = 1, arg_6_1 do
			local var_6_4 = var_6_0:getRoomStructByCoordinate(cc.p(iter_6_1, iter_6_0))
			local var_6_5 = self._roomDic[iter_6_1 .. "_" .. iter_6_0]

			if not self._roomDic[iter_6_1 .. "_" .. iter_6_0] then
				var_6_5 = var_6_4 and fgui.UIPackage:createObject("exploration", "ExplorationRoomMiniComp") or fgui.UIPackage:createObject("exploration", "ExplorationRoomMiniCompNone")
				self._roomDic[iter_6_1 .. "_" .. iter_6_0] = var_6_5

				local var_6_6 = var_6_5:getSize()

				self.m_roomRootNode:addChild(var_6_5)
				var_6_5:setPosition(cc.p(var_6_3.x + (iter_6_1 - iter_6_0) * var_6_6.width / 2, var_6_3.y + (iter_6_1 + iter_6_0 - 2) * var_6_6.height / 2))
			end

			local var_6_7 = var_6_1.x == iter_6_1 and var_6_1.y == iter_6_0
			local var_6_8 = var_6_2.x == iter_6_1 and var_6_2.y == iter_6_0

			var_6_5:setEffectEnable(self._roomEffectEnable)
			var_6_5:updateMiniComp(var_6_4, var_6_7, var_6_8)
		end
	end

	local var_6_9 = self._roomDic["1_1"]:getSize()
	local var_6_10 = cc.size(0, 0)

	var_6_10.width = self._roomDic[arg_6_1 .. "_1"]:getPosition().x - self._roomDic["1_" .. arg_6_2]:getPosition().x + var_6_9.width
	var_6_10.height = self._roomDic[arg_6_1 .. "_" .. arg_6_2]:getPosition().y - self._roomDic["1_1"]:getPosition().y + var_6_9.height

	local var_6_11 = self:getSize()
	local var_6_12 = self:getScale()

	self._moveRange.x = (var_6_11.width - var_6_10.width - var_6_9.width / 2) * var_6_12.x
	self._moveRange.y = (var_6_11.height - var_6_10.height - var_6_9.height / 2) * var_6_12.y
	self._moveRange.width = (var_6_10.width + var_6_9.width - var_6_11.width) * var_6_12.x
	self._moveRange.height = (var_6_10.height + var_6_9.height - var_6_11.height) * var_6_12.y
end

function ExplorationMiniRoomMapComp:getMoveRange()
	return self._moveRange
end

function ExplorationMiniRoomMapComp:_onTouchBegin(arg_8_1)
	if not self.m_roomRootNode:isTouchable() then
		return
	end

	self._touchPos = arg_8_1:getInput():getPosition()

	arg_8_1:captureTouch()
end

function ExplorationMiniRoomMapComp:_onTouchMove(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()
	local var_9_1 = cc.pAdd(self.m_roomRootNode:getPosition(), (cc.pSub(var_9_0, self._touchPos)))
	local KsMath = require("app.core.utils.KsMath")

	var_9_1.x = KsMath.rangeIn(var_9_1.x, self._moveRange.x, self._moveRange.x + self._moveRange.width)
	var_9_1.y = KsMath.rangeIn(var_9_1.y, self._moveRange.y, self._moveRange.y + self._moveRange.height)

	self.m_roomRootNode:setPosition(var_9_1)

	self._touchPos = var_9_0

	if self._followFunc then
		self._followFunc(var_9_1)
	end
end

function ExplorationMiniRoomMapComp:_onTouchEnd()
	self._localTouchPos = nil
	self._moveDistance = 0
end

return ExplorationMiniRoomMapComp
