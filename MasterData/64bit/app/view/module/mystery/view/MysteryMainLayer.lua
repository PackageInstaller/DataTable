local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.mysteryData
local var_0_3 = g.core.const.ConstMgr.MysteryConst
local var_0_4 = g.core.config.mystery_stage_info
local var_0_5 = g.core.common.ModuleUnlock
local var_0_6 = g.core.const.ConstMgr.FUNCTION_TYPE
local BattleConst = require("app.view.battle.const.BattleConst")
local MysteryMainLayer = class("MysteryMainLayer", require("app.fairyGUI.mystery.UI_MysteryMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "mystery",
		isFullScreen = true,
		pkgPath = "ui/mystery/mystery",
		resName = "MysteryMainLayer"
	}, ...)
end)

function MysteryMainLayer:ctor()
	self._finishStoryId = 0
	self._enterMapStoryId = 0
	self._isInBattle = false

	local var_2_0 = var_0_2:getNewChapterId()

	if var_2_0 > 0 then
		var_0_2:setCurChapterId(var_2_0)
		var_0_2:resetNewChapterId()
	else
		var_0_2:setCurChapterId((var_0_2:getLastUnlockChapterId()))
	end

	self._chapterId = var_0_2:getCurChapterId()
	self._chapterData = var_0_2:getChapterDataById(self._chapterId)

	self.m_mapComp:loadTiledMap()
	self:_initRegisterUI()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.MYSTERY)
	self.m_enterTransition:play()
end

function MysteryMainLayer:_initRegisterUI()
	self.m_topBar:setResInfoById(329)
	self.m_goBossBtn:addClickListener(handler(self, self._onClickGoBossBtn))
	self.m_chapterBtn:addClickListener(handler(self, self._onClickChooseChapterBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_newChapterBtn:addClickListener(handler(self, self._onClickNewChapterBtn))
	self.m_bossBtn:addClickListener(handler(self, self._onClickChooseBossBtn))
	self.m_newChapterBtn:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_common_sixlight",
		y = 33,
		x = 33
	})
	self.m_playTimesComp:initView({
		playNum = g.core.const.ConstMgr.ShopConst.PLAY_TYPE.MYSTERY_MONSTER_COUNT,
		getTimesFunc = function()
			return (var_0_2:getChallengeTime())
		end,
		refreshEvent = {
			var_0_0.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			var_0_0.EVENT_CROSS_DAY_NOTIFY
		}
	})
end

function MysteryMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_CHAGNG_CHAPTER, handler(self, self._customChangeMysteryMap), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, handler(self, self._customGoToTerminus), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_INFO, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD, self._updateMainView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ACCEPTTASK, self._updateMainView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_GIVEUPTASK, self._updateMainView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_CHALLENGEBEGIN, handler(self, self._onRcvMysteryChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ELITE_CHALLENGEBEGIN, handler(self, self._onRcvMysteryChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ENTER, handler(self, self._onRcvEnterMystery), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_GETROOMLIST, self._onRcvMysteryGetRoomList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_EXIT_BATTLE, self._onRcvMysteryExitBattle, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_MONSTER_FASTCHALLENGE, self._onS2CMysteryMonsterFastChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_STORY_FINISH, self._onRcvFinishStory, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._refreshRoomInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYMOVE, self._onS2CMysteryNotifyMove, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYATTACK, self._onS2CMysteryNotifyAttack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYEXIT, self._onS2CMysteryNotifyExit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_NOT_ENTER, self._exitMystery, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MYSTERY_ENTER_ROOM_FAILED, self._refreshRoomList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.MYSTERY_CHAT_BUBBLE, self.onShowChatBubble, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_NOTIFYLOOK, self.onShowOtherChatBubble, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.MYSTERY_SHOW_GRID_PLAYER, self.onShowOtherList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self._exitMystery, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_RECONNECT, self._exitMystery, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_TIMEOUT, self._exitMystery, self)

	if not self._isInBattle then
		self.m_mapComp:getMapWorld():sendEnterMystery()
	end

	self:_checkFirstEnterMysteryStory()
	g.core.network.GameNetProxy:send_C2S_Mystery_Info({})
	self.m_playTimesComp:updateView()
	self.m_mapComp:syncRoomUserStatus()
	self:_refreshRoomInfo()

	self._isInBattle = false
end

function MysteryMainLayer:_checkHaveNewChapter()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)

	if var_0_2:getNewChapterId() > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(423019),
			confirmText = g.core.lang:get(423020),
			onConfirm = handler(self, self._onClickNewChapterBtn)
		}))
		self.m_hasNewChapterController:setSelectedIndex(1)
	else
		self.m_hasNewChapterController:setSelectedIndex(0)
	end
end

