local var_0_0 = g.core.config.theme_biography_event_info
local var_0_1 = g.core.config.activity_theme_display_info
local var_0_2 = g.core.event
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.const.ConstMgr.InfoConst
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_6 = g.core.const.ConstMgr.ThemeBioConst
local MapConst = require("app.core.ksmap.MapConst")
local SpineBase = require("app.view.common.SpineBase")
local ThemeBioGameWorld = import(".ThemeBioGameWorld")
local ThemeBioUtils = import("..model.ThemeBioUtils")
local var_0_11 = g.core.network.GameNetProxy
local var_0_12 = g.core.common.Goods
local var_0_13 = g.core.model.User.themeData
local var_0_14 = g.core.const.ConstMgr.ThemeConst
local var_0_15 = false
local ThemeBioVoteGameStage = class("ThemeBioVoteGameStage", require("app.fairyGUI.themeBio.UI_ThemeBioVoteGameStage"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioVoteGameStage",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	})
end)

function ThemeBioVoteGameStage:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1.themeValue or 1
	self._themeBioData = var_0_13:getThemeData(self._activeThemeValue):getThemeBioData()
	self._chapterId = arg_2_1.chapterId
	self._refChapterInfo = self._themeBioData:getChapter(self._chapterId)
	self._displayInfo = var_0_1.get(self._activeThemeValue)
	self._worldId = self._refChapterInfo.stage_map
	self._mapWorld = nil
	self._refChapterInteractInfo = ""
	self._themeBioStorage = nil
	self._refCurMission = nil
	self._refTalkEntity = nil
	self._lastTaskFinish = false
	self._isShowMissionFinish = false
	self._isShowChapterFinish = false
	self._needJump2VoteLayer = false
	self._needShowTargetPop = false
	self._tmpMovieParams = nil
	self._intervalTime = 0
	self._showVoteBtn = arg_2_1.showVoteBtn ~= nil and arg_2_1.showVoteBtn or self._themeBioData and self._themeBioData:showVoteBtn(self._chapterId) or false
	self._unlockVoteBtn = arg_2_1.unlockVoteBtn ~= nil and arg_2_1.unlockVoteBtn or self._themeBioData and self._themeBioData:hasFinishChapter(self._chapterId)

	self:initStage()
end

function ThemeBioVoteGameStage:onLoad()
	self:_initRegister()
	self:getMapWorld():startObserver(self.m_touchMap)
	self.m_autoComp:setVisible(false)
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:setMax(1)
	self.m_taskPart:startUp(self)
	self.m_taskPart:initChapterData(self._refChapterInfo, self._activeThemeValue)

	local var_3_0, var_3_1 = self._themeBioData:getFinishNewMission()

	if var_3_0 then
		self:_playTaskCompleteAni(nil, var_3_1)
		self:_checkChapterFinish(var_3_1)
	else
		self.m_taskPart:refreshTask()
	end

	if self:_checkChainState() then
		self:checkExitBtnShow(true)
	else
		self:checkExitBtnShow(false)
	end

	self:getMapWorld():startWorld()
	self:getMapWorld():refreshEntityState(self._refChapterInfo)
	self:_loadSnowMovie(self._refChapterInfo)
	self:_playMainActionStart()
	self:_addBgMusic()
	g.core.resource.ResourceManager:clearResource()

	self._bagRedPointComp = self.m_bagBtn:getChild("redPointComp")

	self._bagRedPointComp:setId(416)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._bagRedPointComp,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
end

function ThemeBioVoteGameStage:_scheduleOnceCall()
	self:newScheduleOnce(handler(self, function(arg_5_0)
		arg_5_0:_taskFinishAwardSummary()
	end))
end

function ThemeBioVoteGameStage:_addBgMusic()
	self._bgMusic = nil

	if self._refChapterInfo then
		if self._refChapterInfo.music and self._refChapterInfo.music ~= "" then
			self._bgMusic = self._refChapterInfo.music

			g.core.sound.SoundManager:playMusic(self._refChapterInfo.music)
		end
	end
end

function ThemeBioVoteGameStage:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self.m_criComp:removeAllCriSprite()
	self.m_taskPart:startUp(nil)
	self:getMapWorld():stopObserver(self.m_touchMap)

	if self.m_pickupComp then
		self.m_pickupComp:stopAllFGActions()
	end
end

function ThemeBioVoteGameStage:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "EVENT_STORY_END" then
		self:_onEventStoryEnd(arg_8_2)
	elseif arg_8_1 == "UI_EVENT_CLOSE_MAIN_INFO_END" then
		self:_playMainFlowEnd()
	elseif arg_8_1 == "UI_EVENT_CLOSE_MAIN_INFO_START" then
		self:_playMainFlowStart()
	end
end

function ThemeBioVoteGameStage:initStage()
	self:_initMapWorld()
	self:_initStageData()
	self:_initStageUI()
	self.m_enterTransition:play()
end

function ThemeBioVoteGameStage:_playMainActionStart()
	if self:_checkFirstChapter() then
		self:_setHudUIShow(false)
		self:_playMainInfoStart()
	else
		self:_playMainFlowStart()
	end
end

function ThemeBioVoteGameStage:_playMainInfoStart()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.ThemeBioChapterBeginPop").new({
		chapterInfo = self._refChapterInfo,
		themeValue = self._activeThemeValue
	}), {
		withoutAni = true
	})
end

