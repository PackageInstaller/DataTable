local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveData()
local var_0_3 = g.core.const.ConstMgr.GuideConst
local var_0_4 = 100
local GveGameStage = class("GveGameStage", require("app.fairyGUI.gve.UI_GveGameStage"), function()
	return fgui.GComponent:create({
		resName = "GveGameStage",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveGameStage:ctor(arg_2_1)
	var_0_2 = var_0_1:getGveData()

	self.m_siteInfoComp:addClickListener(handler(self, self._onClickMySite))
	self.m_knightBtn:addClickListener(handler(self, self._onClickSelectKnightBtn))
	self.m_idleRewardBtn:addClickListener(handler(self, self._onIdleRewardClick))
	self.m_miniMapBtn:addClickListener(handler(self, self._onMiniMapClick))
	self.m_infoBtn:addClickListener(handler(self, self._onClickGvePioneerTeamLayer))
	self.m_shopBtn:addClickListener(handler(self, self._onClickGveShopLayer))
	self.m_relicBtn:addClickListener(handler(self, self._onClickRelicBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_playerIcon:addClickListener(handler(self, self._onClickPlayerIcon))
	self.m_finalBossRankBtn:addClickListener(handler(self, self.onFinalRankClick))
	self.m_finalBossBtn:addClickListener(handler(self, self.onGoToFightFinalBoss))
	self.m_preFormationBtn:addClickListener(handler(self, self.onPreFormationClick))
	self.m_instituteBtn:addClickListener(handler(self, self.onInstituteClick))
	self.m_stageRankBtn:addClickListener(handler(self, self.onStageRankClick))
	self.m_effShowBtn:addClickListener(handler(self, self._onShowEffStateChange))
	self.m_effShowBtn:setSelected(var_0_2:isGridBuffShow())

	self._jumpPos = arg_2_1 and arg_2_1.jumpPos
	self._isFirstEnter = true

	self.m_mapComp:setStage(self)
	self.m_topBarComp:setResInfoById(190)
	self.m_effShowBtn:setVisible(false)
	g.core.network.GameNetProxy:send_C2S_GVE_TeamInfo({})
	var_0_2:startGveTimer()
end

function GveGameStage:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_0.FUNCTION_TYPE.GVE)

	if self._isFirstEnter then
		local var_3_0 = var_0_2:getCurPosition() or var_0_2:getInitPoint()

		self.m_mapComp:moveToPoint(var_3_0.x, var_3_0.y)

		self._isFirstEnter = false

		g.core.network.GameNetProxy:send_C2S_GVE_WorldMove({
			x = var_3_0.x,
			y = var_3_0.y
		})
	end

	self.m_buffComp:updateBuff()

	if self._jumpPos then
		self.m_mapComp:moveToPoint(self._jumpPos.x, self._jumpPos.y)
		self.m_mapComp:onMapMoveEnd()
		self.m_mapComp:onSingleClick(self._jumpPos.x, self._jumpPos.y)

		self._jumpPos = nil
	else
		local var_3_1 = var_0_2:getJumpPos()

		if var_3_1 then
			self.m_mapComp:moveToPoint(var_3_1.x, var_3_1.y)
			self.m_mapComp:onMapMoveEnd()
		end
	end

	self.m_rewardGroup:setVisible((var_0_2:getCanRecIdleReward()))
	self.m_effBox:removeAllEffect()
	self.m_enterTransition:play()

	if var_0_1:hasIdleTimeAward() then
		self.m_effBox:addEffectSpine({
			anim = "play",
			name = "eff_ui_gve_reward",
			isLoop = true
		})
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MENU_GVE_STAGE)
	self.m_chatComp:setCurChannel(g.core.const.ConstMgr.ChatConst.GVE)
	g.core.network.GameNetProxy:send_C2S_GVE_GetInfo({})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDENTER, handler(self, self._onWorldEnterDataBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self._onPosKnightRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDTIMEAWARD, handler(self, self._onWorldIdleAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO, handler(self, self._onBuffInfoUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_USERLIST, handler(self, self._onBuffInfoUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self.onStoryPlayFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, handler(self, self._onReconnect), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.APP_ENTER_FOREGROUND_EVENT, handler(self, self._onReconnect), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, handler(self, self._onGoToTargetPos), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLBOSSISDEAD, handler(self, self._onAllBossInfoBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onGuideFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.JUMP_TO_GVE_FIRST_STAGE, handler(self, self._jumpFirstStage), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.JUMP_TO_GVE_SECOND_STAGE, handler(self, self._jumpSecondStage), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.JUMP_TO_GVE_TARGET_POS, handler(self, self._jumpTargetPos), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.JUMP_TO_GVE_MY_POS, handler(self, self._jumpMyPos), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onS2CNoticeAllianceState), self)
	g.core.network.GameNetProxy:send_C2S_GVE_Halidom_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GVE_Halidom_UserList({})
	g.core.network.GameNetProxy:send_C2S_GVE_TaskGetInfo({})
	g.core.network.GameNetProxy:send_C2S_GVE_GetResearchInfo({})
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossFirstKill({})

	if g.core.model.User.allianceData:isInAlliance() then
		self:_onWorldEnterDataBack()
	end

	self._scheduleHandler = self:newSchedule(handler(self, self._onScheduleUpdate), 1)

	if not g.core.guide.GuideProxy:isGuideRunning() then
		self:checkExecGuide()
	else
		self._isNeedCheckAfterGuide = true
	end

	g.core.model.User.guideData:setSaveServerData(22)
	self:checkChallengeOpenShow()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_instituteBtn
	})
	self:_onS2CNoticeAllianceState()
end

function GveGameStage:checkChallengeOpenShow()
	self.m_openFinalBossController:setSelectedIndex(var_0_2:getFinalPreBoss():isDeadByIndex() and 1 or 0)
end

function GveGameStage:_onGuideFinish()
	if self._isNeedCheckAfterGuide then
		self._isNeedCheckAfterGuide = false

		self:checkExecGuide()
	end
end

function GveGameStage:checkExecGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_STORY_PLAYED) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = 1766
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_STORY_PLAYED)
	elseif not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FORMAL_STAGE_IN) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_3.ENUM_TICK.GVE_IS_IN_FORMAL_FIRST_ENTER_STAGE
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FORMAL_STAGE_IN)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	else
		self:checkTipsGuide()
	end
