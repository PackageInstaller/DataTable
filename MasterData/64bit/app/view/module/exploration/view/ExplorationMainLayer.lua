local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.guideData
local var_0_2 = g.core.const.ConstMgr.GuideConst
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local var_0_4 = g.core.const.ConstMgr.ExplorationConst
local var_0_5 = g.core.model.User.explorationData
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.event.enum
local ExplorationMainLayer = class("ExplorationMainLayer", require("app.fairyGUI.exploration.UI_ExplorationMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration",
		resName = "ExplorationMainLayer"
	}, ...)
end)

function ExplorationMainLayer:ctor()
	self._gameBtnStartPos = self.m_taskBtn:getPosition()

	var_0_6:dispatchEvent(var_0_7.EVENT_GUIDE_WAIT)
	self:initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.EXPLORATION)
end

function ExplorationMainLayer:initView()
	self:addBg("bg/exploration/bg_slmj_main.jpg", false, nil, 1)
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_openCardBtn:addClickListener(handler(self, self._onOpenCardBtnClick))
	self.m_wishTreeBtn:addClickListener(handler(self, self._onWishTreeBtnClick))
	self.m_packageRainBtn:addClickListener(handler(self, self._onPackageRainBtnClick))
	self.m_guildBuffBtn:addClickListener(handler(self, self._onGuildBuffBtnClick))
	self.m_helpHandBtn:addClickListener(handler(self, self._onHelpHandBtnClick))
	self.m_knightBtn:addClickListener(handler(self, self._onKnightBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_buffAttrBtn:addClickListener(handler(self, self._onBuffAttrBtnClick))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationBtnClick))
	self.m_actionPointComp:addClickListener(handler(self, self._onActionPointCompClick))
	self.m_serverComp:addClickListener(handler(self, self._onServerCompClick))
	self.m_miniMapComp:addClickListener(handler(self, self._onMiniMapClicked))
	self.m_mapComp:setStage(self)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.EXPLORATION_LAYER)
	self.m_topBarComp:setTitle(g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.EXPLORATION).name)
end

function ExplorationMainLayer:_checkTaskBtnVisible()
	self.m_taskBtn:setVisible(var_0_5:getTaskData():getCurTaskInfo() ~= nil)
	self:_updateTaskRedPoint()
	self:_onS2CExplorationUnlockCell()
end

function ExplorationMainLayer:_updateTaskRedPoint()
	var_0_6:dispatchEvent(var_0_7.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn,
		customData = {}
	})
end

function ExplorationMainLayer:onLoad()
	if var_0_5:getCurStage() ~= var_0_4.OPEN_STATE.NORMAL then
		var_0_0:tip(g.core.lang:get(420691))
		self:newScheduleOnce(var_0_0:switchModuleIntelligent(g.view.entrance.HOME))
	end

	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_EXPLORATION_UNLOCKCELL, handler(self, self._onS2CExplorationUnlockCell), self)

	if not var_0_5:getFormationData():isGetSvrFormation() then
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.EXPLORATION
		})
	end

	var_0_6:addEventListener(var_0_7.EVENT_STORY_END, self._onStoryEnd, self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_GUIDE_MOVE_TO_MIRROR, handler(self, self._guideMoveToMirror), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_GUIDE_CONTINUE, handler(self, self._guideMoveToMainRole), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_GUIDE_POP_MIRROR, handler(self, self._popupMirror), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_GUIDE_MOVE_TO_FIRST_MONSTER, handler(self, self._guideMoveToFirstMonster), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_GUIDE_MOVE_TO_SHOP, handler(self, self._guideMoveToShop), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_OPEN_KNIGHT_BAG, handler(self, self._openKnightBag), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onGetFormation), self)
	var_0_6:addEventListener(var_0_7.EVENT_GUIDE_FINISH, handler(self, self._checkTipsGuide), self)
	var_0_6:addEventListener(var_0_7.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_6:addEventListener(var_0_7.EXPLORATION_FORMATION_FIGHT_VALUE_CHECK, handler(self, self._checkFightValue), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._updateTaskRedPoint), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, handler(self, self._onS2CExplorationEventProcess), self)
	g.core.network.GameNetProxy:send_C2S_Exploration_GetServerInfos({})

	if g.core.model.User:getGuildId() > 0 then
		g.core.network.GameNetProxy:send_C2S_FriendHelper_ShowSetKnights({
			play_type = 1
		})
		g.core.network.GameNetProxy:send_C2S_FriendHelper_GetKnights({
			page = 1,
			play_type = 1,
			page_num = 10
		})
	end

	self:_onS2CExplorationUnlockCell()
	self:_refreshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)

	if var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE1) and not var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE2) then
		self:_guideMoveToMainRole()
	end

	self:_checkTaskBtnVisible()
	self:_checkSlaveGuide()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_FOREST)
	self:_checkFightValue()
