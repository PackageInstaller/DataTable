local var_0_0 = g.core.config.theme_biography_event_info
local var_0_1 = g.core.config.activity_theme_display_info
local var_0_2 = g.core.event
local var_0_3 = g.core.const.ConstMgr.InfoConst
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_5 = g.core.const.ConstMgr.ThemeBioConst
local MapConst = require("app.core.ksmap.MapConst")
local SpineBase = require("app.view.common.SpineBase")
local ThemeBioGameWorld = import(".ThemeBioGameWorld")
local ThemeBioUtils = import("..model.ThemeBioUtils")
local var_0_10 = g.core.network.GameNetProxy
local var_0_11 = g.core.common.Goods
local var_0_12 = g.core.model.User.themeData
local var_0_13 = g.core.const.ConstMgr.ThemeConst
local var_0_14 = false
local ThemeBioGameCommonStage = class("ThemeBioGameCommonStage", require("app.fairyGUI.themeBio.UI_ThemeBioGameStage"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioGameStage",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	})
end)

function ThemeBioGameCommonStage:ctor(arg_2_1)
	self._activeThemeValue = arg_2_1.themeValue or 1
	self._themeBioData = var_0_12:getThemeData(self._activeThemeValue):getThemeBioData()
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
	self._tmpMovieParams = nil
	self._intervalTime = 0
	self._missionForAward = nil

	self:initStage()
end

function ThemeBioGameCommonStage:onLoad()
	self:_initRegister()
	self:getMapWorld():startObserver(self.m_touchMap)
	self.m_autoComp:setVisible(false)
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:setMax(1)
	self.m_taskPart:startUp(self)
	self.m_taskPart:initChapterData(self._refChapterInfo, self._activeThemeValue)

	local var_3_0, var_3_1 = self._themeBioData:getFinishNewMission()

	if var_3_0 then
		self:_showMissionFinishTips(var_3_1)
		self:_playTaskCompleteAni()
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
end

function ThemeBioGameCommonStage:_addBgMusic()
	self._bgMusic = nil

	if self._refChapterInfo then
		if self._refChapterInfo.music and self._refChapterInfo.music ~= "" then
			self._bgMusic = self._refChapterInfo.music

			g.core.sound.SoundManager:playMusic(self._refChapterInfo.music)
		end
	end
end

function ThemeBioGameCommonStage:_stopBgMusic()
	if self._bgMusic then
		g.core.sound.SoundManager:stopMusic(self._bgMusic)

		self._bgMusic = nil
	end
end

function ThemeBioGameCommonStage:onUnload()
	self.m_criComp:removeAllCriSprite()
	self.m_taskPart:startUp(nil)
	self:getMapWorld():stopObserver(self.m_touchMap)

	if self.m_pickupComp then
		self.m_pickupComp:stopAllFGActions()
	end
end

function ThemeBioGameCommonStage:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_STORY_END" then
		self:_onEventStoryEnd(arg_7_2)
	end
end

function ThemeBioGameCommonStage:initStage()
	self:_initMapWorld()
	self:_initStageData()
	self:_initStageUI()
	self.m_enterTransition:play(handler(self, self._setMapCanTouchable))
end

function ThemeBioGameCommonStage:_setMapCanTouchable()
	self.m_touchMap:setTouchable(true)
end

function ThemeBioGameCommonStage:_playMainActionStart()
	self:_checkFirstChapter()
	self:_playMainFlowStart()
end

function ThemeBioGameCommonStage:_playMainFlowStart()
	self:_setHudUIShow(true)
end

function ThemeBioGameCommonStage:_playMainFlowEnd()
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
end

function ThemeBioGameCommonStage:_checkChapterFinish(arg_14_1)
	if not self._lastTaskFinish and arg_14_1.finish and self._themeBioData:getChain(arg_14_1.chain).type == 1 and self._themeBioData:getChain(self._refChapterInfo.chains[1]).finish and self._isShowMissionFinish then
		self._isShowChapterFinish = true
	end
end

function ThemeBioGameCommonStage:_playScrollAwardShow()
	self:_playMainInfoEnd()
end

function ThemeBioGameCommonStage:_playMainInfoEnd()
	self:_playMainFlowEnd()
end

function ThemeBioGameCommonStage:_checkFirstChapter()
	if self._themeBioStorage.chapterId == nil or self._themeBioStorage.chapterId < self._chapterId then
		self._themeBioStorage.chapterId = self._chapterId

		self:_serializeBio()

		return true
	end

	return false
end

function ThemeBioGameCommonStage:getMapWorld()
	return self._mapWorld
end

function ThemeBioGameCommonStage:getMapGround()
	return self._mapWorld:getMapGround()
end

function ThemeBioGameCommonStage:talkTrigger(arg_20_1)
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

function ThemeBioGameCommonStage:setAutoSearchPath(arg_22_1)
	self.m_autoComp:setVisible(arg_22_1)
end

function ThemeBioGameCommonStage:pickupStop()
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:stopAllFGActions()
end

function ThemeBioGameCommonStage:saveStayCoord(arg_24_1)
	self._themeBioStorage["stay_" .. self._chapterId] = {
		x = arg_24_1.x,
		y = arg_24_1.y
	}

	self:_serializeBio()
end

function ThemeBioGameCommonStage:getStayCoord()
	return self._themeBioStorage["stay_" .. self._chapterId]
end

function ThemeBioGameCommonStage:setHeadArrow(arg_26_1, arg_26_2, arg_26_3)
	self.m_headBtn:setVisible(arg_26_1)
end

function ThemeBioGameCommonStage:_loadSnowMovie(arg_27_1)
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

function ThemeBioGameCommonStage:_delayCreateMovie()
	if self._tmpMovieParams then
		self.m_criComp:addCriSprite(self._tmpMovieParams)

		self._tmpMovieParams = nil
	end
end

function ThemeBioGameCommonStage:_onCriSpriteEvent()
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

function ThemeBioGameCommonStage:_initMapWorld()
	self._mapWorld = ThemeBioGameWorld.new(self, self._worldId, self._activeThemeValue)

	self.m_worldHold:addNode(self._mapWorld)
end

function ThemeBioGameCommonStage:_initStageData()
	self:_deserializeBio()
end

function ThemeBioGameCommonStage:_initStageUI()
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
	self.m_bagBtn:addClickListener(handler(self, self._onBioBagClick))
	self.m_touchMap:setTouchable(false)
end

function ThemeBioGameCommonStage:_initRegister()
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_EXECUTEMISSION, self._onNetExecuteMission, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_BIO_SEARCH_PATH_TARGET, self._onSearchPathTarget, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_BIO_SET_HUDUI_SHOW, self._onSetHudUIShow, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOFRAOHY_COMPLETE_TASK, self._onCompletedTask, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOTRIGGER_POPTASK_FINISH, self._onPopTaskFinish, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_THEME_BIOTRIGGER_PUBLISHPOP_LAST_FINISH, self._onPublishLastTaskFinish, self)
	var_0_2.EventManager:addEventListener(var_0_2.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
end

function ThemeBioGameCommonStage:_setHudUIShow(arg_36_1)
	if arg_36_1 then
		self.m_topBar:playShowAction()
	elseif var_0_14 then
		self.m_hideTransition:play()
		self.m_topBar:playHideAction()
	end
end

function ThemeBioGameCommonStage:_pickupStart(arg_37_1, arg_37_2, arg_37_3)
	self.m_pickupComp:stopAllFGActions()
	self.m_pickupComp:getChild("descTxt"):setText(arg_37_2)
	self.m_pickupComp:getChild("descTxt2"):setText(arg_37_2)

	if arg_37_3 and arg_37_3 ~= "" then
		self.m_pickupComp:getChild("iconImg"):setURL("icon/bio/" .. arg_37_3)
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
			var_0_10:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_37_1
			})
		end),
		fgui.FDelayTime:create(0.5),
		fgui.FHide:create()
	})))
