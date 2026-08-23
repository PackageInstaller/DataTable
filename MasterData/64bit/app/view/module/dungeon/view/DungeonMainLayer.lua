local DungeonMainLayer = class("DungeonMainLayer", require("app.fairyGUI.dungeon.UI_DungeonMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/dungeon/dungeon",
		resName = "DungeonMainLayer",
		pkgName = "dungeon"
	}, ...)
end)
local var_0_3 = g.core.config.dungeon_land_info
local var_0_4 = g.core.config.dungeon_chapter_info
local var_0_5 = g.core.model.User.dungeonData
local var_0_6 = g.core.common.Path
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.event.enum
local var_0_9 = g.core.common.ModuleUnlock
local var_0_10 = g.core.const.ConstMgr
local var_0_11 = g.core.const.ConstMgr.DungeonConst

function DungeonMainLayer:ctor(arg_2_1)
	self._landBg = nil
	self._landId = 0
	self._firstLandId = 0
	self._isNewLand = false
	self._showLandId = 0
	self._newChapterId = 0
	self._lastTime = -1
	self._ticked = false
	self._isInStageLayer = false

	self:_initUIListener()

	if arg_2_1 then
		self:_initSkipLandByRoute(arg_2_1)
	end

	var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_READY)
	end, 0.1)
	self.m_enterTransition:play()
end

function DungeonMainLayer:_initSkipLandByRoute(arg_4_1)
	local var_4_0 = var_0_5:getLastUnlockChapter()
	local var_4_1 = var_0_3.get(var_0_4.get(var_4_0).land_id)

	self._showLandId = var_4_1.id

	if not arg_4_1.route1 and arg_4_1.route2 == 1 then
		self._showLandId = var_4_1.id
	elseif arg_4_1.route1 and arg_4_1.route1 > 0 then
		self._showLandId = var_4_0 < arg_4_1.route1 and var_4_1.id or var_0_3.get(var_0_4.get(arg_4_1.route1).land_id).id
	end
end

function DungeonMainLayer:_initUIListener()
	self.m_topBarComp:setResInfoById(40)
	self.m_lastBtn:addClickListener(handler(self, self._onClickPreLand))
	self.m_nextBtn:addClickListener(handler(self, self._onClickPostLand))
	self.m_landComp:addClickListener(handler(self, self._onTouchBegin))
	self.m_locationBtn:addClickListener(handler(self, self._onClickLocationNewLand))
	self.m_oneKeyBtn:addClickListener(handler(self, self.onClickOneKey))
	self.m_registBtn:addClickListener(handler(self, self._onClickPreRegistBtn))
	self.m_youngBtn:addClickListener(handler(self, self._onClickYoungBtn))
	self.m_edenGardenBtn:addClickListener(handler(self, self._onClickEdenGardenBtn))
	self.m_achievementBtn:addClickListener(handler(self, self._onClickAchievementBtn))
end

function DungeonMainLayer:onLoad()
	self._isInStageLayer = false

	self.m_oneKeyBtn:setVisible(false)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_DUNGEON_ONEKEY_GETCHAPTERCHESTAWARD, self._onRcvGetOneKeyBoxAward, self)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_DUNGEON_FINISHACHIEVEMENT, self._updateAchieveBtn, self)
	var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_READY)
	end, 0.2)
	self:_updateMainLayer()

	self._ticked = false

	if var_0_5:getLastUnlockChapter() <= 6 and self._landId == var_0_5:getCurLandId() then
		self._lastTime = os.time()

		self:newSchedule(handler(self, self._onCheckWeakGuideTime), 1)
	end

	if g.core.battle.BattleProxy:isInBattle() then
		self.m_topBarComp:setVisible(false)
	else
		self.m_topBarComp:setVisible(true)
	end

	self:_updateAchieveBtn()

	if not g.core.guide.GuideProxy:isGuideRunning() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ACHIEVEMENT) and not g.core.model.User.achievementData._achievementInfoReceived then
		g.core.network.GameNetProxy:send_C2S_Achievement_Info({})
	end
end

function DungeonMainLayer:_onCheckWeakGuideTime()
	if self._ticked then
		return
	end

	local var_8_0 = os.time()

	if var_8_0 - self._lastTime > 3 then
		self._lastTime = var_8_0

		self:_checkTickWeakGuide()
	end
end

