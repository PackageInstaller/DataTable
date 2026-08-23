local var_0_0 = g.core.config.biography_event_info
local var_0_1 = g.core.event
local var_0_2 = g.core.const.ConstMgr.InfoConst
local BattleConst = require("app.view.battle.const.BattleConst")
local BioConst = require("app.view.module.biography.const.BioConst")
local MapConst = require("app.core.ksmap.MapConst")
local SpineBase = require("app.view.common.SpineBase")
local BioGameWorld = import(".BioGameWorld")
local BioUtils = import("..model.BioUtils")
local var_0_9 = g.core.model.User
local var_0_10 = g.core.network.GameNetProxy
local var_0_11 = g.core.common.Goods
local var_0_12 = false
local BioGameStage = class("BioGameStage", require("app.fairyGUI.biography.UI_BioGameStage"), function()
	return fgui.GComponent:create({
		resName = "BioGameStage",
		pkgPath = "ui/biography/biography",
		isFullScreen = true,
		pkgName = "biography"
	})
end)

BioGameStage.PASS_CHIP_ID = 36

function BioGameStage:ctor(arg_2_1)
	self._mapWorld = nil
	self._chapterId = arg_2_1.chapterId
	self._refChapterInfo = var_0_9.bioData:getChapter(self._chapterId)
	self._refChapterInteractInfo = ""
	self._worldId = self._refChapterInfo.stage_map
	self._bioStorage = nil
	self._refCurMission = nil
	self._refTalkEntity = nil
	self._lastTaskFinish = false
	self._isShowMissionFinish = false
	self._isShowChapterFinish = false
	self._showWaitCount = 0
	self._tmpMovieParams = nil
	self._intervalTime = 0
	self.m_enterTransition = self:getView():getTransition("enter")

	self:initStage()
end

function BioGameStage:onLoad()
	self:_initRegister()
	self:getMapWorld():startObserver(self.m_touchMap)
	self.m_autoComp:setVisible(false)
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:setMax(1)
	self.m_taskPart:startUp(self)
	self.m_taskPart:initChapterData(self._refChapterInfo)

	local var_3_0, var_3_1 = var_0_9.bioData:getFinishNewMission()

	if var_3_0 then
		self:_showMissionFinishTips(var_3_1)
		self:_playTaskCompleteAni()
	else
		self.m_taskPart:refreshTask()

		local var_3_2 = g.core.model.User.goldSavingData:getHasNewGameId()

		if not g.core.model.User.goldSavingData:isIgnoreTodayTip() and var_3_2 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.function.GoldSavingTickPop").new({
				id = var_3_2
			}), {
				blackOpacity = 0
			})
		end
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
	self.m_playTimesComp:updateView()
	self:_addBgMusic()
	g.core.resource.ResourceManager:clearResource()
end

function BioGameStage:_addBgMusic()
	self._bgMusic = nil

	if self._refChapterInfo then
		if self._refChapterInfo.music and self._refChapterInfo.music ~= "" then
			self._bgMusic = self._refChapterInfo.music

			g.core.sound.SoundManager:playMusic(self._refChapterInfo.music)
		end
	end
end

function BioGameStage:onUnload()
	self.m_criComp:removeAllCriSprite()

	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	if self._showWaitCount > 0 then
		for iter_5_0 = 1, self._showWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._showWaitCount = 0
	end

	self.m_taskPart:startUp(nil)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:getMapWorld():stopObserver(self.m_touchMap)

	if self.m_pickupComp then
		self.m_pickupComp:stopAllFGActions()
	end
end

function BioGameStage:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "EVENT_STORY_END" then
		self:_onEventStoryEnd(arg_6_2)
	elseif arg_6_1 == "UI_EVENT_CLOSE_MAIN_INFO_START" then
		self:_playMainFlowStart()
	end
end

function BioGameStage:initStage()
	self:_initMapWorld()
	self:_initStageData()
	self:_initStageUI()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_BIOGRAPHIE,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getBioGraphie()
		end
	})
end

function BioGameStage:_onEnterAnimEnd()
	if self._waitState then
		self._waitState = false

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, 1)
	end
end

function BioGameStage:_playMainActionStart()
	if self:_checkFirstChapter() then
		self:_setHudUIShow(false)
		self:_playMainInfoStart()
	else
		self:_playMainFlowStart()
	end