end

function ThemeBioGameCommonStage:_serializeBio()
	g.core.common.Storage:save("theme_biography.json", self._themeBioStorage)
end

function ThemeBioGameCommonStage:_deserializeBio()
	local var_40_0 = g.core.common.Storage:load("theme_biography.json") or {}

	if var_40_0.storys == nil then
		var_40_0.storys = {}
	end

	self._themeBioStorage = var_40_0
end

function ThemeBioGameCommonStage:_showBubbleOrStory(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		local var_41_1 = self._themeBioData:getMission(iter_41_1)
		local var_41_2 = tostring(var_41_1.chain)

		var_41_2 = var_41_1.finish and var_41_2 .. "_2" or var_41_2 .. "_1"

		if var_41_0[var_41_2] then
			if var_41_1.finish and var_41_1.index > var_41_0[var_41_2].index then
				var_41_0[var_41_2] = var_41_1
			elseif not var_41_1.finish and var_41_1.index < var_41_0[var_41_2].index then
				var_41_0[var_41_2] = var_41_1
			end
		else
			var_41_0[var_41_2] = var_41_1
		end
	end

	local var_41_3 = {}
	local var_41_4 = {}

	for iter_41_2, iter_41_3 in pairs(var_41_0) do
		if iter_41_3.finish then
			if iter_41_3.finish_talk ~= "0" then
				table.insert(var_41_4, iter_41_3.finish_talk)
			end
		elseif iter_41_3.canShow and iter_41_3.not_triggerable_talk ~= "0" then
			table.insert(var_41_4, iter_41_3.not_triggerable_talk)
		end
	end

	if #var_41_3 > 0 then
		self:_executeStory({
			excuted = true,
			id = var_41_3[math.random(#var_41_3)]
		})

		return
	end

	if #var_41_4 == 0 then
		return
	end

	self._refTalkEntity:showBubbleTalk(var_41_4[math.random(#var_41_4)], 2)
end

function ThemeBioGameCommonStage:_executeMission(arg_42_1)
	if arg_42_1.type == 2 and arg_42_1.sub_id ~= 0 then
		local var_42_0 = var_0_0.get(arg_42_1.sub_id)

		if var_42_0.event_type == 1 and not g.core.model.bag:isOwnItem(var_0_11.TYPE_BIO, var_42_0.event_value_1) then
			return false
		end
	end

	self._refCurMission = arg_42_1
	self._lastTaskFinish = arg_42_1.finish

	if arg_42_1.type == 3 then
		self:_onMissionStoryEnd()

		return true
	end

	if arg_42_1.trigger_story > 0 and not arg_42_1.finish and self:_isNeedStory(arg_42_1.trigger_story) then
		if self._themeBioData:getChain(arg_42_1.chain).type == 4 and arg_42_1.isLast and arg_42_1.fighting then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerPublishPop").new(3, arg_42_1.id, arg_42_1.trigger_story, self._refTalkEntity, self._activeThemeValue), {
				withoutAni = true
			})
		else
			self:_executeStory({
				id = arg_42_1.trigger_story
			})
		end

		var_0_10:send_C2S_ThemeBiography_WatchStory({
			is_finish_story = false,
			act_id = self._activeThemeValue,
			id = arg_42_1.id
		})
	else
		self:_onMissionStoryEnd()
	end

	return true
end

function ThemeBioGameCommonStage:_onMissionStoryEnd(arg_43_1)
	local var_43_0 = self._refTalkEntity

	if not self._refCurMission or not var_43_0 then
		self._refCurMission = nil
		self._refTalkEntity = nil

		return
	end

	local var_43_1 = self._themeBioData:getChain(self._refCurMission.chain)

	if var_43_1.type == 3 then
		return
	end

	if var_43_1.type == 4 and self._refCurMission.isFirst and self._refCurMission.sub_id ~= 0 then
		self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerPublishPop").new(1, self._refCurMission.id, arg_43_1, var_43_0, self._activeThemeValue), {
			withoutAni = true
		})

		return
	end

	if self._refCurMission.type == 1 then
		if arg_43_1 then
			if self._refCurMission.if_converstion_panel ~= 0 then
				self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0, self._activeThemeValue), {
					withoutAni = true
				})

				return
			end
		elseif self._refCurMission.if_converstion_panel == 1 and not self._refCurMission.finish then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0, self._activeThemeValue), {
				withoutAni = true
			})

			return
		end
	elseif self._refCurMission.type == 2 and self._refCurMission.sub_id ~= 0 then
		local var_43_2 = var_0_0.get(self._refCurMission.sub_id)

		if (var_43_2.event_type == 3 or var_43_2.event_type == 4 or var_43_2.event_type == 5) and self._refCurMission.if_converstion_panel ~= 0 then
			self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0, self._activeThemeValue), {
				withoutAni = true
			})

			return
		end
	end

	self:_onTriggerMission(self._refCurMission, 1, arg_43_1, var_43_0)