end

function GveGameStage:_onAllBossInfoBack()
	if g.core.model.User.storyData:isInStory() or g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() then
		return
	end

	if not var_0_2:isFinalBossAlive() and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_BOSS_AVG_PLAY) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = 1771
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_BOSS_AVG_PLAY)
	else
		self:checkTipsGuide()
	end

	self:checkChallengeOpenShow()
end

function GveGameStage:onStoryPlayFinish()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FORMAL_STAGE_IN) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_3.ENUM_TICK.GVE_IS_IN_FORMAL_FIRST_ENTER_STAGE
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FORMAL_STAGE_IN)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	else
		self:checkTipsGuide()
	end
end

function GveGameStage:_onWorldEnterDataBack(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.network.GameNetProxy:send_C2S_GVE_WorldUserDataFlush({})
	g.core.network.GameNetProxy:send_C2S_GVE_GetAllBossIsDead({})
end

function GveGameStage:_onReconnect()
	g.core.network.GameNetProxy:send_C2S_GVE_WorldEnter({})
	self:_onWorldEnterDataBack()
end

function GveGameStage:onFinalRankClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveStage.GveBossFinalRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GveGameStage:onGoToFightFinalBoss()
	local var_12_0 = var_0_2:getFinalChallengeBoss():getInfo()

	self.m_mapComp:moveToPoint(var_12_0.x, var_12_0.y)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_BOSS_LAYER, {
		x = var_12_0.x,
		y = var_12_0.y,
		path = {},
		bossId = var_12_0.id
	})
end

function GveGameStage:_onPosKnightRefresh()
	self:_onBuffInfoUpdate()
	self.m_mapComp:checkAndSaveCanBeUsedGid()
end

function GveGameStage:_onGoToTargetPos(arg_14_1, arg_14_2, arg_14_3)
	self.m_mapComp:moveToPoint(arg_14_3.x, arg_14_3.y)

	local var_14_0, var_14_1 = self.m_mapComp:checkIsMonsterPoint(arg_14_3.x, arg_14_3.y)

	if not var_14_0 then
		self.m_mapComp:onSingleClick(arg_14_3.x, arg_14_3.y)
	end
end

function GveGameStage:_onClickMySite()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveMySitePop").new()))
end

function GveGameStage:_onClickSelectKnightBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.Recruit_Jiesuan_Single_01)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_SELECT_KNIGHT)
end

function GveGameStage:_onMiniMapClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_MINI_MAP, {
		center = self.m_mapComp:getScreenCenterPoint()
	})
end

function GveGameStage:_onIdleRewardClick()
	g.core.network.GameNetProxy:send_C2S_GVE_WorldTimeAward({})
