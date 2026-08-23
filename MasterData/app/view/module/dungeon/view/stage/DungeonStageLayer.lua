local DungeonStageLayer = class("DungeonStageLayer", require("app.fairyGUI.dungeon.UI_DungeonStageLayer"), function()
	return fgui.GComponent:create({
		resName = "DungeonStageLayer",
		pkgPath = "ui/dungeon/dungeon",
		isFullScreen = true,
		pkgName = "dungeon"
	}, ...)
end)
local var_0_1 = g.core.config.dungeon_chapter_info
local var_0_2 = g.core.config.dungeon_stage_info
local var_0_3 = g.core.const.ConstMgr.DungeonConst
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.model.User.dungeonData
local BattleConst = require("app.view.battle.const.BattleConst")
local BGFactory = require("app.view.common.BGFactory")

function DungeonStageLayer:ctor(arg_2_1)
	var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)
	end, 0)

	if arg_2_1 then
		self._chapterId = arg_2_1.chapterId or 1
	end

	if arg_2_1 then
		self._localStageId = arg_2_1.route1 or 0
	end

	if arg_2_1 then
		self._routeType = arg_2_1.route or 0
	end

	if arg_2_1 then
		self._acqData = arg_2_1.goods or {}
	end

	self._isShowBattlePop = false
	self._waitEventCount = 0
	self._deltaX = 0

	if self._routeType > 0 and self._localStageId == 0 then
		self._localStageId = arg_2_1.route2 and arg_2_1.route2 > 0 and var_0_6:getLastPassedStageId() or var_0_6:getLastUnlockStageId()
	end

	if self._localStageId > 0 then
		self._chapterId = var_0_2.get(self._localStageId).chapter_id
		self._chapterInfo = var_0_1.get(self._chapterId)
	end

	self._isFirstEnter = false
	self._chapterInfo = var_0_1.get(self._chapterId)
	self._mapId = self._chapterInfo.stage_map
	self._routeId = self._chapterInfo.ctrl_id

	if g.core.utils.Quality.needUseStaticMap() then
		self._mapId = self._mapId .. "0001"
		self._routeId = self._routeId .. "0001"
	end

	self.m_scrollComp:initChapterId(self._chapterId)
	self.m_scrollComp:setScale(0.9, 0.9)

	self._battleNode = cc.Node:create()

	self._battleNode:setPosition(cc.p(0, display.height / 2))
	self.m_scrollComp:getStageComp():addNode(self._battleNode)

	self._battleTopLayer = cc.Node:create()

	self._battleTopLayer:setPosition(cc.p(0, 0))
	self:addNode(self._battleTopLayer)
	self.m_topBarComp:setResInfoById(var_0_3.NORMAL_TOP_RES_ID)
	var_0_6:inFailBattleJumpState()
	self.m_scrollComp:getStageComp():setVisible(false)

	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_1 = self.m_bottomComp:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_2_0.x > 0 then
		var_2_1 = var_2_1 - var_2_0.x * 2
	end

	self.m_bottomComp:setWidth(var_2_1)
end