end

function ThemeBioGameCommonStage:_onTriggerMission(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if arg_44_1.type == 1 then
		self:_processMissionBattle(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	elseif arg_44_1.type == 2 then
		self:_processMissionEvent(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	elseif arg_44_1.type == 3 then
		self:_processMissionOther(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	end
end

function ThemeBioGameCommonStage:_processMissionBattle(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_2 ~= 1 then
		var_0_10:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_45_1.id
		})

		return
	end

	if arg_45_3 then
		if arg_45_1.if_converstion_panel == 0 and ThemeBioUtils.checkMission(arg_45_1, nil, self._activeThemeValue) then
			var_0_10:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_45_1.id
			})
		end
	else
		self:addPopup(require("app.view.module.themeBio.view.ThemeBioTriggerBattlePop").new(arg_45_1.id, false, arg_45_4, self._activeThemeValue), {
			withoutAni = true
		})
	end
end

function ThemeBioGameCommonStage:_processMissionEvent(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	self._refCurMission = nil

	if arg_46_1.sub_id == 0 then
		var_0_10:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_46_1.id
		})

		return
	end

	local var_46_0 = var_0_0.get(arg_46_1.sub_id)

	if var_46_0.event_type == 3 or var_46_0.event_type == 4 or var_46_0.event_type == 5 then
		if arg_46_1.if_converstion_panel == 0 then
			if var_46_0.event_type == 3 then
				self:_pickupStart(arg_46_1.id, var_46_0.des, "icon_lz_shiquzhong.png")
			elseif var_46_0.event_type == 4 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameClickLayer").new(arg_46_1.id, self._activeThemeValue), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			elseif var_46_0.event_type == 5 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameQTELayer").new(arg_46_1.id, self._activeThemeValue), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			end
		end
	elseif var_46_0.event_type == 1 then
		if g.core.model.bag:isOwnItem(var_0_11.TYPE_BIO, var_46_0.event_value_1) then
			var_0_10:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = arg_46_1.id
			})
		end
	elseif var_46_0.event_type == 2 then
		var_0_10:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_46_1.id
		})
	elseif var_46_0.event_type == 6 then
		var_0_10:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_46_1.id
		})
	elseif var_46_0.event_type == 7 then
		self:_pickupStart(arg_46_1.id, var_46_0.des, var_46_0.pic)
	elseif var_46_0.event_type == 10 then
		-- block empty
	elseif var_46_0.event_type == 9 then
		-- block empty
	elseif var_46_0.event_type == 8 then
		-- block empty
	elseif var_46_0.event_type == 11 then
		var_0_10:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = arg_46_1.id
		})
	elseif var_46_0.event_type == 15 then
		-- block empty
	elseif var_46_0.event_type == 16 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.touchGame.view.TouchGameLayer").new({
			missionId = arg_46_1.id,
			gameId = var_46_0.event_value_1,
			themeValue = self._activeThemeValue
		})))
	end
