local RiskGameWorld = require("app.view.module.summerTheme.view.explore.world.RiskGameWorld")
local RiskMapConst = require("app.view.module.summerTheme.view.explore.world.RiskMapConst")
local RiskEvent = require("app.view.module.summerTheme.view.explore.world.RiskEvent")
local RiskEventTrigger = require("app.view.module.summerTheme.view.explore.world.RiskEventTrigger")
local var_0_4 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreStage = class("ThemeExploreStage", require("app.fairyGUI.summerTheme.UI_ThemeExploreStage"), function()
	return fgui.GComponent:create({
		resName = "ThemeExploreStage",
		pkgPath = "ui/summerTheme/summerTheme",
		isFullScreen = true,
		pkgName = "summerTheme"
	}, ...)
end)

function ThemeExploreStage:ctor(arg_2_1)
	self._param = arg_2_1

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_4.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_4.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapterFinishCall = nil
	self._curOpeObject = nil
	self._timePowerEffObj = nil
	self._lastFightEntity = nil
	self._isInHideUI = false
	self._mapWorld = nil
	self._worldId = arg_2_1.info.chapter_map
	self._curChapterId = arg_2_1.info.id
	self._toMainRoleId = arg_2_1.info.knight_id
	self._refChapterInfo = arg_2_1.info
	self._riskStorage = nil
	self._stayCoord = nil
	self._riskEventDict = nil
	self._riskEventDoArr = nil
	self._riskEventDoing = nil
	self._finishRiskEventArr = nil
	self._roleKillMonsterNum = 0
	self._tipsComp = nil
	self._tmpMovieParams = nil
	self._intervalTime = 0

	self:saveNewFlag()
	self:initRiskStage()
	self:mergeArchive()
end

function ThemeExploreStage:onLoad()
	if self._activeThemeValue == var_0_4.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_SHENGQIANG_EXPLORE)
	end

	self:_initRegisterMSG()
	self.m_enterTransition:play()
	self:getMapWorld():startObserver(self.m_touchMap)
	self:getMapWorld():startWorld()
	self:_refreshRoleInfo()
	self:updateStageTopView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, true, (RiskEventTrigger.new(RiskMapConst.TRIGGER_TYPE.FIRST)))
	self:checkFightResultState()
	self:_loadSnowMovie(self._refChapterInfo)
	self:newScheduleOnce(handler(self, self._popToHome))
end

function ThemeExploreStage:onUnload()
	self:getMapWorld():stopObserver(self.m_touchMap)

	if self._timePowerEffObj and not tolua.isnull(self._timePowerEffObj) then
		self._timePowerEffObj:removeSelf()

		self._timePowerEffObj = nil
	end

	self.m_criComp:removeAllCriSprite()
end

function ThemeExploreStage:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_RISK_" then
		-- block empty
	end
end

function ThemeExploreStage:saveNewFlag()
	g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():saveChapterNewCache(self._activeThemeValue, self._curChapterId)
end

function ThemeExploreStage:initRiskStage()
	self:_initMapWorld()
	self:_initStageData()
	self:_initStageUI()
end

function ThemeExploreStage:mergeArchive(arg_8_1)
	local var_8_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData()
	local var_8_1 = var_8_0:getExploreMapData(self._curChapterId)

	if not var_8_1 then
		return
	end

	if var_8_1.pos and (var_8_1.pos.x ~= 0 or var_8_1.pos.y ~= 0) then
		self._stayCoord = var_8_1.pos
	end

	if var_8_1.trigger_events then
		self:_mergeRiskEvent(var_8_1.trigger_events)
	end

	if var_8_1.kill_num then
		self._roleKillMonsterNum = var_8_1.kill_num
	end

	local var_8_2 = false

	if var_8_1.object_state then
		self:getMapWorld():mergeDeserializeEntity(var_8_1.object_state)

		var_8_2 = true
	else
		local var_8_3 = var_8_0:getChapterBoxAward(self._curChapterId)

		if var_8_3 then
			local var_8_4 = {}

			for iter_8_0, iter_8_1 in pairs(var_8_3) do
				if iter_8_1 then
					table.insert(var_8_4, {
						num = 0,
						id = iter_8_0
					})

					var_8_2 = true
				end
			end

			self:getMapWorld():mergeDeserializeEntity(var_8_4)
		end
	end

	local var_8_5 = var_8_1.pass_grids

	if var_8_1.pass_grids then
		-- block empty
	elseif var_8_2 then
		var_8_5 = {}
	end

	self:_initCloudData(var_8_5)

	if var_8_1.car_pos then
		self:getMapWorld():mergeDeserializeCarPos(var_8_1.car_pos)
	end
