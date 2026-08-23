local NewSlgMainLayer = class("NewSlgMainLayer", function()
	return fgui.GComponent:create({
		isFullScreen = true,
		resName = "NewSlgMainLayer",
		pkgName = "newSlg",
		otherPkgPath = "ui/newSlg_mapUI/newSlg_mapUI",
		pkgPath = "ui/newSlg/newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.SCALE
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.MAP_PARAMETER.MIN_SCALE
local NewSlgMapNode = require("app.view.module.slg.view.cocosNode.NewSlgMapNode")
local var_0_5 = g.core.model.User.newSlgData
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.event.enum
local var_0_8 = g.core.common.ServerTime

function NewSlgMainLayer:ctor(arg_2_1)
	g.core.config:checkConfigDataClear(true)
	g.core.resource.ResourceManager:clearResource()
	g.core.resource.ResourceManager:luaGCCollect()

	arg_2_1 = arg_2_1 or {}
	self._isEnterFinish = false
	self._autoPopResult = false
	self._params = arg_2_1

	self:addBg("bg/newSlg/bg_map.png")
	var_0_5:initMapInfo()
	fgui.UIPackage:addPackage("ui/newSlg_mapUI/newSlg_mapUI")

	self._comTopBar = self:getChild("ComTopBar")

	self:_updateTopBar()

	self._compUI = self:getChild("Comp_ui")

	self._compUI:setVisible(false)

	self._compMap = self:getChild("Comp_map")

	self._compMap:initTileMap(NewSlgMapNode)
	self._compMap:setCustomScale(var_0_1.MAP_PARAMETER.SCALE)
	self._compMap:setMapUI(self:getChild("Comp_place"))

	self._map = self._compMap:getMapNode()

	self._compUI:setMap(self._map)

	self._popEndTime = 0

	self._comTopBar:setResInfoById(344, nil, {
		{
			value = 60005,
			type = 3
		},
		{
			value = 60006,
			type = 3
		}
	})

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self._comTopBar:setHelpId(376)
	end

	local var_2_0 = self:getChild("Comp_head")

	self._arrowComp = var_2_0

	var_2_0:setVisible(false)
	self._map:setArrowComp(var_2_0)
	var_2_0:addClickListener(handler(self, self._onClickArrowComp))

	self._compEffect = self:getChild("Comp_effect")
	self._compTouch = self:getChild("Comp_touch")

	self._compTouch:addClickListener(handler(self, self._onClickTouch))

	self._battleResultMap = {}
	self._exeQueue = {}
	self._paramsInit = true
	self._compFarmResult = self:getChild("Comp_farmResult")

	self._compFarmResult:setVisible(false)

	self._farmResultInitX = self._compFarmResult:getX()
	self._farmResults = {}
	self._compLamu = self:getChild("Comp_lamuPlace")

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))

	self._loadedTexture = {}

	self:_initTexture()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG)
end

function NewSlgMainLayer:_initTexture()
	local var_3_0 = var_0_5:getMapId()
	local var_3_1 = 1

	while cc.FileUtils:getInstance():isFileExist(("tile_map/new_slg/monsters/SLGxe_" .. 1) .. ".png") do
		self:doLoadTexture("tile_map/new_slg/monsters/SLGxe_" .. 1)

		var_3_1 = var_3_1 + 1

		local var_3_3 = cc.FileUtils:getInstance():isFileExist(("tile_map/new_slg/monsters/SLGxe_" .. var_3_1) .. ".png")
	end

	self:doLoadTexture("tile_map/new_slg/slg" .. var_3_0 .. "/building_texture/texture")
	self:doLoadTexture(cc.FileUtils:getInstance():isFileExist("tile_map/new_slg/slg" .. var_3_0 .. "/chariot/texture.plist") and "tile_map/new_slg/slg" .. var_3_0 .. "/chariot/texture" or "tile_map/new_slg/chariot/texture")

	while g.core.common.Path:isFileExist("tile_map/new_slg/icon_texture/head_texture_" .. 0 .. ".png") do
		self:doLoadTexture("tile_map/new_slg/icon_texture/head_texture_" .. 0)
	end
end

function NewSlgMainLayer:doLoadTexture(arg_4_1)
	if cc.FileUtils:getInstance():isFileExist(arg_4_1 .. ".plist") then
		table.insert(self._loadedTexture, arg_4_1)
		display.loadSpriteFrames(arg_4_1 .. ".plist", arg_4_1 .. ".png")
		cc.SpriteFrameCache:getInstance():retainSpriteFrames(arg_4_1 .. ".plist")
	end
end

function NewSlgMainLayer:doRemoveTexture(arg_5_1)
	cc.SpriteFrameCache:getInstance():releaseSpriteFrames(arg_5_1 .. ".plist")
	display.removeSpriteFrames(arg_5_1 .. ".plist", arg_5_1 .. ".png")

	self._loadedTexture[arg_5_1] = nil
end

function NewSlgMainLayer:onUnload()
	self._compUI:setVisible(false)
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMainLayer_schedule_exeQueue")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgSettleComp_updateTime")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgAttackCityBubble_updateTime")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgGatherComp_schedule")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgEnd_updateTime")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlg_ReqBattle_data")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgFarmCountDownBtn_updateSch")
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMainLayer_schedule_farmResult")

	self._battleResultMap = {}
	self._exeQueue = {}
	self._isExecuteQueue = false
end