end

function BioGameStage:_playMainInfoStart()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.biography.view.BioChapterBeginPop").new({
		chapterInfo = self._refChapterInfo,
		callFunc = handler(self, self._playMainFlowStart)
	}), {
		withoutAni = true
	})
end

function BioGameStage:_playMainFlowStart()
	self:_setHudUIShow(true)
end

function BioGameStage:_checkChapterFinish(arg_14_1)
	if not self._lastTaskFinish and arg_14_1.finish and var_0_9.bioData:getChain(arg_14_1.chain).type == 1 and var_0_9.bioData:getChain(self._refChapterInfo.chains[1]).finish then
		if self._isShowMissionFinish then
			self._isShowChapterFinish = true
		else
			self:_playScrollAwardShow()
		end
	end
end

function BioGameStage:_playScrollAwardShow()
	if self._refChapterInfo.scroll_num > 0 then
		local var_15_0 = g.core.config.item_info.get(BioGameStage.PASS_CHIP_ID)

		g.core.module.ModuleManager:showFeedBackTipsPop({
			title = g.core.lang:get(300021),
			showComp = fgui.UIPackage:createObject("base_new", "BasePassChipAwardNode"),
			iconUrl = g.core.common.Path:getMiddleItemIconById(var_15_0.icon),
			name = var_15_0.name,
			func = handler(self, self._playMainInfoEnd)
		})
	else
		self:_playMainInfoEnd()
	end
end

function BioGameStage:_playMainInfoEnd()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.biography.view.BioChapterEndPop").new({
		chapterInfo = self._refChapterInfo
	}), {
		withoutAni = true
	})
end

function BioGameStage:_checkFirstChapter()
	if self._bioStorage.chapterId == nil or self._bioStorage.chapterId < self._chapterId then
		self._bioStorage.chapterId = self._chapterId

		self:_serializeBio()

		return true
	end

	return false
end

function BioGameStage:getMapWorld()
	return self._mapWorld
end

function BioGameStage:getMapGround()
	return self._mapWorld:getMapGround()
end