function DungeonMainLayer:_updateMainLayer()
	local var_9_0 = var_0_5:getNewLandId()
	local var_9_1 = var_0_5:getNewChapterId()

	self._firstLandId = var_0_5:getFirstLandId()
	self._newChapterId = var_9_1

	local var_9_2 = 0

	var_9_2 = var_9_0 and var_9_0 > self._firstLandId and var_0_5:getPreLandId(var_9_0) or self._showLandId == 0 and var_0_5:getCurLandId() or self._showLandId
	self._showLandId = 0

	var_0_7:dispatchEvent(var_0_8.EVENT_DUNGEON_LAND_START, false, {
		story = {
			var_9_2
		}
	})

	local var_9_3 = var_0_3.get(var_9_2)
	local var_9_4, var_9_5 = var_0_5:isPassALLChapterAndTurnNextLand()

	if var_9_4 and var_9_1 == 0 then
		var_9_3 = var_0_3.get(var_9_5)
		self._showLandId = var_9_5
	end

	self.m_landComp:update({
		landInfo = var_9_3,
		newChapterId = self._newChapterId
	})

	self._landId = self._showLandId == 0 and var_9_2 or self._showLandId

	self:_updateLandList()
	self:_updateLandCommonView()
	self:_loadSnowMovie(var_9_3)
	self.m_slideOverComp:setVisible((var_0_9:isModuleUnlock(var_0_10.FUNCTION_TYPE.BIO_MAIN)))
	self.m_registBtn:updateRegistBtn()
	self.m_youngBtn:setVisible(var_0_5:isShowYoungGift())

	local var_9_6 = var_0_5:getLastPassedChapter()

	self.m_youngBtn:setTitle(var_9_6 .. "/" .. g.core.config.achievement_info.get(10029).num)
	self.m_edenGardenBtn:setVisible(var_0_5:isShowEdenGarden())
	self.m_edenGardenBtn:setTitle(var_9_6 .. "/" .. g.core.config.achievement_info.get(10030).num)
	var_0_7:dispatchEvent(var_0_8.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_oneKeyBtn
	})
	var_0_7:dispatchEvent(var_0_8.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_achievementBtn
	})
	self:newScheduleOnce(handler(self, function()
		self.m_oneKeyBtn:setVisible(var_0_5.checkBoxAward() and var_0_9:isModuleUnlock(var_0_10.FUNCTION_TYPE.DUNGEON_ONEKEY_AWARD))
	end), 0.2)
end

function DungeonMainLayer:onClickOneKey()
	local var_11_0 = var_0_5.getAvailableAwardChapterIds()

	if next(var_11_0) then
		g.core.network.GameNetProxy:send_C2S_Dungeon_OneKey_GetChapterChestAward({
			ids = var_11_0
		})
	end
end

function DungeonMainLayer:_onClickPreRegistBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonPreRegistrationPop").new()))
end

function DungeonMainLayer:_onClickYoungBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonYoungLinkPop").new()))
end

function DungeonMainLayer:_onClickEdenGardenBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonEdenGardenPop").new()))
end

function DungeonMainLayer:_onClickAchievementBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.achievement.DungeonAchievementPop").new()))
end

function DungeonMainLayer:_updateAchieveBtn()
	local var_16_0 = g.core.model.User.dungeonData:isShowAchievePop()

	self.m_showAchievementBtnController:setSelectedIndex(var_16_0 and 1 or 0)

	if var_16_0 then
		self.m_achievementBtn:setTitle(var_0_5:getTotalStars() .. "/" .. var_0_5:getNearestStarNum())
	end

	local var_16_1 = g.core.model.User.dungeonData:canReceiveStarAward()

	if var_16_1 and not self._achieveGetEffect then
		self._achieveGetEffect = self.m_achievementBtn:getChild("effectHolder"):addEffectSpine({
			name = "eff_ui_dungeon_achievementBtn",
			isLoop = true
		})
	elseif self._achieveGetEffect then
		self._achieveGetEffect:setVisible(var_16_1)
	end
end

function DungeonMainLayer:_onRcvGetOneKeyBoxAward(arg_17_1, arg_17_2, arg_17_3)
	self._ticked = false
	self._lastTime = os.time()

	if arg_17_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_17_3.awards)
		self:_updateMainLayer()
	end
end

function DungeonMainLayer:_onClickLocationNewLand()
	self:_onChangeLand(handler(self, self._onLocationNewLand))
end

function DungeonMainLayer:_onLocationNewLand()
	if tolua.isnull(self) then
		return
	end

	self:_onChangeLandEnd()

	local var_19_0 = var_0_5:getCurLandId()

	self._landId = var_19_0

	local var_19_1 = var_0_3.get(var_19_0)

	self.m_landComp:update({
		landInfo = var_19_1
	})
	self:_updateLandList()
	self:_updateLandCommonView()
	self:_loadSnowMovie(var_19_1)