end

function ThemeExploreStage:getMapWorld()
	return self._mapWorld
end

function ThemeExploreStage:getMapGround()
	return self._mapWorld:getMapGround()
end

function ThemeExploreStage:saveStayCoord(arg_11_1)
	self:_setSaveMapInfo()

	self._stayCoord = arg_11_1
end

function ThemeExploreStage:getStayCoord()
	return self._stayCoord
end

function ThemeExploreStage:_initMapWorld()
	self._mapWorld = RiskGameWorld.new(self, self._worldId, self._toMainRoleId)

	self.m_worldHold:addNode(self._mapWorld)
end

function ThemeExploreStage:_initStageData()
	self:_deserializeRisk()
	self:_initRiskEventConfig()
end

function ThemeExploreStage:_initStageUI()
	self._displayInfo = g.core.config.activity_theme_display_info.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.explore_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.explore_name)
	self.m_resetBtn:addClickListener(handler(self, self._onResetBtnClick))
	self.m_timePowerBtn:addClickListener(handler(self, self._onTimePowerBagClick))
	self.m_locationBtn:addClickListener(handler(self, self._onLocationBtnClick))
	self.m_lineUpBtn:addClickListener(handler(self, self._onLineUpBtnClick))
	self.m_touchPanel:addClickListener(handler(self, self._onSawppingTouch))
end

function ThemeExploreStage:_initRegisterMSG()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_SAVEMAPINFO, self._onExploreSaveMap, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_RISK_MAIN_COORD_CHANGE, self._onRiskMainRoleCoordChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, self._onRiskEventCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_BEGINCHALLENGE, self._onBattleChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_RESETINFO, self._onExploreReset, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETBOXAWARD, self.onGetBoxAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETINFO, self.updateStageTopView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_HPRECOVER, self._recoverHpEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_EXPLORE_GETMONSTERHP, self._onGetMonsterHp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_EXPLORE_SELECT_POWER, self._onGetTimePowerEff, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function ThemeExploreStage:_serializeRisk()
	g.core.common.Storage:save("risk_theme_stage.json", self._riskStorage)
end

function ThemeExploreStage:_deserializeRisk()
	local var_18_0 = g.core.common.Storage:load("risk_theme_stage.json") or {}

	if var_18_0.tips_num == nil then
		var_18_0.tips_num = 0
	end

	self._riskStorage = var_18_0
end

function ThemeExploreStage:_loadSnowMovie(arg_19_1)
	if g.core.utils.Quality.needCloseWeather() then
		return
	end

	if not arg_19_1 or not arg_19_1.effect or arg_19_1.effect == "" then
		return
	end

	self.m_criComp:removeAllCriSprite()

	self._intervalTime = arg_19_1.time or 0

	local var_19_0 = {}

	var_19_0.x = 25
	var_19_0.y = 25
	var_19_0.fullScreenState = 1
	var_19_0.movieName = arg_19_1.effect
	var_19_0.isLoop = true
	var_19_0.moduleName = "biography"

	if self._intervalTime > 0 then
		var_19_0.listener = handler(self, self._onCriSpriteEvent)
	end

	self._tmpMovieParams = var_19_0

	self:newScheduleOnce(handler(self, self._delayCreateMovie), self._intervalTime)
end

function ThemeExploreStage:_delayCreateMovie()
	if self._tmpMovieParams then
		self.m_criComp:addCriSprite(self._tmpMovieParams)

		self._tmpMovieParams = nil
	end
end

function ThemeExploreStage:_onCriSpriteEvent()
	if not self.m_criComp then
		return
	end

	self:runFGAction((fgui.FSequence:create({
		fgui.FCallFunc:create(handler(self, function()
			self.m_criComp:setVisible(false)
		end)),
		fgui.FDelayTime:create(self._intervalTime),
		fgui.FCallFunc:create(handler(self, function()
			self.m_criComp:setVisible(true)
		end))
	})))
end

function ThemeExploreStage:_onResetBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(405729),
		desc = g.core.lang:get(405730),
		confirmText = g.core.lang:get(405740),
		onConfirm = handler(self, function()
			g.core.network.GameNetProxy:send_C2S_ThemeExplore_ResetInfo({
				act_id = self._activeThemeValue,
				chapter_id = self._curChapterId
			})
		end)
	}))
end

function ThemeExploreStage:_onTimePowerBagClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreTimePowerPop").new({
		themeValue = self._activeThemeValue,
		chapter = self._curChapterId
	})))
end

