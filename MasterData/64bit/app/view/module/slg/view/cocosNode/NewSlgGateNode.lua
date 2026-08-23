local NewSlgGateNode = class("NewSlgGateNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_4 = g.core.model.User.newSlgData

function NewSlgGateNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)
end

function NewSlgGateNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgGateNode", self)

	self._imgBg = TileMapFunc.convertNode(var_2_0, "Img_bg", true)
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name")
	self._txtTip = TileMapFunc.convertText(var_2_0, "Txt_tip", true)
	self._txtPassTip = TileMapFunc.convertText(var_2_0, "Txt_tip_pass", true)

	self._uiNode:addChild(self._imgBg)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._txtTip)
	self._textNode:addChild(self._txtPassTip)
end

function NewSlgGateNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self:_calcButtonRect()
end

function NewSlgGateNode:_fixPosition(arg_4_1)
	return ({
		["211_271"] = cc.p(0, -0.5 * var_0_3),
		["214_279"] = cc.p(0.5 * var_0_2, 0),
		["260_226"] = cc.p(0.5 * var_0_2, 0),
		["164_126"] = cc.p(0, -0.5 * var_0_3)
	})[arg_4_1.x .. "_" .. arg_4_1.y] or cc.p(0, 0.5 * var_0_3)
end

function NewSlgGateNode:_setImage(arg_5_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(arg_5_1))

		if arg_5_1 ~= "guanai" then
			local var_5_0 = self:_fixPosition(self._objectData.pos)

			self._sprite:setPosition(var_5_0)
			self._uiNode:setPosition(self._pos.x - var_0_2 / 2 + var_5_0.x, self._pos.y - var_0_3 / 2 + var_5_0.y)
			self._textNode:setPosition(self._pos.x - var_0_2 / 2 + var_5_0.x, self._pos.y - var_0_3 / 2 + var_5_0.y)
		else
			self._sprite:setPosition(0, 0.06 * var_0_3)
			self._uiNode:setPosition(self._pos.x - var_0_2 / 2, self._pos.y - var_0_3 / 2)
			self._textNode:setPosition(self._pos.x - var_0_2 / 2, self._pos.y - var_0_3 / 2)
		end

		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgBuilding(arg_5_1))
	end
end

function NewSlgGateNode:setData(arg_6_1)
	self:setBaseData(arg_6_1)
	self:setCustomVisible(true)

	self._objectData = arg_6_1.objectData
	self._componentCfg = var_0_4:getComponentCfg(self._objectData.id)
	self._checkPointCfg = var_0_4:getCheckPointInfoById(self._componentCfg.value)

	if self._resId ~= arg_6_1.resId then
		self:_setImage(arg_6_1.resId)
	end

	self._resId = arg_6_1.resId

	self._txtName:setString(self._checkPointCfg.name)
	self:_updateView()
end

function NewSlgGateNode:_updateView()
	local var_7_0 = var_0_4:isGateCanPass(self._componentCfg.value)

	self._txtTip:setVisible(not var_7_0)
	self._txtPassTip:setVisible(var_7_0)
end

function NewSlgGateNode:update(arg_8_1)
	return
end

return NewSlgGateNode
