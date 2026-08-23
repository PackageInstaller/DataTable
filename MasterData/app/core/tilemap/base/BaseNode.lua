local BaseNode = class("BaseNode", function()
	return cc.Node:create()
end)
local var_0_1 = 5

function BaseNode:p2s(arg_2_1)
	return self .. "_" .. arg_2_1
end

function BaseNode:ctor(arg_3_1, arg_3_2)
	self:enableNodeEvents(true)

	self._nClickTouchX = 0
	self._nClickTouchY = 0
	self._listRect = {}
	self._scale = 1
	self._map = arg_3_1
	self._mapComp = arg_3_2
	self._data = nil
	self._deltaDt = 0
	self._speed = 3
	self._speedTime = 1 / self._speed
	self._isRunning = false

	self:_initFGui()
	self._map:insertBaseNode(self)
end

function BaseNode:createNewSprite(arg_4_1)
	return display.newSprite(arg_4_1)
end

function BaseNode:_initFGui()
	return
end

function BaseNode:getScaleX()
	return self._scale
end

function BaseNode:isRunning()
	return self._isRunning
end

function BaseNode:setBaseData(arg_8_1)
	self._pos = cc.p(arg_8_1.posX or 0, arg_8_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self:_calcButtonRect()
end

function BaseNode:clickEffect()
	return
end

function BaseNode:setData(arg_10_1)
	self._data = arg_10_1
end

function BaseNode:getData()
	return self._data
end

function BaseNode:getPos()
	return self._pos
end

function BaseNode:getUINode()
	return self._uiNode
end

function BaseNode:_initButtonData(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}
	local var_14_1 = arg_14_1:getChild(arg_14_2)

	var_14_0.scaleX = var_14_1:getScaleX()
	var_14_0.scaleY = var_14_1:getScaleY()
	var_14_0.pos = cc.p(var_14_1:getX() - arg_14_1:getSize().width / 2, arg_14_1:getSize().height / 2 - var_14_1:getY())
	var_14_0.size = cc.size(var_14_1:getSize().width * var_14_1:getScaleX(), var_14_1:getSize().height * var_14_1:getScaleY())
	var_14_0.clickListener = arg_14_3

	local var_14_2 = var_14_1:displayObject()

	var_14_0.btn = var_14_2

	table.insert(self._listRect, var_14_0)

	return var_14_2
end

function BaseNode:_initCompTextData(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_2:getChild(arg_15_3)

	return (require("app.core.tilemap.TileMapFunc").convertText(arg_15_2, arg_15_3, arg_15_4))
end

function BaseNode:_initCompBtnData(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_2:getChild(arg_16_3)
	local var_16_1 = {
		scaleX = var_16_0:getScaleX(),
		scaleY = var_16_0:getScaleY(),
		pos = cc.p(var_16_0:getX() + arg_16_2:getX() - arg_16_2:getSize().width / 2 - arg_16_1:getSize().width / 2, arg_16_1:getSize().height - arg_16_2:getY() - (var_16_0:getY() - arg_16_2:getSize().height / 2) - arg_16_1:getSize().height / 2),
		size = cc.size(var_16_0:getSize().width * var_16_0:getScaleX(), var_16_0:getSize().height * var_16_0:getScaleY()),
		clickListener = arg_16_4
	}
	local var_16_2 = var_16_0:displayObject()

	var_16_1.btn = var_16_2

	table.insert(self._listRect, var_16_1)

	return var_16_2
end

function BaseNode:_initCompData(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
	local var_17_0 = arg_17_1:getChild(arg_17_2)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_3) do
		local var_17_2 = self:_initCompBtnData(arg_17_1, var_17_0, iter_17_1.btnName, iter_17_1.clickListener)

		var_17_2:setName(iter_17_1.btnName)

		var_17_2.originPos = {
			x = var_17_2:getPositionX(),
			y = var_17_2:getPositionY()
		}
		var_17_1[iter_17_1.btnName] = var_17_2
	end

	local var_17_3 = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_4) do
		local var_17_4 = self:_initCompTextData(arg_17_1, var_17_0, iter_17_3.txtName, iter_17_3.isOutline)

		var_17_4:setName(iter_17_3.txtName)

		var_17_4.originPos = {
			x = var_17_4:getPositionX(),
			y = var_17_4:getPositionY()
		}
		var_17_3[iter_17_3.txtName] = var_17_4
	end

	local var_17_5 = {}

	for iter_17_4, iter_17_5 in ipairs(arg_17_5) do
		local var_17_6 = require("app.core.tilemap.TileMapFunc"):convertNode(iter_17_5.nodeName)

		var_17_6:setName(iter_17_5.nodeName)

		var_17_6.originPos = {
			x = var_17_6:getPositionX(),
			y = var_17_6:getPositionY()
		}
		var_17_5[iter_17_5.nodeName] = var_17_6
	end

	local var_17_7 = self:_initButtonData(arg_17_1, arg_17_2, arg_17_6)

	var_17_7.originPos = {
		x = var_17_7:getPositionX(),
		y = var_17_7:getPositionY()
	}

	return var_17_7, var_17_1, var_17_3, var_17_5
end

function BaseNode:_calcButtonRect()
	for iter_18_0, iter_18_1 in ipairs(self._listRect) do
		local var_18_0 = self:convertToWorldSpace(iter_18_1.pos)

		iter_18_1.rect = cc.rect(var_18_0.x + iter_18_1.size.width * (1 - self._scale) / 2 - iter_18_1.size.width / 2, var_18_0.y + iter_18_1.size.height * (1 - self._scale) / 2 - iter_18_1.size.height / 2, iter_18_1.size.width * self._scale, iter_18_1.size.height * self._scale)
	end
end

function BaseNode:_isClickButtonStart(arg_19_1, arg_19_2)
	local var_19_0 = false

	for iter_19_0, iter_19_1 in ipairs(self._listRect) do
		if iter_19_1.btn and iter_19_1.btn:isVisible() and cc.rectContainsPoint(iter_19_1.rect, cc.p(arg_19_1, arg_19_2)) then
			var_19_0 = true

			if iter_19_1.clickListener then
				iter_19_1.btn:setScaleX(iter_19_1.scaleX + 0.1)
				iter_19_1.btn:setScaleY(iter_19_1.scaleY + 0.1)

				break
			end
		end
	end

	return var_19_0
end

function BaseNode:_isClickButtonBegin(arg_20_1, arg_20_2)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in ipairs(self._listRect) do
		if iter_20_1.btn and iter_20_1.btn:isVisible() then
			iter_20_1.btn:setScaleX(iter_20_1.scaleX)
			iter_20_1.btn:setScaleY(iter_20_1.scaleY)

			if cc.rectContainsPoint(iter_20_1.rect, cc.p(arg_20_1, arg_20_2)) then
				if iter_20_1.clickListener then
					var_20_0 = true
				end

				do break end
				break
			end
		end
	end

	return var_20_0
end

function BaseNode:_isClickButtonEnd(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = false

	for iter_21_0, iter_21_1 in ipairs(self._listRect) do
		if iter_21_1.btn and iter_21_1.btn:isVisible() then
			iter_21_1.btn:setScaleX(iter_21_1.scaleX)
			iter_21_1.btn:setScaleY(iter_21_1.scaleY)

			if cc.rectContainsPoint(iter_21_1.rect, cc.p(arg_21_1, arg_21_2)) and arg_21_3 and iter_21_1.clickListener then
				var_21_0 = true

				iter_21_1.clickListener()

				break
			end
		end
	end

	return var_21_0
end

function BaseNode:setCustomScale(arg_22_1)
	self._scale = arg_22_1

	self:_calcButtonRect()
end

function BaseNode:setCustomVisible(arg_23_1)
	self:setVisible(arg_23_1)

	if not tolua.isnull(self._cocosNode) then
		self._cocosNode:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._sprSelect) then
		self._sprSelect:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._uiNode) then
		self._uiNode:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._clickUI) then
		self._clickUI:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._textNode) then
		self._textNode:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._topEffectNode) then
		self._topEffectNode:setVisible(arg_23_1)
	end

	if not tolua.isnull(self._footEffectNode) then
		self._footEffectNode:setVisible(arg_23_1)
	end
