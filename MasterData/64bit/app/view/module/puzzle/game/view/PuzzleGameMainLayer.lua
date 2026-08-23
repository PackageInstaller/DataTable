local PuzzleGameMainLayer = class("PuzzleGameMainLayer", require("app.fairyGUI.puzzle.UI_PuzzleGameMainLayer"), function()
	return fgui.GComponent:create({
		resName = "PuzzleGameMainLayer",
		pkgName = "puzzle",
		isFullScreen = true,
		pkgPath = "ui/puzzle/puzzle"
	})
end)
local GuideConfig = require("app.view.module.puzzle.game.const.GuideConfig")
local PuzzleGameSpotLight = require("app.view.module.puzzle.game.view.PuzzleGameSpotLight")
local var_0_3 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")

function PuzzleGameMainLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._canTouch = true
	self._hasGuide = false
	self._clickEmpty = false
	self._hasEmptyGuide = true
	self._lastOptTime = 0

	if arg_2_1 then
		self._isRepeatModel = arg_2_1.isRepeatModel or false
	end

	if arg_2_1 then
		self._isShare = arg_2_1.isShare or false
	end

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.level or g.core.model.User:getPuzzleGameLevel()

		if arg_2_1 and arg_2_1.isnext then
			var_2_0 = var_2_0 + 1

			if var_2_0 > 12 then
				var_2_0 = 10
			end
		end
	end

	self._missionId = arg_2_1 and arg_2_1.missionid
	self._level = var_2_0

	g.core.model.User:setPuzzleGameLevel(var_2_0)

	self._systemData = self:getLevelSysData(var_2_0)
	self._screenState = self._systemData.screenState
	self._bgFileName = self._systemData.bgFileName
	self._cdTime = self._systemData.guidTime

	self:_initBattle()

	local var_2_1 = g.core.common.Storage:load("puzzleGame.json") or {}

	if var_2_1.guide then
		local var_2_2 = var_2_1.guide[tostring(var_2_0)]
	end

	self.m_btnReturn:addClickListener(function()
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(100039),
			desc = g.core.lang:get(302074),
			onConfirm = function()
				self:clearScene()
				g.core.module.ModuleManager:popModule()
			end
		}), {
			touchDisappear = true
		})
	end)
	self.m_btnHome:addClickListener(function()
		self:clearScene()
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end)
	self.m_btnReset:addClickListener(function()
		self:clearScene()
		self:_reportOptTime()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.PUZZLE_GAME, self._params)
	end)
	self.m_btnHome:setVisible(false)
	self:addOneKeyPass()

	self._curGuideIndex = nil
	self._storyGuideData = {}
	self._firstEnter = true
	self._isShowResult = false

	self.m_isPlayedController:setSelectedIndex(1)
	self.m_btnShare:setVisible(not self._isShare)
	self.m_btnShare:addClickListener(handler(self, self._onShareClick))
end

function PuzzleGameMainLayer:onLoad()
	if not self._battle then
		self:_initBattle()
		self:_btnSetOpacity(255)
		self:_onStartAnimPlayEnd()
	end

	if var_0_3 and var_0_3.judgeIsRefuseBioInviteIfEnterModule then
		var_0_3:judgeIsRefuseBioInviteIfEnterModule()
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIGAME_SHOWJUDGE, handler(self, self._showJudgePanel), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onModuleExit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIGAME_REGUID, handler(self, self._reStartGuid), self)
	g.core.layer.LayerManager:getSysTipLayer():setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_EXECUTEMISSION, handler(self, self._onGamePass), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIMAGE_EXIT_GAME, handler(self, self._exitGame), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_TOUCH_START, self._onTouchStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_TOUCH_END, self._onTouchEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_START, self._onPlayStoryStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onPlayStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIGAME_GUIDESTEP, self._onStep, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIGAME_GUIDESTATE, self._onChangeGuideState, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIMAGE_SPECIAL_RESULT, self._playSpecialEffect, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIMAGE_SPOTLIGHT_END, self._onSpotLightEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINIGAME_CLEARGUID, self._onClickGuid, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_REPEAT_PUZZLE_GAME_OVER, self._reRepeatGameOver, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self._reConnect, self)
	self:addTitleEffect()

	if self._firstEnter then
		self._canTouch = false

		PuzzleGameSpotLight:setParent(self)
		self:_onSpotLightEnd()

		self._spLight = PuzzleGameSpotLight:getLight()
		self._firstEnter = false
	end

	self:_reportOptTime()

	self._schedule = self._schedule or g.core.common.Scheduler:newSchedule(handler(self, function()
		if g.core.common.ServerTime:getTime() - self._lastOptTime >= self._cdTime and not self._hasEmptyGuide then
			self._battle:checkWaitGuide()

			self._hasEmptyGuide = true
		end
	end), 0.1)

	if self.m_isPlayedController:getSelectedIndex() == 1 then
		self._canTouch = false

		self.m_actionComp:getTransition("enter"):play(handler(self, self._onStartAnimPlayEnd))
		self._battle:setGuideVisible(false)
	end
