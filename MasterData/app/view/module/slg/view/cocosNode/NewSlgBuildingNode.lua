local NewSlgBuildingNode = class("NewSlgBuildingNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_4 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH

function NewSlgBuildingNode:ctor(arg_1_1, arg_1_2)
	NewSlgBuildingNode.super.ctor(self, arg_1_1, arg_1_2)
end

function NewSlgBuildingNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()
	self._myShowNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)
	self._map._topShowNode:addChild(self._myShowNode)

	self._spineNode = cc.Node:create()

	self._map._topEffectNode:addChild(self._spineNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgBuildingNode", self)

	self._occupyBg = TileMapFunc.convertNode(var_2_0, "occupyBg", true)
	self._callFightBg1 = TileMapFunc.convertNode(var_2_0, "callFightBg1", true)
	self._callFightBg2 = TileMapFunc.convertNode(var_2_0, "callFightBg2", true)
	self._troopBg = TileMapFunc.convertNode(var_2_0, "troopBg", true)
	self._noneDi = TileMapFunc.convertNode(var_2_0, "noneDi", true)
	self._mineDi = TileMapFunc.convertNode(var_2_0, "mineDi", true)
	self._enemiesDi = TileMapFunc.convertNode(var_2_0, "enemiesDi", true)
	self._lvBg = TileMapFunc.convertNode(var_2_0, "Img_lvBg", true)
	self._imgTroopParent = TileMapFunc.convertNode(var_2_0, "Img_troop", true)
	self._imgAlliIconParent = TileMapFunc.convertNode(var_2_0, "imgAlliIcon", true)
	self._elemParent = TileMapFunc.convertNode(var_2_0, "elemNode", true)
	self._weatherParent = TileMapFunc.convertNode(var_2_0, "weatherNode", true)
	self._mineImg = TileMapFunc.convertNode(var_2_0, "mineImg", true)
	self._enemyImg = TileMapFunc.convertNode(var_2_0, "enemyImg", true)
	self._noneImg = TileMapFunc.convertNode(var_2_0, "noneImg", true)
	self._bubbleImg = TileMapFunc.convertNode(var_2_0, "bubbleImg", true)
	self._troopParentX = self._imgTroopParent:getPositionX()
	self._imgHpBg = TileMapFunc.convertNode(var_2_0, "Img_hpBg", true)
	self._barHp = TileMapFunc.convertNode(var_2_0, "Bar_hp", true)
	self._barWidth = self._barHp:getContentSize().width
	self._barHeight = self._barHp:getContentSize().height
	self._txtLv = TileMapFunc.convertText(var_2_0, "Txt_lv", true, FONT_NUMBER_PATH)
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name", true, FONT_TITLE_PATH)
	self._txtTroopNum = TileMapFunc.convertText(var_2_0, "Txt_troopNum", true)
	self._allianceNoticeTxt = TileMapFunc.convertText(var_2_0, "allianceNoticeTxt")

	self._allianceNoticeTxt:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)

	self._callFightStr1 = TileMapFunc.convertText(var_2_0, "callFightStr1")
	self._callFightStr2 = TileMapFunc.convertText(var_2_0, "callFightStr2")
	self._txtHp = TileMapFunc.convertText(var_2_0, "Txt_hp", true)
	self._txtCountDown = TileMapFunc.convertText(var_2_0, "Txt_countDown", true)
	self._txtAlliance = TileMapFunc.convertText(var_2_0, "Txt_alliance", true)

	self._mineImg:setVisible(false)
	self._enemyImg:setVisible(false)
	self._noneImg:setVisible(true)

	self._troopNumX = self._txtTroopNum:getPositionX()

	self._uiNode:addChild(self._occupyBg)
	self._uiNode:addChild(self._callFightBg1)
	self._uiNode:addChild(self._callFightBg2)
	self._uiNode:addChild(self._troopBg)
	self._uiNode:addChild(self._noneDi)
	self._uiNode:addChild(self._mineDi)
	self._uiNode:addChild(self._enemiesDi)
	self._uiNode:addChild(self._lvBg)
	self._uiNode:addChild(self._imgTroopParent)
	self._uiNode:addChild(self._imgAlliIconParent)
	self._uiNode:addChild(self._elemParent)
	self._uiNode:addChild(self._weatherParent)
	self._uiNode:addChild(self._mineImg)
	self._uiNode:addChild(self._enemyImg)
	self._uiNode:addChild(self._noneImg)
	self._uiNode:addChild(self._imgHpBg)
	self._uiNode:addChild(self._barHp)
	self._myShowNode:addChild(self._bubbleImg)
	self._myShowNode:addChild(self._allianceNoticeTxt, 99999)
	self._textNode:addChild(self._txtLv)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._txtTroopNum)
	self._textNode:addChild(self._txtHp)
	self._textNode:addChild(self._txtCountDown)
	self._textNode:addChild(self._txtAlliance)
	self._textNode:addChild(self._callFightStr1)
	self._textNode:addChild(self._callFightStr2)
	self._bubbleImg:setVisible(false)
	self._allianceNoticeTxt:setVisible(false)

	self._txtDir = cc.pSub(cc.p(self._allianceNoticeTxt:getPosition()), cc.p(self._bubbleImg:getPosition()))