function DungeonStageLayer:onLoad()
	var_0_5:addEventListener(var_0_4.EVENT_GUIDE_ENTER_DUNGEON_BATTLE_OPE, self.guideEnterBattleOpe, self)
	var_0_5:addEventListener(var_0_4.EVENT_DUNGEON_STAGE_TO_BATTLE, self._onRcvBattleBegin, self)
	var_0_5:addEventListener(var_0_4.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEBEGIN, self._onRecvGuideBattleMsg, self)
	var_0_5:addEventListener(var_0_4.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, self._onGetChapterChestAward, self)
	var_0_5:addEventListener(var_0_4.EVENT_BATTLE_EXIT, self._onBattleExit, self)
	var_0_5:addEventListener(var_0_4.EVENT_MOP_UP_POP_CLOSE, self.onMopUpPopClose, self)
	var_0_5:addEventListener(var_0_4.EVENT_NET_S2C_DUNGEON_FINISHACHIEVEMENT, self._updateAchieveBtn, self)

	local var_4_0 = g.core.common.Storage:load("dungeon.json") or {}
	local var_4_1 = var_4_0.chapterId

	if var_0_6:getChapterStar(self._chapterId) == 0 and (not var_4_1 or var_4_1 < self._chapterId) and not var_0_6:isAutoChallenge() then
		var_4_0.chapterId = self._chapterId

		g.core.common.Storage:save("dungeon.json", var_4_0)

		self._isFirstEnter = true

		var_0_5:dispatchEvent(var_0_4.EVENT_DUNGEON_CHAPTER_START, false, {
			story = {
				self._chapterId
			}
		})
	end

	local var_4_2 = false

	if self._routeType > 0 and self._isFirstEnter then
		self._isFirstEnter = false
		var_4_2 = true
	end

	if self._isFirstEnter then
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT_SURE_OK)

		self._waitEventCount = self._waitEventCount + 1
		self._inWaitEvent = true
	end

	self:_updateStage()

	if g.core.model.User.storyData:isInStory() then
		self.m_scrollComp:updateMonsterState(false)

		if var_4_2 then
			self.m_scrollComp:updateScrollState(self._localStageId, self._isFirstEnter)
			self.m_scrollComp:setStageTouchable(true)
		end

		if self._isFirstEnter then
			self:setOpacity(0)
		end

		if var_0_1.indexOf(1).id == self._chapterId then
			self._isFirstEnter = false
		end

		self.m_scrollComp:updateScrollState(self._localStageId, false)

		if self._inWaitEvent then
			var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

			self._waitEventCount = self._waitEventCount - 1
			self._inWaitEvent = false
		end

		self._localStageId = 0
		self._isFirstEnter = false

		self.m_scrollComp:setStageTouchable(true)
	else
		self.m_scrollComp:updateScrollState(self._localStageId, self._isFirstEnter)

		if not self._isFirstEnter then
			if self._inWaitEvent then
				var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

				self._waitEventCount = self._waitEventCount - 1
				self._inWaitEvent = false
			end

			self:setOpacity(255)
			self.m_scrollComp:getStageComp():setVisible(true)
		else
			self._inWaitEvent = false

			self.m_enterTransition:play(function()
				self:setOpacity(255)
				self.m_scrollComp:getStageComp():setVisible(true)
			end)
		end

		self._localStageId = 0
		self._isFirstEnter = false

		self.m_scrollComp:setStageTouchable(true)
	end

	self:resetDangerIconState()

	if var_0_6:inFailBattleJumpState() then
		self:battleEndFunc()
	end

	self.m_scrollComp:setOpacity(255)
end

function DungeonStageLayer:onUnload()
	if self._waitEventCount > 0 then
		for iter_6_0 = 1, self._waitEventCount do
			var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)
		end

		self._waitEventCount = 0
	end

	self._isShowBattlePop = false
end

function DungeonStageLayer:switchByAcquire(arg_7_1)
	if arg_7_1 then
		self._chapterId = arg_7_1.chapterId or 1
	end

	if arg_7_1 then
		self._localStageId = arg_7_1.stageId or 1
	end

	self:_updateStage()
end

function DungeonStageLayer:_updateStage()
	self.m_scrollComp:update()
	self.m_scrollComp:getStageComp():updateStageChest()
	self.m_bottomComp:updateChestInfo(self._chapterInfo)
end

function DungeonStageLayer:_updateAchieveBtn()
	self.m_bottomComp:updateAchieveBtn()
end

