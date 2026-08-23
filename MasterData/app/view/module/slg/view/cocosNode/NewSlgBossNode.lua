local NewSlgBossNode = class("NewSlgBossNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_4 = g.core.model.User.newSlgData

function NewSlgBossNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)
end

function NewSlgBossNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)

	self._spineNode = cc.Node:create()

	self._map._footEffectNode:addChild(self._spineNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgBossNode", self)

	self._nameBg = TileMapFunc.convertNode(var_2_0, "Img_nameBg", true)
	self._armyBg = TileMapFunc.convertNode(var_2_0, "armyBg", true)
	self._gatherBg = TileMapFunc.convertNode(var_2_0, "stateDi1", true)
	self._imgTroop = TileMapFunc.convertNode(var_2_0, "Img_troop", true)
	self._imgArmyParent = TileMapFunc.convertNode(var_2_0, "Img_army", true)
	self._txtGather = TileMapFunc.convertText(var_2_0, "stateTxt")
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name", false, FONT_TITLE_PATH)
	self._txtAuthority = TileMapFunc.convertText(var_2_0, "Txt_authority", true)

	self._uiNode:addChild(self._nameBg)
	self._uiNode:addChild(self._imgTroop)
	self._uiNode:addChild(self._armyBg)
	self._uiNode:addChild(self._gatherBg)
	self._uiNode:addChild(self._imgArmyParent)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._txtAuthority)
	self._textNode:addChild(self._txtGather)
	self._gatherBg:setVisible(false)
	self._txtGather:setVisible(false)
end

function NewSlgBossNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self._uiNode:setPosition(self._pos.x - var_0_3 / 2, self._pos.y - var_0_2 / 2)
	self._textNode:setPosition(self._pos.x - var_0_3 / 2, self._pos.y - var_0_2 / 2)
	self:_calcButtonRect()
end

function NewSlgBossNode:_updateBuildingRes(arg_4_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgMonster(arg_4_1))

		self._sprite:setAnchorPoint(0.5, 0.5)

		local var_4_0, var_4_1 = TileMapFunc.rc2p(self._objectData.centerRC.x, self._objectData.centerRC.y)

		if g.core.model.User.newSlgData:getSName() == "S1" then
			self._sprite:setPosition(var_4_0 - self._pos.x, var_4_1 - self._pos.y + var_0_2 / 4)
		else
			self._sprite:setPosition(var_4_0 - self._pos.x, var_4_1 - self._pos.y + var_0_2 / 2)
		end

		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgMonster(arg_4_1))
	end
end

function NewSlgBossNode:_updateArmyType()
	if not self._imgArmy or not self._armyType or self._bossCfg.boss_army_type ~= self._armyType then
		self._armyType = self._bossCfg.boss_army_type

		self._imgArmyParent:removeAllChildren()

		self._imgArmy = self:createNewSprite(g.core.common.Path:getNewSlgTroopIconUI(self._armyType))

		self._imgArmy:setAnchorPoint(0.5, 0.5)
		self._imgArmy:setScale(0.6)
		self._imgArmyParent:addChild(self._imgArmy)
	end
end

function NewSlgBossNode:setData(arg_6_1)
	self:setBaseData(arg_6_1)
	self:setCustomVisible(true)

	self._data = arg_6_1
	self._objectData = arg_6_1.objectData
	self._componentCfg = g.core.model.User.newSlgData:getComponentCfg(self._objectData.id)
	self._value = self._componentCfg.value
	self._bossCfg = g.core.model.User.newSlgData:getBossInfoById(self._value)

	if self._resId ~= arg_6_1.resId then
		self:_updateBuildingRes(arg_6_1.resId)
		self:_addFootEft()
	end

	self:setLocalZOrder(arg_6_1.pos.x + arg_6_1.pos.y)

	self._resId = arg_6_1.resId

	self:_updateArmyType()
	self:_updateView()
end

function NewSlgBossNode:_updateView()
	local var_7_0 = var_0_4:getProvinceCfgByGID((var_0_4:getProvinceGIdByRC(self._objectData.pos.x, self._objectData.pos.y)))

	if var_7_0 then
		local var_7_2 = var_0_4:getResAddition(var_7_0.id)
	end

	local var_7_3 = var_0_4:getScoreAddition()

	self._txtName:setString(g.core.lang:get(428987, {
		level = self._bossCfg.level
	}) .. self._bossCfg.name)
	self._txtAuthority:setString(var_0_4:getBossTotalAuthority(self._value))

	if g.core.model.User.newSlgData:isMyTarget(self._data.pos) then
		self._gatherBg:setVisible(true)
		self._txtGather:setVisible(true)
	else
		self._gatherBg:setVisible(false)
		self._txtGather:setVisible(false)
	end
end

function NewSlgBossNode:_addFootEft()
	self._spineNode:removeAllChildren()

	local var_8_0, var_8_1 = TileMapFunc.rc2p(self._objectData.centerRC.x, self._objectData.centerRC.y)
end

return NewSlgBossNode