end

function NewSlgBuildingNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self._uiNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self._textNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self._myShowNode:setPosition(self._pos.x - var_0_4 / 2, self._pos.y - var_0_3 / 2)
	self:_calcButtonRect()
end

function NewSlgBuildingNode:_updateBuildingRes(arg_4_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding(arg_4_1))

		self._sprite:setAnchorPoint(0.5, 0)
		self._sprite:setPosition(0, -var_0_3 / 4)
		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgBuilding(arg_4_1))
	end
end

function NewSlgBuildingNode:_updateArmyType()
	if self._imgArmy and self._armyType and self._cityCfg.army_type ~= self._armyType then
		-- block empty
	end
end

function NewSlgBuildingNode:_removeFightingFire()
	if self._fireEffect then
		self._fireEffect:setVisible(false)
	end
end

function NewSlgBuildingNode:_updateFightingFire()
	if self._buildingEffect then
		self._buildingEffect:setVisible(false)
	end

	if self._fireEffect then
		self._fireEffect:setVisible(true)

		return
	end

	local var_7_0 = require("app.view.common.SpineBase").new({
		resId = "eff_ui_newSlg_hurt3",
		isLoop = true,
		path = g.core.common.Path:getEffSpine("eff_ui_newSlg_hurt3"),
		anim = self._resId
	})
	local var_7_2, var_7_3 = require("app.core.tilemap.TileMapFunc").rc2p(self._objectData.centerRC.x, self._objectData.centerRC.y)

	var_7_0:setPosition(cc.p(var_7_2, var_7_3))

	self._fireEffect = var_7_0

	self._spineNode:addChild(var_7_0)
end

function NewSlgBuildingNode:_updateBuildingEffect(arg_8_1)
	if arg_8_1 == "0" then
		if self._buildingEffect then
			self._buildingEffect:setVisible(false)
		end
	else
		if self._buildingEffect then
			self._buildingEffect:removeFromParent()

			self._buildingEffect = nil
		end

		if self._buildingEffect then
			self._buildingEffect:play()

			local var_8_0, var_8_1 = g.utils.ToolUtils.tileMapFunc.rc2p(self._objectData.centerRC.x, self._objectData.centerRC.y)

			self._buildingEffect:setPosition(cc.p(var_8_0, var_8_1))
			self._buildingEffect:setScale(1)
			self._spineNode:addChild(self._buildingEffect)
		end
	end
end