end

function PuzzleGameMainLayer:_initBattle()
	local var_9_0 = require("app.view.module.puzzle.game.control.BattleCtrl").new(self._level, self._screenState, self._missionId, self._bgFileName, self._isRepeatModel)

	var_9_0:initBuild()

	self._battle = var_9_0
	self._showPop = false
	self._loader = self.m_loader

	local var_9_1 = cc.Node:create()

	self._loader:addNode(var_9_1)

	self._touchNode = var_9_1

	local var_9_2 = var_9_1:getEventDispatcher()
	local var_9_3 = cc.EventListenerTouchOneByOne:create()

	var_9_3:setSwallowTouches(false)
	var_9_3:registerScriptHandler(function(arg_10_0, arg_10_1)
		self:_reportOptTime()

		if self._canTouch and not self._hasGuide then
			if not self._battle:touchBegin(arg_10_0, arg_10_1) then
				self._clickEmpty = true

				self:newScheduleOnce(handler(self, function()
					if self._clickEmpty and not self._hasEmptyGuide then
						self:clickGuide()

						self._clickEmpty = false
						self._hasEmptyGuide = true
					end
				end), 4)
			else
				self._battle:removeShowElem()
			end

			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_9_3:registerScriptHandler(function(arg_12_0, arg_12_1)
		if self._canTouch and not self._hasGuide then
			self._battle:touchMove(arg_12_0, arg_12_1)
		end
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_9_3:registerScriptHandler(function(arg_13_0, arg_13_1)
		if self._canTouch and not self._hasGuide then
			self._battle:touchEnd(arg_13_0, arg_13_1)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)

	self._touchListener = var_9_3

	var_9_2:addEventListenerWithSceneGraphPriority(var_9_3, var_9_1)

	self._touchEventDispatcher = var_9_2
end

function PuzzleGameMainLayer:_onStartAnimPlayEnd()
	if device.isOHOS() then
		self:newSchedule(handler(self, function(arg_15_0)
			arg_15_0._battle:showJudgePanel(1)
		end), 2)
	else
		g.core.layer.LayerManager:setPhysicsWorldAutoStep(true)
	end

	self._canTouch = true

	self.m_isPlayedController:setSelectedIndex(0)
	self._battle:setGuideVisible(true)
end

function PuzzleGameMainLayer:_onModuleExit(arg_16_1, arg_16_2)
	self._canTouch = true
end

function PuzzleGameMainLayer:setHasEmptyGuide(arg_17_1)
	self._hasEmptyGuide = arg_17_1
end

function PuzzleGameMainLayer:setClickEmpty(arg_18_1)
	self._clickEmpty = arg_18_1
end

function PuzzleGameMainLayer:addOneKeyPass()
	self.m_btnPassKey:setVisible(config.DEBUG_VERSION and cc.exports.CC_OPEN_MINIGAME_PASS)

	if not config.DEBUG_VERSION or not cc.exports.CC_OPEN_MINIGAME_PASS then
		return
	end

	local var_19_1 = (nil):getIsPass()
	local var_19_2 = g.core.common.Storage:load("puzzleGame.json") or {}

	self.m_btnPassKey:addClickListener(function()
		self._battle:clearGuid()

		if not var_19_1 then
			var_19_2.guide = var_19_2.guide or {}
			var_19_2.guide[tostring(self._level)] = true

			g.core.common.Storage:save("puzzleGame.json", var_19_2)
			g.core.network.GameNetProxy:send_C2S_MiniGame_Reward({
				id = self._level
			})

			if self._missionId and self._missionId > 0 then
				g.core.network.GameNetProxy:send_C2S_Biography_ExecuteMission({
					id = self._missionId
				})
			end
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINIGAME_RESULT_CLOSE, false, {
				isnext = true
			})
		end

		if self._level == 999 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINIGAME_RESULT_CLOSE, false, {
				isnext = true
			})
		end

		self:clearScene()
	end)
