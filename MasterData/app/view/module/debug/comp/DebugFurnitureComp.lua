local var_0_0 = g.core.config.furniture_info
local DebugConst = require("app.view.module.debug.const.DebugConst")
local FurnitureRoomGird = require("app.view.module.furniture.view.sub.FurnitureRoomGird")
local var_0_3 = g.core.const.ConstMgr.FurnitureConst
local DebugFurnitureComp = class("DebugFurnitureComp", require("app.fairyGUI.debug.UI_DebugFurnitureComp"))

function DebugFurnitureComp:ctor()
	self._info = nil
	self._actionName = "walk"
	self._showAction = false
	self._initHolderPos = {
		x = 0,
		y = 0
	}
	self._initActorPos = {
		x = 0,
		y = 0
	}
	self._scale = 0.5
	self._hGrid = var_0_3.FURNITURE_GROUND_H_GRID
	self._wGrid = var_0_3.FURNITURE_GROUND_W_GRID

	self:_initView()
	self:resetGroundGird(10, 10)
end

function DebugFurnitureComp:onLoad()
	self._initTouchPos = self.m_touchPos:getPosition()

	self:resetFurniturePos()
end

function DebugFurnitureComp:onUnload()
	var_0_3.FURNITURE_GROUND_H_GRID = self._hGrid
	var_0_3.FURNITURE_GROUND_W_GRID = self._wGrid
end

function DebugFurnitureComp:_initView()
	self.m_searchInfoComp:updatePaths("furnitureInfo")
	self.m_searchActorComp:updatePaths("actorInfo")
	self.m_gridComp:setScale(self._scale)
	self.m_gridCoverComp:setScale(self._scale)
	self.m_furnitureCell:setScale(self._scale)
	self:addListen(self.m_searchInfoComp)
	self:addListen(self.m_searchActorComp)
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_xMinBtn:addClickListener(handler(self, self._onxMinClick))
	self.m_xAddBtn:addClickListener(handler(self, self._onxAddClick))
	self.m_yMinBtn:addClickListener(handler(self, self._onyMinClick))
	self.m_yAddBtn:addClickListener(handler(self, self._onyAddClick))
	self.m_borderEnsureBtn:addClickListener(handler(self, self._onBorderClick))
	self.m_isRotateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRotateSelChanged))
	self.m_actionShowController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onActionShowSelChanged))
end

function DebugFurnitureComp:resetGroundGird(arg_5_1, arg_5_2)
	if self._ground then
		self._ground:removeFromParent()
		self._ground2:removeFromParent()
	end

	var_0_3.DEBUG_GRID_COLORF = cc.c4f(0.15, 0.9, 0.9, 1)
	self._ground = FurnitureRoomGird.new(self, true, arg_5_1, arg_5_2, 0)

	self.m_gridComp:addNode(self._ground)

	var_0_3.DEBUG_GRID_COLORF = cc.c4f(0.8980392156862745, 0.1803921568627451, 0.1803921568627451, 0.8)
	self._ground2 = FurnitureRoomGird.new(self, true, arg_5_1, arg_5_2, 0)

	self.m_gridCoverComp:addNode(self._ground2)
end

function DebugFurnitureComp:updateFurnitureImg(arg_6_1)
	self._info = var_0_0.get(arg_6_1)

	local var_6_0 = string.match(self._info.res, "jiayuan_")

	self._initHolderPos = {
		x = self._info.x,
		y = self._info.y
	}
	self._initActorPos = {
		x = self._info.x2,
		y = self._info.y2 + DebugConst.FURNITURE_ROLE_OFF_Y
	}
	self._actionName = "walk"

	if self._info.probability > 0 then
		if self._info.type == 5 then
			self._actionName = "sleep"
		elseif self._info.type == 6 then
			self._actionName = "sit"
		elseif self._info.type == 7 then
			self._actionName = "bathe"
		end
	end

	self.m_nameText:setText("家具名称：" .. self._info.name)
	self.m_typeText:setText("家具类型：" .. ({
		"地面&墙面",
		"装饰",
		"家具"
	})[self._info.basal_type])
	self.m_gridText:setText("所占格子：" .. self._info.length .. "x" .. self._info.width .. "x" .. self._info.height)
	self.m_cfgPosText:setText("表中偏移：" .. self._info.x .. "x" .. self._info.y)
	self.m_spineBorderText:setText("spine包围：" .. self._info.spine_width .. "x" .. self._info.spine_height)
	self.m_actorPosText:setText("小人偏移：" .. self._info.x2 .. "x" .. self._info.y2)
	self.m_srcNameText:setText("资源名称：" .. self._info.res .. (var_6_0 and ".atals" or ".png"))
	self.m_srcTypeText:setText("资源类型：" .. (var_6_0 and "spine" or "图片"))
	self.m_isRotateController:setSelectedIndex(0)
	self.m_actionShowController:setSelectedIndex(0)
	self.m_furnitureCell:updateURL(self._info.res, var_6_0)
	self.m_furnitureCell:setActionShowIndex(0)
	self.m_furnitureCell:setSpineBorder(self._info.spine_width, self._info.spine_height)
	self.m_borderGroup:setVisible(var_6_0 and true or false)
	self.m_insertBorderWidth:setText(self._info.spine_width)
	self.m_insertBorderHeight:setText(self._info.spine_height)
	self:resetGroundGird(self._info.length, self._info.width)
	self:resetFurniturePos()
end

function DebugFurnitureComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		if arg_7_2 == "furnitureInfo" then
			local var_7_0, var_7_1 = self.m_searchInfoComp:getShowText()

			if var_7_0 then
				self:updateFurnitureImg(var_7_1)
			end
		elseif arg_7_2 == "actorInfo" then
			local var_7_2, var_7_3 = self.m_searchActorComp:getShowText()

			if var_7_2 then
				self.m_furnitureCell:updateMainKnight(var_7_3, self._actionName)
			end
		end
	end