end

function ThemeBioGameCommonStage:_processMissionOther(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	var_0_10:send_C2S_ThemeBiography_ExecuteMission({
		act_id = self._activeThemeValue,
		id = arg_47_1.id
	})
end

function ThemeBioGameCommonStage:_beginBattleJump(arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = self._themeBioData:getMission(arg_48_3.id)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		canSkip = var_48_0.finish,
		drop = var_48_0.reward_tael,
		type = BattleConst.TYPE_THEME_BIO,
		battle_id = arg_48_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.theme_biography_battle_info.get(var_48_0.sub_id).battle_stage,
		prefixScene = {
			entranceModule = g.view.entrance.THEME_BIO_STAGE,
			entranceData = {
				chapterId = self._chapterId,
				themeValue = self._activeThemeValue
			}
		}
	})
end

function ThemeBioGameCommonStage:_showAwardAction(arg_49_1)
	self:getMapWorld():refreshEntityState(self._refChapterInfo)

	local var_49_0 = self._themeBioData:getMission(arg_49_1.id)

	if var_49_0.finish then
		if var_49_0.finish_story > 0 and self:_isNeedStory(var_49_0.finish_story) then
			self._hasShowStoryEndAward = false

			local var_49_1 = self

			self:_executeStory({
				id = var_49_0.finish_story,
				callback = function()
					if var_49_1 and not var_49_1._hasShowStoryEndAward then
						var_49_1:_onShowAwardCall(arg_49_1)

						var_49_1._hasShowStoryEndAward = true
					end
				end
			})
		else
			self:_onShowAwardCall(arg_49_1)
		end
	elseif var_49_0.type == 3 and var_49_0.not_trigger_story > 0 and self:_isNeedStory(var_49_0.not_trigger_story) then
		self:_executeStory({
			excuted = true,
			id = var_49_0.not_trigger_story
		})
	end