function ThemeExploreStage:_onLocationBtnClick()
	self:getMapWorld():jump2MainRole()
end

function ThemeExploreStage:_onLineUpBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		posHpList = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterSelfHpPer(self._curChapterId)
	})
end

function ThemeExploreStage:_onSawppingTouch(arg_29_1)
	arg_29_1:stopPropagation()
end

function ThemeExploreStage:onDragWorld()
	if self._isInHideUI then
		self.m_hideTransition:playReverse()

		self._isInHideUI = false

		if g.core.model.User.storyData:isInStory() then
			g.core.model.User.storyData:endPlay()
		end
	end
end

function ThemeExploreStage:updateStageTopView()
	local var_31_0, var_31_1, var_31_2 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterRewardBox(self._curChapterId)

	self._bigBox = var_31_0
	self._smallBox = var_31_1

	self:updateBoxState()
end

function ThemeExploreStage:updateBoxState()
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(self._smallBox) do
		if iter_32_1.finish then
			var_32_0 = var_32_0 + 1
		end
	end

	local var_32_1 = {
		allNum = #self._smallBox,
		getNum = var_32_0,
		dataStruct = self._smallBox,
		themeValue = self._activeThemeValue,
		chapter = self._curChapterId
	}
	local var_32_2 = 0

	for iter_32_2, iter_32_3 in ipairs(self._bigBox) do
		if iter_32_3.finish then
			var_32_2 = var_32_2 + 1
		end
	end

	local var_32_3 = {
		allNum = #self._bigBox,
		getNum = var_32_2,
		dataStruct = self._bigBox,
		themeValue = self._activeThemeValue,
		chapter = self._curChapterId
	}

	self.m_boxComp1:updateBoxCompShow(var_32_1)
	self.m_boxComp2:updateBoxCompShow(var_32_3)

	if var_32_1.allNum == var_32_1.getNum and var_32_3.allNum == var_32_3.getNum then
		function self._chapterFinishCall()
			self:newScheduleOnce(function()
				g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
					delay = 1,
					englishTitle = "MISSION COMPLETED",
					title = g.core.lang:get(405734)
				}), {
					blackOpacity = 0
				})
			end, 0)
		end
	end
end

function ThemeExploreStage:_onAwardShowFinish()
	if self._chapterFinishCall then
		self._chapterFinishCall()

		self._chapterFinishCall = nil
	end
end

function ThemeExploreStage:_onBattleChallengeBegin(arg_36_1, arg_36_2, arg_36_3)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 2,
		bgId = (self._curOpeObject or nil) and g.core.config.activity_theme_explore_battle.get((self._curOpeObject:getFightID())).battle_scene,
		battle_id = arg_36_3.battle_id,
		type = BattleConst.TYPE_THEME_EXPLORE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
end

function ThemeExploreStage:_setSaveMapInfo()
	local var_37_0 = self:getMapWorld():serializeMapInfo()

	var_37_0.trigger_events = self._finishRiskEventArr
	var_37_0.kill_num = self._roleKillMonsterNum

	g.core.network.GameNetProxy:send_C2S_ThemeExplore_SaveMapInfo({
		act_id = self._activeThemeValue,
		chapter_id = self._curChapterId,
		mapInfo = var_37_0
	})
	g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():setExploreMapData(self._curChapterId, var_37_0)
end

function ThemeExploreStage:_onExploreSaveMap(arg_38_1, arg_38_2, arg_38_3)
	return
end

function ThemeExploreStage:_onExploreReset(arg_39_1, arg_39_2, arg_39_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		isSpine = true,
		forceCallFunc = true,
		callback = function()
			g.core.module.ModuleManager:replaceModule(g.view.entrance.SUMMER_THEME_EXPLORE_STAGE, self._param)
		end
	})
end

function ThemeExploreStage:_recoverHpEvent(arg_41_1, arg_41_2, arg_41_3)
	self:_refreshRoleInfo()

	if self._isAddHp then
		g.core.module.ModuleManager:tip(g.core.lang:get(405742))
		self:playRoleRecoverSpine()
	end

	if self._isHpEvent then
		self._isHpEvent = false

		self:_finishRiskEvent()
	end
end

function ThemeExploreStage:onGetBoxAward(arg_42_1, arg_42_2, arg_42_3)
	g.core.module.ModuleManager:awardSummary(arg_42_3.awards or {}, nil, nil, nil, handler(self, self._onAwardShowFinish))
	self:updateStageTopView()
end