end

function ExplorationMainLayer:_checkFightValue()
	local var_7_0 = var_0_5:getFormationData():getDiffFightValue()

	if var_7_0 > 0 then
		local var_7_1 = {
			otherFightValueChange = var_7_0
		}

		var_7_1.preValue = var_0_5:getFormationData():getMaxFormationFightValue()
		var_7_1.title = g.core.lang:get(420697)

		var_0_6:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, var_7_1)
	end
end

function ExplorationMainLayer:_onStoryEnd()
	self:_checkTipsGuide()
end

function ExplorationMainLayer:_onGetFormation(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_6:dispatchEvent(var_0_7.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn,
		customData = {}
	})

	if not arg_9_4.formations then
		var_0_5:getFormationData():autoSendFirstFormation()
	end
end

function ExplorationMainLayer:_onS2CExplorationUnlockCell()
	local var_10_0 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_FLOP)
	local var_10_1 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_TURNTABLE)
	local var_10_2 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_WALLET)
	local var_10_3 = {}

	if self.m_taskBtn:isVisible() then
		table.insert(var_10_3, self.m_taskBtn)
	end

	self.m_openCardBtn:setVisible(checkbool(var_10_0))

	if checkbool(var_10_0) then
		self.m_openCardBtn:setTitle(var_0_5:getMapData():getEventNumByType(var_0_4.EVENT_TYPE.GAME_FLOP))
		table.insert(var_10_3, self.m_openCardBtn)
	end

	self.m_wishTreeBtn:setVisible(checkbool(var_10_1))

	if checkbool(var_10_1) then
		self.m_wishTreeBtn:setTitle(var_0_5:getMapData():getEventNumByType(var_0_4.EVENT_TYPE.GAME_TURNTABLE))
		table.insert(var_10_3, self.m_wishTreeBtn)
	end

	self.m_packageRainBtn:setVisible(checkbool(var_10_2))

	if checkbool(var_10_2) then
		self.m_packageRainBtn:setTitle(var_0_5:getMapData():getEventNumByType(var_0_4.EVENT_TYPE.GAME_WALLET))
		table.insert(var_10_3, self.m_packageRainBtn)
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		iter_10_1:setPosition(cc.p(self._gameBtnStartPos.x, self._gameBtnStartPos.y + (iter_10_0 - 1) * 102))
	end
end

function ExplorationMainLayer:_onS2CExplorationEventProcess(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.event.tp == var_0_4.EVENT_TYPE.TIP_TASK then
		self.m_mapComp:triggerTaskByNet()
	else
		self:_refreshRedPoint()
	end
end

function ExplorationMainLayer:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "moveToMap" then
		if self.m_mapComp:isRoleMoving() then
			var_0_0:tip(g.core.lang:get(420689))
		else
			self.m_mapComp:getMapWorld():moveCell2SC(arg_12_2.coord)

			if arg_12_2.closePop then
				g.core.module.ModuleManager:popComponent()
			end
		end

		return true
	elseif arg_12_1 == "moveToRole" then
		if self.m_mapComp:isRoleMoving() then
			var_0_0:tip(g.core.lang:get(420689))
		else
			self.m_mapComp:getMapWorld():moveCell2SC((var_0_5:getMapData():getMainRoleCoordinate()))
		end

		return true
	elseif arg_12_1 == "moveToMirror" then
		if self.m_mapComp:isRoleMoving() then
			var_0_0:tip(g.core.lang:get(420689))
		else
			self.m_mapComp:getMapWorld():moveCell2SC((var_0_5:getMapData():getMirrorCoordinate()))
		end

		return true
	elseif arg_12_1 == "taskStateChange" then
		self:_checkTaskBtnVisible()

		return true
	end
end

function ExplorationMainLayer:updateTipIcon()
	local var_13_0 = self.m_mapComp:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_13_1 = var_0_5:getMapData()
	local var_13_2 = var_13_1:getMainRoleCoordinate()
	local var_13_3 = self.m_mapComp:getScale()

	self.m_tipPosComp:updateCompAngleAndPos(cc.p(self.m_mapComp:getMapWorld():getMapGround():coordToPixel(var_13_2.x, var_13_2.y)), var_13_0, var_13_1)

	local var_13_4 = var_0_5:getMapData():getMirrorCoordinate()

	self.m_mirrorDirBtn:updateCompAngleAndPos(cc.p(self.m_mapComp:getMapWorld():getMapGround():coordToPixel(var_13_4.x, var_13_4.y)), var_13_0, var_13_3)

	local var_13_5 = self.m_mapComp:getMapWorld()
	local var_13_6 = var_13_5:getMapGround()
	local var_13_7 = cc.size(var_13_6:getFixOFF())

	self.m_miniMapComp:updateMiniComp(var_13_0, cc.size(self.m_mapComp:getMapWorld():getMapGround():getMapWidth(), self.m_mapComp:getMapWorld().getMapGround(var_13_6).getMapHeight(var_13_5)), var_13_3)
end

function ExplorationMainLayer:_refreshRedPoint()
	var_0_6:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_formationBtn,
		customData = {}
	})
	var_0_6:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_mirrorDirBtn,
		customData = {}
	})
	var_0_6:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_knightBtn,
		customData = {}
	})
	self:_updateTaskRedPoint()