function ThemeBioVoteGameStage:_playMainFlowStart()
	self:_setHudUIShow(true)
end

function ThemeBioVoteGameStage:_playMainFlowEnd()
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
end

function ThemeBioVoteGameStage:_checkChapterFinish(arg_15_1)
	self:_refreshVoteBtn()

	if not self._lastTaskFinish and arg_15_1.finish and self._themeBioData:getChain(arg_15_1.chain).type == 1 and self._themeBioData:getChain(self._refChapterInfo.chains[1]).finish then
		if self._isShowMissionFinish then
			self._isShowChapterFinish = true
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(409158))
			self:_checkVotePop()
		end
	end
end

function ThemeBioVoteGameStage:_playMainInfoEnd()
	if self._refChapterInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.ThemeBioChapterEndPop").new({
			chapterInfo = self._refChapterInfo,
			themeValue = self._activeThemeValue
		}), {
			withoutAni = true
		})
	end
end

function ThemeBioVoteGameStage:_checkFirstChapter()
	if self._themeBioStorage.chapterId == nil or self._themeBioStorage.chapterId < self._chapterId then
		self._themeBioStorage.chapterId = self._chapterId

		self:_serializeBio()

		return true
	end

	return false
end

function ThemeBioVoteGameStage:getMapWorld()
	return self._mapWorld
end

function ThemeBioVoteGameStage:getMapGround()
	return self._mapWorld:getMapGround()
end

function ThemeBioVoteGameStage:talkTrigger(arg_20_1)
	if not arg_20_1 then
		return
	end

	local var_20_0 = arg_20_1:getBindID()

	if not arg_20_1:getIsInteractEntity() then
		local var_20_1 = self._refChapterInfo.res[arg_20_1:getBindID()]

		if var_20_1 == nil then
			return
		end

		self._refTalkEntity = arg_20_1

		local var_20_2 = {}

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			local var_20_4 = self._themeBioData:getMission(iter_20_1)
			local var_20_5 = self._themeBioData:getChain(var_20_4.chain)

			if var_20_5.type == 4 and var_20_4.isLast then
				if var_20_4.finish then
					break
				end

				local var_20_6
				local var_20_7 = true

				for iter_20_2, iter_20_3 in ipairs(var_20_5.missions) do
					local var_20_8 = self._themeBioData:getMission(iter_20_3)

					if var_20_8.isFirst then
						var_20_6 = var_20_8
					end

					if not var_20_8.isFirst and not var_20_8.isLast and var_20_7 and not var_20_8.finish then
						var_20_7 = false
					end
				end

				if not var_20_6.finish or not ((var_20_5.type == 1 and not var_20_4.finish and var_20_4.unlock or nil) and false) then
					break
				end

				if var_20_7 then
					table.insert(var_20_2, var_20_4)

					break
				end

				self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerPublishPop").new(2, var_20_6.id, nil, self._refTalkEntity, self._activeThemeValue), {
					withoutAni = true,
					hideContinue = true,
					touchDisappear = true
				})

				return
			end

			if var_20_4.canTrigger then
				table.insert(var_20_2, var_20_4)
			end
		end

		if #var_20_2 == 0 then
			self:_showBubbleOrStory(var_20_1)
		else
			table.sort(var_20_2, function(arg_21_0, arg_21_1)
				if arg_21_0.unlock ~= arg_21_1.unlock then
					return not arg_21_0.unlock
				end

				if arg_21_0.finish ~= arg_21_1.finish then
					return not arg_21_0.finish
				end

				local var_21_0 = self._themeBioData:getChain(arg_21_0.chain)
				local var_21_1 = self._themeBioData:getChain(arg_21_1.chain)

				if var_21_0.type ~= var_21_1.type then
					return var_21_0.type < var_21_1.type
				end

				return false
			end)
			self:_executeMission(var_20_2[1])
		end
	else
		local var_20_9 = self._themeBioData:getInteractByBindAndChapterId(var_20_0, self._chapterId)

		self._refChapterInteractInfo = var_20_9

		if var_20_9 then
			self:_executeInteractOperation(var_20_9, arg_20_1)
		end
	end
end

function ThemeBioVoteGameStage:setAutoSearchPath(arg_22_1)
	self.m_autoComp:setVisible(arg_22_1)
end

function ThemeBioVoteGameStage:pickupStop()
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:stopAllFGActions()
end

function ThemeBioVoteGameStage:saveStayCoord(arg_24_1)
	self._themeBioStorage["stay_" .. self._chapterId] = {
		x = arg_24_1.x,
		y = arg_24_1.y
	}

	self:_serializeBio()
end

function ThemeBioVoteGameStage:getStayCoord()
	return self._themeBioStorage["stay_" .. self._chapterId]
end

function ThemeBioVoteGameStage:setHeadArrow(arg_26_1, arg_26_2, arg_26_3)
	self.m_headBtn:setVisible(arg_26_1)
end

function ThemeBioVoteGameStage:_loadSnowMovie(arg_27_1)
	if g.core.utils.Quality.needCloseWeather() then
		return
	end

	if not arg_27_1 or not arg_27_1.effect or arg_27_1.effect == "" then
		return
	end

	self.m_criComp:removeAllCriSprite()

	self._intervalTime = arg_27_1.time or 0

	local var_27_0 = {}

	var_27_0.x = 25
	var_27_0.y = 25
	var_27_0.fullScreenState = 1
	var_27_0.movieName = arg_27_1.effect
	var_27_0.isLoop = true
	var_27_0.moduleName = "biography"

	if self._intervalTime > 0 then
		var_27_0.listener = handler(self, self._onCriSpriteEvent)
	end

	self._tmpMovieParams = var_27_0

	self:newScheduleOnce(handler(self, self._delayCreateMovie), self._intervalTime)