function ThemeExploreStage:_onGetMonsterHp(arg_43_1, arg_43_2, arg_43_3)
	if self._curOpeObject then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreBattleInfoPop").new({
			themeValue = self._activeThemeValue,
			chapter = self._curChapterId,
			content = arg_43_3,
			objCfg = g.core.config.activity_theme_explore_object.get((self._curOpeObject:getBindID())),
			battleCfg = g.core.config.activity_theme_explore_battle.get((self._curOpeObject:getFightID())),
			callback = handler(self, self.onConfirmMove)
		})))
	end
end

function ThemeExploreStage:talkPanelPop(arg_44_1)
	if arg_44_1:getEntityType() == RiskMapConst.SPECIAL_ITEM.MONSTER then
		self:onShowBattlePop(arg_44_1)
	else
		self:onShowInfoPop(arg_44_1)
	end
end

function ThemeExploreStage:onConfirmMove()
	self:getMapWorld():autoRouteTalk()
	self.m_locationBtn:setVisible(false)
end

function ThemeExploreStage:talkTrigger(arg_46_1)
	if not arg_46_1:doCheckCanUse() then
		return
	end

	local var_46_0 = arg_46_1:getEntityType()

	if var_46_0 == RiskMapConst.SPECIAL_ITEM.CURE then
		self:_processCureObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.CLEAR then
		self:_processClearObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.GEAR then
		self:_processGearObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.LIFTER then
		self:_processLifterObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.GARGOYLE then
		self:_processGargoyleObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.ABOX then
		self:_processABoxObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.MONSTER then
		self:_processMonsterObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.TRIGGER then
		self:_processTriggerObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.GUN then
		self:_processGunObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.TORCH then
		self:_processTorchObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.ICE then
		self:_processIceObject(arg_46_1)
	elseif var_46_0 == RiskMapConst.SPECIAL_ITEM.TRACK then
		self:_processTrackObject(arg_46_1)
	end
end

function ThemeExploreStage:setAutoSearchPath(arg_47_1)
	return
end

function ThemeExploreStage:_processCureObject(arg_48_1)
	if g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():isHpMax(self._curChapterId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(405741))

		return
	end

	self._isAddHp = true

	g.core.network.GameNetProxy:send_C2S_ThemeExplore_HpRecover({
		event_type = 2,
		act_id = self._activeThemeValue,
		chapter_id = self._curChapterId,
		arg = arg_48_1:getAddHP()
	})
	arg_48_1:triggerUsed()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processClearObject(arg_49_1)
	local var_49_0 = arg_49_1:getClearRange()
	local var_49_1 = arg_49_1:getCoord()

	self:getMapWorld():openCloudEntityVisible(var_49_1, var_49_0 + 1)

	if self:getMapGround():openCloud(var_49_1, var_49_0 + 1) then
		-- block empty
	end

	arg_49_1:triggerUsed()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processGearObject(arg_50_1)
	local var_50_0
	local var_50_1 = arg_50_1:getGroupID()

	if var_50_1 > 0 then
		var_50_0 = self:getMapWorld():getGroupEntityArr(var_50_1)
	end

	if not var_50_0 then
		return
	end

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		iter_50_1:triggerUsed()
	end

	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processLifterObject(arg_51_1)
	assert(false, "升降障碍不能被触摸! id = " .. arg_51_1:getBindID())
end

function ThemeExploreStage:_processGargoyleObject(arg_52_1)
	local var_52_0
	local var_52_1 = arg_52_1:getGroupID()

	if var_52_1 > 0 then
		var_52_0 = self:getMapWorld():getGroupEntityArr(var_52_1)
	end

	if not var_52_0 then
		return
	end

	local var_52_2 = true
	local var_52_3 = true
	local var_52_4 = arg_52_1:getTouchIndex()

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		local var_52_5 = iter_52_1:getTouchIndex()

		if not var_52_5 then
			assert(false, "分组错误！非石像鬼被加入了石像鬼分组! id = " .. arg_52_1:getBindID())

			return
		end

		if var_52_5 < var_52_4 and not iter_52_1:isUsed() then
			var_52_2 = false

			break
		end

		if var_52_4 < var_52_5 then
			var_52_3 = false
		end
	end

	if var_52_2 then
		arg_52_1:triggerUsed()
	else
		for iter_52_2, iter_52_3 in pairs(var_52_0) do
			iter_52_3:cancelUsed()
		end

		arg_52_1:playErrorView()

		if self._riskStorage.tips_num < 5 then
			self:_playErrorTips()

			self._riskStorage.tips_num = self._riskStorage.tips_num + 1

			self:_serializeRisk()
		end

		return
	end

	if var_52_3 then
		local var_52_6 = arg_52_1:getTriggerID()
		local var_52_7 = self:getMapWorld():getBindEntity(var_52_6)

		if not var_52_7 then
			assert(false, "被触发对象不存在! id = " .. arg_52_1:getBindID())
		end

		if var_52_7:getEntityType() == RiskMapConst.SPECIAL_ITEM.ABOX then
			if g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():isBoxAwarded(var_52_6) then
				return
			end
		end

		local var_52_8 = var_52_7:isActivation()

		var_52_7:setActivation(true)

		if not var_52_8 and var_52_7:isActivation() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, true, (RiskEventTrigger.new(RiskMapConst.TRIGGER_TYPE.BORN, var_52_7:getBindID())))
		end
	end

	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processABoxObject(arg_53_1)
	local var_53_0 = arg_53_1:getBindID()

	if g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():isBoxAwarded(var_53_0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(405738))
	else
		g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetBoxAward({
			act_id = self._activeThemeValue,
			chapter_id = self._curChapterId,
			object_id = var_53_0
		})
	end

	arg_53_1:triggerUsed()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processMonsterObject(arg_54_1)
	self._lastFightEntity = arg_54_1

	g.core.network.GameNetProxy:send_C2S_ThemeExplore_BeginChallenge({
		act_id = self._activeThemeValue,
		chapter_id = self._curChapterId,
		monster_id = arg_54_1:getFightID()
	})