end

function BaseNode:setSprSelectVisible(arg_24_1)
	if not tolua.isnull(self._sprSelect) then
		self._sprSelect:setVisible(arg_24_1)
	end
end

function BaseNode:onTouchBegin(arg_25_1, arg_25_2)
	if not self:isVisible() then
		return false
	end

	self._nClickTouchX, self._nClickTouchY = arg_25_1, arg_25_2

	self:_calcButtonRect()

	return self:_isClickButtonBegin(arg_25_1, arg_25_2)
end

function BaseNode:onTouchEnd(arg_26_1, arg_26_2)
	if not self:isVisible() then
		return false
	end

	self:_calcButtonRect()

	if math.abs(self._nClickTouchX - arg_26_1) <= var_0_1 and math.abs(self._nClickTouchY - arg_26_2) <= var_0_1 then
		return self:_isClickButtonEnd(arg_26_1, arg_26_2, true)
	end

	return self:_isClickButtonEnd(arg_26_1, arg_26_2, false)
end

function BaseNode:destory()
	if not tolua.isnull(self._map) then
		self._map:removeBaseNode(self)
	end

	if not tolua.isnull(self._uiNode) then
		if self._uiNode.destory then
			self._uiNode:destory()
		else
			self._uiNode:removeFromParent()
		end
	end

	if not tolua.isnull(self._clickUI) then
		if self._clickUI.destory then
			self._clickUI:destory()
		else
			self._clickUI:removeFromParent()
		end
	end

	if not tolua.isnull(self._textNode) then
		if self._textNode.destory then
			self._textNode:destory()
		else
			self._textNode:removeFromParent()
		end
	end

	if not tolua.isnull(self._spineNode) then
		if self._spineNode.destory then
			self._spineNode:destory()
		else
			self._spineNode:removeFromParent()
		end
	end

	if not tolua.isnull(self._sprSelect) then
		self._sprSelect:removeFromParent()
	end

	if not tolua.isnull(self._cocosNode) then
		self._cocosNode:removeFromParent()
	end

	if not tolua.isnull(self) then
		self:removeFromParent()
	end
