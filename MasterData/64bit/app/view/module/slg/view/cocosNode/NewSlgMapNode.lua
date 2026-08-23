local NewSlgMapNode = class("NewSlgMapNode", require("app.core.tilemap.base.BaseMapNode"))
local NewSlgMonsterPool = require("app.view.module.slg.view.cocosNode.NewSlgMonsterPool")
local NewSlgGatePool = require("app.view.module.slg.view.cocosNode.NewSlgGatePool")
local NewSlgCampPool = require("app.view.module.slg.view.cocosNode.NewSlgCampPool")
local NewSlgBuildingPool = require("app.view.module.slg.view.cocosNode.NewSlgBuildingPool")
local NewSlgBossPool = require("app.view.module.slg.view.cocosNode.NewSlgBossPool")
local NewSlgChariotPool = require("app.view.module.slg.view.cocosNode.NewSlgChariotPool")
local NewSlgSelectNode = require("app.view.module.slg.view.cocosNode.NewSlgSelectNode")
local NewSlgFarmPool = require("app.view.module.slg.view.cocosNode.NewSlgFarmPool")
local NewSlgFunc = require("app.view.module.slg.const.NewSlgFunc")
local TileMapFunc = require("app.core.tilemap.TileMapFunc")
local var_0_11 = g.core.const.ConstMgr.NewSlgConst
local var_0_12 = g.core.const.ConstMgr.NewSlgConst.COMP_TYPE
local var_0_13 = g.core.event.EventManager
local var_0_14 = g.core.event.enum
local var_0_15 = g.core.model.User.newSlgData
local var_0_16 = {
	"_3x6_1Node",
	"_3x6_2Node",
	"_3x6_3Node",
	"_4x8Node",
	"_2x4_1Node",
	"_2x4_2Node",
	"_2x4_3Node",
	"_2x4_4Node",
	"_1x2Node",
	"_floorNode",
	"_chariotPathNode",
	"_footEffectNode",
	"_monsterNode",
	"_buildingNode",
	"_campNode",
	"_topEffectNode",
	"_pathNode",
	"_topNode",
	"_textNode",
	"_topShowNode",
	"_pathHeadNode",
	"_headNode",
	"_headUINode"
}
local var_0_17 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_WIDTH
local var_0_18 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.S_CELL_HEIGHT
local var_0_19 = TileMapFunc.p2s
local var_0_21 = TileMapFunc.s2p
local var_0_22 = TileMapFunc.rc2p
local var_0_23 = TileMapFunc.rc2vc
local var_0_24 = TileMapFunc.p2rc

function NewSlgMapNode:ctor(arg_1_1)
	self.super.ctor(self, arg_1_1)
	var_0_15:setAStar(self._aStar)

	self._mapComp = arg_1_1
	self._maxScale = var_0_11.MAP_PARAMETER.SCALE
	self._layerList = var_0_16

	self:addNodes()

	self._firstIn = true
	self._needPlaySound = false
	self._monstersMapByRC = {}
	self._monsterBlockDataByRC = nil
	self._campsMapByRC = {}
	self._userMarches = {}
	self._gates = {}
	self._cities = {}
	self._bosses = {}
	self._farms = {}
	self._chariots = {}
	self._battleMap = {}
end