end

function ThemeExploreStage:_processTriggerObject(arg_55_1)
	arg_55_1:triggerUsed()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_processGunObject(arg_56_1)
	local var_56_0 = arg_56_1:getDirection()
	local var_56_1 = arg_56_1:getCoord()
	local var_56_2, var_56_3, var_56_4 = self:getMapWorld():checkCoordAndDirFirstHold(var_56_1, var_56_0)

	local function var_56_5()
		local var_57_0 = 1

		if var_56_2 then
			local var_57_1 = var_56_2:getEntityType()

			if var_57_1 == RiskMapConst.SPECIAL_ITEM.MONSTER then
				var_56_2:playDeadAnim()

				var_57_0 = RiskMapConst.MONSTER_DEAD_DELTA
			elseif var_57_1 == RiskMapConst.SPECIAL_ITEM.TORCH then
				var_56_2:triggerUsed()

				if self:_burnRoundIce(var_56_2:getCoord()) then
					var_57_0 = RiskMapConst.ICE_MELT_DELTA
				end
			elseif var_57_1 == RiskMapConst.SPECIAL_ITEM.ICE then
				var_56_2:triggerUsed()

				var_57_0 = RiskMapConst.ICE_MELT_DELTA
			end
		end

		self:newScheduleOnce(handler(self, self._onFireBallMoveFinish), var_57_0)
	end

	self:setStageUnTouchEnable()
	self:newScheduleOnce(function()
		self:getMapGround():addFireBall(var_56_0, var_56_1, var_56_3, var_56_4, var_56_5)
		arg_56_1:triggerUsed()
		self:getMapWorld():moveRolling2SC({
			x = var_56_3.x,
			y = var_56_3.y
		}, var_56_4 * RiskMapConst.FIRE_BALL_DELTA)
	end, (self:getMapWorld():moveRolling2SC({
		x = var_56_1.x,
		y = var_56_1.y
	})))
end

function ThemeExploreStage:_burnRoundIce(arg_59_1)
	local var_59_0 = false
	local var_59_1 = self:getMapWorld():getCenterNineEntities(arg_59_1)

	for iter_59_0 = 1, #var_59_1 do
		if var_59_1[iter_59_0]:getEntityType() == RiskMapConst.SPECIAL_ITEM.ICE then
			var_59_1[iter_59_0]:triggerUsed()

			var_59_0 = true
		end
	end

	return var_59_0
end

function ThemeExploreStage:_processTorchObject(arg_60_1)
	assert(false, "稻草人不能被触摸! id = " .. arg_60_1:getBindID())
end

function ThemeExploreStage:_processIceObject(arg_61_1)
	assert(false, "冰块不能被触摸! id = " .. arg_61_1:getBindID())
end