end

function ThemeBioGameCommonStage:_onShowAwardCall(arg_51_1)
	if arg_51_1.award == nil then
		return
	end

	local var_51_0 = {}

	for iter_51_0 = 1, #arg_51_1.award do
		table.insert(var_51_0, arg_51_1.award[iter_51_0])
	end

	local var_51_1 = self._themeBioData:getMission(arg_51_1.id)

	if var_51_1.type == 2 and var_51_1.sub_id > 0 and var_0_0.get(var_51_1.sub_id).event_type == 3 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.themeBio.view.game.ThemeBioGameTreeLayer"):new(var_51_0, self._activeThemeValue), {
			withoutAni = true,
			ignoreTouch = true
		})

		return
	end

	self:_afterCompletedTask(arg_51_1.id, var_51_0)
end

function ThemeBioGameCommonStage:_afterCompletedTask(arg_52_1, arg_52_2)
	local var_52_0 = self._themeBioData:getMission(arg_52_1)
	local var_52_1 = self._themeBioData:getChain(var_52_0.chain)

	self:_showMissionCostTip(var_52_0)

	if not self._lastTaskFinish and var_52_0.finish and (var_52_0.mission_finish_tip == 1 or var_52_0.mission_finish_tip == 2) then
		if var_52_0.type == 2 and var_52_0.sub_id > 0 and var_0_0.get(var_52_0.sub_id).event_type == 2 then
			self:_showCompletedAward(arg_52_2, var_52_0, var_52_1.type)
			self.m_taskPart:refreshTask()
			self:_checkChapterFinish(var_52_0)

			return
		end

		self:_playTaskCompleteAni(arg_52_2, var_52_0)
	else
		self:_showCompletedAward(arg_52_2, var_52_0, var_52_1.type)
		self.m_taskPart:refreshTask()
	end

	self:_checkChapterFinish(var_52_0)
end

function ThemeBioGameCommonStage:_showMissionCostTip(arg_53_1)
	local var_53_0 = {}

	if arg_53_1.type == 2 and arg_53_1.sub_id > 0 then
		local var_53_2 = var_0_0.get(arg_53_1.sub_id)

		if var_53_2.event_type == 1 then
			table.insert(var_53_0, var_53_2.event_value_1)
		end
	end

	local var_53_4 = 1

	while arg_53_1["item_cost_" .. var_53_4] and arg_53_1["item_cost_" .. var_53_4] > 0 do
		table.insert(var_53_0, arg_53_1["item_cost_" .. var_53_4])

		var_53_4 = var_53_4 + 1
	end

	if #var_53_0 > 0 then
		local var_53_5 = ""

		for iter_53_0 = 1, #var_53_0 do
			var_53_5 = var_53_5 .. var_0_11:convert({
				type = var_0_11.TYPE_BIO,
				value = var_53_0[iter_53_0]
			}).name

			if iter_53_0 < #var_53_0 then
				var_53_5 = var_53_5 .. "、"
			end
		end

		g.core.module.ModuleManager:tip(g.core.lang:get(409107, {
			name = var_53_5
		}))
	end
