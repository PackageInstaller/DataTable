local NewSlgMonsterNode = class("NewSlgMonsterNode", require("app.core.tilemap.base.BaseNode"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_2 = g.core.model.User.newSlgData
local var_0_3 = g.core.utils.Number.getFormatNum
local var_0_4 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_5 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_6 = g.core.const.ConstMgr.NewSlgConst.SPRITE_FRAME
local var_0_7 = cc.Director:getInstance():getFrameRate() / 60 * g.core.const.ConstMgr.NewSlgConst.SPRITE_FRAME_TIME

function NewSlgMonsterNode:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self, arg_1_1, arg_1_2)

	self._mapComp = arg_1_2
end

function NewSlgMonsterNode:_initFGui()
	self._uiNode = cc.Node:create()
	self._textNode = cc.Node:create()

	self._map._topNode:addChild(self._uiNode)
	self._map._textNode:addChild(self._textNode)

	self._footEffect = cc.Node:create()
	self._topEffect = cc.Node:create()

	self._uiNode:addChild(self._footEffect, 0)
	self._uiNode:addChild(self._topEffect, 2)

	local var_2_0 = fgui.UIPackage:createObject("newSlg_mapUI", "NewSlgMonsterNode", self)

	self._nameBg = TileMapFunc.convertNode(var_2_0, "Img_nameBg", true)
	self._armyBg = TileMapFunc.convertNode(var_2_0, "armyBg", true)
	self._imgArmyParent = TileMapFunc.convertNode(var_2_0, "Img_army", true)
	self._imgTroop = TileMapFunc.convertNode(var_2_0, "Img_troop", true)
	self._imgAdd = TileMapFunc.convertNode(var_2_0, "Img_add", true)
	self._txtLv = TileMapFunc.convertText(var_2_0, "Txt_lv", false, FONT_TITLE_PATH)
	self._txtName = TileMapFunc.convertText(var_2_0, "Txt_name", false, FONT_TITLE_PATH)
	self._txtAuthority = TileMapFunc.convertText(var_2_0, "Txt_authority", true)
	self._txtTime = TileMapFunc.convertText(var_2_0, "Txt_countDown", true)
	self._tipsBg = TileMapFunc.convertNode(var_2_0, "tipsBg", true)
	self._rebornBg = TileMapFunc.convertNode(var_2_0, "rebornBg", true)
	self._txtTip = TileMapFunc.convertText(var_2_0, "Txt_tip", true)
	self._imgHpBg = TileMapFunc.convertNode(var_2_0, "Img_hpBg", true)
	self._barHp = TileMapFunc.convertNode(var_2_0, "Bar_hp", true)

	self._txtTime:setVisible(false)
	self._txtTip:setVisible(false)
	self._tipsBg:setVisible(false)
	self._rebornBg:setVisible(false)

	self._barWidth = self._barHp:getContentSize().width
	self._barHeight = self._barHp:getContentSize().height

	self._uiNode:addChild(self._imgTroop)
	self._uiNode:addChild(self._nameBg)
	self._uiNode:addChild(self._tipsBg)
	self._uiNode:addChild(self._armyBg)
	self._uiNode:addChild(self._imgArmyParent)
	self._textNode:addChild(self._txtLv)
	self._textNode:addChild(self._txtName)
	self._textNode:addChild(self._txtAuthority)
	self._textNode:addChild(self._rebornBg)
	self._textNode:addChild(self._txtTip)
	self._textNode:addChild(self._txtTime)
	self._textNode:addChild(self._imgHpBg)
	self._textNode:addChild(self._barHp)
	self._textNode:addChild(self._imgAdd)
	TileMapFunc.changeCocosNodeAnchor(self._nameBg, cc.p(0.5, 1))
end

function NewSlgMonsterNode:_setPosition(arg_3_1, arg_3_2)
	self:setPosition(arg_3_1, arg_3_2)
	self._uiNode:setPosition(arg_3_1 - var_0_4 / 2, arg_3_2 - var_0_5 / 2)
	self._textNode:setPosition(arg_3_1 - var_0_4 / 2, arg_3_2 - var_0_5 / 2)
end

function NewSlgMonsterNode:setData(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self._data = arg_4_1
	self._objectData = arg_4_1.objectData

	self:setCustomVisible(true)

	local var_4_0 = {}

	var_4_0.x = arg_4_1.posX or 0
	var_4_0.y = arg_4_1.posY or 0

	self:_setPosition(var_4_0.x, var_4_0.y)
	self:setLocalZOrder(arg_4_1.pos.x + arg_4_1.pos.y)

	self._monsterSerData = var_0_2:getMonsterDataByRC(arg_4_1.pos.x, arg_4_1.pos.y)
	self._monsterCfg = var_0_2:getMonsterInfoByGID(self._objectData.gid)

	self:_updateBaseInfo()
	self:_updateMonsterRes()
	self:_updateArmyType()
	self:_updateTime()
	self:_updateProgress()
	self:_addEffect()
	self:updateNodePos()
end

function NewSlgMonsterNode:_updateProgress()
	local var_5_0, var_5_1

	if self._monsterSerData then
		var_5_0 = self._monsterSerData.maxTroops or self._monsterCfg.troops

		if self._monsterSerData then
			var_5_1 = self._monsterSerData.troops or var_5_0
		end
	end

	if var_5_0 == var_5_1 or (self._monsterSerData or nil) and self._monsterSerData.troops == 0 and (self._monsterSerData.revive_ts or 0) < g.core.common.ServerTime:getTime() then
		self._imgHpBg:setVisible(false)
		self._barHp:setVisible(false)
	else
		self._imgHpBg:setVisible(true)
		self._barHp:setVisible(true)
		self._barHp:setScaleX(var_5_1 / var_5_0)
	end
end

function NewSlgMonsterNode:_updateBaseInfo()
	local var_6_0 = var_0_2:getProvinceCfgByGID((var_0_2:getProvinceGIdByRC(self._objectData.pos.x, self._objectData.pos.y)))

	self._imgAdd:setVisible(((var_6_0 or nil) and var_0_2:getResAddition(var_6_0.id)) > 0 or var_0_2:getScoreAddition() > 0)
	self._txtLv:setString(g.core.lang:get(429003, {
		level = self._monsterCfg.level
	}))
	self._txtName:setString(self._monsterCfg.name)
	self:updateNodePos()
end

function NewSlgMonsterNode:updateNodePos()
	local var_7_0, var_7_1 = self._txtLv:getPosition()
	local var_7_2, var_7_3 = self._txtName:getPosition()
	local var_7_4 = self._txtLv:getContentSize().width + var_7_0

	self._txtName:setPosition(var_7_4, var_7_3)
	self._txtAuthority:setString(self._monsterCfg.authority)

	local var_7_5, var_7_6 = self._imgAdd:getPosition()

	self._imgAdd:setPosition(self._txtName:getContentSize().width + var_7_4 + self._imgAdd:getContentSize().width / 2, var_7_6)
end

function NewSlgMonsterNode:_addEffect()
	self._footEffect:removeAllChildren()
	self:_addFootEft()
end

function NewSlgMonsterNode:_addFootEft()
	return
end

function NewSlgMonsterNode:_updateTime()
	self._txtTime:setVisible(false)
	self._tipsBg:setVisible(false)
	self._txtTip:setVisible(false)

	if not self._monsterSerData then
		return
	end

	self._lastTime = self._lastTime or g.core.common.ServerTime:getTime()

	local var_10_0 = self._monsterSerData.reviveTime - g.core.common.ServerTime:getTime()

	if var_10_0 > 0 then
		self._txtTime:setVisible(true)
		self._tipsBg:setVisible(true)
		self._txtTime:setString(g.core.lang:get(428811, {
			time = g.core.common.ServerTime:secondToHMSString(var_10_0)
		}))
	end
end

function NewSlgMonsterNode:getAnimIndex(arg_11_1)
	return self._monsterCfg.res .. "_" .. var_0_3(2, arg_11_1 * 2)
end

function NewSlgMonsterNode:_updateMonsterRes()
	self._index = 0
	self._cacheTime = 0

	if not self._sprite then
		self._sprite = display.newSprite("#" .. self:getAnimIndex(self._index) .. ".png")

		self._sprite:setAnchorPoint(0.5, 0)
		self._sprite:setPosition(0, -var_0_5 / 4)
		self:addChild(self._sprite)
	else
		self._sprite:setSpriteFrame(self:getAnimIndex(self._index) .. ".png")
	end
end

function NewSlgMonsterNode:_updateArmyType()
	if not self._imgArmy or not self._armyType or self._monsterCfg.army_type ~= self._armyType then
		self._armyType = self._monsterCfg.army_type

		self._imgArmyParent:removeAllChildren()

		self._imgArmy = self:createNewSprite(g.core.common.Path:getNewSlgTroopIconUI(self._armyType))

		self._imgArmy:setAnchorPoint(0.5, 0.5)
		self._imgArmy:setScale(0.6)
		self._imgArmyParent:addChild(self._imgArmy)
	end
end

function NewSlgMonsterNode:update(arg_14_1)
	if not self:isVisible() then
		return
	end

	if self._sprite then
		self._cacheTime = self._cacheTime + arg_14_1

		if self._cacheTime >= var_0_7 then
			self._cacheTime = self._cacheTime - var_0_7
			self._index = self._index + 1

			if self._index >= var_0_6 then
				self._index = 0
			end

			self._sprite:setSpriteFrame(self:getAnimIndex(self._index) .. ".png")
		end
	end

	if not self._txtTime:isVisible() then
		return
	end

	local var_14_0 = g.core.common.ServerTime:getTime()

	if var_14_0 > self._lastTime then
		self._lastTime = var_14_0

		self:_updateTime()
	end
end

function NewSlgMonsterNode:playWinLose(arg_15_1)
	return
end

function NewSlgMonsterNode:setGray(arg_16_1, arg_16_2)
	arg_16_1:setGLProgramState((cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader(arg_16_2 and "SHADER_UI_GRAY" or "SHADER_UI_NORMAL")))))
end

return NewSlgMonsterNode