end

function PuzzleGameMainLayer:_reStartGuid()
	self:setHasEmptyGuide(false)
	self:setClickEmpty(true)
end

function PuzzleGameMainLayer:addTitleEffect()
	return
end

function PuzzleGameMainLayer:_onTouchStart()
	self._canTouch = true
end

function PuzzleGameMainLayer:_onTouchEnd()
	self._canTouch = false
end

function PuzzleGameMainLayer:_onPlayStoryEnd(arg_25_1, arg_25_2)
	if self._isRepeatModel then
		return
	end

	self:_onTouchStart()
	self:_reportOptTime()

	self._hasEmptyGuide = false

	if arg_25_2.id == 827 then
		g.core.module.ModuleManager:replaceModule(g.view.entrance.PUZZLE_GAME, self._params)

		return
	end

	if self._storyGuideData and self._storyGuideData[arg_25_2.id] and self._storyGuideData[arg_25_2.id].excute then
		self:guide()
	else
		self._hasGuide = false
	end

	if GuideConfig.STORY_ENDS[g.core.model.User:getPuzzleGameLevel()] == arg_25_2.id then
		g.core.module.ModuleManager:popModule()
	end
end

function PuzzleGameMainLayer:_onPlayStoryStart(arg_26_1, arg_26_2)
	self._hasEmptyGuide = true
end

function PuzzleGameMainLayer:_onStep(arg_27_1, arg_27_2)
	self:guide()
end

function PuzzleGameMainLayer:showSpecialResult()
	return
end

function PuzzleGameMainLayer:_onChangeGuideState(arg_29_1, arg_29_2)
	if arg_29_2 then
		self._hasGuide = arg_29_2.state or false
	end
end

function PuzzleGameMainLayer:_onSpotLightEnd(arg_30_1, arg_30_2)
	self._hasEmptyGuide = false
	self._canTouch = true

	self:checkGuide()
end

function PuzzleGameMainLayer:onUnload()
	g.core.layer.LayerManager:getSysTipLayer():setVisible(true)
	self:clearElement()

	if self._touchNode then
		self._touchNode:removeFromParent()
	end

	if self._schedule then
		g.core.common.Scheduler:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	if self._level == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

		local var_31_0 = g.core.layer.LayerManager:getGuideLayer():getChild("TrapSlideGuide")

		if var_31_0 then
			var_31_0:removeFromParent()
		end
	end
end

function PuzzleGameMainLayer:clearElement()
	self._touchEventDispatcher:removeEventListener(self._touchListener)

	if self._battle then
		self._battle:destorySelf()

		self._battle = nil
	end

	self:_btnSetOpacity(0)
end

function PuzzleGameMainLayer:getBattleCtrl()
	return self._battle
end

function PuzzleGameMainLayer:_btnSetOpacity(arg_34_1)
	self.m_btnReset:setOpacity(arg_34_1)
	self.m_btnReturn:setOpacity(arg_34_1)
	self.m_btnHome:setOpacity(arg_34_1)
end

function PuzzleGameMainLayer:_showJudgePanel(arg_35_1, arg_35_2, arg_35_3)
	self._canTouch = false

	local var_35_0, var_35_1

	if self._showPop then
		g.core.module.ModuleManager:popModule()

		self._showPop = false
		var_35_0 = self._battle:getMonster()
		var_35_1 = self._battle:getAnimal()
	end

	if arg_35_3 and arg_35_3.is_win then
		self._battle:getMainRole():onPlayShow()
	else
		if var_35_0 then
			for iter_35_0, iter_35_1 in ipairs(var_35_0) do
				if not iter_35_1:alreadyTrig() then
					iter_35_1:onPlayShow()
				end
			end
		end

		if var_35_1 then
			for iter_35_2, iter_35_3 in ipairs(var_35_1) do
				if not iter_35_3:alreadyTrig() then
					iter_35_3:onPlayShow()
				end
			end
		end
	end

	arg_35_3.retryFunc = handler(self, self._retry)
	arg_35_3.continueEvent = g.core.event.enum.EVENT_MINIMAGE_EXIT_GAME

	self:_showResult(nil, nil, arg_35_3)