function DungeonStageLayer:_updateByStoryEnd(arg_10_1)
	if not arg_10_1.trigger_type or arg_10_1.trigger_type == "EVENT_DUNGEON_CHAPTER_START" then
		if var_0_6:getChapterStar(self._chapterId) == 0 then
			self._localStageId = 0

			if arg_10_1.isDialog then
				self.m_scrollComp:updateScrollState(self._localStageId, true)
				self.m_enterTransition:play(function()
					self:setOpacity(255)
					self.m_scrollComp:getStageComp():setVisible(true)
				end)
				self:newScheduleOnce(handler(self, function()
					self.m_scrollComp:handleFirstEnter()
				end), 0)
			end

			self.m_scrollComp:setMainRoleVisible(self._routeType > 0)

			if var_0_1.indexOf(1).id == self._chapterId then
				self:_handleFirstFinish()
			end
		end
	elseif arg_10_1.trigger_type == "EVENT_DUNGEON_STAGE_START" then
		self:actionsFunc()
	elseif arg_10_1.trigger_type == "EVENT_DUNGEON_STAGE_END" then
		local var_10_0 = var_0_6:getBattleInfo()

		if var_10_0 then
			if var_10_0 then
				if var_10_0 then
					if g.core.guide.GuideProxy:isGuideRunning() and self._chapterId == var_0_3.GUIDE_MOVIE_STORY.CHAPTER_ID and (var_10_0.stageId or 200104) == self._chapterInfo["stage_" .. var_0_3.GUIDE_MOVIE_STORY.STAGE_ID] and (var_10_0.isWin or false) and (var_10_0.isFirst or false) then
						var_0_5:dispatchEvent(var_0_4.EVENT_STORY_FORCE_START, false, {
							id = var_0_3.GUIDE_MOVIE_STORY.EVENT_MOVIE_ID
						})

						return
					end
				end
			end
		end

		self:battleEndFunc()
	elseif arg_10_1.trigger_type == "EVENT_STORY_FORCE_START" then
		if arg_10_1.trigger_data.subEvent == "EVENT_GUIDE_STORY_OPENING" then
			self._localStageId = 0

			if arg_10_1.isDialog then
				self.m_scrollComp:updateScrollState(self._localStageId, true)
				self.m_enterTransition:play(function()
					self:setOpacity(255)
					self.m_scrollComp:getStageComp():setVisible(true)
				end)
				self:newScheduleOnce(handler(self, function()
					self.m_scrollComp:handleFirstEnter()
				end), 0)
			end

			self.m_scrollComp:setMainRoleVisible(self._routeType > 0)

			if var_0_1.indexOf(1).id == self._chapterId then
				self:_handleFirstFinish()
			end
		elseif arg_10_1.trigger_data.subEvent == "EVENT_GUIDE_STORY_PROCESSING" then
			-- block empty
		elseif arg_10_1.trigger_data.id == var_0_3.GUIDE_MOVIE_STORY.EVENT_MOVIE_ID then
			g.core.sound.SoundManager:playMusic(g.core.sound.SoundManager:getCurBgm() or g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAIN_MENU)
			self:battleEndFunc()
		end
	end

	self.m_scrollComp:recheckWeakGuide()
end

function DungeonStageLayer:_handleFirstFinish()
	self._isFirstEnter = false

	self.m_scrollComp:updateMonsterState(true)
	self.m_scrollComp:setMainRoleVisible(true)
	self.m_scrollComp:setStageTouchable(true)
end