function MysteryMainLayer:_customChangeMysteryMap(arg_7_1)
	var_0_2:resetRoomData()
	self.m_mapComp:getMapWorld():sendEnterMystery()
	self.m_mapComp:loadTiledMap()

	if var_0_2:getDailyTaskId() > 0 and not var_0_2:isDaliyTaskDone() then
		g.core.network.GameNetProxy:send_C2S_Mystery_GiveUpTask({})
	end

	self:_checkFirstEnterMysteryStory()
	self:_updateMainView()
	self:newScheduleOnce(handler(self, function()
		self.m_mapComp:autoGoToTerminus(arg_7_1)
	end), 0.3)
end

function MysteryMainLayer:_checkFirstEnterMysteryStory()
	local var_9_0, var_9_1 = self._chapterData:isHaveStoryTrigger(var_0_3.STORY_TYPE.ENTER_MAP)

	if var_9_0 then
		local var_9_2 = g.core.config.mystery_story_info.get(var_9_1)

		if not var_0_2:isAwardMysteryStoryById(var_9_1) and var_0_2:isNeedStory(var_9_2.trigger_story) then
			self._enterMapStoryId = var_9_1

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = var_9_2.trigger_story,
				callback = handler(self, self._sendEnterMapStoryGetAward)
			})
			var_0_2:saveStoryStorage(var_9_2.trigger_story)
		end
	end
end

function MysteryMainLayer:_customGoToTerminus(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3[2] and arg_10_3[2] ~= var_0_2:getCurChapterId() then
		var_0_2:setCurChapterId(arg_10_3[2])
		self:_customChangeMysteryMap(arg_10_3[1])
	else
		self.m_mapComp:autoGoToTerminus(arg_10_3[1])
	end
end

function MysteryMainLayer:_updateMainView()
	self.m_lineComp:updateLineInfo()
	self.m_taskComp:updateMainTaskComp()

	local var_11_0 = var_0_5:isModuleUnlock(var_0_6.MYSTERY_BOSS)

	self.m_bossBtn:setVisible(var_11_0)

	if var_11_0 then
		g.core.network.GameNetProxy:send_C2S_MysteryBoss_GetInfo({})
		self:_checkBossWeakGuide()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bossBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_goBossBtn
	})
end

function MysteryMainLayer:_checkBossWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_RE_CHECK)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function MysteryMainLayer:_onRcvMysteryChallengeBegin(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self._isInBattle = true

	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		canSkip = true,
		battle_id = arg_13_4.battle_id,
		type = BattleConst.TYPE_MYSTERY,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
end

function MysteryMainLayer:_onRcvEnterMystery(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_4.mystery_id then
		self:_sendMysteryGetRoomList(arg_14_4.mystery_id)
		self:newScheduleOnce(handler(self, self._checkHaveNewChapter), 1)
	end
end

function MysteryMainLayer:_sendMysteryGetRoomList(arg_15_1)
	local var_15_0 = arg_15_1 or var_0_2:getCurChapterId()

	g.core.network.GameNetProxy:send_C2S_Mystery_GetRoomList({
		mystery_id = var_15_0
	})
end

function MysteryMainLayer:_onRcvMysteryGetRoomList(arg_16_1, arg_16_2, arg_16_3)
	var_0_2:sendUserSnapIdList()
end

function MysteryMainLayer:_refreshRoomInfo()
	self.m_lineComp:updateLineInfo()
	self.m_mapComp:syncRoomUserStatus()
end

function MysteryMainLayer:_refreshRoomList()
	self:_sendMysteryGetRoomList()
end

function MysteryMainLayer:onShowChatBubble(arg_19_1, arg_19_2)
	self.m_mapComp:getMapWorld():showChatBubble(arg_19_2)
end

function MysteryMainLayer:onShowOtherList(arg_20_1, arg_20_2)
	self.m_otherOpeComp:setShowState(arg_20_2.isShow)

	if arg_20_2.isShow then
		table.sort(arg_20_2.showTarget, function(arg_21_0, arg_21_1)
			return arg_21_0:getBindID() < arg_21_1:getBindID()
		end)
		self.m_otherOpeComp:updateOtherList(arg_20_2.showTarget)
	end
end

function MysteryMainLayer:onShowOtherChatBubble(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3.uid and arg_22_3.uid ~= g.core.model.User:getId() then
		self.m_mapComp:getMapWorld():showOtherChatBubble(arg_22_3)
	end
end

function MysteryMainLayer:_onRcvMysteryExitBattle(arg_23_1, arg_23_2)
	if arg_23_2.content.is_win then
		local var_23_0, var_23_1 = self._chapterData:isHaveStoryTrigger(var_0_3.STORY_TYPE.BATTLE, arg_23_2.content.monster_id)

		if var_23_0 then
			local var_23_2 = g.core.config.mystery_story_info.get(var_23_1)

			if not var_0_2:isAwardMysteryStoryById(var_23_1) and var_0_2:isNeedStory(var_23_2.finish_story) then
				self._finishStoryId = var_23_1

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
					id = var_23_2.finish_story,
					callback = handler(self, self._sendFinshStoryGetAward)
				})
				var_0_2:saveStoryStorage(var_23_2.finish_story)
			end
		end

		if var_0_4.get(arg_23_2.content.monster_id).type == var_0_3.MAP_ITEM_TYPE.ELITE_MONSTER then
			self:_checkHaveNewChapter()
		end
	end
end

function MysteryMainLayer:_onRcvFinishStory(arg_24_1, arg_24_2, arg_24_3)
	g.core.module.ModuleManager:awardSummary(arg_24_3.awards, true)
end

function MysteryMainLayer:_sendFinshStoryGetAward()
	if self._finishStoryId > 0 then
		g.core.network.GameNetProxy:send_C2S_Mystery_Story_Finish({
			story_id = self._finishStoryId
		})

		self._finishStoryId = 0
	end

	self.m_mapComp:resumeMusic()
end

function MysteryMainLayer:_sendEnterMapStoryGetAward()
	if self._enterMapStoryId > 0 then
		g.core.network.GameNetProxy:send_C2S_Mystery_Story_Finish({
			story_id = self._enterMapStoryId
		})

		self._enterMapStoryId = 0
	end

	self.m_mapComp:resumeMusic()
end

function MysteryMainLayer:receiveCompEvent(arg_27_1)
	if arg_27_1 == "CHANGE_ROOM_LINE" then
		self.m_mapComp:getMapWorld():sendEnterMystery(({
			...
		})[1])
	elseif arg_27_1 == "MYSTERY_OTHER_OPE_COMP_OUT_SCREEN" then
		self._isInBattle = true

		self.m_otherOpeComp:setShowState(false)
	end
end

function MysteryMainLayer:_onClickGoBossBtn()
	local var_28_0 = require("app.view.module.mystery.view.infoPop.MysteryGoBossPop").new()

	self:addListen(var_28_0)
	g.core.module.ModuleManager:pushPopup(var_28_0, {
		touchDisappear = false,
		ignoreTouch = true
	})
	var_0_2:showBossAttackBtn()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_CLICK_MAIN_BOSS_BTN, false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bossBtn
	})