end

function DungeonMainLayer:doAutoAction()
	if not self.m_landComp:isCanAutoAction() then
		return
	end

	local var_20_0 = var_0_5:getCurLandId()

	self._landId = var_20_0

	self.m_landComp:update({
		landInfo = var_0_3.get(var_20_0)
	})
	self:_updateLandList()
	self:_updateLandCommonView()
	self.m_landComp:doAutoAction()
end

function DungeonMainLayer:_onTouchBegin()
	if self.m_listComp.onHideLandListComp then
		self.m_listComp:onHideLandListComp()
	end
end

function DungeonMainLayer:_onClickPreLand()
	if self._isAnimation then
		return
	end

	self:_onChangeLand(handler(self, self._scrollToPreLand))
end

function DungeonMainLayer:_onClickPostLand()
	if self._isAnimation then
		return
	end

	if not var_0_5:isFinishLand(self._landId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(300007))

		return
	end

	if var_0_5:getFinalLandId() <= self._landId then
		g.core.module.ModuleManager:tip(g.core.lang:get(300010))

		return
	end

	self:_onChangeLand(handler(self, self._scrollToPostLand))
end

function DungeonMainLayer:_scrollToPreLand()
	if tolua.isnull(self) then
		return
	end

	self:_onChangeLandEnd()

	self._landId = var_0_5:getPreLandId(self._landId)

	self:_updateLandList()
	self:_updateLandCommonView()

	local var_24_0 = var_0_3.get(self._landId)

	self:_loadSnowMovie(var_24_0)
	self.m_landComp:update({
		landInfo = var_24_0
	})
end

function DungeonMainLayer:_scrollToPostLand()
	if tolua.isnull(self) then
		return
	end

	self:_onChangeLandEnd()

	self._landId = var_0_5:getPostLandId(self._landId)

	self:_updateLandList()
	self:_updateLandCommonView()

	local var_25_0 = var_0_3.get(self._landId)

	self:_loadSnowMovie(var_25_0)
	self.m_landComp:update({
		landInfo = var_25_0
	})

	if self._isNewLand and self._landId == var_0_5:getMaxEnterLand() then
		var_0_7:dispatchEvent(var_0_8.EVENT_DUNGEON_LAND_START, false, {
			story = {
				self._landId
			}
		})
	end
end

function DungeonMainLayer:_updateLandList()
	self.m_listComp:updateListComp({
		landId = self._landId
	})
	self.m_listComp:foldList()
end

function DungeonMainLayer:_updateLandCommonView()
	local var_27_0 = var_0_3.get(self._landId)

	self.m_arrowStateController:setSelectedIndex(var_0_3.indexOf(1).id == self._landId and var_0_11.ARROW_CTRL.NO_PRELAND or var_0_3.indexOf((var_0_3.getLength())).id == self._landId and var_0_11.ARROW_CTRL.NO_NEXTLAND or var_0_11.ARROW_CTRL.NOMARL)
	self.m_landNameTxt:setText(var_27_0.name)
	self.m_landNumberTxt:setText(var_27_0.number)
	self.m_bgLoader:setURL((var_0_6:getDungeonLandMapBg(var_27_0.stage_map)))
	self.m_locationBtn:setVisible(self._landId ~= var_0_5:getCurLandId())
end

function DungeonMainLayer:_updateByStoryEnd(arg_28_1)
	if arg_28_1.trigger_type == "EVENT_DUNGEON_LAND_END" then
		-- block empty
	elseif arg_28_1.trigger_type == "EVENT_DUNGEON_CHAPTER_END" then
		-- block empty
	elseif arg_28_1.trigger_type == "EVENT_STORY_FORCE_START" and arg_28_1.trigger_data.id == 10016 then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_MAIN)
		end, 0)
	end
end