function NewSlgBuildingNode:setData(arg_9_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_S2_UPDATE_NOTICE_BUBBLE, false, {
		data = arg_9_1,
		mapNode = self._map
	})
	self:setBaseData(arg_9_1)
	self:setCustomVisible(true)

	self._data = arg_9_1
	self._objectData = arg_9_1.objectData
	self._componentCfg = g.core.model.User.newSlgData:getComponentCfg(self._objectData.id)
	self._value = self._componentCfg.value
	self._cityCfg = g.core.model.User.newSlgData:getCityInfoById(self._value)
	self._serData, self._cityElemCfg = g.core.model.User.newSlgData:getCitySerData(self._value)

	if self._resId ~= arg_9_1.resId then
		self:_updateBuildingRes(arg_9_1.resId)
	end

	self:setLocalZOrder(arg_9_1.pos.x + arg_9_1.pos.y)

	self._resId = arg_9_1.resId

	self:_updateArmyType()
	self:_updateView()

	if g.core.model.User.newSlgData:isCityFighting(self._value) then
		self:_updateFightView()
	else
		local var_9_0 = self._componentCfg.res_2

		if self._effectName ~= self._componentCfg.res_2 then
			self:_updateBuildingEffect(var_9_0)
		end

		self._effectName = var_9_0

		self:_removeFightingFire()
	end
end

function NewSlgBuildingNode:_updateFightView()
	self._barHp:setVisible(true)
	self._imgHpBg:setVisible(true)
	self._txtCountDown:setVisible(true)
	self._txtHp:setVisible(true)
	self._txtHp:setString(g.core.lang:get(428977, {
		num1 = self._cityCfg.city_blood,
		num2 = self._cityCfg.city_blood
	}))
	self._barHp:setScaleX(1)
end

function NewSlgBuildingNode:_updateView()
	local var_11_0 = g.core.model.User.newSlgData
	local var_11_1 = g.core.model.User.allianceData
	local var_11_2 = g.core.model.User.newSlgData:getCityOccupyAllianceId(self._value)

	self._imgAlliIconParent:removeAllChildren()
	self._troopBg:setVisible(true)
	self._txtTroopNum:setVisible(true)

	local var_11_3 = cc.p(-30, 23)

	if var_11_2 > 0 and not g.core.model.User.newSlgData:isCityFighting(self._value) then
		local var_11_4 = var_11_1:getAllianceId() == var_11_2

		self._txtCountDown:setVisible(false)
		self._txtHp:setVisible(false)
		self._imgHpBg:setVisible(false)
		self._barHp:setVisible(false)

		var_11_3 = cc.p(-95, 16)

		if var_11_4 then
			self._txtAlliance:setString(g.core.lang:get(429034, {
				name = var_11_1:getAllianceName()
			}))
			self._mineDi:setVisible(true)
			self._mineImg:setVisible(false)
			self._noneDi:setVisible(false)
			self._noneImg:setVisible(false)
			self._enemiesDi:setVisible(false)
			self._enemyImg:setVisible(false)

			local var_11_5 = display.newSprite(g.core.common.Path:getAllianceFlag128(var_11_1:getFlagRes((var_11_1:getAllianceFlag()))))

			var_11_5:setAnchorPoint(0.5, 0.5)
			var_11_5:setScale(0.4)
			self._imgAlliIconParent:addChild(var_11_5)
			self._troopBg:setVisible(false)
			self._txtTroopNum:setVisible(false)
		else
			local var_11_6 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_11_2)

			if var_11_6 then
				self._txtAlliance:setString(g.core.lang:get(429034, {
					name = var_11_6.name
				}))

				local var_11_7 = display.newSprite(g.core.common.Path:getAllianceFlag128(var_11_1:getFlagRes(var_11_6.flag)))

				var_11_7:setAnchorPoint(0.5, 0.5)
				var_11_7:setScale(0.4)
				self._imgAlliIconParent:addChild(var_11_7)
			end

			self._mineDi:setVisible(false)
			self._mineImg:setVisible(false)
			self._noneDi:setVisible(false)
			self._noneImg:setVisible(false)
			self._enemiesDi:setVisible(true)
			self._enemyImg:setVisible(true)
		end

		self._txtAlliance:setVisible(true)
		self._occupyBg:setVisible(true)
		self._imgAlliIconParent:setVisible(true)
	else
		self._txtCountDown:setVisible(false)
		self._txtHp:setVisible(false)
		self._imgHpBg:setVisible(false)
		self._barHp:setVisible(false)
		self._txtAlliance:setVisible(false)
		self._mineDi:setVisible(false)
		self._mineImg:setVisible(false)
		self._noneDi:setVisible(true)
		self._noneImg:setVisible(true)
		self._enemiesDi:setVisible(false)
		self._enemyImg:setVisible(false)
		self._occupyBg:setVisible(false)
		self._imgAlliIconParent:setVisible(false)
	end

	self._weatherParent:setPosition(var_11_3)
	self:_updateDeclareView()

	local var_11_8 = 0

	var_11_8 = var_11_2 > 0 and var_11_0:getSeasonId() >= 2 and g.core.lang:get(428977, {
		num1 = math.max(var_11_0:getCityDefNum(self._value) - var_11_0:getCityNpcDefNum(self._value), 0),
		num2 = var_11_0:getCityMaxRealDefNum(self._value)
	}) or var_11_0:getCityDefNum(self._value)

	self:_updateTroopNum((var_11_0:isInfiniteCity(self._value) or nil) and g.core.lang:get(429013))
	self._txtLv:setString(self._cityCfg.level)
	self._txtName:setString(self._cityCfg.name)

	local var_11_9 = var_11_0:getCityDeclaration(self._value)

	self:updateAllianceNotice(var_11_9 ~= "", var_11_9)

	local var_11_10 = 0
	local var_11_11 = 0
	local var_11_12

	if self._cityElemCfg then
		var_11_10 = self._cityElemCfg.element
		var_11_11 = self._cityElemCfg.type
		var_11_12 = self._cityElemCfg.res
	end

	self:updateElem(var_11_10, var_11_11)
	self:updateWeather(var_11_12, var_11_11)