end

function GveGameStage:_onClickGvePioneerTeamLayer()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_PIONEER_LAYER)
end

function GveGameStage:_onClickGveShopLayer()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_StoreMenu)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_SHOP)
end

function GveGameStage:_onClickRelicBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_HALIDOM_LAYER)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_relicBtn
	})
end

function GveGameStage:_onClickTaskBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_TASK)
end

function GveGameStage:_onClickPlayerIcon()
	local var_23_0 = var_0_2:getLastAddPoint()

	self.m_mapComp:moveToPoint(var_23_0.x, var_23_0.y)
	self.m_miniMapBtn:updateMapPos(var_23_0)
	self.m_miniMapBtn:updateMapState()
end

function GveGameStage:_onWorldIdleAward(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_24_4.awards)
	end

	self.m_rewardGroup:setVisible(false)
	self.m_effBox:removeAllEffect()
	var_0_2:getIdleReward()
end

function GveGameStage:onPreFormationClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_PRESET_LAYER)
end

function GveGameStage:onInstituteClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstitutePop").new()))
end

function GveGameStage:onStageRankClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_SEASON_RANK)
end

function GveGameStage:checkIsMonsterPoint(arg_28_1, arg_28_2)
	local var_28_0, var_28_1 = var_0_2:getPosNowBossCfg(arg_28_1, arg_28_2)

	if var_28_0 then
		self.m_mapComp:onBossAliveClick(arg_28_1, arg_28_2, var_28_0)

		return true
	end

	if var_28_1 and var_28_1.boss_type == 2 then
		self.m_mapComp:onBossDeadClick(arg_28_1, arg_28_2, var_28_1)
	end

	return false, var_28_1
end

function GveGameStage:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function GveGameStage:_onBuffInfoUpdate()
	self.m_buffComp:updateBuff()
	self.m_effShowBtn:setVisible(var_0_1:getGveBagData():checkCoreHalidomLv4())
end

function GveGameStage:_onScheduleUpdate()
	if g.core.common.ServerTime:getLeftSeconds((var_0_1:getGveFormalEndTime())) < 0 then
		if self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end

		var_0_2:stopGveTimer()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.GVE_RESULT_LAYER)
	end
end

function GveGameStage:_onShowEffStateChange()
	var_0_2:setShowGridBuff((self.m_effShowBtn:isSelected()))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SwitchSmall)
end

function GveGameStage:checkSpeTickGuide()
	if not g.core.guide.GuideProxy:isGuideRunning() then
		self:checkNotEquipKnight()
		self:checkIdleGuide()
		self:checkCoreHalidomLv4()
		self:checkNotPreKnight()
	end
end

function GveGameStage:checkIdleGuide()
	if var_0_2:getAllIdleTime() > 43200 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_GVE_IDLE_REWARD",
			targetBtn = self.m_idleRewardBtn
		})
	end
end

function GveGameStage:checkCoreHalidomLv4()
	if var_0_1:getGveBagData():checkCoreHalidomLv4() then
		self.m_effShowBtn:setVisible(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_GVE_MAIN_HALIDOM_CHANGE_BRANCH",
			targetBtn = self.m_effShowBtn
		})
	end
end

function GveGameStage:checkNotEquipKnight()
	local var_36_0 = var_0_1:getGveFormationData():getAllEquipKnight()

	if not var_36_0 or table.nums(var_36_0) == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_GVE_NOT_UP_FORMATION",
			targetBtn = self.m_knightBtn
		})
	end
end

function GveGameStage:checkNotPreKnight()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "GUIDE_GVE_NO_PRE_FORMATION",
		targetBtn = self.m_preFormationBtn
	})
end

function GveGameStage:calcBorderAngle()
	if not self._angle then
		local function var_38_0(arg_39_0, arg_39_1)
			return (math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_39_1, arg_39_0)))) + 360) % 360
		end

		self._angle = {
			right = {
				var_38_0(cc.p(display.cx, display.cy), cc.p(display.width, 0)),
				var_38_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height))
			},
			left = {
				var_38_0(cc.p(display.cx, display.cy), cc.p(0, display.height)),
				var_38_0(cc.p(display.cx, display.cy), cc.p(0, 0))
			},
			top = {
				var_38_0(cc.p(display.cx, display.cy), cc.p(0, 0)),
				var_38_0(cc.p(display.cx, display.cy), cc.p(display.width, 0))
			},
			bottom = {
				var_38_0(cc.p(display.cx, display.cy), cc.p(display.width, display.height)),
				var_38_0(cc.p(display.cx, display.cy), cc.p(0, display.height))
			}
		}
	end