end

function DebugFurnitureComp:_onTouchBegin(arg_8_1)
	arg_8_1:captureTouch()

	local var_8_0 = arg_8_1:getInput():getPosition()

	self._curTouchX = var_8_0.x
	self._curTouchY = var_8_0.y
end

function DebugFurnitureComp:_onTouchMove(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()
	local var_9_1, var_9_2 = self:getMovePosByLength(var_9_0.x - self._curTouchX, var_9_0.y - self._curTouchY)

	self.m_touchPos:setPosition(self._initTouchPos.x + var_9_1, self._initTouchPos.y + var_9_2)

	local var_9_3

	if self._showAction then
		var_9_3 = self._initActorPos or self._initHolderPos
	end

	local var_9_4 = math.floor(var_9_3.x + var_9_1 * DebugConst.MOVE_FURNITURE_GAP)
	local var_9_5 = math.floor(var_9_3.y + var_9_2 * DebugConst.MOVE_FURNITURE_GAP)

	self.m_furnitureCell:setPosition(var_9_4, var_9_5, self._showAction)
	self.m_posText:setText(var_9_4 - var_9_3.x .. "," .. var_9_5 - var_9_3.y)
end

function DebugFurnitureComp:_onTouchEnd(arg_10_1)
	local var_10_0 = arg_10_1:getInput():getPosition()

	if var_10_0.x - self._curTouchX == 0 and var_10_0.y - self._curTouchY == 0 then
		self:resetFurniturePos()
	end
end

function DebugFurnitureComp:resetFurniturePos()
	local var_11_0

	if self._showAction then
		var_11_0 = self._initActorPos or self._initHolderPos
	end

	self.m_touchPos:setPosition(self._initTouchPos.x, self._initTouchPos.y)
	self.m_furnitureCell:setPosition(var_11_0.x, var_11_0.y, self._showAction)
	self.m_posText:setText("0,0")
end

function DebugFurnitureComp:getMovePosByLength(arg_12_1, arg_12_2)
	local var_12_0 = math.sqrt(arg_12_1 * arg_12_1 + arg_12_2 * arg_12_2)

	if var_12_0 > DebugConst.MOVE_FURNITURE_TOUCH_MAX then
		arg_12_1 = arg_12_1 * DebugConst.MOVE_FURNITURE_TOUCH_MAX / var_12_0
		arg_12_2 = arg_12_2 * DebugConst.MOVE_FURNITURE_TOUCH_MAX / var_12_0
	end

	return arg_12_1, arg_12_2
end

function DebugFurnitureComp:_onRotateSelChanged()
	if self.m_isRotateController:getSelectedIndex() == 1 then
		self.m_furnitureCell:setScaleX(-self._scale)
		self:resetGroundGird(self._info.width, self._info.length)
	else
		self.m_furnitureCell:setScaleX(self._scale)
		self:resetGroundGird(self._info.length, self._info.width)
	end
end

function DebugFurnitureComp:_onActionShowSelChanged()
	self._showAction = false

	if self._actionName == "walk" then
		self.m_actionShowController:setSelectedIndex(0)
		self.m_furnitureCell:setActionShowIndex(0)
		g.core.module.ModuleManager:tip("该家具没有对应动作")

		return
	end

	if not self.m_furnitureCell:hasActor() then
		self.m_actionShowController:setSelectedIndex(0)
		self.m_furnitureCell:setActionShowIndex(0)
		g.core.module.ModuleManager:tip("请先选择小人")

		return
	end

	local var_14_0 = self.m_actionShowController:getSelectedIndex()

	self._showAction = var_14_0 == 1

	if self._showAction then
		self.m_furnitureCell:setAnimation(self._actionName)
		self:resetFurniturePos()
	end

	self.m_furnitureCell:setActionShowIndex(var_14_0)
end

function DebugFurnitureComp:_onxMinClick()
	self:updateFurniturePos(-DebugConst.MOVE_X_STEP, 0)
end

function DebugFurnitureComp:_onxAddClick()
	self:updateFurniturePos(DebugConst.MOVE_X_STEP, 0)
end

function DebugFurnitureComp:_onyMinClick()
	self:updateFurniturePos(0, DebugConst.MOVE_Y_STEP)
end

function DebugFurnitureComp:_onyAddClick()
	self:updateFurniturePos(0, -DebugConst.MOVE_Y_STEP)
end

function DebugFurnitureComp:_onBorderClick()
	self.m_furnitureCell:setSpineBorder(tonumber(self.m_insertBorderWidth:getText()) or 0, tonumber(self.m_insertBorderHeight:getText()) or 0)
end

function DebugFurnitureComp:updateFurniturePos(arg_20_1, arg_20_2)
	local var_20_0 = self.m_furnitureCell:getPosition(self._showAction)
	local var_20_1 = var_20_0.x + arg_20_1
	local var_20_2 = var_20_0.y + arg_20_2
	local var_20_3

	if self._showAction then
		var_20_3 = self._initActorPos or self._initHolderPos
	end

	local var_20_4 = var_20_1 - var_20_3.x

	self.m_furnitureCell:setPosition(var_20_1, var_20_2, self._showAction)
	self.m_posText:setText(var_20_4 .. "," .. var_20_2 - var_20_3.y)
	self.m_touchPos:setPosition(self._initTouchPos.x + var_20_4 / DebugConst.MOVE_FURNITURE_GAP, self._initTouchPos.y + (var_20_2 - var_20_3.y) / DebugConst.MOVE_FURNITURE_GAP)
end

return DebugFurnitureComp