end

function BaseNode:setRealPos(arg_28_1, arg_28_2)
	local var_28_0, var_28_1 = require("app.core.tilemap.TileMapFunc").rc2p(arg_28_1, arg_28_2)

	self:setLocalZOrder(10000)
	self:setBaseData({
		posX = var_28_0,
		posY = var_28_1
	})

	self._mapPos = cc.p(arg_28_1, arg_28_2)
	self._currentMapPos = self._mapPos
end

function BaseNode:getCurRealPos()
	return self._currentMapPos or cc.p(0, 0)
end

function BaseNode:playRunAction()
	if self._knight then
		self._knight:cleanActionCallback()
		self._knight:playAction("run")
	end
end

function BaseNode:playReadyAction()
	if self._knight then
		self._knight:cleanActionCallback()
		self._knight:playAction("ready")
	end
end

function BaseNode:playAttackAction(arg_32_1)
	if self._knight then
		self._knight:cleanActionCallback()
		self._knight:playAction("attack_start_1", handler(self, function(arg_33_0)
			arg_33_0:playReadyAction()

			if arg_32_1 then
				arg_32_1()
			end
		end))
	end
end

function BaseNode:updatePath(arg_34_1, arg_34_2)
	self._path = {}
	self._moveDelta = cc.p(0, 0)

	if arg_34_1 and #arg_34_1 > 1 then
		if arg_34_2 and arg_34_2 < 0 then
			g.core.log:info("BaseNode:updatePath hasGoneTime = " .. arg_34_2)

			arg_34_2 = 0
		end

		if arg_34_2 and arg_34_2 >= 0 then
			if arg_34_2 >= (#arg_34_1 - 1) / self._speed then
				self._isRunning = false

				self:setRealPos(arg_34_1[#arg_34_1].pos.x, arg_34_1[#arg_34_1].pos.y)
				self:_removePath(arg_34_1, #arg_34_1)
				self:playReadyAction()
				self._map:eventHandler("node_move_end", {
					data = self._data,
					cell = self
				})

				return
			else
				self:_removePath(arg_34_1, (math.floor(arg_34_2 * self._speed)))

				if #arg_34_1 > 0 and arg_34_1[1].pos then
					self:setRealPos(arg_34_1[1].pos.x, arg_34_1[1].pos.y)
				end

				if #arg_34_1 > 0 then
					self._moveDelta = cc.p(arg_34_1[1].pos.x - self._mapPos.x, arg_34_1[1].pos.y - self._mapPos.y)

					self:_changeFace(self._moveDelta)

					self._deltaDt = self._deltaDt + arg_34_2 % self._speed

					if self._deltaDt > self._speedTime then
						self._deltaDt = self._speedTime or self._deltaDt
					end

					local var_34_0 = cc.p(self._moveDelta.x * self._deltaDt * self._speed, self._moveDelta.y * self._deltaDt * self._speed)
					local var_34_1 = cc.p(self._mapPos.x + var_34_0.x, self._mapPos.y + var_34_0.y)

					self._curSprLine = arg_34_1[1].line

					self:_setRolePosition(var_34_1.x, var_34_1.y)
				end
			end
		end

		self._path = arg_34_1
	end

	if next(self._path) then
		if not arg_34_2 or arg_34_2 < 0 then
			self._moveDelta = cc.p(0, 0)
		end

		self._isRunning = true

		self:playRunAction()

		self._lastMoveTime = cc.utils.gettime() / 1000
		self._beginTestTime = g.core.common.ServerTime:getTime()
	end
end

function BaseNode:_removePath(arg_35_1, arg_35_2)
	if arg_35_2 <= 0 then
		return
	end

	if arg_35_2 > #arg_35_1 then
		arg_35_2 = #arg_35_1
	end

	local var_35_0 = 0

	while var_35_0 ~= arg_35_2 do
		if arg_35_1[1].dot then
			arg_35_1[1].dot:removeFromParent()
		end

		if arg_35_1[1].line then
			arg_35_1[1].line:removeFromParent()
		end

		table.remove(arg_35_1, 1)

		var_35_0 = var_35_0 + 1
	end
end

function BaseNode:update(arg_36_1)
	return
end

function BaseNode:_updateMove()
	self._lastMoveTime = cc.utils.gettime() / 1000
	self._deltaDt = self._deltaDt + (cc.utils.gettime() / 1000 - self._lastMoveTime)

	if self._deltaDt > self._speedTime then
		self._deltaDt = self._speedTime or self._deltaDt
	end

	local var_37_0 = cc.p(self._moveDelta.x * self._deltaDt * self._speed, self._moveDelta.y * self._deltaDt * self._speed)
	local var_37_1 = cc.p(self._mapPos.x + var_37_0.x, self._mapPos.y + var_37_0.y)
	local var_37_2 = math.abs(self._moveDelta.x)
	local var_37_3 = math.abs(self._moveDelta.y)
	local var_37_4 = math.ceil(math.abs(var_37_0.x) * 10)

	if not self._isMoveBorder and (tostring((math.floor(math.abs(var_37_0.x) * 10))) == tostring(var_37_2 * 10 - (var_37_2 > 0 and 5 or 0)) or tostring(var_37_4) == tostring(var_37_2 * 10 - (var_37_2 > 0 and 5 or 0))) and (tostring((math.floor(math.abs(var_37_0.y) * 10))) == tostring(var_37_3 * 10 - (var_37_3 > 0 and 5 or 0)) or tostring((math.ceil(math.abs(var_37_0.y) * 10))) == tostring(var_37_3 * 10 - (var_37_3 > 0 and 5 or 0))) then
		self._isMoveBorder = true

		local var_37_8 = self._moveDelta.x < 0 and math.floor(var_37_1.x) or math.ceil(var_37_1.x)
		local var_37_9 = self._moveDelta.y < 0 and math.floor(var_37_1.y) or math.ceil(var_37_1.y)

		self._map:eventHandler("map_border", {
			mapPos = cc.p(var_37_8, var_37_9)
		})
	end

	self._currentMapPos = var_37_1

	self._map:eventHandler("node_update_move", {
		realPos = var_37_1,
		data = self._data
	})
	self:_setRolePosition(var_37_1.x, var_37_1.y)

	if tostring(var_37_0.x) == tostring(self._moveDelta.x) and tostring(var_37_0.y) == tostring(self._moveDelta.y) then
		self._isMoveBorder = false
		self._deltaDt = 0
		self._mapPos = var_37_1
		self._currentMapPos = var_37_1

		if self._path[1].dot then
			self._path[1].dot:removeFromParent()
		end

		if not tolua.isnull(self._curSprLine) then
			self._curSprLine:removeFromParent()

			self._curSprLine = nil
		end

		table.remove(self._path, 1)

		if next(self._path) then
			self._moveDelta = cc.p(self._path[1].pos.x - self._mapPos.x, self._path[1].pos.y - self._mapPos.y)

			self:_changeFace(self._moveDelta)

			self._curSprLine = self._path[1].line

			self._map:eventHandler("node_move_pos", {
				realPos = var_37_1,
				data = self._data
			})
		else
			self._isRunning = false

			self:playReadyAction()
			self:_removeSelf()
			self._map:eventHandler("node_move_end", {
				data = self._data,
				cell = self
			})
		end
	end
end

function BaseNode:_removeSelf()
	return
end

function BaseNode:_setRolePosition(arg_39_1, arg_39_2)
	local var_39_0, var_39_1 = self:getPosition()
	local var_39_2, var_39_3 = require("app.core.tilemap.TileMapFunc").rc2p(arg_39_1, arg_39_2)

	if not tolua.isnull(self._curSprLine) then
		self._curSprLine:setContentSize(self._curSprLine:getContentSize().width - math.sqrt(math.pow(math.abs(var_39_0 - var_39_2), 2) + math.pow(math.abs(var_39_1 - var_39_3), 2)), self._curSprLine:getContentSize().height)
	end

	self:setBaseData({
		posX = var_39_2,
		posY = var_39_3
	})
end

function BaseNode:_changeFace(arg_40_1)
	local var_40_0 = 0
	local var_40_1 = 1

	if arg_40_1.x > 0 then
		var_40_1 = -1
	elseif arg_40_1.x < 0 then
		var_40_1 = 1
		var_40_0 = 30
	elseif arg_40_1.y > 0 then
		var_40_1 = 1
	else
		var_40_1 = -1
		var_40_0 = 30
	end

	if self._knight then
		self._knight:setScaleX(-var_40_1)
	end

	if self._lastResIdx ~= var_40_0 then
		self:playRunAction()

		self._lastResIdx = var_40_0
	end
end

return BaseNode