end

function PuzzleGameMainLayer:_onGamePass(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {}

	if arg_36_4.award then
		for iter_36_0, iter_36_1 in ipairs(arg_36_4.award.first_drops) do
			table.insert(var_36_0, iter_36_1)
		end
	end

	self:_showJudgePanel(arg_36_1, arg_36_2, {
		is_win = true,
		rewards = var_36_0
	})
end

function PuzzleGameMainLayer:_reRepeatGameOver(arg_37_1, arg_37_2)
	if arg_37_2 then
		self:_showJudgePanel(_, arg_37_1, {
			is_win = arg_37_2.isWin and true or false,
			rewards = {},
			isRepeatModel = self._isRepeatModel
		})
	end
end

function PuzzleGameMainLayer:_showResult(arg_38_1, arg_38_2, arg_38_3)
	if self._isShowResult then
		return
	end

	self._isShowResult = true
	self._hasEmptyGuide = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_RESULT, false, g.core.event.enum.EVENT_MINIMAGE_SHOW_RESULT, 1, arg_38_3)
end

function PuzzleGameMainLayer:_onRcvRewards(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	return
end

function PuzzleGameMainLayer:getLevelSysData(arg_40_1)
	local var_40_0 = g.core.model.User.puzzleData:getLevelData(arg_40_1)
	local var_40_1 = {}

	var_40_1.screenState = 1

	if var_40_0.screenState then
		var_40_1.screenState = tonumber(var_40_0.screenState)
	end

	var_40_1.moveTime = 0.15

	if var_40_0.moveTime then
		var_40_1.moveTime = tonumber(var_40_0.moveTime)
	end

	var_40_1.stayTime = 0.4

	if var_40_0.stayTime then
		var_40_1.stayTime = tonumber(var_40_0.stayTime)
	end

	var_40_1.gapTime = 5

	if var_40_0.gapTime then
		var_40_1.gapTime = tonumber(var_40_0.gapTime)
	end

	var_40_1.guidTime = 4

	if var_40_0.guidTime then
		var_40_1.guidTime = tonumber(var_40_0.guidTime)
	end

	var_40_1.bgFileName = var_40_0.bgFileName or nil

	return var_40_1
end

function PuzzleGameMainLayer:checkGuide()
	self._guideData = GuideConfig.GUIDE_LIST[1]

	if self._guideData then
		self._curGuideIndex = 0

		local var_41_0 = g.core.common.Storage:load("puzzleGame.json") or {}

		if (var_41_0.levels and var_41_0.levels[tostring(1)] or 0) == 1 and var_41_0.guide and var_41_0.guide[tostring(1)] and 1 ~= 999 then
			return
		else
			var_41_0.levels = var_41_0.levels or {}
			var_41_0.levels[tostring(1)] = 1

			g.core.common.Storage:save("puzzleGame.json", var_41_0)
		end

		self._cacheData = var_41_0

		self:guide()
	end
end

function PuzzleGameMainLayer:guide()
	if not self._cacheData then
		return
	end

	local var_42_0 = self._curGuideIndex + 1
	local var_42_2 = self._guideData and self._guideData[var_42_0]

	if var_42_2 then
		self:_onTouchEnd()

		self._curGuideIndex = var_42_0

		if false then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = var_42_2.storyid
			})

			self._hasGuide = true
			self._storyGuideData[var_42_2.storyid] = var_42_2
		else
			if var_42_2.elemName ~= "" then
				local var_42_3 = self._battle:getElement(var_42_2.elemName)

				if var_42_3 then
					self._battle:showGuide(var_42_3:getRect(), var_42_2)

					self._hasGuide = false
					self._hasEmptyGuide = true
				end
			else
				self._hasGuide = false
			end

			self:_onTouchStart()
		end
	end
end