function BioGameStage:talkTrigger(arg_20_1)
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
			local var_20_4 = var_0_9.bioData:getMission(iter_20_1)
			local var_20_5 = var_0_9.bioData:getChain(var_20_4.chain)

			if var_20_5.type == 4 and var_20_4.isLast then
				if var_20_4.finish then
					break
				end

				local var_20_6
				local var_20_7 = true

				for iter_20_2, iter_20_3 in ipairs(var_20_5.missions) do
					local var_20_8 = var_0_9.bioData:getMission(iter_20_3)

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

				self:addPopup(require("app.view.module.biography.view.BioTriggerPublishPop").new(2, var_20_6.id, nil, self._refTalkEntity), {
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
			table.sort(var_20_2, BioUtils.compareMissionTalk)
			self:_executeMission(var_20_2[1])
		end
	else
		local var_20_9 = var_0_9.bioData:getInteractByBindAndChapterId(var_20_0, self._chapterId)

		self._refChapterInteractInfo = var_20_9

		if var_20_9 then
			self:_executeInteractOperation(var_20_9, arg_20_1)
		end
	end
end

function BioGameStage:setAutoSearchPath(arg_21_1)
	self.m_autoComp:setVisible(arg_21_1)
end

function BioGameStage:pickupStop()
	self.m_pickupComp:setVisible(false)
	self.m_pickupComp:stopAllFGActions()
end

function BioGameStage:saveStayCoord(arg_23_1)
	self._bioStorage["stay_" .. self._chapterId] = {
		x = arg_23_1.x,
		y = arg_23_1.y
	}

	self:_serializeBio()
end

function BioGameStage:getStayCoord()
	return self._bioStorage["stay_" .. self._chapterId]
end

function BioGameStage:setHeadArrow(arg_25_1, arg_25_2, arg_25_3)
	self.m_headBtn:setVisible(arg_25_1)
end

function BioGameStage:_loadSnowMovie(arg_26_1)
	if g.core.utils.Quality.needCloseWeather() then
		return
	end

	if not arg_26_1 or not arg_26_1.effect or arg_26_1.effect == "" then
		return
	end

	self.m_criComp:removeAllCriSprite()

	self._intervalTime = arg_26_1.time or 0

	local var_26_0 = {}

	var_26_0.x = 25
	var_26_0.y = 25
	var_26_0.fullScreenState = 1
	var_26_0.movieName = arg_26_1.effect
	var_26_0.isLoop = true
	var_26_0.moduleName = "biography"

	if self._intervalTime > 0 then
		var_26_0.listener = handler(self, self._onCriSpriteEvent)
	end

	self._tmpMovieParams = var_26_0

	self:newScheduleOnce(handler(self, self._delayCreateMovie), self._intervalTime)
end

function BioGameStage:_delayCreateMovie()
	if self._tmpMovieParams then
		self.m_criComp:addCriSprite(self._tmpMovieParams)

		self._tmpMovieParams = nil
	end
end

function BioGameStage:_onCriSpriteEvent()
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

function BioGameStage:_initMapWorld()
	self._mapWorld = BioGameWorld.new(self, self._worldId)

	self.m_worldHold:addNode(self._mapWorld)
end

function BioGameStage:_initStageData()
	self:_deserializeBio()
end

function BioGameStage:_initStageUI()
	local var_33_0 = SpineBase.new({
		resId = 400140,
		isLoop = true,
		path = g.core.common.Path:getMapKnightPath() .. "400140/400140",
		anim = BattleConst.SPINE_ACTION_TYPE.RUN
	})

	var_33_0:setScale(0.5)
	var_33_0:setPosition(50, 10)
	var_33_0:mulColor(true, cc.vec3(0, 0, 0))
	self.m_autoComp:addNode(var_33_0)
	self.m_headBtn:addClickListener(handler(self, self._onJumpMainRoleClick))
	self.m_exitBtn:addClickListener(handler(self, self._onClickExitBtn))
	self:setHeadArrow(false)
	self.m_topBar:setResInfoById(45)
	self.m_bagBtn:addClickListener(handler(self, self._onBioBagClick))
	self.m_saodangBtn:addClickListener(handler(self, self._onSaoDangClick))
end

function BioGameStage:_initRegister()
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_BIOGRAPHY_EXECUTEMISSION, self._onNetExecuteMission, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_BIOGRAPHY_SYNCTEAMSTATUS, self._onNetRecvTeamInfo, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._onNetUpdateSweepInfo, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_BIO_SEARCH_PATH_TARGET, self._onSearchPathTarget, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_BIOFRAOHY_COMPLETE_TASK, self._onCompletedTask, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_BIO_SET_HUDUI_SHOW, self._onSetHudUIShow, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_BIOTRIGGER_POPTASK_FINISH, self._onPopTaskFinish, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_BIOTRIGGER_PUBLISHPOP_LAST_FINISH, self._onPublishLastTaskFinish, self)
end

function BioGameStage:_setHudUIShow(arg_35_1)
	if arg_35_1 then
		if self.m_enterTransition then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

			self._showWaitCount = self._showWaitCount + 1

			self.m_enterTransition:play(function()
				self._showWaitCount = self._showWaitCount - 1

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
			end)
		end

		self.m_topBar:playShowAction()
	elseif var_0_12 then
		if self.m_enterTransition then
			self.m_enterTransition:playReverse()
		end

		self.m_topBar:playHideAction()
	end
end

function BioGameStage:_pickupStart(arg_37_1, arg_37_2, arg_37_3)
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
			var_0_10:send_C2S_Biography_ExecuteMission({
				id = arg_37_1
			})
		end),
		fgui.FDelayTime:create(0.5),
		fgui.FHide:create()
	})))
end

function BioGameStage:_serializeBio()
	g.core.common.Storage:save("biography.json", self._bioStorage)
end

function BioGameStage:_deserializeBio()
	local var_40_0 = g.core.common.Storage:load("biography.json") or {}

	if var_40_0.storys == nil then
		var_40_0.storys = {}
	end

	self._bioStorage = var_40_0
end