function ThemeExploreStage:_processTrackObject(arg_62_1)
	local var_62_0
	local var_62_1 = arg_62_1:getTrackID()

	if var_62_1 > 0 then
		var_62_0 = self:getMapWorld():getTrackEntityArr(var_62_1)
	end

	if not var_62_0 then
		return
	end

	local var_62_2 = arg_62_1:getDirection()

	for iter_62_0, iter_62_1 in pairs(var_62_0) do
		if iter_62_1:getEntityType() ~= RiskMapConst.SPECIAL_ITEM.TRACK then
			local var_62_3 = iter_62_1:getCoord()
			local var_62_4, var_62_5 = self:getMapWorld():checkCoordAndDirCanMove(var_62_3, var_62_2)

			if var_62_4 then
				iter_62_1:jump2CoordByCar(clone(var_62_5), handler(self, self._setSaveMapInfo))
				self:getMapWorld():exchangeTwoEntity(var_62_3, var_62_5)

				if iter_62_1:getEntityType() == RiskMapConst.SPECIAL_ITEM.TORCH and iter_62_1:getCurState() == 2 and self:_burnRoundIce(var_62_5) then
					self:setStageUnTouchEnable()
					self:newScheduleOnce(handler(self, self.setStageTouchEnable), RiskMapConst.ICE_MELT_DELTA)
				end
			end
		end
	end

	arg_62_1:triggerUsed()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_playErrorTips()
	if self._tipsComp == nil then
		fgui.UIPackage:addPackage("ui/guide/guide")

		self._tipsComp = fgui.UIPackage:createObject("guide", "GuideDialogComp")

		self:addChild(self._tipsComp)
		self._tipsComp:setPosition(300, display.height - 150)
		self._tipsComp:setTouchable(false)
	end

	self._tipsComp:updateText((g.core.lang:get(405744)))
	self._tipsComp:stopAllFGActions()
	self._tipsComp:setVisible(true)
	self._tipsComp:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(5), fgui.FHide:create()))
end

function ThemeExploreStage:stopErrorTips()
	if self._tipsComp == nil then
		return
	end

	self._tipsComp:stopAllFGActions()
	self._tipsComp:setVisible(false)
end

function ThemeExploreStage:checkFightResultState()
	local var_65_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getLastFightState()

	if var_65_0 and var_65_0.isWin and self._lastFightEntity then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreSelectTimePowerPop").new({
			themeValue = self._activeThemeValue,
			chapter = self._curChapterId,
			quality = g.core.config.activity_theme_explore_battle.get(var_65_0.cfgId).quality,
			fightData = var_65_0,
			exitCall = handler(self, self._onSelectCardFinish)
		})))
	end
end

function ThemeExploreStage:_onSelectCardFinish(arg_66_1)
	if arg_66_1.fightData and arg_66_1.fightData.isWin and self._lastFightEntity then
		self._lastFightEntity:triggerUsed()

		self._roleKillMonsterNum = self._roleKillMonsterNum + 1

		self:_setSaveMapInfo()

		self._lastFightEntity = nil

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, true, (RiskEventTrigger.new(RiskMapConst.TRIGGER_TYPE.KILL, self._roleKillMonsterNum)))
	end
end

function ThemeExploreStage:onShowBattlePop(arg_67_1)
	self._curOpeObject = arg_67_1

	g.core.network.GameNetProxy:send_C2S_ThemeExplore_GetMonsterHp({
		act_id = self._activeThemeValue,
		chapter_id = self._curChapterId,
		monster_id = arg_67_1:getFightID()
	})
end

function ThemeExploreStage:onShowInfoPop(arg_68_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreEventDescPop").new({
		themeValue = self._activeThemeValue,
		chapter = self._curChapterId,
		infoId = arg_68_1:getBindID(),
		callback = handler(self, self.onConfirmMove)
	})))
end

function ThemeExploreStage:_onGetTimePowerEff(arg_69_1, arg_69_2)
	local var_69_0 = g.core.layer.LayerManager:getTranslationLayer()
	local var_69_1 = var_69_0:globalToLocal(arg_69_2.worldPos)
	local var_69_2 = fgui.UIPackage:createObject("summerTheme", "ThemeExploreSelectPowerCard")

	var_69_2:updateCardInfo(arg_69_2.cfg)
	var_69_0:addChild(var_69_2)
	var_69_2:setPosition(cc.p(var_69_1.x - 667, var_69_1.y - 375))

	local var_69_3 = var_69_0:localToGlobal((self.m_timePowerBtn:getPosition()))

	var_69_2.m_flyTransition:setHook("move", function()
		var_69_2:runFGAction(fgui.FSequence:create((fgui.FMoveTo:create(0.4, cc.p(var_69_3.x - 60, var_69_3.y)))))
	end)
	var_69_2.m_flyTransition:play(handler(self, self._onFlyFinish))

	self._timePowerEffObj = var_69_2
end

function ThemeExploreStage:_onFlyFinish()
	if self._timePowerEffObj and not tolua.isnull(self._timePowerEffObj) then
		self.m_bagEffHolder:addEffectSpine({
			remove = true,
			name = "eff_ui_explore_inbag",
			isLoop = false
		})
		self._timePowerEffObj:removeSelf()

		self._timePowerEffObj = nil
	end