function NewSlgMainLayer:_removeTexture()
	for iter_7_0, iter_7_1 in ipairs(self._loadedTexture) do
		self:doRemoveTexture(iter_7_1)
	end
end

function NewSlgMainLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SLG_S4)
	var_0_5:initComponents()
	self:_checkJumpPos()
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self._onRcvEnter), self)
	var_0_6:addEventListener(var_0_7.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_OBTAINBATTLEREWARD, handler(self, self._onRcvNewSlgObtainBattleReward), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_FLUSHBATTLERESULTS, handler(self, self._onRcvNewSlgFlushBattleResults), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_CITYBATTLEEND, handler(self, self._onRcvNewSlgBattleEnd), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_BOSSBATTLEFINISHNOTIFY, handler(self, self._onRcvNewSlgBattleEnd), self)
	var_0_6:addEventListener(var_0_1.GOTO_SHARE_POS, handler(self, self._gotoSharedPos), self)
	var_0_6:addEventListener(var_0_1.GOTO_BOSS_INVITE_POS, handler(self, self._gotoBossInvitePos), self)
	var_0_6:addEventListener(var_0_1.OPEN_SEARCH, handler(self, self._openSearch), self)
	var_0_6:addEventListener(var_0_1.OPEN_TEAM_BATTLE, handler(self, self._openTeamBattle), self)
	var_0_6:addEventListener(var_0_7.EVENT_RET_ERROR, handler(self, self._onRetError), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_NOTIFYMONSTERBATTLERESULT, handler(self, self._onRcvNewSlgBattleEnd), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_CITYBATTLEALLISUMMARYNTF, handler(self, self._onRcvS2CityBattleEnd), self)
	var_0_6:addEventListener(var_0_7.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_GETINFOONCITYBATTLEEND, handler(self, self.onGetAllCityInfo), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	var_0_6:addEventListener(var_0_7.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayNotify), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_FARMAWARD, handler(self, self._onRcvFarmGetAward), self)
	var_0_6:addEventListener(var_0_7.EVENT_GUIDE_FINISH, handler(self, self._checkGuide), self)
	var_0_6:addEventListener(var_0_7.APP_ENTER_FOREGROUND_EVENT, handler(self, self._onReconnect), self)
	var_0_6:addEventListener(var_0_7.EVENT_NEW_SLG_RESET_SEASON, handler(self, self._onResetSeason), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_FARMBATTLEREPORT, handler(self, self._onRcvGetFarmBattleResult), self)
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_NEW_SLG_FARMGIVEUP, handler(self, self._onRcvGiveUpFarm), self)
	var_0_6:addEventListener(var_0_7.SLG_RED_REFRESH_EVENT, handler(self, self.onRedRefreshEvent), self)
	var_0_6:addEventListener(var_0_7.SLG_FARM_JUMP_STEP_2, handler(self, self.onJumpToFarm), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_NewSlg_Enter({})

	self._isExecuteQueue = false

	self:newScheduleOnce(handler(self, function()
		if not tolua.isnull(self) then
			self._compTouch:setVisible(false)
		end
	end), 3)
	self._map:updateCamp()

	if var_0_5:isNeedOpenSearch() then
		self:_openSearch()
	elseif var_0_5:isNeedOpenTeamBattle() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TOTAL_TEAM)
	end

	if var_0_5:isFarmOpen() then
		self:_checkFarmResult()
	end

	g.core.utils.Tools.newSlgFunc.addSchedule({
		isOnce = true,
		key = "NewSlg_ReqBattle_data",
		startTime = g.core.model.User.newSlgData:getCityBattleEndTime()
	})
end

function NewSlgMainLayer:_openTeamBattle()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TOTAL_TEAM)
end

function NewSlgMainLayer:_onReconnect()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_NewSlg_Enter({})
end

function NewSlgMainLayer:_onResetSeason()
	return
end

function NewSlgMainLayer:onRedRefreshEvent()
	g.core.network.GameNetProxy:send_C2S_NewSlg_Enter({})
end

function NewSlgMainLayer:_checkJumpPos()
	local var_14_0 = var_0_5:getJumpPos()

	if var_14_0 then
		self._map:jumpToPosFinish(var_14_0)
		self._compUI:hideUI()
	end
end

function NewSlgMainLayer:_onRecGuideStop()
	self:_checkGuide()
end

function NewSlgMainLayer:_checkGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_16_0 = g.core.const.ConstMgr.GuideConst
	local var_16_1 = g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.NEW_SLG_STEP_GUIDE

	if var_0_5:getSName() == "S2" then
		var_16_1 = var_16_0.SAVE_SERVER_DATA_IDS.NEW_SLG_STEP_GUIDE_S2
	end

	if not g.core.model.User.guideData:getServerDataById(var_16_1) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_16_0.ENUM_TICK.NEW_SLG_STEP_GUIDE
		})
		g.core.model.User.guideData:setSaveServerData(var_16_1)
		g.core.model.User.guideData:setGuideTickedFinish(40)
	end
end