function BioGameStage:_showBubbleOrStory(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		local var_41_1 = var_0_9.bioData:getMission(iter_41_1)
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

function BioGameStage:_executeMission(arg_42_1)
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
		if var_0_9.bioData:getChain(arg_42_1.chain).type == 4 and arg_42_1.isLast and arg_42_1.fighting then
			self:addPopup(require("app.view.module.biography.view.BioTriggerPublishPop").new(3, arg_42_1.id, arg_42_1.trigger_story, self._refTalkEntity), {
				withoutAni = true
			})
		else
			self:_executeStory({
				id = arg_42_1.trigger_story
			})
		end
	else
		self:_onMissionStoryEnd()
	end

	return true
end

function BioGameStage:_onMissionStoryEnd(arg_43_1)
	local var_43_0 = self._refTalkEntity

	if not self._refCurMission or not var_43_0 then
		self._refCurMission = nil
		self._refTalkEntity = nil

		return
	end

	local var_43_1 = var_0_9.bioData:getChain(self._refCurMission.chain)

	if var_43_1.type == 3 then
		return
	end

	if var_43_1.type == 4 and self._refCurMission.isFirst and self._refCurMission.sub_id ~= 0 then
		self:addPopup(require("app.view.module.biography.view.BioTriggerPublishPop").new(1, self._refCurMission.id, arg_43_1, var_43_0), {
			withoutAni = true
		})

		return
	end

	if self._refCurMission.type == 1 then
		if arg_43_1 then
			if self._refCurMission.if_converstion_panel ~= 0 then
				self:addPopup(require("app.view.module.biography.view.BioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0), {
					withoutAni = true
				})

				return
			end
		elseif self._refCurMission.if_converstion_panel == 1 and not self._refCurMission.finish then
			self:addPopup(require("app.view.module.biography.view.BioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0), {
				withoutAni = true
			})

			return
		end
	elseif self._refCurMission.type == 2 and self._refCurMission.sub_id ~= 0 then
		local var_43_2 = var_0_0.get(self._refCurMission.sub_id)

		if (var_43_2.event_type == 3 or var_43_2.event_type == 4 or var_43_2.event_type == 5) and self._refCurMission.if_converstion_panel ~= 0 then
			self:addPopup(require("app.view.module.biography.view.BioTriggerBattlePop").new(self._refCurMission.id, arg_43_1, var_43_0), {
				withoutAni = true
			})

			return
		end
	end

	self:_onTriggerMission(self._refCurMission, 1, arg_43_1, var_43_0)
end

function BioGameStage:_onTriggerMission(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if arg_44_1.type == 1 then
		self:_processMissionBattle(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	elseif arg_44_1.type == 2 then
		self:_processMissionEvent(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	elseif arg_44_1.type == 3 then
		self:_processMissionOther(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	end
end

function BioGameStage:_processMissionBattle(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_2 ~= 1 then
		var_0_10:send_C2S_Biography_ExecuteMission({
			id = arg_45_1.id
		})

		return
	end

	if arg_45_3 then
		if arg_45_1.if_converstion_panel == 0 and BioUtils.checkMission(arg_45_1) then
			var_0_10:send_C2S_Biography_ExecuteMission({
				id = arg_45_1.id
			})
		end
	else
		self:addPopup(require("app.view.module.biography.view.BioTriggerBattlePop").new(arg_45_1.id, false, arg_45_4), {
			withoutAni = true
		})
	end
end

function BioGameStage:_processMissionEvent(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	self._refCurMission = nil

	if arg_46_1.sub_id == 0 then
		var_0_10:send_C2S_Biography_ExecuteMission({
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
				g.core.module.ModuleManager:pushPopup(require("app.view.module.biography.view.BioGameClickLayer").new(arg_46_1.id), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			elseif var_46_0.event_type == 5 then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.biography.view.BioGameQTELayer").new(arg_46_1.id), {
					blackOpacity = 0.9,
					withoutAni = true
				})
			end
		end
	elseif var_46_0.event_type == 1 then
		if g.core.model.bag:isOwnItem(var_0_11.TYPE_BIO, var_46_0.event_value_1) then
			var_0_10:send_C2S_Biography_ExecuteMission({
				id = arg_46_1.id
			})
		end
	elseif var_46_0.event_type == 2 then
		var_0_10:send_C2S_Biography_ExecuteMission({
			id = arg_46_1.id
		})
	elseif var_46_0.event_type == 6 then
		var_0_10:send_C2S_Biography_ExecuteMission({
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
		var_0_10:send_C2S_Biography_ExecuteMission({
			id = arg_46_1.id
		})
	elseif var_46_0.event_type == 15 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PUZZLE_GAME, {
			level = var_46_0.event_value_1,
			missionid = arg_46_1.id
		})
	elseif var_46_0.event_type == 16 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.touchGame.view.TouchGameLayer").new({
			missionId = arg_46_1.id,
			gameId = var_46_0.event_value_1
		})))
	end
end

function BioGameStage:_processMissionOther(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	var_0_10:send_C2S_Biography_ExecuteMission({
		id = arg_47_1.id
	})
end

function BioGameStage:_beginBattleJump(arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = var_0_9.bioData:getMission(arg_48_3.id)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		canSkip = var_48_0.finish,
		drop = var_48_0.reward_tael,
		type = BattleConst.TYPE_BIO,
		battle_id = arg_48_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.biography_battle_info.get(var_48_0.sub_id).battle_stage,
		prefixScene = {
			entranceModule = g.view.entrance.BIO_STAGE,
			entranceData = {
				chapterId = self._chapterId
			}
		}
	})
end

function BioGameStage:_showAwardAction(arg_49_1)
	self:getMapWorld():refreshEntityState(self._refChapterInfo)

	local var_49_0 = var_0_9.bioData:getMission(arg_49_1.id)

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

function BioGameStage:_onShowAwardCall(arg_51_1)
	if arg_51_1.award == nil then
		return
	end

	local var_51_0 = {}

	if arg_51_1.award.rare_drops then
		for iter_51_0 = 1, #arg_51_1.award.rare_drops do
			arg_51_1.award.rare_drops[iter_51_0].isRare = true

			table.insert(var_51_0, arg_51_1.award.rare_drops[iter_51_0])
		end
	end

	if arg_51_1.award.first_drops then
		for iter_51_1 = 1, #arg_51_1.award.first_drops do
			table.insert(var_51_0, arg_51_1.award.first_drops[iter_51_1])
		end
	end

	if arg_51_1.award.finish_drops then
		for iter_51_2 = 1, #arg_51_1.award.finish_drops do
			table.insert(var_51_0, arg_51_1.award.finish_drops[iter_51_2])
		end
	end

	local var_51_1 = arg_51_1.id
	local var_51_2 = var_0_9.bioData:getMission(arg_51_1.id)

	if var_51_2.type == 2 and var_51_2.sub_id > 0 and var_0_0.get(var_51_2.sub_id).event_type == 3 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.biography.view.BioGameTreeLayer"):new(var_51_0), {
			withoutAni = true,
			ignoreTouch = true
		})

		return
	end

	self:_afterCompletedTask(var_51_1, var_51_0)
end

function BioGameStage:_afterCompletedTask(arg_52_1, arg_52_2)
	local var_52_0 = var_0_9.bioData:getMission(arg_52_1)
	local var_52_1 = var_0_9.bioData:getChain(var_52_0.chain)

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

function BioGameStage:_showMissionCostTip(arg_53_1)
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

		g.core.module.ModuleManager:tip(g.core.lang:get(302020, {
			name = var_53_5
		}))
	end
end

function BioGameStage:_playTaskCompleteAni(arg_54_1, arg_54_2)
	var_0_9.bioData:setFinishNewMission()

	self._isShowMissionFinish = true

	if not self.m_taskPart then
		return
	end

	self._isShowMissionFinish = false

	self.m_taskPart:refreshTask()

	if self._isShowChapterFinish then
		self._isShowChapterFinish = false

		self:_playScrollAwardShow()
	else
		local var_54_0 = self

		if arg_54_1 and #arg_54_1 > 0 then
			g.core.module.ModuleManager:awardSummary(arg_54_1, true, nil, nil, handler(self, function()
				if not tolua.isnull(var_54_0) then
					if var_54_0:_checkChainState() then
						g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
							delay = 1,
							englishTitle = g.core.lang:get(109614),
							title = g.core.lang:get(302010)
						}), {
							blackOpacity = 0
						})

						if var_54_0:_checkChainState() then
							var_54_0:checkSpeTickedGuide()
							var_54_0:checkExitBtnShow(true)
						else
							var_54_0:checkExitBtnShow(false)
						end
					else
						var_54_0:_showMissionFinishTips(arg_54_2)
					end
				end
			end))
		end
	end
