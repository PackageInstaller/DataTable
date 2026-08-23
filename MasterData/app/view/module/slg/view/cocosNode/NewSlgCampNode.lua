local NewSlgCampNode = class("NewSlgCampNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.const.ConstMgr.NewSlgConst
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_4 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_5 = g.core.model.User.newSlgData

function NewSlgCampNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)

	self._side = var_0_2.CAMP_SIDE.NONE
end

function NewSlgCampNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgCampNode", self)

	self._otherBgDi = TileMapFunc.convertNode(var_2_0, "otherBgDi", true)
	self._mineBgDi = TileMapFunc.convertNode(var_2_0, "mineBgDi", true)
	self._alliBgDi = TileMapFunc.convertNode(var_2_0, "alliBgDi", true)
	self._mineDi = TileMapFunc.convertNode(var_2_0, "mineDi", true)
	self._otherDi = TileMapFunc.convertNode(var_2_0, "otherDi", true)
	self._alliDi = TileMapFunc.convertNode(var_2_0, "alliDi", true)
	self._lvBgParent = TileMapFunc.convertNode(var_2_0, "Img_lvBg", true)
	self._txtLv = TileMapFunc.convertText(var_2_0, "Txt_lv", true)
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name", true, FONT_TITLE_PATH)
	self._fightImg = TileMapFunc.convertNode(var_2_0, "fightImg", true)
	self._txtFightValue = TileMapFunc.convertText(var_2_0, "fightValueTxt", true)

	self._otherBgDi:setVisible(false)
	self._alliBgDi:setVisible(false)
	self._uiNode:addChild(self._otherBgDi)
	self._uiNode:addChild(self._mineBgDi)
	self._uiNode:addChild(self._alliBgDi)
	self._uiNode:addChild(self._mineDi)
	self._uiNode:addChild(self._otherDi)
	self._uiNode:addChild(self._alliDi)
	self._uiNode:addChild(self._lvBgParent)
	self._textNode:addChild(self._txtLv)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._fightImg)
	self._textNode:addChild(self._txtFightValue)
end

function NewSlgCampNode:setBaseData(arg_3_1)
	self._pos = cc.p(arg_3_1.posX or 0, arg_3_1.posY or 0)

	self:setPosition(self._pos.x, self._pos.y)
	self._uiNode:setPosition(self._pos.x - var_0_3 / 2, self._pos.y - var_0_4 / 2)
	self._textNode:setPosition(self._pos.x - var_0_3 / 2, self._pos.y - var_0_4 / 2)
	self:_calcButtonRect()
end

function NewSlgCampNode:_setImage(arg_4_1)
	if not self._sprite then
		self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgBuilding("zhucheng_" .. arg_4_1))

		self._sprite:setAnchorPoint(0.5, 0)
		self._sprite:setPosition(0, -var_0_4 / 2)
		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(g.core.common.Path:getNewSlgBuilding("zhucheng_" .. arg_4_1))
	end
end

function NewSlgCampNode:setData(arg_5_1)
	self:setBaseData(arg_5_1)
	self:setCustomVisible(true)

	self._data = arg_5_1

	self:setLocalZOrder(arg_5_1.pos.x + arg_5_1.pos.y)

	if self._resId ~= arg_5_1.resId then
		self:_setImage(arg_5_1.resId)
	end

	self._resId = arg_5_1.resId

	self:_updateView()
end

function NewSlgCampNode:fitBg()
	return
end

function NewSlgCampNode:_updateView()
	local var_7_0 = var_0_5:getUserDataByUid(self._data.id)

	self._txtLv:setString(var_7_0.mainCityLevel)
	self._txtName:setString(var_7_0.name)
	self._txtFightValue:setString(g.core.utils.Number.transTextNumFormation(var_7_0.authority))

	local var_7_1, var_7_2 = self._fightImg:getPosition()
	local var_7_3, var_7_4 = self._txtFightValue:getPosition()

	self._fightImg:setPosition(var_7_3 - self._txtFightValue:getContentSize().width / 2, var_7_2)

	local var_7_5

	if self._data.id == g.core.model.User:getId() then
		var_7_5 = var_0_2.CAMP_SIDE.SELF

		if g.core.model.User.newSlgData:checkPlayMoveHomeEff() then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_TouziSuccess)

			local var_7_6

			var_7_6 = require("app.view.common.SpineBase").new({
				anim = "play",
				isLoop = false,
				resId = "eff_ui_newSlg_move",
				path = g.core.common.Path:getEffSpine("eff_ui_newSlg_move"),
				listener = function(self)
					if self.type == "complete" then
						var_7_6:removeFromParent(true)
					end
				end
			})

			;(nil):setPosition(0, 0)
			self:addChild(var_7_6)
		end
	else
		var_7_5 = var_7_0.allianceId == g.core.model.User.allianceData:getAllianceId() and var_0_2.CAMP_SIDE.ALLIANCE or var_0_2.CAMP_SIDE.NEUTRAL
	end

	self:_updateNameLvBg(var_7_5)
	self:fitBg()
end

function NewSlgCampNode:_updateNameLvBg(arg_9_1)
	if not self._imgNameBg or not self._side ~= arg_9_1 then
		if arg_9_1 == var_0_2.CAMP_SIDE.NEUTRAL then
			self._otherDi:setVisible(true)
			self._mineDi:setVisible(false)
			self._alliDi:setVisible(false)
			self._otherBgDi:setVisible(true)
			self._mineBgDi:setVisible(false)
			self._alliBgDi:setVisible(false)
		elseif arg_9_1 == var_0_2.CAMP_SIDE.SELF then
			self._otherDi:setVisible(false)
			self._mineDi:setVisible(true)
			self._alliDi:setVisible(false)
			self._otherBgDi:setVisible(false)
			self._mineBgDi:setVisible(true)
			self._alliBgDi:setVisible(false)
		elseif arg_9_1 == var_0_2.CAMP_SIDE.ALLIANCE then
			self._otherDi:setVisible(false)
			self._mineDi:setVisible(false)
			self._alliDi:setVisible(true)
			self._otherBgDi:setVisible(false)
			self._mineBgDi:setVisible(false)
			self._alliBgDi:setVisible(true)
		end

		self._side = arg_9_1
	end
end

function NewSlgCampNode:update(arg_10_1)
	return
end

return NewSlgCampNode