end

function ThemeBioGameCommonStage:_playTaskCompleteAni(arg_54_1, arg_54_2)
	self._themeBioData:setFinishNewMission()

	self._isShowMissionFinish = true

	if not self.m_taskPart then
		return
	end

	self.m_taskPart:refreshTask()

	if self._isShowChapterFinish then
		self._isShowChapterFinish = false
	elseif arg_54_1 and #arg_54_1 > 0 then
		self._missionForAward = arg_54_2

		g.core.module.ModuleManager:awardSummary(arg_54_1, true, nil, nil, handler(self, self._afterAwardCall))
	end
end

function ThemeBioGameCommonStage:checkExitBtnShow(arg_55_1)
	self.m_exitBtn:setVisible(arg_55_1)

	if arg_55_1 and not self._exitSpine then
		self._exitSpine = self.m_exitBtn:addEffectSpine({
			y = 33,
			name = "eff_ui_common_sixlight",
			isLoop = true,
			anim = "play",
			x = 33
		})
	end
end

function ThemeBioGameCommonStage:_showCompletedAward(arg_56_1, arg_56_2, arg_56_3)
	g.core.module.ModuleManager:awardSummary(arg_56_1)
end

function ThemeBioGameCommonStage:_isNeedStory(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(self._themeBioStorage.storys) do
		if iter_57_1 == arg_57_1 then
			return false
		end
	end

	return true
end

function ThemeBioGameCommonStage:_executeStory(arg_58_1, arg_58_2)
	var_0_2.EventManager:dispatchEvent(var_0_2.enum.EVENT_STORY_FORCE_START, arg_58_2 or false, arg_58_1)
	self:_setHudUIShow(false)

	if self:_isNeedStory(arg_58_1.id) then
		table.insert(self._themeBioStorage.storys, arg_58_1.id)
		self:_serializeBio()
	end
end

function ThemeBioGameCommonStage:_onEventStoryEnd(arg_59_1)
	if arg_59_1.trigger_data.isInteractTrigger then
		return
	end

	if arg_59_1.trigger_data.id == self._refChapterInfo.story then
		return
	end

	self:_setHudUIShow(true)

	if arg_59_1.trigger_data.excuted then
		return
	end

	if arg_59_1.trigger_data.callback then
		arg_59_1.trigger_data.callback()

		return
	end

	if arg_59_1.triggerTaskId then
		if arg_59_1.triggerTaskId > 0 then
			self:_onMissionStoryEnd(true)
		end
	elseif arg_59_1.chooseIndex == nil then
		self:_onMissionStoryEnd(true)
	elseif arg_59_1.chooseIndex == 1 then
		self:newScheduleOnce(function()
			if self._onMissionStoryEnd then
				self:_onMissionStoryEnd(true)
			end
		end, 0)
	end
end

function ThemeBioGameCommonStage:_getMissionTarget(arg_61_1, arg_61_2)
	local var_61_0

	if arg_61_1 == 2 and arg_61_2 and arg_61_2.finish then
		arg_61_1 = 1
	end

	if arg_61_1 == 1 then
		local var_61_1 = self._themeBioData:getChain(self._refChapterInfo.chains[1])

		if var_61_1.finish then
			return nil
		end

		var_61_0 = self._themeBioData:getMission(var_61_1.missions[var_61_1.current])
	else
		var_61_0 = arg_61_2
	end

	if not var_61_0 then
		return nil
	end

	if self:getMapWorld() then
		return (self:getMapWorld():getBindEntity(var_61_0.mission_resource))
	else
		return nil
	end
end

function ThemeBioGameCommonStage:_onSearchPathTarget(arg_62_1, arg_62_2)
	local var_62_0 = self:_getMissionTarget(arg_62_2.type, arg_62_2.mission)

	if var_62_0 then
		self:setAutoSearchPath(true)
		self:getMapWorld():autoRouteTalk(var_62_0, true)
	end
end

function ThemeBioGameCommonStage:_onCompletedTask(arg_63_1, arg_63_2)
	self:_afterCompletedTask(arg_63_2.id, arg_63_2.awards)
end

function ThemeBioGameCommonStage:_onSetHudUIShow(arg_64_1, arg_64_2)
	self:_setHudUIShow(arg_64_2)
end

function ThemeBioGameCommonStage:_onJumpMainRoleClick()
	self._mapWorld:jump2MainRole()
	self:setHeadArrow(false)
end

function ThemeBioGameCommonStage:_onClickExitBtn()
	g.core.module.ModuleManager:popModule()
end

function ThemeBioGameCommonStage:_onBioBagClick()
	self:addPopup((require("app.view.module.themeBio.view.ThemeBioPropPop").new(self._chapterId)))
end

function ThemeBioGameCommonStage:_onNetExecuteMission(arg_68_1, arg_68_2, arg_68_3)
	if self._themeBioData:getMission(arg_68_3.id).type == 1 then
		self:_beginBattleJump(arg_68_1, arg_68_2, arg_68_3)
	else
		self:_showAwardAction(arg_68_3)

		if self._bgMusic then
			g.core.sound.SoundManager:resumeMusic()
		end
	end
end

function ThemeBioGameCommonStage:_onPopTaskFinish(arg_69_1, arg_69_2)
	self:_onTriggerMission(arg_69_2.mission, 0, false, arg_69_2.touchItem)
end

function ThemeBioGameCommonStage:_onPublishLastTaskFinish(arg_70_1, arg_70_2)
	self:_executeStory({
		id = arg_70_2.storyId
	})
end

function ThemeBioGameCommonStage:refreshTargetVector()
	local var_71_9000
	local var_71_0 = self._themeBioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)

	if not var_71_0 or var_71_0 == var_0_5.BIO_TASK_STATE.ALL_FINISH then
		self.m_directionComp:setVisible(false)

		return
	end

	local var_71_1

	if var_71_0 == var_0_5.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_71_1 = self:_getMissionTarget(1)
	elseif var_71_0 == var_0_5.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_71_3 = self.m_taskPart:getSubTaskMissionInfo()

		if var_71_3 then
			var_71_1 = self:_getMissionTarget(2, var_71_3)
		end
	end

	if var_71_1 then
		if self:getMapWorld():checkSingleEntityInView(var_71_1) then
			self.m_directionComp:setVisible(false)

			return
		end

		self.m_directionComp:setVisible(true)

		local var_71_4 = var_71_1:getCoord()
		local var_71_5, var_71_6 = self:getMapGround():coordToPixel(var_71_4.x, var_71_4.y)
		local var_71_7, var_71_8 = self:getMapWorld().getTargetAngelFromScreenCenter(self:getMapGround():convertToNodeSpace(display.center), (cc.pNormalize((cc.pSub(cc.p(var_71_5 - 100, var_71_6 + 100), var_71_9000)))))

		self.m_directionComp:updateDirectionByAngle(var_71_7, var_71_8, var_71_0)
	end