end

function ThemeBioVoteGameStage:_delayCreateMovie()
	if self._tmpMovieParams then
		self.m_criComp:addCriSprite(self._tmpMovieParams)

		self._tmpMovieParams = nil
	end
end

function ThemeBioVoteGameStage:_onCriSpriteEvent()
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

function ThemeBioVoteGameStage:_initMapWorld()
	self._mapWorld = ThemeBioGameWorld.new(self, self._worldId, self._activeThemeValue)

	self.m_worldHold:addNode(self._mapWorld)
end

function ThemeBioVoteGameStage:_initStageData()
	self:_deserializeBio()
end

function ThemeBioVoteGameStage:_initStageUI()
	local var_34_0 = SpineBase.new({
		resId = 400140,
		isLoop = true,
		path = g.core.common.Path:getMapKnightPath() .. "400140/400140",
		anim = BattleConst.SPINE_ACTION_TYPE.RUN
	})

	var_34_0:setScale(0.5)
	var_34_0:setPosition(50, 10)
	var_34_0:mulColor(true, cc.vec3(0, 0, 0))
	self.m_autoComp:addNode(var_34_0)
	self.m_headBtn:addClickListener(handler(self, self._onJumpMainRoleClick))
	self.m_exitBtn:addClickListener(handler(self, self._onClickExitBtn))
	self:setHeadArrow(false)
	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
	self.m_reviewBtn:addClickListener(handler(self, self._onBioReviewClick))
	self.m_bagBtn:addClickListener(handler(self, self._onBioBagClick))
	self.m_voteBtn:addClickListener(handler(self, self._onBioVoteClick))
	self.m_voteBtn:setVisible(self._showVoteBtn)
	self:_refreshVoteBtn()
end

function ThemeBioVoteGameStage:_initRegister()
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSION, self._onNetExecuteMission, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_BIO_SEARCH_PATH_TARGET, self._onSearchPathTarget, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_BIO_SET_HUDUI_SHOW, self._onSetHudUIShow, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOFRAOHY_COMPLETE_TASK, self._onCompletedTask, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOTRIGGER_POPTASK_FINISH, self._onPopTaskFinish, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOTRIGGER_PUBLISHPOP_LAST_FINISH, self._onPublishLastTaskFinish, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_NET_S2C_THEME_PV_GETINFO, handler(self, self._onThemePVGetInfo), self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
end

function ThemeBioVoteGameStage:_setHudUIShow(arg_36_1)
	if arg_36_1 then
		self.m_topBar:playShowAction()
	elseif var_0_15 then
		self.m_hideTransition:play()
		self.m_topBar:playHideAction()
	end
end

function ThemeBioVoteGameStage:_refreshVoteBtn()
	local var_37_0 = self._themeBioData and self._themeBioData:showVoteBtn(self._chapterId) or false

	if self._showVoteBtn ~= var_37_0 then
		self._needShowTargetPop = true
	end

	self._showVoteBtn = var_37_0

	self.m_voteBtn:setVisible(var_37_0)
	self.m_raceTxtComp:setVisible(var_37_0)

	local var_37_1

	if not var_37_0 then
		do return end

		var_37_1 = {}
	end

	var_37_1.txt = self._themeBioData:getVoteGroupInfo(self._chapterId).goal

	self.m_raceTxtComp:updateRaceTextComp(var_37_1)

	local var_37_2 = self._themeBioData:hasFinishChapter(self._chapterId)

	if self._unlockVoteBtn ~= var_37_2 then
		self._needJump2VoteLayer = true
	end

	self._unlockVoteBtn = var_37_2

	self.m_voteBtn:setCtrlState("state", {
		index = var_37_2 and 1 or 0
	})
end

function ThemeBioVoteGameStage:_pickupStart(arg_38_1, arg_38_2, arg_38_3)
	self.m_pickupComp:stopAllFGActions()
	self.m_pickupComp:getChild("descTxt"):setText(arg_38_2)
	self.m_pickupComp:getChild("descTxt2"):setText(arg_38_2)

	if arg_38_3 and arg_38_3 ~= "" then
		self.m_pickupComp:getChild("iconImg"):setURL("icon/bio/" .. arg_38_3)
	end

	self.m_pickupComp:setVisible(true)
	self.m_pickupComp:getController("show"):setSelectedIndex(0)
	self.m_pickupComp:setValue(0)
	self.m_pickupComp:tweenValue(1, 1)
	self.m_pickupComp:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(function()
			self.m_pickupComp:getController("show"):setSelectedIndex(1)
			self.m_pickupComp:getTransition("out"):play()
			var_0_11:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_38_1
			})
		end),
		fgui.FDelayTime:create(0.5),
		fgui.FHide:create()
	})))
end

function ThemeBioVoteGameStage:_serializeBio()
	g.core.common.Storage:save("theme_biography.json", self._themeBioStorage)
end

function ThemeBioVoteGameStage:_deserializeBio()
	local var_41_0 = g.core.common.Storage:load("theme_biography.json") or {}

	if var_41_0.storys == nil then
		var_41_0.storys = {}
	end

	self._themeBioStorage = var_41_0