end

function ExplorationMainLayer:_onRankBtnClick()
	var_0_0:pushModule(g.view.entrance.EXPLORATION_RANK_LAYER)
end

function ExplorationMainLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.task.ExplorationTaskPop").new((var_0_5:getTaskData():getCurTaskInfo()))))
end

function ExplorationMainLayer:_onOpenCardBtnClick()
	local var_17_0 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_FLOP)

	if var_17_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.game.ExplorationTickGamePop").new(var_17_0)))
	end
end

function ExplorationMainLayer:_onWishTreeBtnClick()
	local var_18_0 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_TURNTABLE)

	if var_18_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.game.ExplorationTickGamePop").new(var_18_0)))
	end
end

function ExplorationMainLayer:_onPackageRainBtnClick()
	local var_19_0 = var_0_5:getMapData():getEventByType(var_0_4.EVENT_TYPE.GAME_WALLET)

	if var_19_0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.game.ExplorationTickGamePop").new(var_19_0)))
	end
end

function ExplorationMainLayer:_onGuildBuffBtnClick()
	if g.core.model.User.guildData:hasGuild() then
		local var_20_0 = require("app.view.module.exploration.view.buff.ExplorationGuildBuffPop").new()

		self:addListen(var_20_0)
		var_0_0:pushPopup(var_20_0)
	else
		var_0_0:tip(g.core.lang:get(420682))
	end
end

function ExplorationMainLayer:_onHelpHandBtnClick()
	if g.core.model.User:getGuildId() > 0 then
		var_0_0:pushPopup((require("app.view.module.exploration.view.formation.ExplorationFormationRentLayer").new()))
	else
		var_0_0:tip(g.core.lang:get(420682))
	end
end

function ExplorationMainLayer:_onKnightBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_BAG)
end

function ExplorationMainLayer:_onShopBtnClick()
	var_0_0:pushModule(g.view.entrance.EXPLORATION_PLAY_SHOP)
end

function ExplorationMainLayer:_onBuffAttrBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.buff.ExplorationBuffBagPop").new()))
end

function ExplorationMainLayer:_onFormationBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.EXPLORATION_FORMATION, {
		isMainEnter = true,
		teamNums = 3
	})
end

function ExplorationMainLayer:_onActionPointCompClick()
	return
end

function ExplorationMainLayer:_onServerCompClick()
	g.core.common.GlobalFunc.pushMatchServerPop({
		serverInfo = var_0_5:getServerList()
	})
end

function ExplorationMainLayer:_onMiniMapClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.miniMap.ExplorationMiniDetailPop").new()))
end

function ExplorationMainLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_29_0
	local var_29_1 = self.m_mapComp:getFloorComp():getFloorChildComp((var_0_5:getMapData():getMirrorCoordinate()))

	if var_29_1 then
		var_29_0 = var_29_1.m_icon
	end

	if not g.core.model.User.guideData:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE1) then
		g.core.model.User.guideData:setSaveServerData(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE1)
		self:newScheduleOnce(function()
			var_0_6:dispatchEvent(var_0_7.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "EXPLORATION_MAIN_LAYER_GUIDE1",
				objects = {
					self.m_guideHolder,
					self.m_mirrorDirBtn,
					[4] = var_29_0,
					[5] = self.m_guideHolder
				}
			})
		end, 0)
	end
end

function ExplorationMainLayer:_checkTipsGuide2()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_31_0
	local var_31_1 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_0_5:getMapData():getMainRoleCoordinate()))
	local var_31_2 = var_0_5:getMapData():getRoomStructByCoordinate(cc.p(var_31_1.x, var_31_1.y))
	local var_31_3 = var_31_2:getShopTiled()
	local var_31_4 = {}

	for iter_31_0, iter_31_1 in ipairs((var_31_2:getEntranceList(true))) do
		var_31_4[#var_31_4 + 1] = iter_31_1
	end

	while not var_31_3 do
		local var_31_5 = table.remove(var_31_4, 1)

		var_31_3 = var_31_5:getShopTiled()

		for iter_31_2, iter_31_3 in ipairs((var_31_5:getEntranceList(true))) do
			var_31_4[#var_31_4 + 1] = iter_31_3
		end
	end

	local var_31_6 = self.m_mapComp:getFloorComp():getFloorChildComp((var_31_3:getCoordinate()))

	if var_31_6 then
		var_31_0 = var_31_6.m_icon
	end

	if var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE1) and not var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE2) then
		var_0_1:setSaveServerData(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_MAIN_LAYER_GUIDE2)
		self:newScheduleOnce(function()
			var_0_6:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "EXPLORATION_MAIN_LAYER_GUIDE2",
				objects = {
					self.m_guideHolder,
					self.m_guideHolder,
					self.m_guideHolder,
					[5] = var_31_0
				}
			})
		end, 0)
	end