function DungeonMainLayer:receiveCompEvent(arg_30_1, arg_30_2)
	if arg_30_1 == "enter_chapter" then
		local var_30_0

		if arg_30_2 then
			var_30_0 = arg_30_2.id

			local var_30_1

			if not arg_30_2.id then
				var_30_0 = 1
				var_30_1 = g.core.model.User:getLevel()
			end

			if var_30_1 < var_0_4.get(var_30_0).condition_level and var_0_4.get((var_0_5:getLastUnlockChapter())).next_id == var_30_0 then
				self:_showLevelUpTipPop()
			elseif not var_0_5:isChapterUnlocked(var_30_0) then
				local var_30_2 = var_0_4.get(var_30_0 - 1)

				g.core.module.ModuleManager:tip(g.core.lang:get(300043, {
					chapter = var_30_2.land_id,
					stage = var_0_5:getChapterIndex(var_30_2.id)
				}))
			end
		end

		self._showLandId = self._landId

		if not self._isInStageLayer then
			g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON_STAGE, {
				chapterId = var_30_0
			})

			self._isInStageLayer = true
		end
	elseif arg_30_1 == "EVENT_STORY_START" then
		self.m_topBarComp:playHideAction()
	elseif arg_30_1 == "EVENT_STORY_END" then
		self:_updateByStoryEnd(arg_30_2)
		self.m_topBarComp:playShowAction()
	elseif arg_30_1 == "DungeonListComp_select" then
		self._newLand = arg_30_2.isNew
		self._landId = arg_30_2.landInfo.id
		self._showLandId = arg_30_2.landInfo.id

		self:_onChangeLand(handler(self, self._onGotoSelected))
	end
end

function DungeonMainLayer:_showLevelUpTipPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(111026),
		desc = g.core.lang:get(300046),
		confirmText = g.core.lang:get(309118),
		onConfirm = function()
			g.view.entrance.ModuleGotoProxy:gotoModuleByParams({
				srcRouteId = 200023,
				popToRoot = false
			})
		end
	}), {
		touchDisappear = true
	})
end

function DungeonMainLayer:_onChangeLand(arg_33_1)
	self._isAnimation = true

	self:setTouchable(false)
	self:setOpaque(false)
	self.m_backTransition:play()
	var_0_7:dispatchEvent(var_0_8.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		isSpine = true,
		forceCallFunc = true,
		callback = arg_33_1
	})
end

function DungeonMainLayer:_onChangeLandEnd()
	self.m_enterTransition:play(handler(self, function()
		self:setTouchable(true)
		self:setOpaque(true)

		self._isAnimation = false
	end))
end

function DungeonMainLayer:_onGotoSelected()
	if tolua.isnull(self) then
		return
	end

	self:_onChangeLandEnd()

	local var_36_0 = var_0_3.get(self._landId)

	self.m_landComp:update({
		landInfo = var_36_0,
		isNewLand = self._newLand
	})
	self:_loadSnowMovie(var_36_0)
	self:_updateLandList()
	self:_updateLandCommonView()
end

function DungeonMainLayer:_loadSnowMovie(arg_37_1)
	if g.core.utils.Quality.needCloseWeather() then
		return
	end

	if not arg_37_1 and not arg_37_1.effect and string.len(arg_37_1.effect) <= 0 then
		return
	end

	self.m_criComp:removeAllCriSprite()

	self._intervalTime = arg_37_1.time or 0

	local var_37_0 = {
		x = -display.width / 2,
		y = -display.height / 2
	}

	var_37_0.anchorX = 0
	var_37_0.anchorY = 0
	var_37_0.width = display.width
	var_37_0.height = display.height
	var_37_0.movieName = arg_37_1.effect
	var_37_0.isLoop = true
	var_37_0.additiveFlag = false
	var_37_0.moduleName = "dungeon"

	if self._intervalTime > 0 then
		var_37_0.listener = handler(self, self._onCriSpriteEvent)
	end

	self:newScheduleOnce(handler(self, function()
		self.m_criComp:addCriSprite(var_37_0)
	end), self._intervalTime)
end

function DungeonMainLayer:_onCriSpriteEvent()
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

function DungeonMainLayer:_checkTickWeakGuide()
	self._ticked = true

	local var_42_0 = var_0_5:getLastUnlockChapter()

	if var_42_0 <= 6 and self._landId == var_0_5:getCurLandId() then
		if var_0_5.checkBoxAward() and var_0_9:isModuleUnlock(var_0_10.FUNCTION_TYPE.DUNGEON_ONEKEY_AWARD) then
			var_0_7:dispatchEvent(var_0_8.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "DUNGEON_MAIN_LAYER_STAY_1",
				targetBtn = self.m_oneKeyBtn
			})
		else
			var_0_7:dispatchEvent(var_0_8.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "DUNGEON_MAIN_LAYER_STAY_2",
				targetBtn = self.m_landComp["m_chapter" .. ((var_42_0 % 5 == 0 or nil) and 5)]
			})
		end
	end
end

function DungeonMainLayer:onUnload()
	var_0_7:dispatchEvent(var_0_8.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:cancelAllSchedule()
	self.m_criComp:removeAllCriSprite()
end

return DungeonMainLayer