function NewSlgMainLayer:_onNoticeState()
	g.core.module.ModuleManager:tip(g.core.lang:get(429037))
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function NewSlgMainLayer:_onRetError(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if arg_18_4 == g.core.network.proto.MSG_S2C_NewSlg_Enter then
		g.core.module.ModuleManager:popModule()
	elseif arg_18_4 == g.core.network.proto.MSG_S2C_NewSlg_ObtainBattleReward then
		self._isExecuteQueue = false
	end
end

function NewSlgMainLayer:_onSchedule(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_3.id or 0

	if arg_19_3.key == "NewSlgMainLayer_addBattleResult_" .. var_19_0 then
		self:_addResultInQueue(var_19_0)
	elseif arg_19_3.key == "NewSlgMainLayer_schedule_exeQueue" then
		self:_autoPop()
	elseif arg_19_3.key == "NewSlg_ReqBattle_data" then
		self:newScheduleOnce(function()
			g.core.network.GameNetProxy:send_C2S_NewSlg_GetInfoOnCityBattleEnd({})
		end, math.random(100, 300) / 100)
	elseif arg_19_3.key == "NewSlgMainLayer_schedule_farmResult" then
		self:_checkFarmResult()
	end
end

function NewSlgMainLayer:_checkFarmResult()
	if self._farmResults[1] then
		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgMainLayer_schedule_farmResult"
		})

		if g.core.guide.GuideProxy:isGuideRunning() then
			return
		end

		local var_21_0 = g.core.common.ServerTime:getTime()

		if not self._farmResults[1].showTime then
			self._farmResults[1].showTime = var_21_0

			self:_showFarmResult(self._farmResults[1])
		elseif var_21_0 > self._farmResults[1].showTime + 5 then
			self:_hideFarmResult()
		end
	else
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMainLayer_schedule_farmResult")
	end
end

function NewSlgMainLayer:_showFarmResult(arg_22_1)
	self._compFarmResult:setVisible(true)
	self._compFarmResult:stopAllFGActions()
	self._compFarmResult:updateView(arg_22_1)
	self._compFarmResult:runFGAction((fgui.FSequence:create(fgui.FSequence:create(fgui.FMoveTo:create(1, cc.p(0, self._compFarmResult:getY()))))))
end

function NewSlgMainLayer:_hideFarmResult()
	if #self._farmResults > 0 then
		table.remove(self._farmResults, 1)
	end

	self._compFarmResult:stopAllFGActions()
	self._compFarmResult:setVisible(false)
	self._compFarmResult:setX(self._farmResultInitX)
end

function NewSlgMainLayer:getMapNode()
	return self._map
end

function NewSlgMainLayer:_updateUIView()
	return
end

function NewSlgMainLayer:_updateTopBar()
	self._comTopBar:setReturnCallBack(handler(self, function()
		g.core.module.ModuleManager:popComponent()
	end))
	self._comTopBar:setHomeCallBack(handler(self, function()
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end))
end

function NewSlgMainLayer:_onTouchBegin(arg_29_1)
	local var_29_0 = arg_29_1:getInput():getTouch():getLocation()
end

function NewSlgMainLayer:_onClickArrowComp()
	self:_onClickUIComp()
	self._map:onClickArrowComp()
end

function NewSlgMainLayer:_onClickTouch()
	return
end

function NewSlgMainLayer:_onClickJumpTo()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.NewSlgJumpToPop").new(), {
		touchDisappear = true
	})
end

function NewSlgMainLayer:_onClickMap()
	self._compUI:hideUI()
end

function NewSlgMainLayer:_onClickUIComp()
	self._compMap:hideMapUI()
	self._map:selectCell()
end

function NewSlgMainLayer:_onSliderChanged(arg_35_1)
	print("NewSlgMainLayer:_onSliderChanged ", 0.01 * arg_35_1 * (var_0_2 - var_0_3) + var_0_3, "value = ", arg_35_1)
	self._map:setCustomScale(0.01 * arg_35_1 * (var_0_2 - var_0_3) + var_0_3)
end

function NewSlgMainLayer:_onModuleExit(arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_3 and arg_36_3.params

	if not (arg_36_3 and arg_36_3.params) then
		return
	end

	if var_36_0 and var_36_0.tag and (var_36_0 and var_36_0.tag) == "NewSlgMainLayer_exeQueue" then
		self._isExecuteQueue = false
	end
end

function NewSlgMainLayer:_autoPop()
	if self._exeQueue[1] then
		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgMainLayer_schedule_exeQueue"
		})

		if not self._isEnterFinish and self._exeQueue[1].key == "CITY_RESULT_POP" then
			return
		end

		if g.core.guide.GuideProxy:isGuideRunning() then
			return
		end

		if self._isExecuteQueue then
			return
		end

		table.remove(self._exeQueue, 1)
		self._exeQueue[1].func(self._exeQueue[1].data)
	else
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMainLayer_schedule_exeQueue")
	end
end