end

function ThemeBioVoteGameStage:_showBubbleOrStory(arg_42_1)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		local var_42_1 = self._themeBioData:getMission(iter_42_1)
		local var_42_2 = tostring(var_42_1.chain)

		var_42_2 = var_42_1.finish and var_42_2 .. "_2" or var_42_2 .. "_1"

		if var_42_0[var_42_2] then
			if var_42_1.finish and var_42_1.index > var_42_0[var_42_2].index then
				var_42_0[var_42_2] = var_42_1
			elseif not var_42_1.finish and var_42_1.index < var_42_0[var_42_2].index then
				var_42_0[var_42_2] = var_42_1
			end
		else
			var_42_0[var_42_2] = var_42_1
		end
	end

	local var_42_3 = {}
	local var_42_4 = {}

	for iter_42_2, iter_42_3 in pairs(var_42_0) do
		if iter_42_3.finish then
			if iter_42_3.finish_talk ~= "0" then
				table.insert(var_42_4, iter_42_3.finish_talk)
			end
		elseif iter_42_3.canShow and iter_42_3.not_triggerable_talk ~= "0" then
			table.insert(var_42_4, iter_42_3.not_triggerable_talk)
		end
	end

	if #var_42_3 > 0 then
		self:_executeStory({
			excuted = true,
			id = var_42_3[math.random(#var_42_3)]
		})

		return
	end

	if #var_42_4 == 0 then
		return
	end

	self._refTalkEntity:showBubbleTalk(var_42_4[math.random(#var_42_4)], 2)
end

function ThemeBioVoteGameStage:_executeMission(arg_43_1)
	if arg_43_1.type == 2 and arg_43_1.sub_id ~= 0 then
		local var_43_0 = var_0_0.get(arg_43_1.sub_id)

		if var_43_0.event_type == 1 and not g.core.model.bag:isOwnItem(var_0_12.TYPE_BIO, var_43_0.event_value_1) then
			return false
		end
	end

	self._refCurMission = arg_43_1
	self._lastTaskFinish = arg_43_1.finish

	if arg_43_1.type == 3 then
		self:_onMissionStoryEnd()

		return true
	end

	if arg_43_1.trigger_story > 0 and not arg_43_1.finish and self:_isNeedStory(arg_43_1.trigger_story) then
		if self._themeBioData:getChain(arg_43_1.chain).type == 4 and arg_43_1.isLast and arg_43_1.fighting then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerPublishPop").new(3, arg_43_1.id, arg_43_1.trigger_story, self._refTalkEntity, self._activeThemeValue), {
				withoutAni = true
			})
		else
			self:_executeStory({
				id = arg_43_1.trigger_story
			})
		end

		var_0_11:send_C2S_ThemeBiography_WatchStory({
			is_finish_story = false,
			act_id = self._activeThemeValue,
			id = arg_43_1.id
		})
	else
		self:_onMissionStoryEnd()
	end

	return true
end

function ThemeBioVoteGameStage:_onMissionStoryEnd(arg_44_1)
	local var_44_0 = self._refTalkEntity

	if not self._refCurMission or not var_44_0 then
		self._refCurMission = nil
		self._refTalkEntity = nil

		return
	end

	local var_44_1 = self._themeBioData:getChain(self._refCurMission.chain)

	if var_44_1.type == 3 then
		return
	end

	if var_44_1.type == 4 and self._refCurMission.isFirst and self._refCurMission.sub_id ~= 0 then
		self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerPublishPop").new(1, self._refCurMission.id, arg_44_1, var_44_0, self._activeThemeValue), {
			withoutAni = true
		})

		return
	end

	if self._refCurMission.type == 1 then
		if arg_44_1 then
			if self._refCurMission.if_converstion_panel ~= 0 then
				self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_44_1, var_44_0, self._activeThemeValue), {
					withoutAni = true
				})

				return
			end
		elseif self._refCurMission.if_converstion_panel == 1 and not self._refCurMission.finish then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_44_1, var_44_0, self._activeThemeValue), {
				withoutAni = true
			})

			return
		end
	elseif self._refCurMission.type == 2 and self._refCurMission.sub_id ~= 0 then
		local var_44_2 = var_0_0.get(self._refCurMission.sub_id)

		if (var_44_2.event_type == 3 or var_44_2.event_type == 4 or var_44_2.event_type == 5) and self._refCurMission.if_converstion_panel ~= 0 then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_44_1, var_44_0, self._activeThemeValue), {
				withoutAni = true
			})

			return
		end
	end

	self:_onTriggerMission(self._refCurMission, 1, arg_44_1, var_44_0)
end

function ThemeBioVoteGameStage:_onTriggerMission(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_1.type == 1 then
		self:_processMissionBattle(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	elseif arg_45_1.type == 2 then
		self:_processMissionEvent(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	elseif arg_45_1.type == 3 then
		self:_processMissionOther(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	end
end

function ThemeBioVoteGameStage:_processMissionBattle(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if arg_46_2 ~= 1 then
		var_0_11:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_46_1.id
		})

		return
	end

	if arg_46_3 then
		if arg_46_1.if_converstion_panel == 0 and ThemeBioUtils.checkMission(arg_46_1, nil, self._activeThemeValue) then
			var_0_11:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_46_1.id
			})
		end
	else
		self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(arg_46_1.id, false, arg_46_4, self._activeThemeValue), {
			withoutAni = true
		})
	end