end

function ThemeBioGameCommonStage:_checkChainState()
	if not self._themeBioData:getChain(self._refChapterInfo.chains[1]).finish then
		return false
	end

	for iter_72_0 = 2, #self._refChapterInfo.chains do
		for iter_72_1, iter_72_2 in ipairs(self._themeBioData:getChain(self._refChapterInfo.chains[iter_72_0]).missions) do
			if not self._themeBioData:getMission(iter_72_2).finish then
				return false
			end
		end
	end

	return true
end

function ThemeBioGameCommonStage:isNextMissionTarget(arg_73_1)
	if not arg_73_1 then
		return
	end

	local var_73_0 = self._themeBioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)
	local var_73_1

	if var_73_0 == var_0_5.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_73_1 = self:_getMissionTarget(1)
	elseif var_73_0 == var_0_5.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_73_2 = self.m_taskPart:getSubTaskMissionInfo()

		if var_73_2 then
			var_73_1 = self:_getMissionTarget(2, var_73_2)
		end
	end

	if var_73_1 and var_73_1:getBindID() == arg_73_1 then
		return true
	end

	return false
end

function ThemeBioGameCommonStage:_executeInteractOperation(arg_74_1, arg_74_2)
	if arg_74_1.type == var_0_5.BIO_INTERACT_TYPE.INTERACT_INFO_REMIND then
		local var_74_1 = {
			title = "",
			typeValue = arg_74_1.pop_type,
			desc = arg_74_1.des
		}

		if arg_74_1.pop_type == var_0_3.InfoTipPopType.BASE_TIP then
			var_74_1.title = arg_74_1.titel
		elseif arg_74_1.pop_type == var_0_3.InfoTipPopType.PAPER_TIP then
			var_74_1.title = ""
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoFullTipPop").new(var_74_1), {
			touchDisappear = true,
			hideContinue = false
		})
	elseif arg_74_1.type == var_0_5.BIO_INTERACT_TYPE.INTERACT_BOX then
		if arg_74_2 and arg_74_2:getResType() == MapConst.RESTYPE.SPINE then
			local var_74_2 = not arg_74_2:getIsOpen()

			arg_74_2:setOpenState(var_74_2)
			arg_74_2:playAnim(var_74_2 and "play" or "play2", true)
		end
	elseif arg_74_1.type == var_0_5.BIO_INTERACT_TYPE.INTERACT_NPC_DIALOG then
		if arg_74_1.plot_id ~= 0 then
			var_0_2.EventManager:dispatchEvent(var_0_2.enum.EVENT_STORY_FORCE_START, false, {
				isInteractTrigger = true,
				id = arg_74_1.plot_id
			})
		end
	end