function NewSlgMainLayer:receiveCompEvent(arg_38_1, arg_38_2)
	arg_38_2 = arg_38_2 or {}

	if arg_38_1 == "BaseMapComp_onTouchBegin" then
		self:_onClickMap()
	elseif arg_38_1 == "NewSlgMainUIComp_onTouchBegin" then
		self:_onClickUIComp()
	elseif arg_38_1 == "NewSlg_slider" then
		self:_onSliderChanged(arg_38_2.value)
	elseif arg_38_1 == "NewSlg_slider_end" then
		self._map:autoSilderEnd()
	elseif arg_38_1 == "NewSlg_selectCell" then
		self._map:selectCell(arg_38_2.pos, {
			showArrow = arg_38_2.showArrow
		})
	elseif arg_38_1 == "NewSlg_jumpToPos" then
		self._map:jumpToPos(arg_38_2.pos)
		self._compUI:hideUI()
	elseif arg_38_1 == "NewSlg_jumpToPos_withoutClick" then
		self._map:jumpToPosFinish(arg_38_2.pos, nil, arg_38_2.callback)
		self._compUI:hideUI()
	elseif arg_38_1 == "NewSlg_City_Gather" then
		if arg_38_2.key then
			if (self._lastKey or -1) == arg_38_2.key then
				return
			end

			self._lastKey = arg_38_2.key
		end

		if var_0_5:isChariotMoveTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428898))

			return
		end

		if not var_0_5:isChariotGatherTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428895))

			return
		end

		self:receiveCompEvent("NewSlgMainLayer_hideAllUI")

		if var_0_5:getSName() == "S1" then
			local var_38_1 = var_0_5:getChariotComponentById(arg_38_2.info.id)
			local var_38_2 = var_0_5:getCityComponentById(arg_38_2.info.id)

			arg_38_2.path = self._map:getPath(cc.p(var_38_1.anchor_x, var_38_1.anchor_y))
			arg_38_2.returnPath = self._map:getPath(cc.p(var_38_2.anchor_x, var_38_2.anchor_y))
		elseif (arg_38_2.gatherTp or 0) == 0 then
			local var_38_4 = var_0_5:getSelfAdjacentOccupyCities(arg_38_2.info.id)[1] or 0
			local var_38_5 = var_0_5:getChariotComponentById(arg_38_2.info.id, var_38_4)

			if not var_38_5 then
				return
			end

			local var_38_6 = var_0_5:getCityComponentById(arg_38_2.info.id)

			arg_38_2.path = self._map:getPath(cc.p(var_38_5.anchor_x, var_38_5.anchor_y))
			arg_38_2.returnPath = self._map:getPath(cc.p(var_38_6.anchor_x, var_38_6.anchor_y))
			arg_38_2.value2 = var_38_4
		else
			local var_38_7 = var_0_5:getCityComponentById(arg_38_2.info.id)

			arg_38_2.path = self._map:getPath(cc.p(var_38_7.anchor_x, var_38_7.anchor_y))
			arg_38_2.returnPath = self._map:getPath(cc.p(var_38_7.anchor_x, var_38_7.anchor_y))
		end

		g.core.module.ModuleManager:pushPopup((require("app.view.module.slg.view.team.NewSlgTeamSelectPop").new(arg_38_2)))
	elseif arg_38_1 == "NewSlgTeamInfoBubbleComp_clickFarm" then
		local var_38_8 = g.core.model.User.newSlgData:getMyTeamByIndex(arg_38_2.teamIndex)

		if not var_38_8 then
			return
		end

		local var_38_9 = g.core.model.User.newSlgData:getTeamStateByTeam(var_38_8).targetPoint or cc.p(0, 0)
		local var_38_10 = g.core.model.User.newSlgData:getFarmInfoByRC(var_38_9.x, var_38_9.y)

		if not var_38_10 then
			return
		end

		if not self:_checkCanFarm(var_38_10) then
			return
		end

		g.core.module.ModuleManager:pushPopup((require("app.view.newSlg.farm.NewSlgFarmConfirmPop").new({
			tp = 2,
			id = var_38_10.id,
			handlerParam = {
				team_index = arg_38_2.teamIndex
			}
		})))
	elseif arg_38_1 == "NewSlgFarmConfirmPop_ok" then
		if arg_38_2.tp == 1 then
			self:dispatchCompEvent("NewSlg_play_march_sound")
			g.core.network.GameNetProxy:send_C2S_NewSlg_FarmMarch(arg_38_2.content)
		elseif arg_38_2.tp == 2 then
			g.core.network.GameNetProxy:send_C2S_NewSlg_FarmDefToFarm(arg_38_2.content)
		end

		g.core.module.ModuleManager:popAllPopup()
	elseif arg_38_1 == "NewSlg_Farm_Gather" then
		if arg_38_2.marchTp == g.core.const.ConstMgr.NewSlgConst.FARM_SERVER_TYPE.FARM then
			if not self:_checkCanFarm(arg_38_2.info) then
				return
			end
		elseif arg_38_2.marchTp == g.core.const.ConstMgr.NewSlgConst.FARM_SERVER_TYPE.ATK and not var_0_5:isFarmPeriod() then
			g.core.module.ModuleManager:tip(g.core.lang:get(429693))

			return
		end

		self:receiveCompEvent("NewSlgMainLayer_hideAllUI")

		local var_38_12 = var_0_5:getFarmComponentById(arg_38_2.info.id)
		local var_38_13 = self._map:getPath(cc.p(var_38_12.anchor_x, var_38_12.anchor_y))

		if not var_38_13 then
			g.core.module.ModuleManager:tip(g.core.lang:get(429715))

			return
		end

		arg_38_2.path = var_38_13

		g.core.module.ModuleManager:pushPopup((require("app.view.module.slg.view.team.NewSlgTeamSelectPop").new(arg_38_2)))
	elseif arg_38_1 == "NewSlg_City_Declare" then
		if var_0_5:getCityPeriod() ~= var_0_1.Slg2CityState.declare_war then
			self:receiveCompEvent("NewSlgMainLayer_hideAllUI")

			return
		end

		local var_38_14 = arg_38_2.cityId

		if not var_0_5:isCityCanDeclare(arg_38_2.cityId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(429046))
			self:receiveCompEvent("NewSlgMainLayer_hideAllUI")

			return
		end

		g.core.network.GameNetProxy:send_C2S_NewSlg_CityDeclare({
			city_id = var_38_14,
			tp = arg_38_2.tp
		})
	elseif arg_38_1 == "NewSlg_Boss_Gather" then
		if arg_38_2.bossTeam and arg_38_2.bossTeam.is_leaved then
			g.core.module.ModuleManager:tip(g.core.lang:get(428929))

			return
		end

		if arg_38_2.bossTeam and arg_38_2.bossTeam.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_3 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428939))

			return
		end

		if arg_38_2.bossTeam and arg_38_2.bossTeam.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_2 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428940))

			return
		end

		if arg_38_2.bossTeam then
			local var_38_15 = arg_38_2.bossTeam.users or {}

			if #var_38_15 >= 4 then
				local var_38_16 = false

				for iter_38_0, iter_38_1 in ipairs(var_38_15) do
					if iter_38_1.robot_info_id > 0 then
						var_38_16 = true

						break
					end
				end

				if not var_38_16 then
					g.core.module.ModuleManager:tip(g.core.lang:get(428941))

					return
				end
			end
		end

		local var_38_17 = var_0_5:getPathByTmpl((var_0_5:getBossComponentById(arg_38_2.info.id)))

		if not var_38_17 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428907))

			return
		end

		if arg_38_2.bossTeam and arg_38_2.bossTeam.create_time + var_0_5:getBossTeamGatherTotalTime() < var_0_8:getTime() + g.core.utils.Tools.newSlgFunc.getMarchDurationByPath(var_38_17, var_0_5:getMyPrivilegePer(), var_0_1.MONSTER_TYPE.BOSS) then
			g.core.module.ModuleManager:tip(g.core.lang:get(428932))

			return
		end

		if var_0_5:getBossChallengedLevel() < arg_38_2.info.level - 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428938, {
				level = arg_38_2.info.level - 1
			}))

			return
		end

		arg_38_2.path = var_38_17

		if var_0_5:getBossChallengeTime() == 0 then
			g.core.utils.Tools.newSlgFunc.openTeamBossAssistPop({
				callback = handler(self, self._openTeamSelectByBoss),
				data = arg_38_2
			})

			return
		end

		self:_openTeamSelectByBoss(arg_38_2)
	elseif arg_38_1 == "NewSlg_MoveTo_BornPrvince" then
		self._map:selectCell(arg_38_2.pos, {
			forceMove = arg_38_2.forceMove
		})
	elseif arg_38_1 == "NewSlgMainLayer_hideAllUI" then
		self._compUI:hideUI()
		self._compMap:hideMapUI()
		self._map:selectCell()
	elseif arg_38_1 == "NewSlgMapNode_updatePassBtn" then
		self._compUI:updateGatePassBtn()
	elseif arg_38_1 == "NewSlg_play_march_sound" then
		self._map:readyPlaySound()
	elseif arg_38_1 == "NewSlg_Touch_Close_ui" then
		self._compUI:hideUI()
	elseif arg_38_1 == "NewSlg_SearchBtn_Click" then
		-- block empty
	elseif arg_38_1 == "input_pop_cancel" then
		if arg_38_2.bindInfo.txtType == var_0_1.Slg2CityNoticeEvent then
			g.core.network.GameNetProxy:send_C2S_NewSlg_SetCityDeclaration({
				declaration = "",
				city_id = arg_38_2.bindInfo.cityId
			})
			g.core.module.ModuleManager:popComponent()
		end
	elseif arg_38_1 == "NewSlgFarmResult_close" then
		self:_hideFarmResult()
	end