end

function NewSlgBuildingNode:_updateDeclareView()
	self._callFightBg1:setVisible(false)
	self._callFightBg2:setVisible(false)
	self._callFightStr1:setVisible(false)
	self._callFightStr2:setVisible(false)

	local var_12_0 = g.core.model.User.newSlgData:getCityPeriod()

	if var_12_0 == var_0_2.Slg2CityState.declare_war then
		if g.core.model.User.newSlgData:isCityDeclared(self._value) then
			self._callFightStr2:setVisible(true)
			self._callFightBg2:setVisible(true)
		elseif g.core.model.User.newSlgData:isCityCanDeclare(self._value) then
			self._callFightStr1:setVisible(true)
			self._callFightBg1:setVisible(true)
		end
	elseif var_12_0 == var_0_2.Slg2CityState.gather and g.core.model.User.newSlgData:isCityDeclared(self._value) then
		self._callFightStr2:setVisible(true)
		self._callFightBg2:setVisible(true)
	end
end

function NewSlgBuildingNode:_updateTroopNum(arg_13_1)
	self._txtTroopNum:setString(arg_13_1)
end

function NewSlgBuildingNode:_updateHp()
	if g.core.model.User.newSlgData:isCityFighting(self._value) then
		local var_14_0 = g.core.model.User.newSlgData:getBattleReportData(var_0_2.BATTLE_TYPE.CITY, self._value, cc.p(self._componentCfg.anchor_x, self._componentCfg.anchor_y))

		if var_14_0:isBattleStage2() then
			self:_updateFightingFire()

			local var_14_1 = var_14_0:getLastTime() / (var_14_0.battleEndTime - var_14_0.cityBattleStartTime) * 100

			self._barHp:setScaleX(math.floor(self._barWidth * var_14_1 / 100) / self._barWidth)
			self._txtHp:setString(g.core.lang:get(428977, {
				num1 = math.floor(self._cityCfg.city_blood * var_14_1 / 100),
				num2 = self._cityCfg.city_blood
			}))
		end
	end
end

function NewSlgBuildingNode:_updateCountDown()
	if g.core.model.User.newSlgData:isCityFighting(self._value) then
		self._txtCountDown:setString(g.core.lang:get(428875, {
			time = g.core.common.ServerTime:secondToHMSString((g.core.model.User.newSlgData:getBattleReportData(var_0_2.BATTLE_TYPE.CITY, self._value, cc.p(self._componentCfg.anchor_x, self._componentCfg.anchor_y)):getLastTime()))
		}))
	end