end

function ThemeExploreStage:_initCloudData(arg_72_1)
	self:getMapWorld():mergeDeserializeCloud(arg_72_1)
end

function ThemeExploreStage:_onRiskMainRoleCoordChange(arg_73_1, arg_73_2)
	self:getMapWorld():openCloudEntityVisible(arg_73_2, RiskMapConst.CLOUD_RANGE)

	if self:getMapGround():openCloud(arg_73_2, RiskMapConst.CLOUD_RANGE) then
		-- block empty
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, true, (RiskEventTrigger.new(RiskMapConst.TRIGGER_TYPE.COORD, arg_73_2.x, arg_73_2.y)))
end

function ThemeExploreStage:setHeadArrow(arg_74_1)
	self.m_locationBtn:setVisible(arg_74_1)
end

function ThemeExploreStage:setStageUnTouchEnable()
	self.m_touchPanel:setVisible(true)
end

function ThemeExploreStage:setStageTouchEnable()
	self.m_touchPanel:setVisible(false)
end

function ThemeExploreStage:_initRiskEventConfig()
	self._riskEventDict = {}
	self._riskEventDoArr = {}
	self._finishRiskEventArr = {}

	for iter_77_0 = 1, g.core.config.activity_theme_explore_event.getLength() do
		local var_77_0 = g.core.config.activity_theme_explore_event.indexOf(iter_77_0)

		if var_77_0.chapter == self._curChapterId then
			self._riskEventDict[var_77_0.id] = RiskEvent.new(var_77_0)
		end
	end
end

function ThemeExploreStage:_mergeRiskEvent(arg_78_1)
	for iter_78_0, iter_78_1 in pairs(arg_78_1) do
		self._riskEventDict[iter_78_1] = nil

		table.insert(self._finishRiskEventArr, iter_78_1)
	end
end

function ThemeExploreStage:_onRiskEventCheckTrigger(arg_79_1, arg_79_2)
	local var_79_0 = false

	for iter_79_0, iter_79_1 in pairs(self._riskEventDict) do
		if iter_79_1:checkTrigger(arg_79_2) then
			self:_pushActiveRiskEvent(iter_79_1)

			self._riskEventDict[iter_79_0] = nil

			table.insert(self._finishRiskEventArr, iter_79_0)

			var_79_0 = true

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RISK_EVENT_TRIGGER, true, (RiskEventTrigger.new(RiskMapConst.TRIGGER_TYPE.EVENT, iter_79_1:getChapterID(), iter_79_1:getGroupID())))
		end
	end

	if var_79_0 then
		self:_processRiskEvent()
		self:_setSaveMapInfo()
	end
end

function ThemeExploreStage:_pushActiveRiskEvent(arg_80_1)
	local var_80_0 = #self._riskEventDoArr + 1
	local var_80_1 = arg_80_1:getSortOrder()

	for iter_80_0, iter_80_1 in ipairs(self._riskEventDoArr) do
		if var_80_1 < iter_80_1:getSortOrder() then
			var_80_0 = iter_80_0

			break
		end
	end

	table.insert(self._riskEventDoArr, var_80_0, arg_80_1)
end

function ThemeExploreStage:_processRiskEvent()
	if self._riskEventDoing then
		return
	end

	if #self._riskEventDoArr <= 0 then
		self:onConfirmMove()

		return
	end

	self._riskEventDoing = self._riskEventDoArr[1]

	table.remove(self._riskEventDoArr, 1)
	self:getMapWorld():stopAutoRoute()

	local var_81_0 = self._riskEventDoing:getProcessType()
	local var_81_1 = self._riskEventDoing:getBaseInfo()

	if var_81_0 == RiskMapConst.PROCESS_TYPE.DIALOG then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_81_1.event_param_1
		})
		self.m_hideTransition:play()

		self._isInHideUI = true
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.SCREEN then
		self:setStageUnTouchEnable()
		self:newScheduleOnce(handler(self, self._onMoveMapFinish), self:getMapWorld():moveRolling2SC({
			x = var_81_1.event_param_1,
			y = var_81_1.event_param_2
		}) + var_81_1.event_param_3 / 1000)
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.SHOW then
		self:_onShowEvent(var_81_1)
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.DISAPPEAR then
		self:_onDisappearEvent(var_81_1)
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.BUFF then
		self:_onBuffEvent(var_81_1)
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.FLASH then
		self:_onFlashEvent(var_81_1)
	elseif var_81_0 == RiskMapConst.PROCESS_TYPE.HP then
		self:_onHpEvent(var_81_1)
	else
		self:_finishRiskEvent()
	end