end

function NewSlgMainLayer:_onRcvFarmDefToFarm()
	return
end

function NewSlgMainLayer:_checkCanFarm(arg_40_1)
	return true
end

function NewSlgMainLayer:_onRcvGetFarmBattleResult(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	self:_addBattleResult(arg_41_4.result)
	self:_autoPop()

	if arg_41_4.result and arg_41_4.result.id and arg_41_4.result.id > 0 and arg_41_4.result.type == var_0_1.REPORT.SVR_TYPE.NEW_SLG_REPORT_TYPE_FARM and arg_41_4.result.awards then
		-- block empty
	end

	local var_41_0 = arg_41_4.report

	if arg_41_4.report then
		local var_41_1 = false

		for iter_41_0, iter_41_1 in ipairs(self._farmResults) do
			if iter_41_1.reportId and iter_41_1.reportId == var_41_0.report_id then
				var_41_1 = true

				break
			end
		end

		if not var_41_1 then
			var_41_0.isDef = false

			local var_41_2 = var_41_0.is_win
			local var_41_3 = 0

			for iter_41_2, iter_41_3 in ipairs(var_41_0.atk_teams or {}) do
				if iter_41_3.user and iter_41_3.user.uid == g.core.model.User:getId() then
					var_41_3 = iter_41_3.team_id
				end
			end

			local var_41_4 = 0

			for iter_41_4, iter_41_5 in ipairs(var_41_0.battles or {}) do
				if iter_41_5.atk_team == var_41_3 then
					var_41_4 = iter_41_4
				end
			end

			if var_41_4 > 0 then
				var_41_0.isDef = false
				var_41_2 = var_41_0.battles[var_41_4].is_win
			else
				local var_41_5 = {}

				for iter_41_6, iter_41_7 in ipairs(var_41_0.def_teams or {}) do
					if iter_41_7.user and iter_41_7.user.uid == g.core.model.User:getId() then
						table.insert(var_41_5, iter_41_7.team_id)
					end
				end

				local var_41_6 = 0

				for iter_41_8, iter_41_9 in ipairs(var_41_0.battles or {}) do
					if table.contain(var_41_5, iter_41_9.def_team) then
						var_41_6 = iter_41_8
					end
				end

				if var_41_6 > 0 then
					var_41_0.isDef = true
					var_41_2 = not var_41_0.battles[var_41_6].is_win
				end
			end

			local var_41_7 = {
				tp = 0,
				desc = "",
				costTitle = "",
				titleColorIndex = 1,
				title = "",
				awards = {},
				reportId = var_41_0.report_id
			}

			if var_41_0.score and var_41_0.score > 0 then
				({})[1] = {
					type = g.core.common.Goods.TYPE_RESOURCE,
					value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION,
					size = arg_41_4.result.score
				}
				var_41_7.tp = 0
			else
				var_41_7.tp = 2
			end

			if var_41_2 then
				var_41_7.title = g.core.lang:get(429694)
				var_41_7.titleColorIndex = 1
			else
				var_41_7.title = g.core.lang:get(429695)
				var_41_7.titleColorIndex = 2

				if not g.core.model.User.newSlgData:isCityInShare(g.core.model.User.newSlgData:getFarmInfoById(var_41_0.def_id).belong) then
					var_41_7.tp = 1
					var_41_7.desc = g.core.lang:get(429697, {
						num = g.core.model.User.newSlgData:getNewSlgParamsValueById(190) / 10
					})
				end
			end

			table.insert(self._farmResults, var_41_7)
			self:_checkFarmResult()
		end
	end
end

function NewSlgMainLayer:_openTeamSelectByBoss(arg_42_1)
	self:receiveCompEvent("NewSlgMainLayer_hideAllUI")
	g.core.module.ModuleManager:pushPopup((require("app.view.module.slg.view.team.NewSlgTeamSelectPop").new(arg_42_1)))
end

function NewSlgMainLayer:_dealCityBattleResult(arg_43_1)
	if arg_43_1 and arg_43_1.city_battle_result then
		arg_43_1.city_battle_result.final_alli_rank = arg_43_1.city_battle_result.final_alli_rank or 0

		if arg_43_1.city_battle_result.final_winner then
			if arg_43_1.city_battle_result.final_alli_rank == 1 then
				self:showNewSlgPvcFinalResultSuc({
					result = arg_43_1
				})
			else
				self:showNewSlgPvcFinalResult({
					result = arg_43_1
				})
			end
		elseif arg_43_1.city_battle_result.is_win then
			self:showNewSlgPvcNormalSuc({
				result = arg_43_1
			})
		else
			self:showNewSlgPvcNormalFail({
				result = arg_43_1
			})
		end
	else
		self._isExecuteQueue = false
	end
end

function NewSlgMainLayer:_dealBossBattleResult(arg_44_1)
	if arg_44_1 and arg_44_1.boss_battle_result then
		if arg_44_1.boss_battle_result.is_win then
			self:showNewSlgBossSucResult({
				result = arg_44_1
			})
		else
			self:showNewSlgBossFailResult({
				result = arg_44_1
			})
		end
	else
		self._isExecuteQueue = false
	end
end

function NewSlgMainLayer:_dealMonsterBattleResult(arg_45_1)
	if arg_45_1 then
		if arg_45_1.awards and #arg_45_1.awards > 0 then
			g.core.module.ModuleManager:awardSummary(arg_45_1.awards, nil, nil, nil, handler(self, function(arg_46_0)
				arg_46_0._isExecuteQueue = false
			end))
		else
			self._isExecuteQueue = false
		end
	end
end

function NewSlgMainLayer:_onRcvFarmGetAward(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = g.core.model.User.newSlgData:getFarmInfoById(arg_47_4.farm_id)

	if arg_47_4.tp == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429712, {
			name = var_47_0.name
		}))
	elseif arg_47_4.tp == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429713, {
			name = var_47_0.name
		}))
	elseif arg_47_4.tp == 3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429714, {
			name = var_47_0.name
		}))
	end