end

function GveGameStage:updatePlayerIcon(arg_40_1, arg_40_2)
	if math.abs(arg_40_2.x - arg_40_1.x) < display.cx and math.abs(arg_40_2.y - arg_40_1.y) < display.cy then
		self.m_playerIcon:setVisible(false)
	else
		self:calcBorderAngle()
		self.m_playerIcon:setVisible(true)

		local var_40_0 = self.m_playerIcon:updateArrow(arg_40_1, arg_40_2)
		local var_40_1 = 0
		local var_40_2 = 0
		local var_40_3 = display.cx
		local var_40_4 = display.cy
		local var_40_5 = var_40_0

		if var_40_0 >= self._angle.right[1] and var_40_0 <= 360 or var_40_0 <= self._angle.right[2] and var_40_0 >= 0 then
			var_40_1 = var_40_3 - var_0_4

			if var_40_0 >= self._angle.right[1] then
				var_40_5 = var_40_5 - 360
			end

			var_40_2 = var_40_3 * math.tan(var_40_5 / 180 * math.pi)
		elseif var_40_0 >= self._angle.bottom[1] and var_40_0 <= self._angle.bottom[2] then
			var_40_2 = var_40_4 - var_0_4
			var_40_1 = -var_40_4 * math.tan((var_40_0 - 90) / 180 * math.pi)
		elseif var_40_0 >= self._angle.left[1] and var_40_0 <= self._angle.left[2] then
			var_40_1 = -var_40_3 + var_0_4
			var_40_2 = -var_40_3 * math.tan((var_40_0 - 180) / 180 * math.pi)
		elseif var_40_0 >= self._angle.top[1] and var_40_0 <= self._angle.top[2] then
			var_40_2 = -var_40_4 + var_0_4
			var_40_1 = var_40_4 * math.tan((var_40_0 - 270) / 180 * math.pi)
		end

		if var_40_2 < -var_40_4 + var_0_4 then
			var_40_2 = -var_40_4 + var_0_4
		elseif var_40_2 > var_40_4 - var_0_4 then
			var_40_2 = var_40_4 - var_0_4
		end

		if var_40_1 < -var_40_3 + var_0_4 then
			var_40_1 = -var_40_3 + var_0_4
		elseif var_40_1 > var_40_3 - var_0_4 then
			var_40_1 = var_40_3 - var_0_4
		end

		self.m_playerIcon:setPosition(display.cx + var_40_1, display.cy + var_40_2)
	end
end

function GveGameStage:checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not g.core.model.User.guideData:getServerDataById(var_0_3.SAVE_SERVER_DATA_IDS.GVE_FIRST_ENTER_GUIDE1) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_3.ENUM_TICK.GVE_RESEARCH_GUIDE
		})
		g.core.model.User.guideData:setSaveServerData(var_0_3.SAVE_SERVER_DATA_IDS.GVE_FIRST_ENTER_GUIDE1)

		return
	end

	if var_0_2:isAllBossKilled(2) then
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "GVE_SECOND_STAGE_FINISH",
				objects = {}
			})
		end, 0)
	elseif var_0_2:isAllBossKilled(1) then
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "GVE_FIRST_STAGE_FINISH",
				objects = {}
			})
		end, 0)
	end

	self:checkSpeTickGuide()
end

function GveGameStage:_jumpFirstStage()
	local var_44_0 = var_0_2:getNearestStageBoss(1)

	self.m_mapComp:moveToPoint(var_44_0.x, var_44_0.y)
end

function GveGameStage:_jumpSecondStage()
	local var_45_0 = var_0_2:getNearestStageBoss(2)

	self.m_mapComp:moveToPoint(var_45_0.x, var_45_0.y)
end

function GveGameStage:_jumpTargetPos()
	self.m_mapComp:moveToPoint(77, 214)
end

function GveGameStage:_jumpMyPos()
	self:_onClickPlayerIcon()
end

function GveGameStage:updateMiniMap(arg_48_1)
	self.m_miniMapBtn:updateMapPos(arg_48_1)
end

function GveGameStage:updateMapState()
	self.m_miniMapBtn:updateMapState()
end

function GveGameStage:onRemoved()
	var_0_2:stopGveTimer()
end

function GveGameStage:_onS2CNoticeAllianceState()
	if not g.core.model.User.allianceData:isInAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(309198))
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)
	end
end

return GveGameStage