end

function ThemeBioVoteGameStage:_processMissionEvent(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	self._refCurMission = nil

	if arg_47_1.sub_id == 0 then
		var_0_11:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_47_1.id
		})

		return
	end

	local var_47_0 = var_0_0.get(arg_47_1.sub_id)

	if var_47_0.event_type == 3 or var_47_0.event_type == 4 or var_47_0.event_type == 5 then
		if arg_47_1.if_converstion_panel == 0 then
			if var_47_0.event_type == 3 then
				self:_pickupStart(arg_47_1.id, var_47_0.des, "icon_lz_shiquzhong.png")
			elseif var_47_0.event_type == 4 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameClickLayer").new(arg_47_1.id, self._activeThemeValue), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			elseif var_47_0.event_type == 5 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameQTELayer").new(arg_47_1.id, self._activeThemeValue), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			end
		end
	elseif var_47_0.event_type == 1 then
		if g.core.model.bag:isOwnItem(var_0_12.TYPE_BIO, var_47_0.event_value_1) then
			var_0_11:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_47_1.id
			})
		end
	elseif var_47_0.event_type == 2 then
		var_0_11:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_47_1.id
		})
	elseif var_47_0.event_type == 6 then
		var_0_11:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_47_1.id
		})
	elseif var_47_0.event_type == 7 then
		self:_pickupStart(arg_47_1.id, var_47_0.des, var_47_0.pic)
	elseif var_47_0.event_type == 10 then
		-- block empty
	elseif var_47_0.event_type == 9 then
		-- block empty
	elseif var_47_0.event_type == 8 then
		-- block empty
	elseif var_47_0.event_type == 11 then
		var_0_11:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_47_1.id
		})
	elseif var_47_0.event_type == 15 then
		-- block empty
	elseif var_47_0.event_type == 16 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.touchGame.view.TouchGameLayer").new({
			missionId = arg_47_1.id,
			gameId = var_47_0.event_value_1,
			themeValue = self._activeThemeValue
		})))
	end
end

function ThemeBioVoteGameStage:_processMissionOther(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	var_0_11:send_C2S_ThemeBiography_ExecuteMission({
		act_id = self._activeThemeValue,
		id = arg_48_1.id
	})
end

function ThemeBioVoteGameStage:_beginBattleJump(arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = self._themeBioData:getMission(arg_49_3.id)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		canSkip = var_49_0.finish,
		drop = var_49_0.reward_tael,
		type = BattleConst.TYPE_THEME_BIO,
		battle_id = arg_49_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.theme_biography_battle_info.get(var_49_0.sub_id).battle_stage,
		prefixScene = {
			entranceModule = g.view.entrance.THEME_BIO_STAGE,
			entranceData = {
				chapterId = self._chapterId,
				themeValue = self._activeThemeValue,
				showVoteBtn = self._showVoteBtn,
				unlockVoteBtn = self._unlockVoteBtn
			}
		}
	})
end

function ThemeBioVoteGameStage:_showAwardAction(arg_50_1)
	self:getMapWorld():refreshEntityState(self._refChapterInfo)

	local var_50_0 = self._themeBioData:getMission(arg_50_1.id)

	if var_50_0.finish then
		if var_50_0.finish_story > 0 and self:_isNeedStory(var_50_0.finish_story) then
			self._hasShowStoryEndAward = false

			local var_50_1 = self

			self:_executeStory({
				id = var_50_0.finish_story,
				callback = function()
					if var_50_1 and not var_50_1._hasShowStoryEndAward then
						var_50_1._hasShowStoryEndAward = true

						var_50_1:_onShowAwardCall(arg_50_1)
					end
				end
			})
		else
			self:_onShowAwardCall(arg_50_1)
		end
	elseif var_50_0.type == 3 and var_50_0.not_trigger_story > 0 and self:_isNeedStory(var_50_0.not_trigger_story) then
		self:_executeStory({
			excuted = true,
			id = var_50_0.not_trigger_story
		})
	end
end

function ThemeBioVoteGameStage:_onShowAwardCall(arg_52_1)
	if arg_52_1.award == nil then
		return
	end

	local var_52_0 = {}

	for iter_52_0 = 1, #arg_52_1.award do
		table.insert(var_52_0, arg_52_1.award[iter_52_0])
	end

	local var_52_1 = self._themeBioData:getMission(arg_52_1.id)

	if var_52_1.type == 2 and var_52_1.sub_id > 0 and var_0_0.get(var_52_1.sub_id).event_type == 3 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameTreeLayer"):new(var_52_0, self._activeThemeValue), {
			withoutAni = true,
			ignoreTouch = true
		})

		return
	end

	self:_afterCompletedTask(arg_52_1.id, var_52_0)
end

function ThemeBioVoteGameStage:_afterCompletedTask(arg_53_1, arg_53_2)
	local var_53_0 = self._themeBioData:getMission(arg_53_1)
	local var_53_1 = self._themeBioData:getChain(var_53_0.chain)

	self:_showMissionCostTip(var_53_0)

	if not self._lastTaskFinish and var_53_0.finish and (var_53_0.mission_finish_tip == 1 or var_53_0.mission_finish_tip == 2) then
		if var_53_0.type == 2 and var_53_0.sub_id > 0 and var_0_0.get(var_53_0.sub_id).event_type == 2 then
			self:_showCompletedAward(arg_53_2, var_53_0, var_53_1.type)
			self.m_taskPart:refreshTask()
			self:_checkChapterFinish(var_53_0)

			return
		end

		self:_playTaskCompleteAni(arg_53_2, var_53_0)
	else
		self:_showCompletedAward(arg_53_2, var_53_0, var_53_1.type)
		self.m_taskPart:refreshTask()
	end

	self:_checkChapterFinish(var_53_0)