end

function ExplorationMainLayer:_checkSlaveGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_1:getServerDataById(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_SLAVE_GUIDE) then
		if #var_0_5:getFormationData():getWithinKnightList() > 0 then
			g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
			var_0_1:setSaveServerData(var_0_2.SAVE_SERVER_DATA_IDS.EXPLORATION_SLAVE_GUIDE)
			self:newScheduleOnce(function()
				var_0_6:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
					key = "EXPLORATION_SLAVE_GUIDE",
					objects = {
						self.m_knightBtn
					}
				})
			end, 0)
		end
	end
end

function ExplorationMainLayer:_guideMoveToMirror()
	self.m_mapComp:getMapWorld():moveCell2SC((var_0_5:getMapData():getMirrorCoordinate()))
end

function ExplorationMainLayer:_guideMoveToMainRole()
	self.m_mapComp:getMapWorld():moveCell2SC((var_0_5:getMapData():getMainRoleCoordinate()))
	g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
	self:newScheduleOnce(handler(self, self._checkTipsGuide2))
end

function ExplorationMainLayer:_guideMoveToFirstMonster()
	local var_37_0 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_0_5:getMapData():getMainRoleCoordinate()))
	local var_37_1 = var_0_5:getMapData():getRoomStructByCoordinate(cc.p(var_37_0.x, var_37_0.y))
	local var_37_2 = var_37_1:getEntranceList()

	for iter_37_0, iter_37_1 in pairs(var_0_4.DIRECTION) do
		local var_37_3

		if var_37_2[nil] then
			var_37_3 = iter_37_1
		end
	end

	self.m_mapComp:getMapWorld():moveCell2SC((cc.p(ExplorationMapCommon.getGlobalCoordinateByRoomAndRoomCoordinate(var_37_1, (var_37_1:getTileEntranceStruct(var_0_4.DIRECTION.RIGHT):getCoordinate())))))
end

function ExplorationMainLayer:_guideMoveToShop()
	local var_38_0 = ExplorationMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate((var_0_5:getMapData():getMainRoleCoordinate()))
	local var_38_1 = var_0_5:getMapData():getRoomStructByCoordinate(cc.p(var_38_0.x, var_38_0.y))
	local var_38_2 = var_38_1:getShopTiled()
	local var_38_3 = {}

	for iter_38_0, iter_38_1 in ipairs((var_38_1:getEntranceList(true))) do
		var_38_3[#var_38_3 + 1] = iter_38_1
	end

	while not var_38_2 do
		var_38_1 = table.remove(var_38_3, 1)
		var_38_2 = var_38_1:getShopTiled()

		for iter_38_2, iter_38_3 in ipairs((var_38_1:getEntranceList(true))) do
			var_38_3[#var_38_3 + 1] = iter_38_3
		end
	end

	self.m_mapComp:getMapWorld():moveCell2SC((cc.p(ExplorationMapCommon:getGlobalCoordinateByRoomAndRoomCoordinate((var_38_2:getCoordinate())))))
end

function ExplorationMainLayer:_popupMirror()
	self:newScheduleOnce(function()
		local var_40_0 = var_0_5:getMapData()
		local var_40_1, var_40_2 = var_40_0:getRoomStructAndLocalCoordinate(var_40_0:getMirrorCoordinate())

		g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.map.ExplorationMapMirrorPop").new((var_40_1:getTiledStruct(var_40_2)))))
	end)
end

function ExplorationMainLayer:_openKnightBag()
	self:_onKnightBtnClick()
end

function ExplorationMainLayer:_onCrossDayUpdate()
	if var_0_5:getCurStage() ~= var_0_4.OPEN_STATE.NORMAL then
		var_0_0:tip(g.core.lang:get(420691))
		var_0_0:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function ExplorationMainLayer:onUnload()
	var_0_6:dispatchEvent(var_0_7.EVENT_GUIDE_READY)
	var_0_6:dispatchEvent(var_0_7.EVENT_TICK_TIP_GUIDE_FINISH)
end

return ExplorationMainLayer