function PuzzleGameMainLayer:clickGuide()
	local var_43_2 = self._battle:getGuidElement()

	if var_43_2 and var_43_2.elemType == "BlockSheng" then
		GuideConfig.slideGuide.unique = var_43_2.uniqueName
		GuideConfig.slideGuide.offsetPos = {
			y = -40,
			x = 50
		}

		self._battle:showGuide(var_43_2:getRect(), GuideConfig.slideGuide)
	elseif var_43_2 then
		GuideConfig.clickGuide.unique = var_43_2.uniqueName
		GuideConfig.clickGuide.rota = var_43_2:getRota()

		self._battle:showGuide(var_43_2:getRect(), GuideConfig.clickGuide)
	end
end

function PuzzleGameMainLayer:_onClickGuid(arg_44_1, arg_44_2)
	self._battle:clickGuid(arg_44_2.unique)
	self:_checkSuperSdkOptStats(arg_44_2.unique)
end

function PuzzleGameMainLayer:_playSpecialEffect(arg_45_1, arg_45_2)
	return
end

function PuzzleGameMainLayer:clearScene()
	if self._battle then
		self._battle:removeAllElems()
	end

	self._clickEmpty = false
end

function PuzzleGameMainLayer:_reportOptTime()
	self._lastOptTime = g.core.common.ServerTime:getTime()
end

function PuzzleGameMainLayer:_reConnect()
	if self._isShowResult then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINIGAME_RESULT_CLOSE, false)
	end
end

function PuzzleGameMainLayer:_retry()
	self:clearScene()
	self:_reportOptTime()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.PUZZLE_GAME, self._params)
end

function PuzzleGameMainLayer:_tryAgain()
	local var_50_0 = g.core.module.ModuleManager:getCurModule()

	if g.core.module.ModuleManager:getModuleCount() > 1 and var_50_0.module == g.view.entrance.PUZZLE_GAME then
		g.core.module.ModuleManager:removeModuleByIndex(1)
	end

	if var_50_0.display:getName() == "ComAssistPop" then
		return
	end
end

function PuzzleGameMainLayer:_checkSuperSdkStats()
	for iter_51_0, iter_51_1 in pairs(GuideConfig.STORY_TRIGGERS) do
		if iter_51_1 == 1 then
			if GuideConfig.SUPERSDK_RESULT_LEVELS[1] then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = GuideConfig.SUPERSDK_RESULT_LEVELS[1]
				})
			end
		end
	end
end

function PuzzleGameMainLayer:_checkSuperSdkOptStats(arg_52_1)
	local var_52_0 = g.core.model.User:getPuzzleGameLevel()

	for iter_52_0, iter_52_1 in pairs(GuideConfig.STORY_TRIGGERS) do
		if iter_52_1 == var_52_0 then
			if GuideConfig.SUPERSDK_OPT_LEVELS[var_52_0] then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
					event_id = GuideConfig.SUPERSDK_OPT_LEVELS[var_52_0],
					des1 = g.core.lang:get(1222, {
						target = arg_52_1
					})
				})
			end
		end
	end
end

function PuzzleGameMainLayer:_exitGame(arg_53_1, arg_53_2, arg_53_3)
	if self._isExited then
		return
	end

	self._isExited = true

	self:clearScene()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PuzzleGameMainLayer:onRemoved()
	g.core.layer.LayerManager:setPhysicsWorldAutoStep(false)
end

function PuzzleGameMainLayer:doAutoAction()
	if not self._canTouch then
		return
	end

	if self._missionId and self._missionId > 0 then
		g.core.network.GameNetProxy:send_C2S_Biography_ExecuteMission({
			id = self._missionId
		})
	end
end

function PuzzleGameMainLayer:_onShareClick()
	fgui.UIPackage:addPackage("ui/share/share")

	local var_56_0 = fgui.UIPackage:createObject("share", "ShareSendMsgComp")

	var_56_0:setTitle(g.core.lang:get(308508, {
		name = g.core.model.User:getName()
	}))
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseChatCallPop").new({
		title = g.core.lang:get(308501),
		level = self._level,
		missionId = self._missionId,
		childComp = var_56_0,
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.PUZZLE_GAME
	}))
end

return PuzzleGameMainLayer