function NewSlgMapNode:onEnter()
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self._onRcvEnter), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_GETMAPSHOWDATA, handler(self, self._onRcvBlockInfo), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_NOTIFYMAPSHOW, handler(self, self._onRcvMapShow), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_NOTIFYMOVEUNIT, handler(self, self._onRcvMarches), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_MOVEHOME, handler(self, self._onRcvMoveHome), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_CITYNTF, handler(self, self._onRcvNewSlgCityNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_CITYBATTLEEND, handler(self, self._onRcvNewSlgBattleEnd), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_MONSTERBATTLEREPORT, handler(self, self._onRcvMonsterBattleReport), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_BOSSBATTLESTARTNOTIFY, handler(self, self._onRcvBossBattleReport), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_NOTIFYMONSTERBATTLERESULT, handler(self, self._onRcvMonsterResult), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_NOTIFYCHECKPOINTQUEST, handler(self, self._onRcvNewSlgNotifyCheckpointQuest), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWSTATISTIC, handler(self, self._onRcvMapShow), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_MOVETARGETRIGHTNOW, handler(self, self._onRcvMoveRightNow), self)
	var_0_13:addEventListener(var_0_14.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	var_0_13:addEventListener(var_0_14.EVENT_NEW_SLG_BATTLE_END, handler(self, self._onBattleShowEnd), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_SETCITYDECLARATION, handler(self, self._onChangeDeclaration), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, handler(self, self._onCityDeclareNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF, handler(self, self._onCityBeDeclaredNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_GETINFOONCITYBATTLEEND, handler(self, self._onGetInfoOnCityBattleEnd), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_ASSISTCITYNTF, handler(self, self._onAssistCityNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateUserCamps), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateBuildingAlli), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_CITYOCCUPIERNTF, handler(self, self._onCityOccupierNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_FARMMAPSHOWNTF, handler(self, self._onFarmShowNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_FARMBATTLEREPORT, handler(self, self._onFarmShowNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_FARMGIVEUP, handler(self, self._onFarmShowNtf), self)
	var_0_13:addEventListener(var_0_14.EVENT_NET_S2C_NEW_SLG_BOSSMONSTERTEAM, handler(self, self._onRcvNewSlgGetBossDefInfo), self)

	self._poolCamp = NewSlgCampPool.new(self._mapComp)
	self._poolMonster = NewSlgMonsterPool.new(self._mapComp)
	self._poolGate = NewSlgGatePool.new(self._mapComp)
	self._poolBuilding = NewSlgBuildingPool.new(self._mapComp)
	self._poolBoss = NewSlgBossPool.new(self._mapComp)
	self._poolChariot = NewSlgChariotPool.new(self._mapComp)
	self._compSelect = NewSlgSelectNode.new(self, self._mapComp)
	self._poolFarm = NewSlgFarmPool.new(self._mapComp)

	self._compSelect:setCustomVisible(false)
	self._floorNode:addChild(self._compSelect)
	self:_addChariotMoveSchedule()
end

function NewSlgMapNode:_onBattleShowEnd()
	self:_updateBuildings()
end

function NewSlgMapNode:_onSchedule(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.key == "NewSlgMapNode_ChariotMove" then
		self:_updateChariots()
	elseif arg_4_3.key == "NewSlgMapNode_ChariotGather" then
		self:_updateChariots()
	end
end

function NewSlgMapNode:onExit()
	if self._compSelect then
		self._compSelect:removeSelfAndClear(true)

		self._compSelect = nil
	end

	self._lastPos = nil

	self:clearAllPool()
	self.super.onExit(self)
end

function NewSlgMapNode:onTouchBegin(arg_6_1, arg_6_2)
	self.super.onTouchBegin(self, arg_6_1, arg_6_2)

	if self._compSelect then
		self._compSelect:setCustomVisible(false)
	end
end

function NewSlgMapNode:clearAllPool()
	self:_removeMarch()

	if self._poolCamp then
		self._poolCamp:clearPool()

		self._poolCamp = nil
	end

	if self._poolMonster then
		self._poolMonster:clearPool()

		self._poolMonster = nil
	end

	if self._poolGate then
		self._poolGate:clearPool()

		self._poolGate = nil
	end

	if self._poolBuilding then
		self._poolBuilding:clearPool()

		self._poolBuilding = nil
	end

	if self._poolBoss then
		self._poolBoss:clearPool()

		self._poolBoss = nil
	end

	if self._poolChariot then
		self._poolChariot:clearPool()

		self._poolChariot = nil
	end

	if self._poolFarm then
		self._poolFarm:clearPool()

		self._poolFarm = nil
	end

	self._monstersMapByRC = {}
	self._campsMapByRC = {}
	self._gates = {}
	self._cities = {}
	self._bosses = {}
	self._chariots = {}
	self._farms = {}

	self:_removeAllBattleNode()
end

function NewSlgMapNode:_setScaleToPool(arg_8_1)
	if self._poolCamp then
		self._poolCamp:setCustomScale(arg_8_1)
	end

	if self._poolMonster then
		self._poolMonster:setCustomScale(arg_8_1)
	end

	if self._poolGate then
		self._poolGate:setCustomScale(arg_8_1)
	end

	if self._poolBuilding then
		self._poolBuilding:setCustomScale(arg_8_1)
	end

	if self._poolBoss then
		self._poolBoss:setCustomScale(arg_8_1)
	end

	if self._poolChariot then
		self._poolChariot:setCustomScale(arg_8_1)
	end

	if self._poolFarm then
		self._poolFarm:setCustomScale(arg_8_1)
	end
end

function NewSlgMapNode:_updatePool(arg_9_1)
	if self._poolCamp and (not arg_9_1 or arg_9_1 == var_0_12.PLAYER_CASTLE) then
		for iter_9_0, iter_9_1 in pairs(self._campsMapByRC) do
			self._poolCamp:updateNode(iter_9_1)
		end
	end

	if self._poolMonster and (not arg_9_1 or arg_9_1 == var_0_12.MONSTER) then
		for iter_9_2, iter_9_3 in pairs(self._monstersMapByRC) do
			self._poolMonster:updateNode(iter_9_3)
			self:_checkBattle(iter_9_3, var_0_11.BATTLE_TYPE.MONSTER)
		end
	end

	if self._poolGate and (not arg_9_1 or arg_9_1 == var_0_12.GATE) then
		for iter_9_4, iter_9_5 in ipairs(self._gates) do
			self._poolGate:updateNode(iter_9_5)
		end
	end

	if self._poolBuilding and (not arg_9_1 or arg_9_1 == var_0_12.CITY) then
		for iter_9_6, iter_9_7 in ipairs(self._cities) do
			self._poolBuilding:updateNode(iter_9_7)
			self:_checkBattle(iter_9_7, var_0_11.BATTLE_TYPE.CITY)
		end
	end

	if self._poolBoss and (not arg_9_1 or arg_9_1 == var_0_12.TEAMBOSS) then
		for iter_9_8, iter_9_9 in ipairs(self._bosses) do
			self._poolBoss:updateNode(iter_9_9)
			self:_checkBattle(iter_9_9, var_0_11.BATTLE_TYPE.BOSS)
		end
	end

	if self._poolChariot and (not arg_9_1 or arg_9_1 == var_0_12.CHARIOT) then
		for iter_9_10, iter_9_11 in ipairs(self._chariots) do
			self._poolChariot:updateNode(iter_9_11)
		end
	end

	if self._poolFarm and (not arg_9_1 or arg_9_1 == var_0_12.FARM) then
		for iter_9_12, iter_9_13 in ipairs(self._farms) do
			self._poolFarm:updateNode(iter_9_13)
			self:_checkBattle(iter_9_13, var_0_11.BATTLE_TYPE.FARM)
		end
	end
end

function NewSlgMapNode:onClickArrowComp()
	self:selectCell()
	self:_jumpToCamp()
	self:_updateMonsters()
	self:_updateEyeArea()

	local var_10_0, var_10_1 = var_0_22(self._myCampRealPos.x, self._myCampRealPos.y)

	self._compSelect:setData({
		posX = var_10_0,
		posY = var_10_1
	})
end

function NewSlgMapNode:_onRcvNewSlgGetBossDefInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:_updateBosses()
end

function NewSlgMapNode:setCustomScale(arg_12_1)
	if self._compSelect then
		self._compSelect:setCustomScale(arg_12_1)
	end

	NewSlgMapNode.super.setCustomScale(self, arg_12_1)
end

function NewSlgMapNode:_getBarrierData(arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = self:_getRealPoint(arg_13_1, arg_13_2)
	local var_13_2 = var_0_15:getObjectDataByRC(var_13_0, var_13_1)

	if var_13_2 and var_13_0 == var_13_2.pos.x and var_13_1 == var_13_2.pos.y and var_13_2.type == var_0_12.GATE then
		return not var_0_15:isGateCanPass(var_13_2.value)
	end

	return var_0_15:isBarrier(var_13_0, var_13_1)
end

function NewSlgMapNode:_getRealPoint(arg_14_1, arg_14_2)
	local var_14_0 = 0
	local var_14_1 = 0

	if type(arg_14_1) == "table" then
		var_14_0 = arg_14_1.x
		var_14_1 = arg_14_1.y
	else
		var_14_0 = arg_14_1
		var_14_1 = arg_14_2
	end

	return var_14_0, var_14_1
end

function NewSlgMapNode:update(arg_15_1)
	if self._poolMonster and self._poolMonster.update then
		self._poolMonster:update(arg_15_1)
	end

	if self._poolBuilding and self._poolBuilding.update then
		self._poolBuilding:update(arg_15_1)
	end

	if self._poolChariot and self._poolChariot.update then
		self._poolChariot:update(arg_15_1)
	end

	if self._poolFarm and self._poolFarm.update then
		self._poolFarm:update(arg_15_1)
	end

	for iter_15_0, iter_15_1 in pairs(self._userMarches) do
		if not tolua.isnull(iter_15_1) and iter_15_1.update and iter_15_1:isVisible() then
			iter_15_1:update(arg_15_1)
		end
	end
end

function NewSlgMapNode:selectCell(arg_16_1, arg_16_2)
	if not arg_16_1 then
		self._lastPos = nil

		self._compSelect:setCustomVisible(false)
	else
		self:_clickMapCell(arg_16_1.x, arg_16_1.y, arg_16_2)
	end
end

function NewSlgMapNode:_onClickMapCell(arg_17_1, arg_17_2)
	local var_17_0 = cc.Director:getInstance():getWinSize()
	local var_17_1, var_17_2 = var_0_24((arg_17_1 - var_17_0.width / 2) / self._scale - self._mapNode:getPositionX(), (arg_17_2 - var_17_0.height / 2) / self._scale - self._mapNode:getPositionY())

	if self._lastPos then
		self._lastPos = nil

		return
	end

	self:_clickMapCell(var_17_1, var_17_2)
end

function NewSlgMapNode:_clickMapCell(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0, var_18_1 = var_0_23(arg_18_1, arg_18_2)

	if var_18_0 <= -1 or var_18_1 <= -1 or var_18_0 >= self._borderX or var_18_1 >= self._borderY then
		return
	end

	self._lastPos = {
		x = arg_18_1,
		y = arg_18_2
	}

	local var_18_2 = true
	local var_18_3 = self._monstersMapByRC[var_0_19(arg_18_1, arg_18_2)]
	local var_18_4 = self._campsMapByRC[var_0_19(arg_18_1, arg_18_2)]
	local var_18_5 = var_0_15:getObjectDataByRC(arg_18_1, arg_18_2)

	if var_18_3 then
		self:_showMonsterInfoComp(var_18_3)
	elseif var_18_4 then
		var_18_2 = false

		if var_18_4.id == g.core.model.User:getId() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER)
		else
			self._lastPos = nil

			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PLAYER_INFO, {
				uid = var_18_4.id
			})
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RankingSwitchPage)
	elseif var_18_5 then
		local var_18_6 = var_0_15:getComponentCfg(var_18_5.id)

		if var_18_6.type == var_0_12.CITY then
			local var_18_7, var_18_8 = var_0_15:canCityClick(var_18_6.value)

			if not var_18_7 then
				g.core.module.ModuleManager:tip(var_18_8)
			else
				self:_showCityInfoComp(var_18_6.value)
			end
		elseif var_18_6.type == var_0_12.TEAMBOSS then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RankingSwitchPage)

			if var_0_15:isBossFighting(var_18_6.value) then
				g.core.module.ModuleManager:tip(g.core.lang:get(428890))
			else
				self:_showBossInfoComp(var_18_6.value)
			end
		elseif var_18_6.type == var_0_12.CHARIOT then
			if var_0_15:getChariotShowState(var_18_5.value, var_18_5.value2) == var_0_11.Slg2ChariotShowState.gather then
				g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_CHARIOT_POP, {
					object = var_18_5
				})
			end
		elseif var_18_6.type == var_0_12.GATE then
			local var_18_9, var_18_10 = var_0_15:getCheckPointState(var_18_6.value)

			if var_18_9 == var_0_11.CheckPointState.UnActive then
				g.core.module.ModuleManager:tip(g.core.lang:get(428878, {
					name = var_18_10
				}))
			elseif var_18_9 == var_0_11.CheckPointState.UnPass then
				g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_POINT_QUEST_POP, var_18_6.value)
			else
				var_18_2 = false
			end
		elseif var_18_6.type == var_0_12.FARM then
			self:_showFarmInfoComp(var_18_6.value)
		else
			g.core.module.ModuleManager:tip("unkown type=" .. var_18_6.type)
		end
	else
		local var_18_11 = {
			pos = cc.p(arg_18_1, arg_18_2)
		}

		var_18_11.canMove = false

		if arg_18_3 and arg_18_3.forceMove then
			var_18_11.forceMove = true
		elseif var_0_15:isWater(arg_18_1, arg_18_2) then
			var_18_11.canMove = false
		elseif not self:_getBarrierData(arg_18_1, arg_18_2) then
			local var_18_12 = self:getPath(var_18_11.pos)

			var_18_11.path = var_18_12

			if var_18_12 and #var_18_12 > 1 then
				var_18_11.canMove = true
			elseif var_0_15:canMoveToBornProvince(var_18_11.pos) then
				var_18_11.canMove = true
			end
		end

		local var_18_13, var_18_14, var_18_15 = TileMapFunc._getUnitMapBigTileLayer(self._tiledMapData, arg_18_1, arg_18_2)

		if var_18_13 then
			local var_18_16 = var_0_15:getTerrainCfg((var_18_13:getTileGIDAt(cc.p(var_18_14, var_18_15))))

			if var_18_16 then
				var_18_11.name = var_18_16.name
				var_18_11.pic = var_18_16.pic
			end
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_build)
		self:_showMoveHomeComp(var_18_11)
	end

	if var_18_2 then
		local var_18_17, var_18_18 = var_0_22(arg_18_1, arg_18_2)

		self._compSelect:setData({
			posX = var_18_17,
			posY = var_18_18
		})
	end
end

function NewSlgMapNode:getPath(arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or self._myCampRealPos or cc.p(0, 0)

	return (self._aStar:getPath(arg_19_2, arg_19_1))
end

function NewSlgMapNode:jumpToPos(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0, var_20_1 = self:_getRealPoint(arg_20_1, arg_20_2)

	self:jumpToPosFinish(var_20_0, var_20_1)
	self:_clickMapCell(var_20_0, var_20_1)
end

function NewSlgMapNode:jumpToPosFinish(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0, var_21_1 = self:_getRealPoint(arg_21_1, arg_21_2)

	self:_moveRealPosToCenter(var_21_0, var_21_1, arg_21_3)
	self:_updateMonsters()
	self:_updateEyeArea()
end

function NewSlgMapNode:getCenterPos()
	local var_22_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())
	local var_22_1, var_22_2 = var_0_24(var_22_0.x, var_22_0.y)

	return cc.p(var_22_1, var_22_2)
end

function NewSlgMapNode:updateArrowComp()
	if not self._compArrow then
		return
	end

	local var_23_0 = self._myCampPos or cc.p(0, 0)
	local var_23_1 = cc.Director:getInstance():getWinSize()
	local var_23_2, var_23_3, var_23_4 = self:_isShowArrowComp((cc.p((var_23_0.x + self._mapNode:getPositionX() + var_23_1.width * (1 / self._scale) / 2) * self._scale, (var_23_0.y + self._mapNode:getPositionY() + var_23_1.height * (1 / self._scale) / 2) * self._scale)))

	self._compArrow:setVisible(var_23_2)

	if var_23_3 then
		self._compArrow:setAniRotate(var_23_3)
	end
end

function NewSlgMapNode:eventHandler(arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or {}

	if arg_24_1 == "TileMap_initLayerCell" then
		self:_getLayerCell(arg_24_2.data, "3*6_1", nil, self._3x6_1Node, 7)
		self:_getLayerCell(arg_24_2.data, "3*6_2", nil, self._3x6_2Node, 7)
		self:_getLayerCell(arg_24_2.data, "3*6_3", nil, self._3x6_3Node, 7)
		self:_getLayerCell(arg_24_2.data, "4*8", nil, self._4x8Node, 11)
		self:_getLayerCell(arg_24_2.data, "2*4_1", nil, self._2x4_1Node, 8)
		self:_getLayerCell(arg_24_2.data, "2*4_2", nil, self._2x4_2Node, 8)
		self:_getLayerCell(arg_24_2.data, "2*4_3", nil, self._2x4_3Node, 8)
		self:_getLayerCell(arg_24_2.data, "2*4_4", nil, self._2x4_4Node, 3)
		self:_getLayerCell(arg_24_2.data, "1*2", nil, self._1x2Node, 1)
	elseif arg_24_1 == "newSlg_chariot_updatePool" then
		self:_updateChariots()
	elseif arg_24_1 == "newSlg_city_updatePool" then
		self:_updateBuildings()
	elseif arg_24_1 == "newSlg_march_node_move_end" then
		var_0_15:setMarchUnitEnd(arg_24_2.data.id)
	else
		self._mapComp:dispatchCompEvent(arg_24_1, arg_24_2)
	end
end

function NewSlgMapNode:readyPlaySound()
	self._needPlaySound = true
end

function NewSlgMapNode:autoSilderEnd()
	self:_updateMonsters()
	self:_updatePool()
end

function NewSlgMapNode:_updateMyCampPos()
	local var_27_0 = var_0_15:getMyUserData()

	var_27_0.pos = var_27_0.pos or cc.p(0, 0)
	self._myCampRealPos = var_27_0.pos

	local var_27_1, var_27_2 = var_0_22(self._myCampRealPos.x, self._myCampRealPos.y)

	self._myCampPos = {
		x = var_27_1,
		y = var_27_2
	}
end

function NewSlgMapNode:_jumpToCamp(arg_28_1)
	local var_28_0 = self._myCampRealPos or cc.p(0, 0)
	local var_28_1, var_28_2 = var_0_22(var_28_0.x, var_28_0.y)

	self:_movePosToCenter(var_28_1, var_28_2, arg_28_1)
end

function NewSlgMapNode:_updateUserCamps()
	self:_updateCamps()
	self:_updateFarms()
end

function NewSlgMapNode:_updateBuildingAlli()
	self:_updateBuildings()
end

function NewSlgMapNode:updateCamp()
	self:_updateCamps()
end

function NewSlgMapNode:_updateCamps(arg_32_1)
	self._campsMapByRC = {}

	for iter_32_0, iter_32_1 in pairs((var_0_15:getUsersData())) do
		local var_32_1 = iter_32_1.pos or {}
		local var_32_2 = var_0_19(var_32_1.x, var_32_1.y)

		if (self._campsMapByRC[var_32_2] and iter_32_1.uid == self._campsMapByRC[var_32_2].id or nil) and false then
			self._campsMapByRC[var_32_2] = self:_genMapShowObject(var_32_1, iter_32_1.uid, g.core.model.User.newSlgDevelopData:getMainCityCfg(iter_32_1.mainCityLevel).theme_res, iter_32_1)
		end
	end

	if not arg_32_1 then
		for iter_32_2, iter_32_3 in pairs(self._campsMapByRC) do
			iter_32_3.isExist = false
		end

		self:_updatePool(var_0_12.PLAYER_CASTLE)
	end
end

function NewSlgMapNode:_updateGates(arg_33_1)
	if #self._gates == 0 then
		self._gates = {}

		if self._poolGate then
			self._poolGate:clearPool()
		end

		for iter_33_0, iter_33_1 in ipairs((var_0_15:getObjectDataByType(var_0_12.GATE))) do
			table.insert(self._gates, (self:_genMapShowObject(iter_33_1.pos, iter_33_1.id, var_0_15:getComponentCfg(iter_33_1.id).res_1, iter_33_1)))
		end
	else
		for iter_33_2, iter_33_3 in ipairs(self._gates) do
			iter_33_3.isExist = false
		end
	end

	if not arg_33_1 then
		self:_updatePool(var_0_12.GATE)
	end
end

function NewSlgMapNode:_initMonsterData()
	if self._monsterBlockDataByRC then
		return
	end

	self._monsterBlockDataByRC = {}

	for iter_34_0, iter_34_1 in pairs((var_0_15:getMonsterCvsData())) do
		local var_34_0, var_34_1 = var_0_21(iter_34_0)
		local var_34_2 = NewSlgFunc.getBlockCenterPos(var_34_0, var_34_1)
		local var_34_3 = var_0_19(var_34_2.x, var_34_2.y)

		self._monsterBlockDataByRC[var_34_3] = self._monsterBlockDataByRC[var_34_3] or {}

		table.insert(self._monsterBlockDataByRC[var_34_3], {
			gid = tonumber(iter_34_1),
			pos = cc.p(var_34_0, var_34_1)
		})
	end
end

function NewSlgMapNode:getCenterBlocks()
	local var_35_0 = self:getCenterPos()

	return (NewSlgFunc.getArroundBlockRC(NewSlgFunc.getBlockCenterPos(var_35_0.x, var_35_0.y), math.ceil(1 / self._scale), var_0_11.SERVER_BLOCK_NUM))
end

function NewSlgMapNode:getMonsterDataByBlock()
	self:_initMonsterData()

	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs((self:getCenterBlocks())) do
		local var_36_1 = self._monsterBlockDataByRC[var_0_19(iter_36_1.x, iter_36_1.y)] or {}

		if #var_36_1 > 0 then
			table.insertto(var_36_0, var_36_1)
		end
	end

	return var_36_0
end

function NewSlgMapNode:_genMapShowObject(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0, var_37_1 = var_0_22(arg_37_1.x, arg_37_1.y)

	return {
		pos = cc.p(arg_37_1.x, arg_37_1.y),
		posX = var_37_0,
		posY = var_37_1,
		id = arg_37_2,
		resId = arg_37_3,
		objectData = arg_37_4 or {}
	}
end

function NewSlgMapNode:_updateMonsters(arg_38_1)
	self._monstersMapByRC = {}

	for iter_38_0, iter_38_1 in ipairs((self:getMonsterDataByBlock())) do
		local var_38_0 = var_0_19(iter_38_1.pos.x, iter_38_1.pos.y)

		self._monstersMapByRC[var_38_0] = self._monstersMapByRC[var_38_0] or self:_genMapShowObject(iter_38_1.pos, var_38_0, var_38_0, iter_38_1)
	end

	if not arg_38_1 then
		for iter_38_2, iter_38_3 in pairs(self._monstersMapByRC) do
			iter_38_3.isExist = false
		end

		self:_updatePool(var_0_12.MONSTER)
	end
end

function NewSlgMapNode:_checkBattle(arg_39_1, arg_39_2)
	if arg_39_1 == nil then
		return
	end

	if arg_39_2 == nil then
		return
	end

	local var_39_0 = arg_39_1.objectData

	if arg_39_1.objectData then
		local var_39_1 = var_39_0.gid
		local var_39_2 = var_39_0.pos
		local var_39_3 = arg_39_2
		local var_39_4

		if arg_39_2 == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.MONSTER then
			var_39_4 = var_0_15:getMonsterInfoByGID(var_39_1).id
		elseif arg_39_2 == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.BOSS then
			var_39_4 = var_0_15:getComponentCfg(arg_39_1.id).value
		elseif arg_39_2 == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.CITY then
			var_39_4 = var_0_15:getComponentCfg(arg_39_1.id).value
		elseif arg_39_2 == g.core.const.ConstMgr.NewSlgConst.BATTLE_TYPE.FARM then
			var_39_4 = var_0_15:getComponentCfg(arg_39_1.id).value
		end

		local var_39_6 = string.format("%d_%d_%d_%d", var_39_1, var_39_3, var_39_2.x, var_39_2.y)
		local var_39_7 = {}

		for iter_39_0, iter_39_1 in pairs(self._battleMap) do
			if iter_39_1.tm <= g.core.common.ServerTime:getTime() then
				table.insert(var_39_7, iter_39_0)
			end
		end

		for iter_39_2, iter_39_3 in ipairs(var_39_7) do
			self:_removeBattleNode(iter_39_3)
		end

		local var_39_8 = var_0_15:getBattleReportData(var_39_3, var_39_4, var_39_2)

		if var_39_8 then
			if not var_39_8:isBattleFinish() then
				if self:isOutOfEye(arg_39_1.posX, arg_39_1.posY) then
					self:_removeBattleNode(var_39_6)
					print("移除界面 删除战斗场景")
				elseif self._battleMap[var_39_6] == nil then
					print("创建战斗场景")

					local var_39_9 = require("app.view.module.slg.view.cocosNode.NewSlgBattleNode"):create()

					var_39_9:updateGIDData({
						x = arg_39_1.posX,
						y = arg_39_1.posY,
						battleData = var_39_8,
						id = var_39_1,
						pos = var_39_2,
						target_id = var_39_4
					})
					self._headNode:addChild(var_39_9)

					self._battleMap[var_39_6] = {
						node = var_39_9,
						tm = var_39_8.battleEndTime
					}
				end
			else
				self:_removeBattleNode(var_39_6)
				print("战斗结束 删除战斗场景")
			end
		end
	end
end

function NewSlgMapNode:_removeBattleNode(arg_40_1)
	if self._battleMap[arg_40_1] and not tolua.isnull(self._battleMap[arg_40_1].node) then
		self._battleMap[arg_40_1].node:removeFromParent()
	end

	self._battleMap[arg_40_1] = nil
end

function NewSlgMapNode:_removeAllBattleNode()
	for iter_41_0, iter_41_1 in pairs(self._battleMap) do
		self:_removeBattleNode(iter_41_0)
	end

	self._battleMap = {}
end

function NewSlgMapNode:_updateMonster(arg_42_1)
	local var_42_0 = self._monstersMapByRC[var_0_19(arg_42_1.x, arg_42_1.y)]

	if var_42_0 and self._poolMonster then
		self._poolMonster:updateNode(var_42_0, true)
	end
end

function NewSlgMapNode:_updateCamp(arg_43_1)
	arg_43_1 = arg_43_1 or {}

	for iter_43_0, iter_43_1 in pairs(self._campsMapByRC) do
		if iter_43_1.id == arg_43_1.uid then
			iter_43_1.objectData = arg_43_1
			iter_43_1.isExist = false

			if self._poolCamp then
				self._poolCamp:updateNode(iter_43_1)
			end

			break
		end
	end
end

function NewSlgMapNode:_removeMarch()
	self._pathHeadNode:removeAllChildren()
	self._pathNode:removeAllChildren()

	self._userMarches = {}
end

function NewSlgMapNode:_updateMarches(arg_45_1)
	if not var_0_15:getRefreshMarch() then
		return
	end

	self:_removeMarch()

	for iter_45_0, iter_45_1 in pairs((var_0_15:getMarchUnit())) do
		if not iter_45_1.isPathEnd then
			local var_45_0 = require("app.view.module.slg.view.cocosNode.NewSlgMarchNode").new(self, self._mapComp)

			var_45_0:setData((self:_genMapShowObject(iter_45_1.startPos, iter_45_0, iter_45_0, iter_45_1)))

			self._userMarches[iter_45_0] = var_45_0

			self._pathHeadNode:addChild(var_45_0)
		end
	end
end

function NewSlgMapNode:_getServerBlockInfo(arg_46_1)
	local var_46_0 = cc.p(-self._mapNode:getPositionX(), -self._mapNode:getPositionY())

	self:_checkBlockData()

	if not arg_46_1 then
		if self._curBlock and self:_isInBlock(var_46_0, self._curBlock, var_0_17 * var_0_11.SERVER_BLOCK_NUM, var_0_18 * var_0_11.SERVER_BLOCK_NUM) then
			return false
		end

		for iter_46_0, iter_46_1 in pairs(self._blockMap) do
			if self:_isInBlock(var_46_0, iter_46_1.pos, var_0_17 * var_0_11.SERVER_BLOCK_NUM, var_0_18 * var_0_11.SERVER_BLOCK_NUM) then
				return false
			end
		end
	end

	local var_46_1, var_46_2 = var_0_24(var_46_0.x, var_46_0.y)
	local var_46_3 = NewSlgFunc.getBlockCenterPos(var_46_1, var_46_2)
	local var_46_4, var_46_5 = var_0_22(var_46_3.x, var_46_3.y)

	self._curBlock = cc.p(var_46_4, var_46_5)
	self._blockMap[var_0_19(var_46_4, var_46_5)] = {
		pos = cc.p(var_46_4, var_46_5),
		expire = g.core.common.ServerTime:getTime()
	}

	g.core.network.GameNetProxy:send_C2S_NewSlg_GetMapShowData({
		center = var_46_3
	})

	return true
end

function NewSlgMapNode:_onRcvEnter(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	self:_updateMyCampPos()

	if self._firstIn or var_0_15:isExpired() then
		self:_jumpToCamp()

		self._firstIn = false

		var_0_15:resetExpired()
	end

	if not var_0_15:getAStar() then
		var_0_15:setAStar(self._aStar)
	end

	self:_createEyeTileMap()
	self:_updateMonsters(true)
	self:_updateCamps(true)
	self:_updateGates(true)
	self:_updateBuildings(true)
	self:_updateBosses(true)
	self:_updateChariots(true)
	self:_updateFarms(true)
	self:_getServerBlockInfo(true)
end

function NewSlgMapNode:_onRcvNewSlgNotifyCheckpointQuest()
	self:_updateGates()
	self._mapComp:dispatchCompEvent("NewSlgMapNode_updatePassBtn")
end

function NewSlgMapNode:_onRcvNewSlgCityNtf()
	self:_updateBuildings()
	self:_updateChariots()
end

function NewSlgMapNode:_onRcvNewSlgBattleEnd()
	self:_updateBuildings()
end

function NewSlgMapNode:_onRcvMonsterResult(arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if arg_51_4.monster and g.core.model.User.newSlgData:getMonsterDataByRC(arg_51_4.monster.pos.x, arg_51_4.monster.pos.y) then
		self:_updateMonster(arg_51_4.monster.pos)
	end
end

function NewSlgMapNode:_onRcvAllianceIdChange()
	if not g.core.model.User.allianceData:hasAlliance() then
		self:_updateChariots()
	end
end

function NewSlgMapNode:_onRcvMarches(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if self._compSelect then
		self._compSelect:setCustomVisible(false)
	end

	self:_updateMarches()
	self:_updateBosses()
end

function NewSlgMapNode:_onRcvMoveRightNow(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	if self._compSelect then
		self._compSelect:setCustomVisible(false)
	end

	self:_updateCamps()
	self:_updateGates()
	self:_updateBuildings()
	self:_updateBosses()
	self:_updateChariots()
	self:_updateMarches()
	self:_updateMonsters()
end

function NewSlgMapNode:_onRcvMonsterBattleReport(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	self:_updatePool(var_0_12.MONSTER)
end

function NewSlgMapNode:_onRcvBossBattleReport()
	self:_updateBosses()
end

function NewSlgMapNode:_onRcvBlockInfo(arg_57_1, arg_57_2, arg_57_3, arg_57_4)
	if not self._updateCamps then
		return
	end

	self:_updateCamps()
	self:_updateGates()
	self:_updateBuildings()
	self:_updateBosses()
	self:_updateChariots()
	self:_updateMarches()
	self:_updateMonsters()
	self:_updateFarms()
end

function NewSlgMapNode:_onRcvMapShow(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	self:_updateCamps()
end

function NewSlgMapNode:_onRcvMoveHome(arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	self:_updateMyCampPos()

	self._lastPos = nil

	self._compSelect:setCustomVisible(false)
	self:_jumpToCamp()
	self:_updatePool()
	g.core.module.ModuleManager:tip(g.core.lang:get(428801))
end

function NewSlgMapNode:_updateRedpoint()
	self:_updateCamp((var_0_15:getMyUserData()))
end

function NewSlgMapNode:_updateBuildings(arg_61_1)
	if #self._cities == 0 then
		for iter_61_0, iter_61_1 in ipairs((var_0_15:getObjectDataByType(var_0_12.CITY))) do
			table.insert(self._cities, (self:_genMapShowObject(iter_61_1.pos, iter_61_1.id, var_0_15:getComponentCfg(iter_61_1.id).res_1, iter_61_1)))
		end
	else
		for iter_61_2, iter_61_3 in ipairs(self._cities) do
			iter_61_3.isExist = false
		end
	end

	if not arg_61_1 then
		self:_updatePool(var_0_12.CITY)
	end
end

function NewSlgMapNode:_updateBosses(arg_62_1)
	if #self._bosses == 0 then
		for iter_62_0, iter_62_1 in ipairs((var_0_15:getObjectDataByType(var_0_12.TEAMBOSS))) do
			table.insert(self._bosses, (self:_genMapShowObject(iter_62_1.pos, iter_62_1.id, var_0_15:getComponentCfg(iter_62_1.id).res_1, iter_62_1)))
		end
	else
		for iter_62_2, iter_62_3 in ipairs(self._bosses) do
			iter_62_3.isExist = false
		end
	end

	if not arg_62_1 then
		self:_updatePool(var_0_12.TEAMBOSS)
	end
end

function NewSlgMapNode:_updateChariots(arg_63_1)
	if #self._chariots == 0 then
		for iter_63_0, iter_63_1 in ipairs((var_0_15:getObjectDataByType(var_0_12.CHARIOT))) do
			table.insert(self._chariots, (self:_genMapShowObject(iter_63_1.pos, iter_63_1.id, var_0_15:getComponentCfg(iter_63_1.id).res_1, iter_63_1)))
		end
	else
		for iter_63_2, iter_63_3 in ipairs(self._chariots) do
			iter_63_3.isExist = false
		end
	end

	if not arg_63_1 then
		self:_updatePool(var_0_12.CHARIOT)
	end
end

function NewSlgMapNode:_updateFarms(arg_64_1)
	if #self._farms == 0 then
		for iter_64_0, iter_64_1 in ipairs((var_0_15:getObjectDataByType(var_0_12.FARM))) do
			table.insert(self._farms, (self:_genMapShowObject(iter_64_1.pos, iter_64_1.id, var_0_15:getComponentCfg(iter_64_1.id).res_1, iter_64_1)))
		end
	else
		for iter_64_2, iter_64_3 in ipairs(self._farms) do
			iter_64_3.isExist = false
		end
	end

	if not arg_64_1 then
		self:_updatePool(var_0_12.FARM)
	end
end

function NewSlgMapNode:_showMoveHomeComp(arg_65_1)
	local var_65_0 = self:getWindowPos(cc.p(var_0_22(arg_65_1.pos.x, arg_65_1.pos.y)))

	var_65_0.y = display.height - var_65_0.y

	self._mapComp:showTipsUI("newSlg", "NewSlgMoveComp", {
		pos = arg_65_1.pos,
		winPos = var_65_0,
		path = arg_65_1.path,
		name = arg_65_1.name,
		canMove = arg_65_1.canMove,
		forceMove = arg_65_1.forceMove,
		pic = arg_65_1.pic
	})
end

function NewSlgMapNode:_showMonsterInfoComp(arg_66_1)
	local var_66_0 = self:getWindowPos(cc.p(var_0_22(arg_66_1.pos.x, arg_66_1.pos.y)))

	var_66_0.y = display.height - var_66_0.y

	self._mapComp:showTipsUI("newSlg", "NewSlgMonsterInfoComp", {
		monster = arg_66_1,
		winPos = var_66_0,
		path = nil
	})
end

function NewSlgMapNode:_showCityInfoComp(arg_67_1)
	local var_67_0 = var_0_15:getCityComponentById(arg_67_1)
	local var_67_1 = self:getWindowPos(cc.p(var_0_22(var_67_0.anchor_x, var_67_0.anchor_y)))
	local var_67_2 = var_0_15:getObjectDataByRC(var_67_0.anchor_x, var_67_0.anchor_y)

	if var_67_2 then
		var_67_1 = self:getWindowPos(cc.p(var_0_22(var_67_2.centerRC.x, var_67_2.centerRC.y)))
	end

	var_67_1.y = display.height - var_67_1.y

	local var_67_3 = {
		cityId = arg_67_1,
		winPos = var_67_1
	}

	if var_0_15:getSName() == "S1" then
		self._mapComp:showTipsUI("newSlg", "NewSlgPvcCityInfoComp", var_67_3)
	elseif var_0_15:getSeasonId() >= 2 then
		if var_0_15:getCityPeriod() == var_0_11.Slg2CityState.gather and var_0_15:getCityOccupyAllianceId(arg_67_1) > 0 and var_0_15:isCityInShare(arg_67_1) then
			self._mapComp:showTipsUI("newSlg", "NewSlgS2CityInfoComp2", var_67_3)
		else
			self._mapComp:showTipsUI("newSlg", "NewSlgS2CityInfoComp1", var_67_3)
		end
	end
end

function NewSlgMapNode:_showFarmInfoComp(arg_68_1)
	local var_68_0 = g.core.model.User.newSlgData:getFarmComponentById(arg_68_1)
	local var_68_1 = self:getWindowPos(cc.p(var_0_22(var_68_0.anchor_x, var_68_0.anchor_y)))

	var_68_1.y = display.height - var_68_1.y

	self._mapComp:showTipsUI("newSlg", "NewSlgFarmInfoComp", {
		farmId = arg_68_1,
		winPos = var_68_1,
		path = self:getPath(cc.p(var_68_0.anchor_x, var_68_0.anchor_y))
	})
end

function NewSlgMapNode:_showBossInfoComp(arg_69_1)
	local var_69_0 = var_0_15:getBossComponentById(arg_69_1)
	local var_69_1 = self:getWindowPos(cc.p(var_0_22(var_69_0.anchor_x, var_69_0.anchor_y)))

	var_69_1.y = display.height - var_69_1.y

	self._mapComp:showTipsUI("newSlg", "NewSlgBossInfoComp", {
		bossId = arg_69_1,
		winPos = var_69_1,
		path = self:getPath(cc.p(var_69_0.anchor_x, var_69_0.anchor_y))
	})
end

function NewSlgMapNode:_addChariotMoveSchedule()
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgMapNode_ChariotMove",
		startTime = var_0_15:getChariotMoveTimeStartTime(),
		endTime = var_0_15:getChariotMoveTimeStartTime() + 5
	})
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgMapNode_ChariotGather",
		startTime = var_0_15:getChariotGatherStartTime(),
		endTime = var_0_15:getChariotGatherStartTime() + 5
	})
end

function NewSlgMapNode:_onChangeDeclaration()
	self:_updateBuildings()
end

function NewSlgMapNode:_onCityDeclareNtf()
	self:_updateBuildings()
	self:_updateChariots()
end

function NewSlgMapNode:_onAssistCityNtf()
	self:_updateChariots()
end

function NewSlgMapNode:_onCityOccupierNtf()
	self:_updateBuildings()
end

function NewSlgMapNode:_onFarmShowNtf()
	self:_updateFarms()
	self:_updatePool(var_0_12.FARM)
	self._mapComp:hideMapUI()
end

function NewSlgMapNode:_onCityBeDeclaredNtf()
	self:_updateBuildings()
end

function NewSlgMapNode:_onGetInfoOnCityBattleEnd()
	self:_updateBuildings()
	self:_updateChariots()
	self:_updateBosses()
	self:_updateMonsters()
end

return NewSlgMapNode