end

function BioGameStage:checkSpeTickedGuide()
	if self._chapterId == 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_BIO_FIRST_CHAPTER_FINISH",
			targetBtn = self.m_topBar.m_returnBtn
		})
	end
end

function BioGameStage:checkExitBtnShow(arg_57_1)
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

function BioGameStage:_showCompletedAward(arg_58_1, arg_58_2, arg_58_3)
	g.core.module.ModuleManager:awardSummary(arg_58_1)
end

function BioGameStage:_isNeedStory(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(self._bioStorage.storys) do
		if iter_59_1 == arg_59_1 then
			return false
		end
	end

	return true
end

function BioGameStage:_executeStory(arg_60_1, arg_60_2)
	var_0_1.EventManager:dispatchEvent(var_0_1.enum.EVENT_STORY_FORCE_START, arg_60_2 or false, arg_60_1)
	self:_setHudUIShow(false)

	if self:_isNeedStory(arg_60_1.id) then
		table.insert(self._bioStorage.storys, arg_60_1.id)
		self:_serializeBio()
	end
end

function BioGameStage:_onEventStoryEnd(arg_61_1)
	if arg_61_1.trigger_data.isInteractTrigger then
		return
	end

	if arg_61_1.trigger_data.id == self._refChapterInfo.story then
		self:_playMainInfoStart()

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

function BioGameStage:_getMissionTarget(arg_63_1, arg_63_2)
	local var_63_0

	if arg_63_1 == 2 and arg_63_2 and arg_63_2.finish then
		arg_63_1 = 1
	end

	if arg_63_1 == 1 then
		local var_63_1 = var_0_9.bioData:getChain(self._refChapterInfo.chains[1])

		if var_63_1.finish then
			return nil
		end

		var_63_0 = var_0_9.bioData:getMission(var_63_1.missions[var_63_1.current])
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

function BioGameStage:_onSearchPathTarget(arg_64_1, arg_64_2)
	local var_64_0 = self:_getMissionTarget(arg_64_2.type, arg_64_2.mission)

	if var_64_0 then
		self:setAutoSearchPath(true)
		self:getMapWorld():autoRouteTalk(var_64_0, true)
	end
end

function BioGameStage:_onCompletedTask(arg_65_1, arg_65_2)
	self:_afterCompletedTask(arg_65_2.id, arg_65_2.awards)
end

function BioGameStage:_onSetHudUIShow(arg_66_1, arg_66_2)
	self:_setHudUIShow(arg_66_2)
end

function BioGameStage:_onJumpMainRoleClick()
	self._mapWorld:jump2MainRole()
	self:setHeadArrow(false)
end

function BioGameStage:_onClickExitBtn()
	g.core.module.ModuleManager:popModule()
end

function BioGameStage:_onBioBagClick()
	self:addPopup((require("app.view.module.biography.view.BioPropPop").new(self._chapterId)))
end

function BioGameStage:_onSaoDangClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BIOTEAMAKEY_POP)
end