function DungeonStageLayer:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "first_finish" then
		self:_handleFirstFinish()
		self:storyVisible(true)
		self.m_topBarComp:setVisible(true)
		self:showBottomCompAction()
	elseif arg_16_1 == "DungeonStageComp_show_end" then
		self.m_scrollComp:setStageTouchable(true)
	elseif arg_16_1 == "chapter_finish" then
		local var_16_0 = true
		local var_16_1 = false

		if g.core.guide.GuideProxy:isGuideRunning() then
			var_16_1 = true

			if self._chapterId == 1 then
				var_16_1 = false

				var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)
				g.core.common.Scheduler:newScheduleOnce(function()
					var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)
				end, 0)
			end

			var_16_0 = false
		end

		self.m_scrollComp:getChild("stage"):setTouchable(false)
		self.m_bottomComp:setTouchable(false)
		self.m_topBarComp:setTouchable(false)

		local var_16_2 = require("app.view.module.dungeon.view.DungeonEffectPop").new()

		self:addPopup(var_16_2, {
			blackOpacity = 0.7,
			touchDisappear = true,
			withoutAni = true,
			popScene = var_16_0
		})
		var_16_2:update({
			name = "finish",
			chapterId = self._chapterId
		})
		var_16_2:addEventListener(fgui.UIEventType.ExitFinish, function()
			if var_16_1 then
				g.core.common.Scheduler:newScheduleOnce(function()
					g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.DUNGEON)
				end, 0)
			end

			var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)
			g.core.common.Scheduler:newScheduleOnce(function()
				var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)
			end, 0)
		end)
	elseif arg_16_1 == "effect_exit" then
		self.m_scrollComp:getChild("stage"):setTouchable(true)
	elseif arg_16_1 == "end_auto_fight" then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.2)
		self:_updateStage()

		self._isAutoFight = false
	elseif arg_16_1 == "DungeonBattleInfoPop_blitz" then
		local var_16_3 = var_0_6:getStage(arg_16_2.stageId)

		if var_16_3 and var_16_3:isPassed() then
			local var_16_4 = require("app.view.base.infoPop.BlitzDungeonResultPop").new({
				stageId = arg_16_2.stageId,
				num = arg_16_2.num,
				acqData = self._acqData
			})

			g.core.module.ModuleManager:pushModule({
				modType = g.view.entrance.POPUP,
				create = function()
					return var_16_4
				end
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(300020))
		end
	elseif arg_16_1 == "EVENT_STORY_START" then
		self:storyVisible(false)
	elseif arg_16_1 == "EVENT_STORY_END" then
		if g.core.battle.BattleProxy:isInBattle() then
			return
		end

		self:storyVisible(true)
		self:_updateByStoryEnd(arg_16_2)
	elseif arg_16_1 == "DungeonMonsterComp_SHOW_BATTLE_COMP" then
		self._monsterPos = arg_16_2.pos
		self._monsterId = arg_16_2.monsterId
		self._deltaX = arg_16_2.deltaX or 0

		if var_0_6:getLastUnlockStageId() == self._monsterId then
			self._oldMonsterId = self._monsterId or nil
		end

		local var_16_5 = self.m_scrollComp:getMainRolePos()
		local var_16_6 = self._monsterPos.x

		if cc.pGetDistance(cc.p(var_16_5.x, var_16_5.y), cc.p(self._monsterPos.x, self._monsterPos.y)) > 130 then
			var_16_6 = var_16_5.x < self._monsterPos.x and self._monsterPos.x - 100 - self._deltaX or self._monsterPos.x + 100 + self._deltaX

			self.m_scrollComp:onMoveTargetPos({
				x = var_16_6,
				y = self._monsterPos.y
			}, handler(self, self.receiveActionsFunc))
		else
			self:receiveActionsFunc()
		end
	elseif arg_16_1 == "HIDE_TOP_DOWN_COMP" then
		self:storyVisible(false)
	elseif arg_16_1 == "DungeonMonsterComp_HIDE_BATTLE_COMP" then
		self._isShowBattlePop = false

		self.m_dangerHostComp:updateState()

		if arg_16_2 and arg_16_2.isEnterBattle then
			self.m_onLineAwardBtn:hide()
			self.m_scrollComp:setStageTouchable(false)
			self.m_dangerHostComp:hide()
			self:runFGAction(fgui.FSequence:create({
				fgui.FCallFunc:create(handler(self, function()
					self.m_scrollComp:getStageComp():getMainRole():setVisible(false)
					self.m_topBarComp:setVisible(false)
					self:hideBottomCompAction()

					local var_23_0 = self.m_scrollComp:getStageComp()

					var_23_0:setAllMonsterVisible(false)
					var_23_0:setAllStageChestVisible(false)
					var_23_0:setAllStageInteractVisible(false)
				end)),
				fgui.FDelayTime:create(0.3),
				fgui.FCallFunc:create(handler(self, function()
					self:_scaleCamera(true)
				end))
			}))
		else
			self.m_scrollComp:addTouchListener()
			self:showBottomCompAction()
			self.m_topBarComp:setVisible(true)
		end
	elseif arg_16_1 == "DUNGEON_SCAN_FULL_SCENE" then
		self:_scanFullScreeAndHideComp()
	end
end

function DungeonStageLayer:receiveActionsFunc()
	if self._isShowBattlePop then
		return
	end

	if var_0_6:getStageStar(g.core.config.dungeon_stage_info.get(self._monsterId).id) == 0 and not var_0_6:isAutoChallenge() then
		var_0_5:dispatchEvent(var_0_4.EVENT_DUNGEON_STAGE_START, false, {
			story = {
				self._monsterId
			}
		})
	end

	if g.core.model.User.storyData:isInStory() then
		return
	end

	self:actionsFunc()
end

function DungeonStageLayer:storyVisible(arg_26_1)
	self.m_topBarComp:setVisible(arg_26_1)
	self.m_bottomComp:setVisible(arg_26_1)
end

function DungeonStageLayer:actionsFunc()
	local var_27_0 = self._monsterId

	if not var_0_6:isCanAutoFightByStageId() then
		self.m_scrollComp:removeTouchListener()
		self.m_topBarComp:setVisible(false)
		self:hideBottomCompAction()
		self.m_scrollComp:moveToMonsterPos(self._monsterPos, 5, handler(self, function()
			local var_28_0 = g.core.model.User.storyData:checkHasTrigger(var_0_4.EVENT_DUNGEON_STAGE_START, {
				var_27_0
			})

			if not ((var_0_6:isAutoChallenge() or nil) and false) then
				g.core.common.Scheduler:newScheduleOnce(handler(self, function()
					g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.DUNGEON_BATTLE_POP, var_27_0)

					self._isShowBattlePop = true
				end), 0)
			else
				var_0_5:dispatchEvent(var_0_4.EVENT_DUNGEON_STAGE_START, false, {
					story = {
						var_27_0
					}
				})
			end
		end))
	else
		self._stageId = self._monsterId

		self:_goBattle()
	end