end

function NewSlgBuildingNode:_updateFightingTroopNum()
	if g.core.model.User.newSlgData:isCityFighting(self._value) then
		local var_16_0 = g.core.model.User.newSlgData:getBattleReportData(var_0_2.BATTLE_TYPE.CITY, self._value, cc.p(self._componentCfg.anchor_x, self._componentCfg.anchor_y))

		if g.core.model.User.newSlgData:isInfiniteCity(self._value) then
			self:_updateTroopNum(g.core.lang:get(429013))
		elseif var_16_0 then
			self:_updateTroopNum(var_16_0.enemyCount)
		end
	end
end

function NewSlgBuildingNode:updateAllianceNotice(arg_17_1, arg_17_2)
	if arg_17_1 and (g.core.model.User.newSlgData:isCityDeclared(self._value) or #g.core.model.User.newSlgData:getCityDeclaredAlliances(self._value) ~= 0) then
		local var_17_0, var_17_1 = self._sprite:getPosition()

		self._bubbleImg:setPositionY((self._sprite:getContentSize().height + var_17_1) * 0.9)
		self._allianceNoticeTxt:setPosition((cc.pAdd(cc.p(self._bubbleImg:getPosition()), self._txtDir)))
		self._allianceNoticeTxt:setTextAreaSize(cc.size(200, 0))
		self._allianceNoticeTxt:setString(arg_17_2)
		self._bubbleImg:setVisible(arg_17_1)
		self._allianceNoticeTxt:setVisible(arg_17_1)
	else
		self._bubbleImg:setVisible(false)
		self._allianceNoticeTxt:setVisible(false)
	end
end

function NewSlgBuildingNode:updateElem(arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		self._elemParent:setVisible(false)

		return
	end

	local var_18_0 = self._elemParent:getChildByName("elemNode")
	local var_18_1

	if not var_18_0 then
		var_18_0 = require("app.view.module.slg.view.cocosNode.NewSlgBuildingElemNode").new()

		var_18_0:setName("elemNode")
		self._elemParent:addChild(var_18_0)

		var_18_1 = {}
	end

	var_18_1.elemFrame = self._map._mapComp:getFguiSpriteFrame((g.core.common.Path:getKnightElementIcon(arg_18_1, "ui://newSlg_mapUI/")))

	if arg_18_2 then
		var_18_1.tipFrame = self._map._mapComp:getFguiSpriteFrame(table.concat({
			"ui://newSlg_mapUI/pic_hzts_ysjt",
			arg_18_2
		}))
	end

	var_18_0:updateElemNode(var_18_1)
	self._elemParent:setVisible(true)
end

function NewSlgBuildingNode:updateWeather(arg_19_1, arg_19_2)
	if not arg_19_1 then
		self._weatherParent:setVisible(false)

		return
	end

	local var_19_0 = self._elemParent:getChildByName("weatherNode")
	local var_19_1

	if not var_19_0 then
		var_19_0 = require("app.view.module.slg.view.cocosNode.NewSlgBuildingWeatherNode").new()

		var_19_0:setName("weatherNode")
		self._weatherParent:addChild(var_19_0)

		var_19_1 = {
			weatherFrame = self._map._mapComp:getFguiSpriteFrame(table.concat({
				"ui://newSlg_mapUI/",
				arg_19_1
			}))
		}
	end

	var_19_1.bgFrame = self._map._mapComp:getFguiSpriteFrame((table.concat({
		"ui://newSlg_mapUI/pic_hzts_tq",
		arg_19_2
	})))

	var_19_0:updateWeatherNode(var_19_1)
	self._weatherParent:setVisible(true)
end

function NewSlgBuildingNode:update(arg_20_1)
	if self._value > 0 then
		self:_updateCountDown()
		self:_updateHp()
		self:_updateFightingTroopNum()
	end
end

return NewSlgBuildingNode
