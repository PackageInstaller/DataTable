local NewSlgChariotNode = class("NewSlgChariotNode", require("app.core.tilemap.base.BaseMoveNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_4 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_5 = g.core.model.User.newSlgData

function NewSlgChariotNode:ctor(arg_1_1, arg_1_2)
	NewSlgChariotNode.super.ctor(self, arg_1_1, arg_1_2)

	self._speed = 0.01
	self._speedTime = 1 / self._speed
end

function NewSlgChariotNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()
	self._spineNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)
	self._map._topEffectNode:addChild(self._spineNode)

	self._chariotPathNode = cc.Node:create()

	self._map._chariotPathNode:addChild(self._chariotPathNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgChariotNode", self)

	self._imgBg = TileMapFunc.convertNode(var_2_0, "Img_bg", true)
	self._mineBg = TileMapFunc.convertNode(var_2_0, "mineBg", true)
	self._otherBg = TileMapFunc.convertNode(var_2_0, "otherBg", true)
	self._imgFvIcon = TileMapFunc.convertNode(var_2_0, "Img_fvIcon", true)
	self._imgTroopIcon = TileMapFunc.convertNode(var_2_0, "Img_troopIcon", true)
	self._imgCountDownBg = TileMapFunc.convertNode(var_2_0, "Img_countDownBg", true)
	self._barCountDown = TileMapFunc.convertNode(var_2_0, "Bar_countDown", true)
	self._stateDi1 = TileMapFunc.convertNode(var_2_0, "stateDi1", true)
	self._stateDi2 = TileMapFunc.convertNode(var_2_0, "stateDi2", true)
	self._barWidth = self._barCountDown:getContentSize().width
	self._txtTroop = TileMapFunc.convertText(var_2_0, "Txt_troop")
	self._stateTxt = TileMapFunc.convertText(var_2_0, "stateTxt")
	self._txtFv = TileMapFunc.convertText(var_2_0, "Txt_fv")
	self._txtTime = TileMapFunc.convertText(var_2_0, "Txt_time", true)

	self._stateDi1:setVisible(false)
	self._stateDi2:setVisible(false)
	self._stateTxt:setVisible(false)
	self._uiNode:addChild(self._imgBg)
	self._uiNode:addChild(self._mineBg)
	self._uiNode:addChild(self._otherBg)
	self._uiNode:addChild(self._imgFvIcon)
	self._uiNode:addChild(self._imgTroopIcon)
	self._uiNode:addChild(self._imgCountDownBg)
	self._uiNode:addChild(self._barCountDown)
	self._textNode:addChild(self._stateDi1)
	self._textNode:addChild(self._stateDi2)
	self._textNode:addChild(self._txtTroop)
	self._textNode:addChild(self._txtFv)
	self._textNode:addChild(self._txtTime)
	self._textNode:addChild(self._stateTxt, 99999)
	self._mineBg:setVisible(false)
	self._otherBg:setVisible(false)
end

function NewSlgChariotNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self._uiNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self._textNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self._spineNode:setPosition(self._pos.x, self._pos.y)
	self:_calcButtonRect()
end

function NewSlgChariotNode:_updateRes(arg_4_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(arg_4_1))

		self._sprite:setAnchorPoint(0.5, 0)
		self._sprite:setPosition(10, -var_0_3 / 2 + 10)
		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgBuilding(arg_4_1))
	end
end

function NewSlgChariotNode:_findPath()
	g.core.model.User.newSlgData.isChariotFindPath = true

	local var_5_0 = self._map:getPath(g.core.model.User.newSlgData:getNearPos(self._value, self._value2), (cc.p(self._componentCfg.anchor_x, self._componentCfg.anchor_y)))

	g.core.model.User.newSlgData.isChariotFindPath = false

	self._map:drawPath({
		var_5_0[#var_5_0 - 1],
		var_5_0[#var_5_0]
	}, true, self._chariotPathNode)
	table.remove(var_5_0, #var_5_0)

	if var_5_0 and #var_5_0 > 1 then
		self._speed = #var_5_0 / g.core.model.User.newSlgData:getChariotMoveTotalTime()
		self._speedTime = 1 / self._speed
	end

	return var_5_0
end

function NewSlgChariotNode:setData(arg_6_1)
	self:setBaseData(arg_6_1)
	self:_removeChariotMoveEffect()
	self._chariotPathNode:removeAllChildren()

	self._data = arg_6_1
	self._objectData = arg_6_1.objectData
	self._componentCfg = var_0_5:getComponentCfg(self._objectData.id)
	self._value = self._componentCfg.value
	self._value2 = self._objectData.value2
	self._cityCfg = var_0_5:getCityInfoById(self._value)
	self._serData = var_0_5:getCitySerData(self._value)

	local var_6_0 = var_0_5:getChariotShowState(self._value, self._value2)

	if var_6_0 == var_0_2.Slg2ChariotShowState.gather then
		self:setCustomVisible(true)
	elseif var_6_0 == var_0_2.Slg2ChariotShowState.move then
		self:setCustomVisible(true)

		local var_6_1 = self:_findPath()

		if var_6_1 and #var_6_1 > 1 then
			self:updatePath(self._map:drawPath(var_6_1, true, self._chariotPathNode), g.core.common.ServerTime:getTime() - var_0_5:getChariotMoveTimeStartTime())
			self:_addChariotMoveEffect()
		end
	else
		self:setCustomVisible(false)
	end

	if self:isVisible() then
		if self._resId ~= arg_6_1.resId then
			self:_updateRes(arg_6_1.resId)
		end

		self._resId = arg_6_1.resId

		self:_updateView()
	end
end

function NewSlgChariotNode:_removeChariotMoveEffect()
	if self._moveEffect then
		self._moveEffect:setVisible(false)
	end
end

function NewSlgChariotNode:_addChariotMoveEffect()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Gem_Click)

	if self._moveEffect then
		self._moveEffect:setVisible(true)

		return
	end

	local var_8_0 = require("app.view.common.SpineBase").new({
		anim = "play",
		isLoop = true,
		resId = self._data.resId,
		path = g.core.common.Path:getEffSpine(self._data.resId)
	})

	;(nil):setPosition(0, 25)
	self:addChild(var_8_0)

	self._moveEffect = var_8_0
end

function NewSlgChariotNode:_updateView()
	self:_updateTroopNum()
	self:_updateFV()
end

function NewSlgChariotNode:_updateTroopNum()
	local var_10_0 = g.core.model.User.newSlgData:getChariotGatherNum(self._value, self._value2)
	local var_10_1 = g.core.model.User.newSlgData:getChariotBelongAlliance(self._value, self._value2)
	local var_10_2

	if var_10_1 and var_10_1 == g.core.model.User.allianceData:getAllianceId() and g.core.model.User.newSlgData:isCityAssisted(self._value) then
		var_10_0 = var_10_0 + g.core.model.User.newSlgData:getAssistTroopNum(self._value)
		var_10_2 = {
			num1 = var_10_0
		}
	end

	var_10_2.num2 = g.core.model.User.newSlgData:getChariotGatherMaxNum(self._value, self._value2)

	self._txtTroop:setString(g.core.lang:get(428977, var_10_2))
end

function NewSlgChariotNode:_updateFV()
	local var_11_1 = g.core.model.User.newSlgData:getChariotBelongAlliance(self._value, self._value2)

	self._txtFv:setString(g.core.model.User.newSlgData:getChariotAuthority(self._value, self._value2) + ((var_11_1 and var_11_1 == g.core.model.User.allianceData:getAllianceId() or nil) and g.core.model.User.newSlgData:getAssistAuthority(self._value)))
end

function NewSlgChariotNode:_updateCountDown()
	if g.core.model.User.newSlgData:isChariotGatherTime() then
		local var_12_2 = g.core.model.User.newSlgData:getChariotGatherEndTime() - g.core.common.ServerTime:getTime()

		self._txtTime:setString((g.core.common.ServerTime:secondToHMSString(var_12_2)))

		local var_12_3 = self._barCountDown:getContentSize().height

		self._barCountDown:setScaleX(math.floor(self._barWidth * (var_12_2 / g.core.model.User.newSlgData:getChariotGatherTotalTime() * 100) / 100) / self._barWidth)
	elseif g.core.model.User.newSlgData:isChariotMoveTime() then
		local var_12_4 = g.core.model.User.newSlgData:getChariotMoveTimeEndTime() - g.core.common.ServerTime:getTime()

		self._txtTime:setString((g.core.common.ServerTime:secondToMSString(var_12_4)))

		local var_12_5 = self._barCountDown:getContentSize().height

		self._barCountDown:setScaleX(math.floor(self._barWidth * (var_12_4 / g.core.model.User.newSlgData:getChariotMoveTotalTime() * 100) / 100) / self._barWidth)
	else
		self._map:eventHandler("newSlg_chariot_updatePool")
		self._map:eventHandler("newSlg_city_updatePool")
	end
end

function NewSlgChariotNode:update(arg_13_1)
	if not self:isVisible() then
		return
	end

	self:_updateCountDown(arg_13_1)

	if self._path and next(self._path) then
		self:_updateMove()
	end
end

function NewSlgChariotNode:destory()
	NewSlgChariotNode.super.destory(self)
end

function NewSlgChariotNode:_changeFace(arg_15_1)
	local var_15_1 = "zhanche_0" .. (arg_15_1.x > 0 and 4 or arg_15_1.x < 0 and 3 or arg_15_1.y > 0 and 2 or 1)

	if self._resId ~= "zhanche_0" .. (arg_15_1.x > 0 and 4 or arg_15_1.x < 0 and 3 or arg_15_1.y > 0 and 2 or 1) then
		self:_updateRes(var_15_1)
	end

	self._resId = var_15_1
end

return NewSlgChariotNode