end

function DungeonStageLayer:_onRcvBattleBegin(arg_30_1, arg_30_2)
	self.m_dangerHostComp:hide()

	self._battleId = arg_30_2.battle_id

	local var_30_0 = var_0_2.get(arg_30_2.id)
	local var_30_1 = self.m_scrollComp:getStageComp():displayObject():convertToNodeSpace(cc.p(display.cx, display.cy))

	if self._battleNode then
		self._battleNode:setPosition(cc.p(var_30_1.x - display.cx, var_30_1.y - display.cy))
	end

	var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)

	self._waitEventCount = self._waitEventCount + 1

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		ignoreResult = true,
		id = arg_30_2.id,
		canSkip = var_0_6:isStagePassed(arg_30_2.id),
		drop = var_30_0.reward_tael,
		battle_id = arg_30_2.battle_id,
		type = BattleConst.TYPE_DUNGEON,
		typeQuality = var_30_0.quality,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		battleNode = self._battleNode,
		bgm = var_30_0.battle_music,
		offsetX = -var_30_1.x,
		offsetY = -var_30_1.y,
		mapId = self._mapId
	})
	self.m_scrollComp:setOpacity(0)
	var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

	self._waitEventCount = self._waitEventCount - 1

	self.m_onLineAwardBtn:hide()
end

function DungeonStageLayer:_onGetChapterChestAward(arg_31_1, arg_31_2, arg_31_3)
	g.core.module.ModuleManager:awardSummary((arg_31_3 or nil) and (arg_31_3.awards or {}))
end

function DungeonStageLayer:guideEnterBattleOpe()
	self.m_scrollComp:setStageTouchable(false)
	self.m_dangerHostComp:hide()
	self.m_scrollComp:getStageComp():getMainRole():setVisible(false)
	self:hideBottomCompAction()

	local var_32_0 = self.m_scrollComp:getStageComp()

	var_32_0:setAllMonsterVisible(false)
	var_32_0:setAllStageChestVisible(false)
	var_32_0:setAllStageInteractVisible(false)
	self.m_topBarComp:setVisible(false)
	self.m_onLineAwardBtn:hide()
end

