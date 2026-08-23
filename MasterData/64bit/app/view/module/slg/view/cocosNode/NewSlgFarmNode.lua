local NewSlgFarmNode = class("NewSlgFarmNode", require("app.core.tilemap.base.BaseMoveNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_4 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH

function NewSlgFarmNode:ctor(arg_1_1, arg_1_2)
	NewSlgFarmNode.super.ctor(self, arg_1_1, arg_1_2)
end

function NewSlgFarmNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)

	self._spineNode = cc.Node:create()

	self._map._topEffectNode:addChild(self._spineNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgFarmNode", self)

	self._imgNameBg = TileMapFunc.convertNode(var_2_0, "Img_nameBg", true)
	self._imgLvBg = TileMapFunc.convertNode(var_2_0, "Img_lvBg", true)
	self._imgTroopParent = TileMapFunc.convertNode(var_2_0, "Img_troop", true)
	self._protectPic = TileMapFunc.convertNode(var_2_0, "Img_protect", true)
	self._txtLv = TileMapFunc.convertText(var_2_0, "Txt_lv", true, FONT_NUMBER_PATH)
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name")
	self._txtTroopNum = TileMapFunc.convertText(var_2_0, "Txt_troopNum")
	self._txtCountDown = TileMapFunc.convertText(var_2_0, "Txt_countDown", true)
	self._txtPlayerName = TileMapFunc.convertText(var_2_0, "Txt_playerName", true)
	self._txtOccuState = TileMapFunc.convertText(var_2_0, "Txt_occuState", true)
	self._txtProtectTime = TileMapFunc.convertText(var_2_0, "Txt_protect", true)

	self._uiNode:addChild(self._protectPic)
	self._uiNode:addChild(self._imgNameBg)
	self._uiNode:addChild(self._imgLvBg)
	self._uiNode:addChild(self._imgTroopParent)
	self._textNode:addChild(self._txtLv)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._txtTroopNum)
	self._textNode:addChild(self._txtCountDown)
	self._textNode:addChild(self._txtPlayerName)
	self._textNode:addChild(self._txtOccuState)
	self._textNode:addChild(self._txtProtectTime)

	self._nameBgArr = {}
	self._lvBgArr = {}

	self._protectPic:setVisible(false)
	self._txtProtectTime:setVisible(false)
end

function NewSlgFarmNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self._uiNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self._textNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self:_calcButtonRect()
end

function NewSlgFarmNode:_updateBuildingRes(arg_4_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(arg_4_1))

		self._sprite:setAnchorPoint(0.5, 0)
		self._sprite:setPosition(0, -var_0_3 / 2)
		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgBuilding(arg_4_1))
	end
end

function NewSlgFarmNode:_updateArmyType()
	if not self._imgArmy or not self._armyType or self._info.army_type ~= self._armyType then
		self._armyType = self._info.army_type

		self._imgTroopParent:removeAllChildren()

		self._imgArmy = self:createNewSprite(g.core.common.Path:getNewSlgTroopIconUI(self._armyType))

		self._imgArmy:setAnchorPoint(0.5, 0.5)
		self._imgArmy:setScale(0.25)
		self._imgTroopParent:addChild(self._imgArmy)
	end
end

function NewSlgFarmNode:_updateFightingFire()
	if self._fireEffect then
		self._fireEffect:setVisible(true)

		return
	end
end

function NewSlgFarmNode:_removeFightingFire()
	if self._fireEffect then
		self._fireEffect:setVisible(false)
	end
end

function NewSlgFarmNode:setData(arg_8_1)
	self:setBaseData(arg_8_1)
	self:setCustomVisible(true)

	self._data = arg_8_1
	self._objectData = arg_8_1.objectData
	self._componentCfg = g.core.model.User.newSlgData:getComponentCfg(self._objectData.id)
	self._value = self._componentCfg.value
	self._info = g.core.model.User.newSlgData:getFarmInfoById(self._value)
	self._data = g.core.model.User.newSlgData:getFarmDataById(self._value)

	if self._resId ~= arg_8_1.resId then
		self:_updateBuildingRes(arg_8_1.resId)
	end

	self._txtPlayerName:setVisible(false)
	self._txtOccuState:setVisible(false)

	if self._data.protectTime > 0 then
		self._protectPic:setVisible(true)
		self._txtProtectTime:setVisible(true)
	end

	if self._data and self._data.userId > 0 then
		local var_8_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._data.userId)

		if var_8_0 then
			self._txtPlayerName:setVisible(true)
			self._txtPlayerName:setString(var_8_0.name)
		end
	end

	self:setLocalZOrder(arg_8_1.pos.x + arg_8_1.pos.y)

	self._resId = arg_8_1.resId

	self:_updateArmyType()
	self:_updateView()
end

function NewSlgFarmNode:_updateView()
	if not self._data then
		self._txtName:setVisible(false)

		return
	end

	self._txtName:setVisible(true)
	self._txtLv:setString(self._info.level)
	self._txtName:setString(self._info.name)
	self._txtTroopNum:setString(self._data.defNum)
	self:_setBgState()
	self:_updateCountDown()

	if self._data.isAttacking and self._data.hasBattle or g.core.model.User.newSlgData:isOccupying(self._data) then
		self:_updateFightingFire()
	else
		self:_removeFightingFire()
	end
end

function NewSlgFarmNode:_setBgState()
	if not self._data then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(self._lvBgArr) do
		iter_10_1:setVisible(false)
	end

	for iter_10_2, iter_10_3 in ipairs(self._nameBgArr) do
		iter_10_3:setVisible(false)
	end

	self._txtCountDown:setVisible(false)

	if self._data.state == var_0_2.FARM_STATE.NO_OWNER then
		self._imgLvBg:setVisible(true)
		self._imgNameBg:setVisible(true)
	end
end

function NewSlgFarmNode:_updateCountDown()
	if not self._data then
		return
	end

	local var_11_0 = g.core.common.ServerTime:getTime()

	if self._data.startTime and self._data.startTime > 0 then
		if not self._txtOccuState:isVisible() then
			self._txtOccuState:setVisible(true)
		end

		self._txtOccuState:setString(g.core.lang:get(429703) .. g.core.common.ServerTime:secondToHMSString(var_11_0 - self._data.startTime))
	else
		self._txtOccuState:setVisible(false)
	end

	local var_11_1 = g.core.model.User.newSlgData:getNewSlgParamsValueById(192) + self._data.protectTime

	if var_11_1 - var_11_0 > 0 then
		self._txtProtectTime:setString(g.core.common.ServerTime:secondToHMSString(var_11_1 - var_11_0))
	elseif self._protectPic:isVisible() then
		self._protectPic:setVisible(false)
		self._txtProtectTime:setVisible(false)
	end

	local var_11_2, var_11_3 = g.core.model.User.newSlgData:isOccupying(self._data)

	if var_11_2 then
		if not self._txtCountDown:isVisible() then
			self._txtCountDown:setVisible(true)
		end

		return
	end

	local var_11_4, var_11_5 = g.core.model.User.newSlgData:isProtecting(self._data)

	if var_11_4 then
		if not self._txtCountDown:isVisible() then
			self._txtCountDown:setVisible(true)
		end

		self._txtCountDown:setString(g.core.lang:get(429680, {
			time = g.core.common.ServerTime:secondToMSString(var_11_5)
		}))
	elseif self._txtCountDown:isVisible() then
		self._txtCountDown:setVisible(false)
	end
end

function NewSlgFarmNode:update(arg_12_1)
	self:_updateCountDown()
end

return NewSlgFarmNode
