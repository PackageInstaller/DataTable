local NewSlg2ChariotNode = class("NewSlg2ChariotNode", require("app.view.module.slg.view.cocosNode.NewSlgChariotNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst
local var_0_5 = g.core.model.User.newSlgData

function NewSlg2ChariotNode:_initFGui()
	NewSlg2ChariotNode.super._initFGui(self)

	self._chariotPathNode = cc.Node:create()

	self._map._chariotPathNode:addChild(self._chariotPathNode)
	self._imgBg:setVisible(false)
end

function NewSlg2ChariotNode:setData(arg_2_1)
	self:setBaseData(arg_2_1)
	self:_removeChariotMoveEffect()
	self._chariotPathNode:removeAllChildren()

	self._data = arg_2_1
	self._objectData = arg_2_1.objectData
	self._componentCfg = var_0_5:getComponentCfg(self._objectData.id)
	self._value = self._objectData.value
	self._value2 = self._objectData.value2
	self._cityCfg = var_0_5:getCityInfoById(self._value)
	self._serData = var_0_5:getCitySerData(self._value)

	local var_2_0, var_2_1 = var_0_5:getChariotShowState(self._value, self._value2)

	if not var_0_5:isCityInShare(self._value2) then
		var_2_1 = false
	end

	if var_2_0 == var_0_2.Slg2ChariotShowState.gather then
		self:setCustomVisible(true)
		self._mineBg:setVisible(var_2_1)
		self._otherBg:setVisible(not var_2_1)
	elseif var_2_0 == var_0_2.Slg2ChariotShowState.move then
		self:setCustomVisible(true)
		self._mineBg:setVisible(var_2_1)
		self._otherBg:setVisible(not var_2_1)

		local var_2_2 = self:_findPath()

		if var_2_2 and #var_2_2 > 1 then
			self:updatePath(self._map:drawPath(var_2_2, true, self._chariotPathNode), g.core.common.ServerTime:getTime() - var_0_5:getChariotMoveTimeStartTime())
			self:_addChariotMoveEffect()
		end
	else
		self:setCustomVisible(false)
	end

	if self:isVisible() then
		if self._resId ~= arg_2_1.resId then
			self:_updateRes(arg_2_1.resId)
		end

		self._resId = arg_2_1.resId

		self:_updateView()
	end
end

return NewSlg2ChariotNode