function DungeonStageLayer:_onRecvGuideBattleMsg(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = g.core.module.ModuleManager:getCurModule()

	if var_33_0 then
		print(var_33_0.display:getName())

		if var_33_0.display:getName() ~= "DungeonStageLayer" then
			return
		end
	end

	local var_33_1 = arg_33_3.id

	self._battleId = arg_33_3.battle_id

	local var_33_2 = var_0_2.get(var_33_1)

	if not var_0_6:isCanAutoFightByStageId() then
		self.m_dangerHostComp:hide()

		local var_33_3 = self.m_scrollComp:getStageComp():displayObject():convertToNodeSpace(cc.p(display.cx, display.cy))

		if self._battleNode then
			self._battleNode:setPosition(cc.p(var_33_3.x - display.cx, var_33_3.y - display.cy))
		end

		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)

		self._waitEventCount = self._waitEventCount + 1

		g.core.battle.BattleProxy:enterBattle({
			cloudLoading = true,
			ignoreResult = true,
			id = var_33_1,
			canSkip = var_0_6:isStagePassed(var_33_1),
			drop = var_33_2.reward_tael,
			battle_id = arg_33_3.battle_id,
			type = BattleConst.TYPE_DUNGEON,
			typeQuality = var_33_2.quality,
			battleType = BattleConst.BATTLE_TYPE.PVE,
			battleNode = self._battleNode,
			bgm = var_33_2.battle_music,
			offsetX = -var_33_3.x,
			offsetY = -var_33_3.y,
			mapId = self._mapId
		})
		self.m_scrollComp:setOpacity(0)
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

		self._waitEventCount = self._waitEventCount - 1

		self.m_onLineAwardBtn:hide()
	end
end

function DungeonStageLayer:battleEndFunc()
	if var_0_6:isSpecialGuideOpe() then
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

		return
	end

	self:_scaleCamera(false)
	self.m_topBarComp:setVisible(true)
	self:showBottomCompAction()
	self:_updateStage()
	var_0_5:dispatchEvent(var_0_4.EVENT_REENTER_DUNGEON_STAGE_AFTER_BATTLE)
	self:resetDangerIconState()
	self.m_scrollComp:getStageComp():getMainRole():setVisible(true)

	local var_34_0 = self.m_scrollComp:getStageComp()

	var_34_0:setAllMonsterVisible(true)
	var_34_0:setAllStageInteractVisible(true)
	self.m_scrollComp:handlePostBattleAni()
	self.m_scrollComp:battleEndUpdate(false)
	self.m_scrollComp:addTouchListener()
	self.m_scrollComp:setStageTouchable(true)
	var_34_0:setAllStageChestVisible(true)
	self.m_onLineAwardBtn:show()

	if var_0_6:getLastUnlockChapter() == self._chapterId then
		local var_34_1 = var_0_6:getLastUnlockStageId()

		if self._oldMonsterId and self._oldMonsterId ~= var_34_1 then
			local var_34_2 = self.m_scrollComp:getMonsterByStageID(var_34_1)

			if var_34_2 then
				var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)
				var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)

				self._waitEventCount = self._waitEventCount + 2

				local var_34_3 = var_34_2:getPosition()

				self.m_scrollComp:onMoveTargetPos({
					x = var_34_3.x - 100 - self._deltaX,
					y = var_34_3.y
				}, handler(self, function()
					var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

					self._waitEventCount = self._waitEventCount - 1
				end))
				self.m_scrollComp:moveToMonsterPos(var_34_3, nil, handler(self, function()
					var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

					self._waitEventCount = self._waitEventCount - 1
				end))
			end
		end
	end

	var_0_6:resetBattleInfo()
	var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_CHECK, false, {
		tickType = 4,
		stageId = self._monsterId
	})
end

function DungeonStageLayer:_onBattleExit()
	self.m_scrollComp:getStageComp():postBattle()
	self.m_scrollComp:setOpacity(255)

	if g.core.model.User.storyData:isInStory() then
		return
	end

	self:battleEndFunc()
	var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)
	end, 0.5)
end

function DungeonStageLayer:showBottomCompAction()
	if self.m_bottomComp then
		self.m_bottomComp:setVisible(true)
	end
end

function DungeonStageLayer:hideBottomCompAction()
	if self.m_bottomComp then
		self.m_bottomComp:setVisible(false)
	end
end

function DungeonStageLayer:_scaleCamera(arg_41_1)
	self.m_scrollComp:setPivot(0, 0)

	local var_41_0 = self.m_scrollComp:getWidth() * 0.1
	local var_41_1 = self.m_scrollComp:getHeight() * 0.1
	local var_41_2 = 0.9

	if arg_41_1 then
		var_41_0 = -var_41_0
		var_41_1 = -var_41_1
		var_41_2 = 1
	end

	self.m_scrollComp:stopAllFGActions()
	self.m_scrollComp:runFGAction((fgui.FSpawn:create(fgui.FScaleTo:create(0.5, var_41_2), fgui.FMoveTo:create(0.5, {
		x = self.m_scrollComp:getX() + var_41_0 / 2,
		y = self.m_scrollComp:getY() + var_41_1 / 2
	}))))