end

function ThemeExploreStage:_onShowEvent(arg_82_1)
	self:getMapWorld():setSameCoordEntityActivation(arg_82_1.event_param_1, true)
	self:_setSaveMapInfo()
	self:_finishRiskEvent()
end

function ThemeExploreStage:_onDisappearEvent(arg_83_1)
	local var_83_0 = self:getMapWorld():getBindEntity(arg_83_1.event_param_1)

	if not var_83_0 then
		assert(false, "被隐藏对象不存在! id = " .. arg_83_1.event_param_1)
	end

	var_83_0:triggerUsed()
	self:getMapWorld():setSameCoordEntityActivation(arg_83_1.event_param_1, false)
	self:_setSaveMapInfo()
	self:_finishRiskEvent()
end

function ThemeExploreStage:_onBuffEvent(arg_84_1)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.explore.pop.ThemeExploreSelectTimePowerPop").new({
		themeValue = self._activeThemeValue,
		chapter = self._curChapterId,
		selType = arg_84_1.event_param_1,
		quality = arg_84_1.event_param_2,
		exitCall = handler(self, self._onSelectBuffFinish)
	})))
end

function ThemeExploreStage:_onSelectBuffFinish(arg_85_1)
	self:_setSaveMapInfo()
	self:_finishRiskEvent()
end

function ThemeExploreStage:_onFlashEvent(arg_86_1)
	self:getMapWorld():mainRoleFlash(cc.p(arg_86_1.event_param_1, arg_86_1.event_param_2))
	self:getMapWorld():checkEntityInView()
	self:setStageUnTouchEnable()
	self:newScheduleOnce(handler(self, self._onMoveMapFinish), self:getMapWorld():moveRolling2SC({
		x = arg_86_1.event_param_1,
		y = arg_86_1.event_param_2
	}) + arg_86_1.event_param_3 / 1000)
end

function ThemeExploreStage:_onHpEvent(arg_87_1)
	self._isHpEvent = true
	self._isAddHp = arg_87_1.event_param_1 == 2

	g.core.network.GameNetProxy:send_C2S_ThemeExplore_HpRecover({
		act_id = self._activeThemeValue,
		chapter_id = self._curChapterId,
		arg = arg_87_1.event_param_2,
		event_type = arg_87_1.event_param_1
	})
end

function ThemeExploreStage:_onFireBallMoveFinish()
	self:getMapWorld():moveRolling2SCRole()
	self:setStageTouchEnable()
	self:_setSaveMapInfo()
end

function ThemeExploreStage:_onMoveMapFinish()
	self:setStageTouchEnable()
	self:_finishRiskEvent()
end

function ThemeExploreStage:_onStoryEnd()
	self:_finishRiskEvent()

	self._isInHideUI = false

	self.m_hideTransition:playReverse()
end

function ThemeExploreStage:_finishRiskEvent()
	if not self._riskEventDoing then
		return
	end

	self._riskEventDoing = nil

	self:_processRiskEvent()
end

function ThemeExploreStage:_refreshRoleInfo()
	local var_92_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterSelfHpPer(self._curChapterId)

	if not var_92_0 then
		return
	end

	local var_92_1 = 0
	local var_92_2 = 0

	for iter_92_0, iter_92_1 in pairs(var_92_0) do
		var_92_1 = var_92_1 + 1
		var_92_2 = var_92_2 + iter_92_1
	end

	if var_92_1 <= 0 then
		return
	end

	self:getMapWorld():refreshMainRoleHP(var_92_2 / var_92_1 / 10)
end

function ThemeExploreStage:playRoleRecoverSpine()
	local var_93_0

	var_93_0 = require("app.view.common.SpineBase").new({
		anim = "play",
		resId = "buff_huixue",
		path = "battle/attr_spine/buff_huixue/buff_huixue",
		listener = function(self)
			if self.type == "complete" then
				var_93_0:removeFromParent(true)
			end
		end
	})

	;(nil):setPosition(0, 150)
	self:getMapWorld():playMainRoleRecoverAnim(var_93_0)
end

function ThemeExploreStage:_onCrossDayUpdate()
	local var_95_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, self._activeThemeValue)

	if not ((var_95_1 and var_95_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function ThemeExploreStage:_popToHome()
	local var_96_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, self._activeThemeValue)

	if not ((var_96_1 and var_96_1:isOpen() or nil) and true) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function ThemeExploreStage:getExploreData()
	return (g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData())
end

return ThemeExploreStage