function BioGameStage:_onNetExecuteMission(arg_71_1, arg_71_2, arg_71_3)
	if var_0_9.bioData:getMission(arg_71_3.id).type == 1 then
		self:_beginBattleJump(arg_71_1, arg_71_2, arg_71_3)
	else
		self:_showAwardAction(arg_71_3)

		if self._bgMusic then
			g.core.sound.SoundManager:resumeMusic()
		end
	end
end

function BioGameStage:_onNetRecvTeamInfo(arg_72_1, arg_72_2, arg_72_3)
	return
end

function BioGameStage:_onNetUpdateSweepInfo(arg_73_1, arg_73_2, arg_73_3)
	return
end

function BioGameStage:_onPopTaskFinish(arg_74_1, arg_74_2)
	self:_onTriggerMission(arg_74_2.mission, 0, false, arg_74_2.touchItem)
end

function BioGameStage:_onPublishLastTaskFinish(arg_75_1, arg_75_2)
	self:_executeStory({
		id = arg_75_2.storyId
	})
end

function BioGameStage:refreshTargetVector()
	local var_76_9000
	local var_76_0 = var_0_9.bioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)

	if not var_76_0 or var_76_0 == BioConst.BIO_TASK_STATE.ALL_FINISH then
		self.m_directionComp:setVisible(false)

		return
	end

	local var_76_1

	if var_76_0 == BioConst.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_76_1 = self:_getMissionTarget(1)
	elseif var_76_0 == BioConst.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_76_3 = self.m_taskPart:getSubTaskMissionInfo()

		if var_76_3 then
			var_76_1 = self:_getMissionTarget(2, var_76_3)
		end
	end

	if var_76_1 then
		if self:getMapWorld():checkSingleEntityInView(var_76_1) then
			self.m_directionComp:setVisible(false)

			return
		end

		self.m_directionComp:setVisible(true)

		local var_76_4 = var_76_1:getCoord()
		local var_76_5, var_76_6 = self:getMapGround():coordToPixel(var_76_4.x, var_76_4.y)
		local var_76_7, var_76_8 = self:getMapWorld().getTargetAngelFromScreenCenter(self:getMapGround():convertToNodeSpace(display.center), (cc.pNormalize((cc.pSub(cc.p(var_76_5 - 100, var_76_6 + 100), var_76_9000)))))

		self.m_directionComp:updateDirectionByAngle(var_76_7, var_76_8, var_76_0)
	end