end

function DungeonStageLayer:resetDangerIconState()
	self.m_dangerHostComp:updateState()
end

function DungeonStageLayer:onMopUpPopClose()
	g.core.model.User.rebelData:getNewestRebelElem()
	self.m_dangerHostComp:updateState()
end

function DungeonStageLayer:onRemoved()
	if self._battleNode then
		self._battleNode:removeFromParent()

		self._battleNode = nil
	end

	if self._battleTopLayer then
		self._battleTopLayer:removeFromParent()

		self._battleTopLayer = nil
	end
end

function DungeonStageLayer:_scanFullScreeAndHideComp()
	self:_scaleInteractCamera(false)
	self:hideBottomCompAction()

	if self.m_scrollComp then
		local var_45_0 = self.m_scrollComp:getStageComp()

		if var_45_0 then
			self.m_topBarComp:setResInfoById(var_0_3.SCAN_FULL_SCENE_TOP_RES_ID)
			self.m_topBarComp:setReturnCallBack(handler(self, self._resumeLayerCompFromFullScreen))
			var_45_0:hideStageCompToShowFullScene()
		end
	end
end

function DungeonStageLayer:_resumeLayerCompFromFullScreen()
	self:_scaleInteractCamera(true)
	self:showBottomCompAction()
	self.m_topBarComp:setResInfoById(var_0_3.NORMAL_TOP_RES_ID)
	self.m_topBarComp:resumeReturnClickLister()

	if self.m_scrollComp then
		local var_46_0 = self.m_scrollComp:getStageComp()

		if var_46_0 then
			var_46_0:resumeStageCompFromFullScene()
		end
	end
end

function DungeonStageLayer:_scaleInteractCamera(arg_47_1)
	self._mapSize = BGFactory.getMapSize({
		bgPath = "parallax/dungeon_stage/" .. self._mapId .. "/dungeon_stage.pcfg"
	})

	local var_47_0 = 0.9

	var_0_3.SCAN_FULL_SCENE_OFFSET_X = 0

	if arg_47_1 == false then
		var_47_0 = var_0_3.SCAN_FULL_SCALE
		var_0_3.SCAN_FULL_SCENE_OFFSET_X = self._mapSize.width * (0.9 - var_0_3.SCAN_FULL_SCALE)
	end

	self.m_scrollComp:stopAllFGActions()
	self.m_scrollComp:runFGAction((fgui.FSpawn:create(fgui.FScaleTo:create(1.5, var_47_0))))
end

function DungeonStageLayer:_goBattle()
	if self:_checkBattleRes() then
		g.core.common.GlobalFunc.checkBagBeforeBattle(handler(self, self._onRequestBattle))
	end
end

function DungeonStageLayer:_checkBattleRes()
	if g.core.model.User.resourceData:getVit() < var_0_2.get(self._stageId).cost then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_STAMINA_PILL,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
		}), {
			touchDisappear = true
		})

		return false
	end

	return true
end

function DungeonStageLayer:doAutoAction()
	if self.m_scrollComp:getSpineStateName() ~= "idle" then
		return
	end

	local var_50_0 = self.m_scrollComp:doAutoAction()

	if not var_50_0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return true
	end

	self.m_scrollComp:moveToMonsterPos(var_50_0:getPosition(), nil, handler(self, function()
		var_0_5:dispatchEvent(var_0_4.EVENT_GUIDE_READY)

		self._waitEventCount = self._waitEventCount - 1
	end))
end

function DungeonStageLayer:_onRequestBattle()
	if var_0_6:isCanAutoFightByStageId() and not self._isAutoFight then
		g.core.network.GameNetProxy:send_C2S_Dungeon_ChallengeStageBegin({
			id = self._stageId
		})

		self._isAutoFight = true
	end
end

return DungeonStageLayer