end

function ThemeBioGameCommonStage:_showMissionFinishTips(arg_75_1, arg_75_2)
	if arg_75_1 then
		if not arg_75_2 then
			if arg_75_1.mission_finish_tip == 1 then
				g.core.module.ModuleManager:tip(g.core.lang:get(409110))
			elseif arg_75_1.mission_finish_tip == 2 then
				local var_75_0 = var_0_0.get(arg_75_1.sub_id)

				if var_75_0.event_type == 15 or var_75_0.event_type == 16 then
					g.core.module.ModuleManager:tip(g.core.lang:get(409111))
				end
			end
		end

		if arg_75_1.finish_story > 0 then
			if arg_75_1.type == 1 then
				self:_executeStory({
					excuted = true,
					id = arg_75_1.finish_story
				})
			end

			var_0_10:send_C2S_ThemeBiography_WatchStory({
				is_finish_story = true,
				act_id = self._activeThemeValue,
				id = arg_75_1.id
			})
		end
	end

	self._isShowMissionFinish = false
end

function ThemeBioGameCommonStage:_onCrossDayUpdate()
	local var_76_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_13.THEME_TYPE, self._activeThemeValue)

	if not ((var_76_1 and var_76_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popModule()

		return
	end
end

function ThemeBioGameCommonStage:_afterAwardCall()
	self:newScheduleOnce(function()
		if not tolua.isnull(self) then
			if self:_checkChainState() then
				self:_showMissionFinishTips(self._missionForAward, true)
				g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
					delay = 1,
					englishTitle = g.core.lang:get(409108),
					title = g.core.lang:get(409109),
					callBack = handler(self, function()
						self._isShowMissionFinish = false

						if self._playScrollAwardShow then
							self:_playScrollAwardShow()
						end
					end)
				}), {
					blackOpacity = 0
				})
				self:checkExitBtnShow(true)
			else
				self:checkExitBtnShow(false)
				self:_showMissionFinishTips(self._missionForAward)
			end
		end
	end)
end

return ThemeBioGameCommonStage