end

function ThemeBioVoteGameStage:_showMissionCostTip(arg_54_1)
	local var_54_0 = {}

	if arg_54_1.type == 2 and arg_54_1.sub_id > 0 then
		local var_54_2 = var_0_0.get(arg_54_1.sub_id)

		if var_54_2.event_type == 1 then
			table.insert(var_54_0, var_54_2.event_value_1)
		end
	end

	local var_54_4 = 1

	while arg_54_1["item_cost_" .. var_54_4] and arg_54_1["item_cost_" .. var_54_4] > 0 do
		table.insert(var_54_0, arg_54_1["item_cost_" .. var_54_4])

		var_54_4 = var_54_4 + 1
	end

	if #var_54_0 > 0 then
		local var_54_5 = ""

		for iter_54_0 = 1, #var_54_0 do
			var_54_5 = var_54_5 .. var_0_12:convert({
				type = var_0_12.TYPE_BIO,
				value = var_54_0[iter_54_0]
			}).name

			if iter_54_0 < #var_54_0 then
				var_54_5 = var_54_5 .. "、"
			end
		end

		g.core.module.ModuleManager:tip(g.core.lang:get(409107, {
			name = var_54_5
		}))
	end
end

function ThemeBioVoteGameStage:_playTaskCompleteAni(arg_55_1, arg_55_2)
	self._themeBioData:setFinishNewMission()

	if not self.m_taskPart then
		return
	end

	self._isShowMissionFinish = false

	self.m_taskPart:refreshTask()

	self._curMission = arg_55_2

	if arg_55_1 and #arg_55_1 > 0 then
		self._isShowMissionFinish = true

		g.core.module.ModuleManager:awardSummary(arg_55_1, true, nil, nil, handler(self, self._scheduleOnceCall))
	else
		self:_taskFinishAwardSummary(arg_55_2)
	end
end

function ThemeBioVoteGameStage:_taskFinishAwardSummary(arg_56_1)
	arg_56_1 = arg_56_1 or self._curMission
	self._isShowMissionFinish = false

	if self:_checkChainState() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
			delay = 1,
			englishTitle = g.core.lang:get(409108),
			title = g.core.lang:get(409109),
			callBack = handler(self, self._playMainInfoEnd)
		}), {
			blackOpacity = 0,
			tag = "BaseLineTipsPop"
		})
		self:checkExitBtnShow(true)
	elseif self._isShowChapterFinish then
		self._isShowChapterFinish = false

		g.core.module.ModuleManager:tip(g.core.lang:get(409158))
		self:_checkJump2VoteLayer()
	else
		self:_showMissionFinishTips(arg_56_1)
		self:checkExitBtnShow(false)
		self:_checkVotePop()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self._bagRedPointComp,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
end

function ThemeBioVoteGameStage:checkExitBtnShow(arg_57_1)
	self.m_exitBtn:setVisible(arg_57_1)

	if arg_57_1 and not self._exitSpine then
		self._exitSpine = self.m_exitBtn:addEffectSpine({
			y = 33,
			name = "eff_ui_common_sixlight",
			isLoop = true,
			anim = "play",
			x = 33
		})
	end
end

function ThemeBioVoteGameStage:_showCompletedAward(arg_58_1, arg_58_2, arg_58_3)
	g.core.module.ModuleManager:awardSummary(arg_58_1, true, nil, nil, handler(self, self._checkVotePop))
end