end

function NewSlgMainLayer:_onRcvGiveUpFarm()
	g.core.module.ModuleManager:tip(g.core.lang:get(429705))
end

function NewSlgMainLayer:_onRcvEnter(arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	self._compTouch:setVisible(false)
	self:_updateUIView()
	self._compUI:updateView()
	self._compUI:getTransition("enter"):play(handler(self, function()
		self._isEnterFinish = true

		self:_checkGuide()
	end))
	self._compUI:setVisible(true)
	self:_dealInitParams()

	if not self._autoPopResult then
		if g.core.model.User.newSlgData:getSName() == "S2" and var_0_5:getCityResultServerData() then
			local var_49_0, var_49_1 = var_0_5:isCityPopTime()

			if var_49_0 then
				if var_49_1 ~= (var_0_5:loadCache("auto_pop_time_cache_finish_time") or 0) and self._popEndTime ~= var_49_1 then
					if g.core.common.ServerTime:getIsSameDay(var_0_5:getActStartTime()) then
						if g.core.common.ServerTime:getTime() > var_0_5:getCityBattleEndTime() then
							g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)
						end
					elseif not var_0_5:isCityBattleTime() then
						g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)
					end

					var_0_5:saveCache("auto_pop_time_cache_finish_time", var_49_1)

					self._popEndTime = var_49_1
				end
			end
		end

		self._autoPopResult = true
	end
end