end

function MysteryMainLayer:_onClickChooseChapterBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERY_CHOOSE_CHAPTER)
end

function MysteryMainLayer:_onClickShopBtn()
	self._isInBattle = true

	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_1.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_1.ShopConst.SHOP_TYPE.MYSTERY
	})
end

function MysteryMainLayer:_onClickNewChapterBtn()
	local var_31_0 = var_0_2:getNewChapterId()

	if var_31_0 > 0 then
		var_0_2:setCurChapterId(var_31_0)
		self:_customChangeMysteryMap()
		var_0_2:resetNewChapterId()
	end
end

function MysteryMainLayer:_onClickChooseBossBtn()
	self._isInBattle = true

	g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERY_BOSS_CHOOSE)
end

function MysteryMainLayer:onUnload()
	if not self._isInBattle then
		g.core.network.GameNetProxy:send_C2S_Mystery_Exit({})
	end
end

function MysteryMainLayer:_onS2CMysteryNotifyMove(arg_34_1, arg_34_2, arg_34_3)
	if arg_34_3.user.user_id then
		self.m_mapComp:getMapWorld():playerRouteToCoord(arg_34_3.user.user_id, arg_34_3.user.pos)
	end
end

function MysteryMainLayer:_onS2CMysteryNotifyAttack(arg_35_1, arg_35_2, arg_35_3)
	if arg_35_3.user.user_id then
		self.m_mapComp:getMapWorld():playerAttackMonster(arg_35_3.user.user_id)
	end
end

function MysteryMainLayer:_onS2CMysteryMonsterFastChallenge(arg_36_1, arg_36_2, arg_36_3)
	if arg_36_3.awards then
		self:newScheduleOnce(handler(self, function()
			g.core.module.ModuleManager:awardSummary(arg_36_3.awards, true)
		end), 0.6)
	end

	self.m_taskComp:updateMainTaskComp()
end

function MysteryMainLayer:_onS2CMysteryNotifyExit(arg_38_1, arg_38_2, arg_38_3)
	if arg_38_3.uid then
		self.m_lineComp:updateLineInfo()
		self.m_mapComp:getMapWorld():delUserEntity(arg_38_3.uid)
	end
end

function MysteryMainLayer:_exitMystery()
	var_0_2:resetRoomData()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return MysteryMainLayer