end

function BioGameStage:_checkChainState()
	if not var_0_9.bioData:getChain(self._refChapterInfo.chains[1]).finish then
		return false
	end

	for iter_77_0 = 2, #self._refChapterInfo.chains do
		for iter_77_1, iter_77_2 in ipairs(var_0_9.bioData:getChain(self._refChapterInfo.chains[iter_77_0]).missions) do
			if not var_0_9.bioData:getMission(iter_77_2).finish then
				return false
			end
		end
	end

	return true
end

function BioGameStage:isNextMissionTarget(arg_78_1)
	if not arg_78_1 then
		return
	end

	local var_78_0 = var_0_9.bioData:getCurChapterMainAndSubTaskState(self._refChapterInfo)
	local var_78_1

	if var_78_0 == BioConst.BIO_TASK_STATE.MAIN_TASK_UN_FINISH then
		var_78_1 = self:_getMissionTarget(1)
	elseif var_78_0 == BioConst.BIO_TASK_STATE.SUB_TASK_UN_FINISH then
		local var_78_2 = self.m_taskPart:getSubTaskMissionInfo()

		if var_78_2 then
			var_78_1 = self:_getMissionTarget(2, var_78_2)
		end
	end

	if var_78_1 and var_78_1:getBindID() == arg_78_1 then
		return true
	end

	return false
end

function BioGameStage:_executeInteractOperation(arg_79_1, arg_79_2)
	if arg_79_1.type == BioConst.BIO_INTERACT_TYPE.INTERACT_INFO_REMIND then
		local var_79_1 = {
			title = "",
			typeValue = arg_79_1.pop_type,
			desc = arg_79_1.des
		}

		if arg_79_1.pop_type == var_0_2.InfoTipPopType.BASE_TIP then
			var_79_1.title = arg_79_1.titel
		elseif arg_79_1.pop_type == var_0_2.InfoTipPopType.PAPER_TIP then
			var_79_1.title = ""
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoFullTipPop").new(var_79_1), {
			touchDisappear = true,
			hideContinue = false
		})
	elseif arg_79_1.type == BioConst.BIO_INTERACT_TYPE.INTERACT_BOX then
		if arg_79_2 and arg_79_2:getResType() == MapConst.RESTYPE.SPINE then
			local var_79_2 = not arg_79_2:getIsOpen()

			arg_79_2:setOpenState(var_79_2)
			arg_79_2:playAnim(var_79_2 and "play" or "play2", true)
		end
	elseif arg_79_1.type == BioConst.BIO_INTERACT_TYPE.INTERACT_NPC_DIALOG then
		if arg_79_1.plot_id ~= 0 then
			var_0_1.EventManager:dispatchEvent(var_0_1.enum.EVENT_STORY_FORCE_START, false, {
				isInteractTrigger = true,
				id = arg_79_1.plot_id
			})
		end
	end
end

function BioGameStage:_showMissionFinishTips(arg_80_1)
	if arg_80_1 then
		if arg_80_1.mission_finish_tip == 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109615))
		elseif arg_80_1.mission_finish_tip == 2 then
			local var_80_0 = var_0_0.get(arg_80_1.sub_id)

			if var_80_0.event_type == 15 or var_80_0.event_type == 16 then
				g.core.module.ModuleManager:tip(g.core.lang:get(302096))
			end
		end
	end
end

function BioGameStage:doAutoAction(arg_81_1)
	return self.m_taskPart:doAutoAction(arg_81_1)
end

return BioGameStage