function NewSlgMainLayer:onGetAllCityInfo()
	local var_51_0, var_51_1 = var_0_5:isCityPopTime()

	if (var_0_5:loadCache("auto_pop_time_cache_finish_time") or 0) ~= var_51_1 and var_51_0 and g.core.model.User.newSlgData:getSName() == "S2" and var_0_5:getCityResultServerData() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)

		self._popEndTime = var_0_5:getCityBattleStartTime() + 86400

		var_0_5:saveCache("auto_pop_time_cache_finish_time", self._popEndTime)
	end
end

function NewSlgMainLayer:_dealInitParams()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self._paramsInit = false

		return
	end

	if self._paramsInit then
		if self._params.route1 then
			if type(self._params.route1) == "table" then
				self._map:jumpToPosFinish(self._params.route1)
			elseif type(self._params.route1) == "number" and self._params.route1 == 1 then
				self:_openSearch()
			end
		elseif self._params.bossInviteInfo then
			self:newScheduleOnce(handler(self, function()
				self:_gotoBossInvitePos(nil, nil, self._params.bossInviteInfo)
			end), 1)
		end

		self._paramsInit = false
	end
end

function NewSlgMainLayer:_gotoSharedPos(arg_54_1, arg_54_2, arg_54_3)
	self._map:jumpToPos(arg_54_3)
end

function NewSlgMainLayer:_gotoBossInvitePos(arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = var_0_5:getBossComponentById(arg_55_3.bossId)
	local var_55_1 = g.core.utils.Tools.newSlgFunc.getMarchDurationByPath(var_0_5:getPathByTmpl(var_55_0), 0, var_0_1.MONSTER_TYPE.BOSS)

	if var_55_1 > 0 then
		self._map:jumpToPos(cc.p(var_55_0.anchor_x, var_55_0.anchor_y))
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TEAM_LIST_POP, {
			bossId = arg_55_3.bossId,
			teamId = arg_55_3.teamId,
			duration = var_55_1
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428933))
	end
end

function NewSlgMainLayer:_openSearch()
	self._compUI:setCompSearchVis(true, {})
end

function NewSlgMainLayer:_dealResultScore(arg_57_1, arg_57_2)
	if arg_57_1.score and arg_57_1.score > 0 then
		local var_57_0 = arg_57_2.awards or {}
		local var_57_1 = false

		for iter_57_0, iter_57_1 in ipairs(var_57_0) do
			if iter_57_1.type == g.core.common.Goods.TYPE_RESOURCE and iter_57_1.value == g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION then
				var_57_1 = true

				break
			end
		end

		if not var_57_1 then
			table.insert(var_57_0, 1, {
				type = g.core.common.Goods.TYPE_RESOURCE,
				value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION,
				size = arg_57_1.score
			})
		end

		arg_57_1.awards = var_57_0
	else
		arg_57_1.awards = arg_57_2.awards or {}
	end
end