function ThemeBioVoteGameStage:_isNeedStory(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(self._themeBioStorage.storys) do
		if iter_59_1 == arg_59_1 then
			return false
		end
	end

	return true
end

function ThemeBioVoteGameStage:_executeStory(arg_60_1, arg_60_2)
	var_0_2.EventManager:dispatchEvent(var_0_2.enum.EVENT_STORY_FORCE_START, arg_60_2 or false, arg_60_1)
	self:_setHudUIShow(false)

	if self:_isNeedStory(arg_60_1.id) then
		table.insert(self._themeBioStorage.storys, arg_60_1.id)
		self:_serializeBio()
	end
end

function ThemeBioVoteGameStage:_onEventStoryEnd(arg_61_1)
	if arg_61_1.trigger_data.isInteractTrigger then
		return
	end

	if arg_61_1.trigger_data.id == self._refChapterInfo.story then
		return
	end

	self:_setHudUIShow(true)

	if arg_61_1.trigger_data.excuted then
		return
	end

	if arg_61_1.trigger_data.callback then
		arg_61_1.trigger_data.callback()

		return
	end

	if arg_61_1.triggerTaskId then
		if arg_61_1.triggerTaskId > 0 then
			self:_onMissionStoryEnd(true)
		end
	elseif arg_61_1.chooseIndex == nil then
		self:_onMissionStoryEnd(true)
	elseif arg_61_1.chooseIndex == 1 then
		self:newScheduleOnce(function()
			if self._onMissionStoryEnd then
				self:_onMissionStoryEnd(true)
			end
		end, 0)
	end
end

function ThemeBioVoteGameStage:_getMissionTarget(arg_63_1, arg_63_2)
	local var_63_0

	if arg_63_1 == 2 and arg_63_2 and arg_63_2.finish then
		arg_63_1 = 1
	end

	if arg_63_1 == 1 then
		local var_63_1 = self._themeBioData:getChain(self._refChapterInfo.chains[1])

		if var_63_1.finish then
			return nil
		end

		var_63_0 = self._themeBioData:getMission(var_63_1.missions[var_63_1.current])
	else
		var_63_0 = arg_63_2
	end

	if not var_63_0 then
		return nil
	end

	if self:getMapWorld() then
		return (self:getMapWorld():getBindEntity(var_63_0.mission_resource))
	else
		return nil
	end
end

function ThemeBioVoteGameStage:_onSearchPathTarget(arg_64_1, arg_64_2)
	local var_64_0 = self:_getMissionTarget(arg_64_2.type, arg_64_2.mission)

	if var_64_0 then
		self:setAutoSearchPath(true)
		self:getMapWorld():autoRouteTalk(var_64_0, true)
	end
end

function ThemeBioVoteGameStage:_onCompletedTask(arg_65_1, arg_65_2)
	self:_afterCompletedTask(arg_65_2.id, arg_65_2.awards)
end

function ThemeBioVoteGameStage:_onSetHudUIShow(arg_66_1, arg_66_2)
	self:_setHudUIShow(arg_66_2)
end

function ThemeBioVoteGameStage:_onJumpMainRoleClick()
	self._mapWorld:jump2MainRole()
	self:setHeadArrow(false)
end

function ThemeBioVoteGameStage:_onClickExitBtn()
	g.core.module.ModuleManager:popModule()
end

function ThemeBioVoteGameStage:_onThemePVGetInfo(arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_0 = g.core.model.User.plotReplayReviewData:getPlotReplayDataIndex(4, self._chapterId)
	local var_69_1 = g.core.model.User.plotReplayReviewData:getReplayCellInfo(3, var_69_0)

	if var_69_1.openStageNum > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLOT_REPLAY_REPLAY, {
			type = var_0_3.PlotReplayConst.THEME_BIO,
			scrollId = var_69_0,
			info = var_69_1
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409141))
	end
end

function ThemeBioVoteGameStage:_onModuleExit(arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = arg_70_3 and arg_70_3.params

	if not (arg_70_3 and arg_70_3.params) then
		return
	end

	if var_70_0 and var_70_0.tag and (var_70_0 and var_70_0.tag) == "ClueLayer" then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._bagRedPointComp,
			customData = {
				themeValue = self._activeThemeValue
			}
		})
	end
end

function ThemeBioVoteGameStage:_onBioReviewClick()
	g.core.network.GameNetProxy:send_C2S_ThemePV_GetInfo({})
end

function ThemeBioVoteGameStage:_onBioBagClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.vote.ThemeBioVoteClueLayer").new({
		themeValue = self._activeThemeValue,
		chapterId = self._chapterId
	}), {
		tag = "ClueLayer",
		ignoreTouch = false,
		touchDisappear = false
	})
end

function ThemeBioVoteGameStage:_onBioVoteClick()
	local var_73_0 = self._themeBioData:getChapter(self._chapterId)

	if var_73_0 and var_73_0.finish then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_VOTE, {
			themeValue = self._activeThemeValue,
			chapterId = self._chapterId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409140))
	end
end

function ThemeBioVoteGameStage:_onNetExecuteMission(arg_74_1, arg_74_2, arg_74_3)
	if self._themeBioData:getMission(arg_74_3.id).type == 1 then
		self:_beginBattleJump(arg_74_1, arg_74_2, arg_74_3)
	else
		self:_showAwardAction(arg_74_3)

		if self._bgMusic then
			g.core.sound.SoundManager:resumeMusic()
		end
	end
end

function ThemeBioVoteGameStage:_onPopTaskFinish(arg_75_1, arg_75_2)
	self:_onTriggerMission(arg_75_2.mission, 0, false, arg_75_2.touchItem)
end

function ThemeBioVoteGameStage:_onPublishLastTaskFinish(arg_76_1, arg_76_2)
	self:_executeStory({
		id = arg_76_2.storyId
	})
end

function ThemeBioVoteGameStage:refreshTargetVector()
	local var_77_9000
	local var_77_0 = self._themeBioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)

	if not var_77_0 or var_77_0 == var_0_6.BIO_TASK_STATE.ALL_FINISH then
		self.m_directionComp:setVisible(false)

		return
	end

	local var_77_1

	if var_77_0 == var_0_6.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_77_1 = self:_getMissionTarget(1)
	elseif var_77_0 == var_0_6.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_77_3 = self.m_taskPart:getSubTaskMissionInfo()

		if var_77_3 then
			var_77_1 = self:_getMissionTarget(2, var_77_3)
		end
	end

	if var_77_1 then
		if self:getMapWorld():checkSingleEntityInView(var_77_1) then
			self.m_directionComp:setVisible(false)

			return
		end

		self.m_directionComp:setVisible(true)

		local var_77_4 = var_77_1:getCoord()
		local var_77_5, var_77_6 = self:getMapGround():coordToPixel(var_77_4.x, var_77_4.y)
		local var_77_7, var_77_8 = self:getMapWorld().getTargetAngelFromScreenCenter(self:getMapGround():convertToNodeSpace(display.center), (cc.pNormalize((cc.pSub(cc.p(var_77_5 - 100, var_77_6 + 100), var_77_9000)))))

		self.m_directionComp:updateDirectionByAngle(var_77_7, var_77_8, var_77_0)
	end