function NewSlgMainLayer:_onRcvNewSlgObtainBattleReward(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	local var_58_0 = clone(self._battleResultMap[arg_58_4.id])

	self._battleResultMap[arg_58_4.id] = nil

	if arg_58_4.has_award then
		self._isExecuteQueue = false
	else
		self:_addLamuEffect(var_58_0, handler(self, function(arg_59_0)
			if var_58_0 then
				arg_59_0:_dealResultScore(var_58_0, arg_58_4)

				if var_58_0.boss_battle_result then
					arg_59_0:_dealBossBattleResult(var_58_0)
				elseif var_58_0.monster_battle_result then
					arg_59_0:_dealMonsterBattleResult(var_58_0)
				elseif var_58_0.city_battle_result then
					arg_59_0:_dealCityBattleResult(var_58_0)
				else
					arg_59_0._isExecuteQueue = false
				end
			else
				arg_59_0._isExecuteQueue = false
			end
		end))
	end
end

function NewSlgMainLayer:_onRcvNewSlgFlushBattleResults(arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	for iter_60_0, iter_60_1 in ipairs(arg_60_4.results or {}) do
		self:_addBattleResult(iter_60_1)
	end

	self:_autoPop()
end

function NewSlgMainLayer:_sendObtainBattleReward(arg_61_1)
	self._isExecuteQueue = true

	if not self._battleResultMap[arg_61_1.id] then
		self._isExecuteQueue = false

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainBattleReward(arg_61_1)
end

function NewSlgMainLayer:_onRcvNewSlgBattleEnd(arg_62_1, arg_62_2, arg_62_3, arg_62_4)
	self:_addBattleResult(arg_62_4.result)
	self:_autoPop()
end

function NewSlgMainLayer:_onRcvS2CityBattleEnd(arg_63_1, arg_63_2, arg_63_3, arg_63_4)
	return
end

function NewSlgMainLayer:_popLastReport()
	if g.core.model.User.newSlgData:getSName() == "S2" and g.core.model.User.newSlgData:getCityPeriod() ~= var_0_1.Slg2CityState.battle then
		local var_64_0 = g.core.model.User.newSlgData:getCityResultServerData()

		if var_64_0 and var_64_0.cities and #var_64_0.cities > 0 and self:_canAutoPopS2CityResultByTime() and self:_checkCanPushToList() then
			table.insert(self._exeQueue, {
				key = "CITY_RESULT_POP",
				data = {},
				func = handler(self, function(arg_65_0)
					g.core.model.User.newSlgData:saveCache("S2_cityResult_autoPop_time", g.core.common.ServerTime:getTime() + (86400 - g.core.model.User.newSlgData:getSlgInfo().attack_begin_time))

					if var_0_5:isCityBattleTime() then
						g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_CITY_RESULT)
					end
				end)
			})
		end
	end
end

function NewSlgMainLayer:_checkCanPushToList()
	for iter_66_0, iter_66_1 in ipairs(self._exeQueue) do
		if iter_66_1.key and iter_66_1.key == "CITY_RESULT_POP" then
			return false
		end
	end

	return true
end

function NewSlgMainLayer:_addLamuEffect2(arg_67_1)
	return
end

function NewSlgMainLayer:_canAutoPopS2CityResultByTime()
	local var_68_0 = g.core.model.User.newSlgData:loadCache("S2_cityResult_autoPop_time")

	if var_68_0 == 0 then
		return true
	end

	if self:secondsFromToday(var_68_0) < 0 then
		return true
	end

	return false
end

function NewSlgMainLayer:secondsFromToday(arg_69_1)
	local var_69_0 = var_0_8:getTime() + (86400 - var_0_5:getSlgInfo().attack_begin_time)
	local var_69_1 = var_0_8:getDateObject(var_69_0)

	return arg_69_1 - (var_69_0 - var_69_1.hour * 3600 - var_69_1.min * 60 - var_69_1.sec)
end

function NewSlgMainLayer:_addBattleResult(arg_70_1)
	if arg_70_1 and arg_70_1.id and arg_70_1.id > 0 then
		if self._battleResultMap[arg_70_1.id] then
			self:_autoPop()

			return
		end

		self._battleResultMap[arg_70_1.id] = arg_70_1

		if var_0_8:getTime() < arg_70_1.timestamp then
			g.core.utils.Tools.newSlgFunc.addSchedule({
				isOnce = true,
				key = "NewSlgMainLayer_addBattleResult_" .. arg_70_1.id,
				id = arg_70_1.id,
				startTime = arg_70_1.timestamp
			})
		else
			self:_addResultInQueue(arg_70_1.id)
		end
	end
end

function NewSlgMainLayer:_addResultInQueue(arg_71_1)
	table.insert(self._exeQueue, {
		data = {
			id = arg_71_1
		},
		func = handler(self, self._sendObtainBattleReward)
	})
end

function NewSlgMainLayer:_addLamuEffect(arg_72_1, arg_72_2)
	if not arg_72_1 then
		if arg_72_2 then
			arg_72_2()
		end

		return
	end

	if arg_72_1.type ~= var_0_1.BATTLE_TYPE.FARM then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.pvc.NewSlgPvcFinishPop").new({
			result = arg_72_1,
			callback = arg_72_2
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	elseif arg_72_2 then
		arg_72_2()
	end
end

function NewSlgMainLayer:showNewSlgPvcNormalSuc(arg_73_1)
	local var_73_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgPvcNormalSucPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_73_1)

	var_73_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_suc"
	})

	return g.core.module.ModuleManager:pushPopup(var_73_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:showNewSlgPvcNormalFail(arg_74_1)
	local var_74_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgPvcNormalFailPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_74_1)

	var_74_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_suc"
	})

	return g.core.module.ModuleManager:pushPopup(var_74_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:showNewSlgPvcFinalResult(arg_75_1)
	local var_75_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgPvcFinalResultPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_75_1)

	var_75_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_suc"
	})

	return g.core.module.ModuleManager:pushPopup(var_75_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:showNewSlgPvcFinalResultSuc(arg_76_1)
	local var_76_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgPvcFinalResultSucPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_76_1)

	var_76_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_suc"
	})

	return g.core.module.ModuleManager:pushPopup(var_76_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:showNewSlgBossSucResult(arg_77_1)
	local var_77_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgBossSucPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_77_1)

	var_77_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_suc"
	})

	return g.core.module.ModuleManager:pushPopup(var_77_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:showNewSlgBossFailResult(arg_78_1)
	local var_78_0 = require("app.view.showPop.ShowPop").new({
		isFullScreen = false,
		resName = "ShowNewSlgBossFailPop",
		pkgName = "newSlg",
		pkgPath = "ui/newSlg/newSlg"
	}, arg_78_1)

	var_78_0:playSpineAnim("effTitle", {
		isLoop = false,
		name = "eff_ui_newSlg_popTitle",
		remove = true,
		anim = "play_fail"
	})

	return g.core.module.ModuleManager:pushPopup(var_78_0, {
		tag = "NewSlgMainLayer_exeQueue",
		withoutAni = true
	})
end

function NewSlgMainLayer:_onCrossDayNotify()
	g.core.network.GameNetProxy:send_C2S_NewSlg_Enter({})

	if var_0_5:getActEndTime() <= var_0_8:getTime() then
		self:newScheduleOnce(handler(self, function()
			g.core.module.ModuleManager:replaceModule(g.view.entrance.NEW_SLG_END_SHOW_LAYER)
		end), 1)
	end
end

function NewSlgMainLayer:onRemoved()
	self:_removeTexture()
	self._map:onRemoved()
	fgui.UIPackage:removePackage("ui/newSlg_mapUI/newSlg_mapUI")
	var_0_5:exitSlg()
	g.core.network.GameNetProxy:send_C2S_NewSlg_Leave({})
end

function NewSlgMainLayer:onJumpToFarm(arg_82_1, arg_82_2, arg_82_3)
	self._map:jumpToPos(arg_82_3.pos)
	self._compUI:hideUI()
end

return NewSlgMainLayer