end

function ThemeBioVoteGameStage:_checkChainState()
	if not self._themeBioData:getChain(self._refChapterInfo.chains[1]).finish then
		return false
	end

	for iter_78_0 = 2, #self._refChapterInfo.chains do
		for iter_78_1, iter_78_2 in ipairs(self._themeBioData:getChain(self._refChapterInfo.chains[iter_78_0]).missions) do
			if not self._themeBioData:getMission(iter_78_2).finish then
				return false
			end
		end
	end

	return true
end

function ThemeBioVoteGameStage:isNextMissionTarget(arg_79_1)
	if not arg_79_1 then
		return
	end

	local var_79_0 = self._themeBioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)
	local var_79_1

	if var_79_0 == var_0_6.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_79_1 = self:_getMissionTarget(1)
	elseif var_79_0 == var_0_6.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_79_2 = self.m_taskPart:getSubTaskMissionInfo()

		if var_79_2 then
			var_79_1 = self:_getMissionTarget(2, var_79_2)
		end
	end

	if var_79_1 and var_79_1:getBindID() == arg_79_1 then
		return true
	end

	return false
end

function ThemeBioVoteGameStage:_executeInteractOperation(arg_80_1, arg_80_2)
	if arg_80_1.type == var_0_6.BIO_INTERACT_TYPE.INTERACT_INFO_REMIND then
		local var_80_1 = {
			title = "",
			typeValue = arg_80_1.pop_type,
			desc = arg_80_1.des
		}

		if arg_80_1.pop_type == var_0_4.InfoTipPopType.BASE_TIP then
			var_80_1.title = arg_80_1.titel
		elseif arg_80_1.pop_type == var_0_4.InfoTipPopType.PAPER_TIP then
			var_80_1.title = ""
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoFullTipPop").new(var_80_1), {
			touchDisappear = true,
			hideContinue = false
		})
	elseif arg_80_1.type == var_0_6.BIO_INTERACT_TYPE.INTERACT_BOX then
		if arg_80_2 and arg_80_2:getResType() == MapConst.RESTYPE.SPINE then
			local var_80_2 = not arg_80_2:getIsOpen()

			arg_80_2:setOpenState(var_80_2)
			arg_80_2:playAnim(var_80_2 and "play" or "play2", true)
		end
	elseif arg_80_1.type == var_0_6.BIO_INTERACT_TYPE.INTERACT_NPC_DIALOG then
		if arg_80_1.plot_id ~= 0 then
			var_0_2.EventManager:dispatchEvent(var_0_2.enum.EVENT_STORY_FORCE_START, false, {
				isInteractTrigger = true,
				id = arg_80_1.plot_id
			})
		end
	end
end

function ThemeBioVoteGameStage:_showMissionFinishTips(arg_81_1)
	if arg_81_1 then
		if arg_81_1.mission_finish_tip == 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(409110))
		elseif arg_81_1.mission_finish_tip == 2 then
			local var_81_0 = var_0_0.get(arg_81_1.sub_id)

			if var_81_0.event_type == 15 or var_81_0.event_type == 16 then
				g.core.module.ModuleManager:tip(g.core.lang:get(409111))
			end
		end

		if arg_81_1.finish_story > 0 then
			if arg_81_1.type == 1 then
				self:_executeStory({
					excuted = true,
					id = arg_81_1.finish_story
				})
			end

			var_0_11:send_C2S_ThemeBiography_WatchStory({
				is_finish_story = true,
				act_id = self._activeThemeValue,
				id = arg_81_1.id
			})
		end
	end

	self._isShowMissionFinish = false
end

function ThemeBioVoteGameStage:_onCrossDayUpdate()
	local var_82_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_14.THEME_TYPE, self._activeThemeValue)

	if not ((var_82_1 and var_82_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popToRoot()

		return
	end
end

function ThemeBioVoteGameStage:_checkVoteTargetPop()
	if self._needShowTargetPop then
		self._needShowTargetPop = false

		self:getMapWorld():stopWalkRole()

		return g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.vote.pop.ThemeBioVoteTargetPop").new({
			descTxt = self._themeBioData:getVoteGroupInfo(self._chapterId).goal
		}), {
			withoutAni = false,
			hideContinue = false,
			touchDisappear = true
		})
	end
end

function ThemeBioVoteGameStage:_checkJump2VoteLayer()
	if self._needJump2VoteLayer then
		self._needJump2VoteLayer = false

		self:getMapWorld():stopWalkRole()

		return g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_VOTE, {
			themeValue = self._activeThemeValue,
			chapterId = self._chapterId
		})
	end
end

function ThemeBioVoteGameStage:_checkVotePop()
	if self._needShowTargetPop then
		self:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create(1),
			fgui.FCallFunc:create(function()
				if self._checkVoteTargetPop then
					self:_checkVoteTargetPop()
				end
			end)
		})))
	end

	if self._needJump2VoteLayer then
		self:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create(1),
			fgui.FCallFunc:create(function()
				if self._checkJump2VoteLayer then
					self:_checkJump2VoteLayer()
				end
			end)
		})))
	end
end

return ThemeBioVoteGameStage
