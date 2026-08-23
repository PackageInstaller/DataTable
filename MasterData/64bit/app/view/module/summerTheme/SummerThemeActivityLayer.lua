local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.config.activity_theme_display_info
local var_0_5 = g.core.config.activity_theme_info
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_7 = g.core.const.ConstMgr.SoundConst
local SummerThemeActivityLayer = class("SummerThemeActivityLayer", require("app.fairyGUI.summerTheme.UI_SummerThemeActivityLayer"), function()
	local var_1_0 = ({
		...
	})[1].themeValue or var_0_0.THEME_VALUE.GRYPH

	return fgui.GComponent:create({
		pkgName = "summerTheme",
		isFullScreen = true,
		pkgPath = "ui/summerTheme/summerTheme",
		resName = var_0_0.THEME_ACTIVITY_MAIN_LAYER[var_1_0]
	}, ...)
end)

function SummerThemeActivityLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._curThemeData = nil
	self._activityType = 0
	self._activityState = 0
	self._finishTime = 0
	self._expireTime = 0
	self._isFirstEnter = true
	self._recruitRouteId = 0

	self:_initRegisterListen()
	self:_initActivityMainUI()
end

function SummerThemeActivityLayer:_initRegisterListen()
	self.m_previewBgBtn:addClickListener(handler(self, self._onPreviewBgBtnClick))
	self.m_exploreBtn:addClickListener(handler(self, self._onExploreBtnClick))
	self.m_bossBattleBtn:addClickListener(handler(self, self._onBossBattleBtnClick))
	self.m_themeDungeonBtn:addClickListener(handler(self, self._onThemeDungeonBtnClick))
	self.m_showUIComp:addClickListener(handler(self, self._onShowUIClick))
	self.m_themeShopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_themeGameBtn:addClickListener(handler(self, self._onGameBtnClick))
	self.m_themeTaskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_jumpShopBtn:addClickListener(handler(self, self._onThemeGiftBtnClick))
	self.m_jumpChoukaBtn:addClickListener(handler(self, self._onThemeRecruitBtnClick))
	self.m_jumpSkinBtn:addClickListener(handler(self, self._onThemeSkinBtnClick))

	if self.m_themeBiographyBtn then
		self.m_themeBiographyBtn:addClickListener(handler(self, self._onThemeBioBtnClick))
	end

	if self.m_skinBubble then
		self.m_skinBubble:addClickListener(handler(self, self._onShopSkinBubbleBtnClick))
	end

	if self.m_themeGiftBtn then
		self.m_themeGiftBtn:addClickListener(handler(self, self._onGiftBtnClick))
	end

	self.m_passCardBtn = self:getChild("passCardBtn")

	if self.m_passCardBtn then
		self.m_passCardBtn:addClickListener(handler(self, self._onPassCardBtnClicked))
	end

	self.m_jumpList = self:getChild("jumpList")

	if self.m_jumpList then
		self.m_jumpList:setVirtual()
		self.m_jumpList:setItemRenderer(handler(self, self._onJumpListItemRender))
		self.m_jumpList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onJumpListClick))
	end
end

function SummerThemeActivityLayer:_initActivityMainUI()
	self:addBg(var_0_0.THEME_ACTIVITY_BG[self._activeThemeValue], nil, nil, 1)

	self._displayInfo = var_0_4.get(self._activeThemeValue)
	self._recruitRouteId = self._displayInfo.recruit_route

	self.m_topBarComp:setResInfoById(self._displayInfo.main_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.main_name)
	self.m_jumpShopBtn:setTitle(self._displayInfo.gift_name)

	self._activityThemeInfo = var_0_5.get(self._activeThemeValue)

	local var_4_0 = var_0_1:getThemeMergeMiniGameInfo(self._activeThemeValue)

	self._miniGameInfo = var_4_0
	self._miniGameType = var_4_0.miniGameType

	self.m_themeGameBtn:setVisible(self._miniGameInfo.entryVisible)
	self.m_themeGameBtn:setTitle(self._miniGameInfo.displayInfo.minigame_name or "")
	self.m_bossBattleBtn:setTitle(self._displayInfo.boss_name)

	if self._displayInfo.role_res > 0 and not (var_0_0.THEME_RES_ALIAS_GROUP[self._activeThemeValue] ~= nil or var_0_0.THEME_RES_KEY_ALIAS[self._activeThemeValue] ~= nil) then
		self._knightSpine = DrawKnight.new({
			scale = 1,
			resId = self._displayInfo.role_res,
			isShowBg = checkbool(self._displayInfo.show_bg == 1)
		})

		self.m_knightComp:addChild(self._knightSpine)

		local var_4_1 = var_0_0.KNIGHT_SPINE_SCALE[self._activeThemeValue] or {
			y = 1,
			x = 1
		}

		self._knightSpine:setScale(var_4_1.x, var_4_1.y)
	end

	if self.m_passCardBtn then
		self.m_passCardBtn:setText(self._displayInfo.passcard_name)
	end

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA or not checkbool(string.len(self._displayInfo.pv) > 0) then
		self.m_pvBtn:setVisible(false)
	end

	self:_sendC2SMiniGameGetInfo()
	self:_playEnterMenuOpenSound()
	self:_initJumpList()
end

function SummerThemeActivityLayer:_sendC2SMiniGameGetInfo()
	if self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_CARD then
		g.core.network.GameNetProxy:send_C2S_TurnCard_GetInfo({
			id = self._miniGameInfo.miniGameThemeValue
		})
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_TABLE then
		g.core.network.GameNetProxy:send_C2S_Turntable_GetInfo({
			act_id = self._miniGameInfo.miniGameThemeValue
		})
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GEM_ELIMINATE then
		g.core.network.GameNetProxy:send_C2S_Eliminate_GetInfo({
			id = self._miniGameInfo.miniGameThemeValue
		})
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.PUZZLE then
		g.core.network.GameNetProxy:send_C2S_Puzzle_GetInfo({
			id = self._miniGameInfo.miniGameThemeValue
		})
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GUESS then
		g.core.network.GameNetProxy:send_C2S_MiniGame_Guess_GetInfo({
			id = self._miniGameInfo.miniGameThemeValue
		})
	end
end

function SummerThemeActivityLayer:_playEnterMenuOpenSound()
	if self._activeThemeValue == var_0_0.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playSound(var_0_7.Sound.SWIM_MENUOPEN)
	elseif self._activeThemeValue == var_0_0.THEME_VALUE.GRYPH then
		g.core.sound.SoundManager:playSound(var_0_7.Sound.SHENGQIANG_MENUOPEN)
	end
end

function SummerThemeActivityLayer:_refreshGiftBtnRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeGiftBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
end

function SummerThemeActivityLayer:_refreshPassCardBtnRedPoint()
	if not self.m_passCardBtn then
		return
	end

	local var_8_0 = {
		redPointComp = self.m_passCardBtn
	}
	local var_8_1 = {
		themeValue = self._activeThemeValue
	}

	var_8_1.activityValues = self:_getEntranceData():getActivityThemeValueList()
	var_8_0.customData = var_8_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, var_8_0)
end

function SummerThemeActivityLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayRefresh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TURN_CARD_GETINFO, self._refreshBtnUnlock, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELIMINATE_GETINFO, self._refreshBtnUnlock, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUZZLE_GETINFO, self._refreshBtnUnlock, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINI_GAME_GUESS_GETINFO, self._refreshBtnUnlock, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_THEME_BIO_EXIT_CHAPTER_CHOOSE_LAYER, handler(self, self._onExitChapters), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._refreshGiftBtnRedPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, self._refreshGiftBtnRedPoint, self)

	self._curThemeData = var_0_1:getActivityData(self._activeThemeValue)

	if not self._curThemeData then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:popModule()
		end, 0.1)

		return
	end

	self._activityType = self._curThemeData:getActivityType()
	self._activityState = self._curThemeData:getActivityState()
	self._themePvFirstPlay = g.core.common.Storage:load("theme_pv_first_play_" .. self._activityType .. "_" .. self._activeThemeValue .. ".json", false) or {
		played = false
	}

	if not self._themePvFirstPlay.played then
		self:_playPvVideo()
	end

	self:_addThemeActivityKv()
	var_0_1:changeThemeBGM(self._activeThemeValue)
	self:_updateThemeMainView()
	self:_refreshRedPointComp()

	if self._isFirstEnter then
		self.m_enterTransition:play(handler(self, self.isNeedShowSkinBubble))

		self._isFirstEnter = false
	else
		self.m_enter_1Transition:play(handler(self, self.isNeedShowSkinBubble))
	end
end

function SummerThemeActivityLayer:isNeedShowSkinBubble()
	local var_11_0 = var_0_1:getThemeData(self._activeThemeValue):getThemeShopSkinData()

	if var_11_0 and self.m_skinBubble then
		self.m_skinBubble:setTitle(var_11_0.name)
		self.m_skinBubble:getChild("headIcon"):setIcon(g.core.common.Path:getRoleHeadIcon(var_11_0.value))
		self.m_skinbubbleTransition:play()
	end
end

function SummerThemeActivityLayer:_onShopSkinBubbleBtnClick()
	local var_12_0 = var_0_1:getThemeData(self._activeThemeValue):getThemeShopSkinData()

	if var_12_0 and self.m_skinBubble then
		g.core.common.GlobalFunc.pushInfoPop(var_12_0)
	end
end

function SummerThemeActivityLayer:_getEntranceData()
	return var_0_1:getThemeMergeEntranceActivityData(self._activeThemeValue)
end

function SummerThemeActivityLayer:_getOpenThemeValue()
	return self:_getEntranceData():getOpenActivityData():getConfigActivityValue()
end

function SummerThemeActivityLayer:_onGiftBtnClick()
	local var_15_0 = self:_getEntranceData()
	local var_15_1, var_15_2

	if not var_15_0:isMergedGiftOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		do return end

		var_15_1 = require("app.view.module.shop.view.shopThemeGift.ShopThemeGiftPop").new
		var_15_2 = {
			activityValue = self:_getOpenThemeValue()
		}
	end

	var_15_2.activityValues = var_15_0:getActivityThemeValueList()

	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopThemeGift.ShopThemeGiftPop").new(var_15_2)))
end

function SummerThemeActivityLayer:_onPassCardBtnClicked()
	local var_16_0 = self:_getOpenThemeValue()

	require("app.core.common.Provider").reqThemePassCardParam.activity_id = var_16_0

	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_PASS_CARD, {
		themeValue = var_16_0
	})
end

function SummerThemeActivityLayer:_addThemeActivityKv()
	if not var_0_0.THEME_KV_MOVIE[self._activeThemeValue] then
		return
	end

	if self._activeThemeValue == var_0_0.THEME_VALUE.LINEDELL and config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		return
	end

	self:addMovie(var_0_0.THEME_KV_MOVIE[self._activeThemeValue], 1666, 750)
end

function SummerThemeActivityLayer:addMovie(arg_18_1, arg_18_2, arg_18_3)
	self.m_movieComp:removeAllCriSprite()
	self.m_movieComp:addCriSprite({
		y = 0,
		x = 0,
		fullScreenState = 2,
		moduleName = "activity",
		isLoop = true,
		movieName = arg_18_1
	})
	self.m_bgComp:setScale((math.max(display.width / arg_18_2, display.height / arg_18_3)))
end

function SummerThemeActivityLayer:_refreshRedPointComp()
	local var_19_0 = self:_getEntranceData():getActivityThemeValueList()

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeShopBtn,
		customData = {
			themeValue = self._activeThemeValue,
			activityValues = var_19_0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeTaskBtn,
		customData = {
			themeValue = self._activeThemeValue,
			activityValues = var_19_0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeDungeonBtn,
		customData = {
			themeValue = self._activeThemeValue,
			activityValues = var_19_0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bossBattleBtn,
		customData = {
			themeValue = self._activeThemeValue,
			activityValues = var_19_0
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_exploreBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeGameBtn,
		customData = {
			themeValue = self._miniGameInfo.miniGameThemeValue
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeGiftBtn,
		customData = {
			themeValue = self._activeThemeValue
		}
	})

	local var_19_1 = {}

	for iter_19_0 = 1, var_0_0.THEME_BIO_CHAPTER_NUM do
		if self._activityThemeInfo["biography_id_" .. iter_19_0] > 0 then
			var_19_1[#var_19_1 + 1] = self._activityThemeInfo["biography_id_" .. iter_19_0]
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_themeBiographyBtn,
		customData = {
			themeValue = self._activeThemeValue,
			ids = var_19_1
		}
	})
	self:_refreshPassCardBtnRedPoint()
end

function SummerThemeActivityLayer:_onCrossDayRefresh()
	self._activityState = self._curThemeData:getActivityState()

	if self._activityState == var_0_2.ACTIVITY_STATE.EXPIRE then
		g.core.module.ModuleManager:popModule()

		return
	end

	local var_20_0 = g.core.model.User.themeData

	for iter_20_0, iter_20_1 in ipairs(self:_getEntranceData():getActivityThemeValueList()) do
		local var_20_1 = var_20_0:getThemeData(iter_20_1)

		if var_20_1 then
			var_20_1:getBossData():refreshBossCrossDay()
		end
	end

	var_20_0:getThemeData(self._activeThemeValue):getTaskData():refreshTaskCrossDay()
	self:_updateThemeMainView()
	self:_refreshRedPointComp()
end

function SummerThemeActivityLayer:_updateThemeMainView()
	self._curThemeData = var_0_1:getActivityData(self._activeThemeValue)

	if self._curThemeData then
		self._activityState = self._curThemeData:getActivityState()

		self:_refreshBtnUnlock()
		self:_refreshActivityCountDown()

		self._cdScheduler = self._cdScheduler or self:newSchedule(handler(self, self._onUpdateCDTime), 60)
	end

	local var_21_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue)

	if var_21_0 then
		if var_21_0:getExploreData():hasExplore() then
			self.m_exploreBtn:setVisible(true)
		else
			self.m_exploreBtn:setVisible(false)
		end
	end
end

function SummerThemeActivityLayer:_onUpdateCDTime()
	self:_refreshActivityCountDown()
end

function SummerThemeActivityLayer:_refreshActivityCountDown()
	local var_23_0 = self:_getEntranceData()
	local var_23_1 = var_23_0:getActivityState()

	if var_23_1 == var_0_2.ACTIVITY_STATE.START then
		local var_23_2, var_23_3, var_23_4, var_23_5 = var_0_3:getLeftTimeParts((var_23_0:getFinishTime()))

		if var_23_4 > 0 or var_23_5 > 0 then
			var_23_3 = var_23_3 + 1
		end

		self.m_themeTitleComp:setTitle(g.core.lang:get(405707, {
			day = var_23_2,
			hour = var_23_3
		}))
	elseif var_23_1 == var_0_2.ACTIVITY_STATE.END then
		local var_23_6, var_23_7, var_23_8, var_23_9 = var_0_3:getLeftTimeParts((var_23_0:getExpireTime()))

		if var_23_8 > 0 or var_23_9 > 0 then
			var_23_7 = var_23_7 + 1
		end

		self.m_themeTitleComp:setTitle(g.core.lang:get(405708, {
			day = var_23_6,
			hour = var_23_7
		}))
	elseif self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)

		self._cdScheduler = nil
	end
end

function SummerThemeActivityLayer:_refreshBtnUnlock()
	if self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_CARD then
		self:_refreshTurnCardStartBtnState()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_TABLE then
		self:_refreshTurnTableStartBtnState()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GEM_ELIMINATE then
		self:_refreshGemStartBtnState()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.PUZZLE then
		self:_refreshPuzzleStartBtnState()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GUESS then
		self:_refreshGuessStartBtnState()
	end

	if self._activityState == var_0_2.ACTIVITY_STATE.START then
		self:_refreshExploreStartBtnState()
		self:_refreshBossWarStartBtnState()
		self:_refreshDungeonStartBtnState()
		self:_refreshThemeBioStartBtnState()

		if self.m_themeGiftBtn then
			self:_refreshThemeGiftStartBtnState(var_0_0.BTN_CTRL.OPEN)
		end
	elseif self._activityState == var_0_2.ACTIVITY_STATE.END then
		self:_refreshAllBtnEndState()
	elseif self._activityState == var_0_2.ACTIVITY_STATE.PREVIEW and self.m_themeGiftBtn then
		self:_refreshThemeGiftStartBtnState(var_0_0.BTN_CTRL.NOTOPEN)
	end
end

function SummerThemeActivityLayer:_refreshExploreStartBtnState()
	local var_25_0 = var_0_1:getThemeData(self._activeThemeValue)

	if var_25_0 then
		if var_0_3:getTime() > var_25_0:getExploreData():getExploreStartTime() then
			self.m_exploreBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.OPEN
			})
		else
			self.m_exploreBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.NOTOPEN
			})
		end
	end
end

function SummerThemeActivityLayer:_refreshBossWarStartBtnState()
	local var_26_0 = var_0_1:getThemeData(self._activeThemeValue)

	if var_26_0 then
		local var_26_1 = var_26_0:getBossData()
		local var_26_2 = var_26_1:getBossStartTime()

		if var_0_3:getTime() < var_26_2 then
			local var_26_3, var_26_4, var_26_5, var_26_6 = var_0_3:getLeftTimeParts(var_26_2)

			if var_26_3 == 0 and (var_26_4 > 0 or var_26_5 > 0 or var_26_6 > 0) then
				self.m_bossBattleBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
			else
				self.m_bossBattleBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
					time = var_26_3
				}))
			end

			self.m_bossBattleBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.NOTOPEN
			})
		elseif var_26_1:getBossOpenState() == var_0_0.THEME_STATE_TYPE.OPENING then
			self.m_bossBattleBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.OPEN
			})
		else
			self.m_bossBattleBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.END
			})
		end
	end
end

function SummerThemeActivityLayer:_refreshDungeonStartBtnState()
	local var_27_0 = var_0_1:getThemeData(self._activeThemeValue)

	if var_27_0 then
		local var_27_1 = var_27_0:getDungeonData():getThemeDungeonStartTime()

		if var_0_3:getTime() < var_27_1 then
			local var_27_2, var_27_3, var_27_4, var_27_5 = var_0_3:getLeftTimeParts(var_27_1)

			if var_27_2 == 0 and (var_27_3 > 0 or var_27_4 > 0 or var_27_5 > 0) then
				self.m_themeDungeonBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
			else
				self.m_themeDungeonBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
					time = var_27_2
				}))
			end

			self.m_themeDungeonBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.NOTOPEN
			})
		else
			self.m_themeDungeonBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.OPEN
			})
		end
	end
end

function SummerThemeActivityLayer:_refreshThemeBioStartBtnState()
	local var_28_0 = var_0_1:getThemeData(self._activeThemeValue)

	if var_28_0 and self.m_themeBiographyBtn then
		local var_28_1 = var_28_0:getThemeBioData():getThemeBioStartTime()

		if var_0_3:getTime() < var_28_1 then
			local var_28_2, var_28_3, var_28_4, var_28_5 = var_0_3:getLeftTimeParts(var_28_1)

			if var_28_2 == 0 and (var_28_3 > 0 or var_28_4 > 0 or var_28_5 > 0) then
				self.m_themeBiographyBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
			else
				self.m_themeBiographyBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
					time = var_28_2
				}))
			end

			self.m_themeBiographyBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.NOTOPEN
			})
		else
			self.m_themeBiographyBtn:setCtrlState("state", {
				index = var_0_0.BTN_CTRL.OPEN
			})
		end
	end
end

function SummerThemeActivityLayer:_refreshTurnCardStartBtnState()
	local var_29_0 = var_0_1:getThemeData(self._miniGameInfo.miniGameThemeValue)
	local var_29_1 = g.core.model.User.activityDataManager:getCustomActivityDataByConfigVal(var_0_0.THEME_TYPE, self._miniGameInfo.miniGameThemeValue)
	local var_29_2, var_29_3

	if not var_29_1 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})

		do return end

		var_29_2 = var_29_1:getStartTime()
		var_29_3 = var_29_1:getFinishTime()
	end

	if var_29_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
		var_29_2 = var_29_0:getTurnCardData():getGuessStartTime()
		var_29_3 = var_29_0:getTurnCardData():getGuessEndTime()
	end

	local var_29_4 = var_0_3:getTime()

	if var_29_4 < var_29_2 then
		local var_29_5, var_29_6, var_29_7, var_29_8 = var_0_3:getLeftTimeParts(var_29_2)

		if var_29_5 == 0 and (var_29_6 > 0 or var_29_7 > 0 or var_29_8 > 0) then
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
		else
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
				time = var_29_5
			}))
		end

		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.NOTOPEN
		})
	elseif var_29_3 < var_29_4 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	else
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.OPEN
		})
	end
end

function SummerThemeActivityLayer:_refreshTurnTableStartBtnState()
	local var_30_0 = var_0_1:getThemeData(self._miniGameInfo.miniGameThemeValue)
	local var_30_1 = g.core.model.User.activityDataManager:getCustomActivityDataByConfigVal(var_0_0.THEME_TYPE, self._miniGameInfo.miniGameThemeValue)
	local var_30_2, var_30_3

	if not var_30_1 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})

		do return end

		var_30_2 = var_30_1:getStartTime()
		var_30_3 = var_30_1:getFinishTime()
	end

	if var_30_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
		var_30_2 = var_30_0:getTurnTableData():getGuessStartTime()
		var_30_3 = var_30_0:getTurnTableData():getGuessEndTime()
	end

	local var_30_4 = var_0_3:getTime()

	if var_30_4 < var_30_2 then
		local var_30_5, var_30_6, var_30_7, var_30_8 = var_0_3:getLeftTimeParts(var_30_2)

		if var_30_5 == 0 and (var_30_6 > 0 or var_30_7 > 0 or var_30_8 > 0) then
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
		else
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
				time = var_30_5
			}))
		end

		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.NOTOPEN
		})
	elseif var_30_3 < var_30_4 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	else
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.OPEN
		})
	end
end

function SummerThemeActivityLayer:_refreshGemStartBtnState()
	local var_31_0 = var_0_1:getThemeData(self._miniGameInfo.miniGameThemeValue)
	local var_31_1 = g.core.model.User.activityDataManager:getCustomActivityDataByConfigVal(var_0_0.THEME_TYPE, self._miniGameInfo.miniGameThemeValue)
	local var_31_2, var_31_3

	if not var_31_1 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})

		do return end

		var_31_2 = var_31_1:getStartTime()
		var_31_3 = var_31_1:getFinishTime()
	end

	if var_31_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
		var_31_2 = var_31_0:getGemEliminateData():getGuessStartTime()
		var_31_3 = var_31_0:getGemEliminateData():getGuessEndTime()
	end

	local var_31_4 = var_0_3:getTime()

	if var_31_4 < var_31_2 then
		local var_31_5, var_31_6, var_31_7, var_31_8 = var_0_3:getLeftTimeParts(var_31_2)

		if var_31_5 == 0 and (var_31_6 > 0 or var_31_7 > 0 or var_31_8 > 0) then
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
		else
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
				time = var_31_5
			}))
		end

		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.NOTOPEN
		})
	elseif var_31_3 < var_31_4 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	else
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.OPEN
		})
	end
end

function SummerThemeActivityLayer:_refreshPuzzleStartBtnState()
	local var_32_0 = var_0_1:getThemeData(self._miniGameInfo.miniGameThemeValue)
	local var_32_1 = g.core.model.User.activityDataManager:getCustomActivityDataByConfigVal(var_0_0.THEME_TYPE, self._miniGameInfo.miniGameThemeValue)
	local var_32_2, var_32_3

	if not var_32_1 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})

		do return end

		var_32_2 = var_32_1:getStartTime()
		var_32_3 = var_32_1:getFinishTime()
	end

	if var_32_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
		var_32_2 = var_32_0:getThemePuzzleData():getGuessStartTime()
		var_32_3 = var_32_0:getThemePuzzleData():getGuessEndTime()
	end

	local var_32_4 = var_0_3:getTime()

	if var_32_4 < var_32_2 then
		local var_32_5, var_32_6, var_32_7, var_32_8 = var_0_3:getLeftTimeParts(var_32_2)

		if var_32_5 == 0 and (var_32_6 > 0 or var_32_7 > 0 or var_32_8 > 0) then
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
		else
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
				time = var_32_5
			}))
		end

		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.NOTOPEN
		})
	elseif var_32_3 < var_32_4 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	else
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.OPEN
		})
	end
end

function SummerThemeActivityLayer:_refreshGuessStartBtnState()
	local var_33_0 = var_0_1:getThemeData(self._miniGameInfo.miniGameThemeValue)
	local var_33_1 = g.core.model.User.activityDataManager:getCustomActivityDataByConfigVal(var_0_0.THEME_TYPE, self._miniGameInfo.miniGameThemeValue)
	local var_33_2, var_33_3

	if not var_33_1 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})

		do return end

		var_33_2 = var_33_1:getStartTime()
		var_33_3 = var_33_1:getFinishTime()
	end

	if var_33_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
		var_33_2 = var_33_0:getThemeGuessData():getGuessStartTime()
		var_33_3 = var_33_0:getThemeGuessData():getGuessEndTime()
	end

	local var_33_4 = var_0_3:getTime()

	if var_33_4 < var_33_2 then
		local var_33_5, var_33_6, var_33_7, var_33_8 = var_0_3:getLeftTimeParts(var_33_2)

		if var_33_5 == 0 and (var_33_6 > 0 or var_33_7 > 0 or var_33_8 > 0) then
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405709))
		else
			self.m_themeGameBtn:getChild("openTimeTxt"):setText(g.core.lang:get(405710, {
				time = var_33_5
			}))
		end

		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.NOTOPEN
		})
	elseif var_33_3 < var_33_4 then
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	else
		self.m_themeGameBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.OPEN
		})
	end
end

function SummerThemeActivityLayer:_refreshThemeGiftStartBtnState(arg_34_1)
	self.m_themeGiftBtn:setCtrlState("state", {
		index = arg_34_1
	})
end

function SummerThemeActivityLayer:_refreshAllBtnEndState()
	self.m_exploreBtn:setCtrlState("state", {
		index = var_0_0.BTN_CTRL.END
	})
	self.m_themeTaskBtn:setCtrlState("state", {
		index = var_0_0.BTN_CTRL.END
	})
	self.m_themeDungeonBtn:setCtrlState("state", {
		index = var_0_0.BTN_CTRL.END
	})
	self.m_bossBattleBtn:setCtrlState("state", {
		index = var_0_0.BTN_CTRL.END
	})

	if self.m_themeGiftBtn then
		self.m_themeGiftBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	end

	if self.m_themeBiographyBtn then
		self.m_themeBiographyBtn:setCtrlState("state", {
			index = var_0_0.BTN_CTRL.END
		})
	end
end

function SummerThemeActivityLayer:_playPvVideo()
	if g.core.model.User.homeData:isCensorPv() then
		return
	end

	local var_36_0 = self._displayInfo.pv

	if string.len(self._displayInfo.pv) > 0 then
		local var_36_1 = {
			pvName = var_36_0,
			zimuName = self._displayInfo.subtitles
		}

		var_36_1.bgPVSound = var_0_0.THEME_PV_BGM[self._activeThemeValue] or var_0_0.THEME_PV_BGM[1]
		var_36_1.localName = "theme_pv_first_play_" .. self._activityType .. "_" .. self._activeThemeValue

		g.core.module.ModuleManager:pushPopup(require("app.view.module.login.view.PvPlayLayer").new(var_36_1))
	end
end

function SummerThemeActivityLayer:_onPvClick()
	self:_playPvVideo()
end

function SummerThemeActivityLayer:_onPreviewBgBtnClick()
	if self.m_hideUIController:getSelectedIndex() == 0 then
		self.m_hideUIController:setSelectedIndex(1)
	end
end

function SummerThemeActivityLayer:_onShowUIClick()
	if self.m_hideUIController:getSelectedIndex() == 1 then
		self.m_hideUIController:setSelectedIndex(0)
	end
end

function SummerThemeActivityLayer:_onExploreBtnClick()
	if self._activityState == var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_EXPLORE, {
			themeValue = self._activeThemeValue
		})
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))
	end
end

function SummerThemeActivityLayer:_onGameBtnClick()
	local var_41_0 = self.m_themeGameBtn:getController("state"):getSelectedIndex()

	if var_41_0 == var_0_0.BTN_CTRL.NOTOPEN then
		g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

		return
	elseif var_41_0 == var_0_0.BTN_CTRL.END then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		return
	end

	if self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_CARD then
		self:_gotoTurnCard()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.TURN_TABLE then
		self:_gotoTurnTable()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GEM_ELIMINATE then
		self:_gotoGemEliminate()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.PUZZLE then
		self:_gotoPuzzle()
	elseif self._miniGameType == var_0_0.THEME_MINIGAME_TYPE.GUESS then
		self:_goToGuess()
	end
end

function SummerThemeActivityLayer:_gotoTurnCard()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_TURNCARD, {
		themeValue = self._miniGameInfo.miniGameThemeValue
	})
end

function SummerThemeActivityLayer:_gotoTurnTable()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_TURNTABLE, {
		themeValue = self._miniGameInfo.miniGameThemeValue
	})
end

function SummerThemeActivityLayer:_gotoGemEliminate()
	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_GEM_ELIMINATE, {
		themeValue = self._miniGameInfo.miniGameThemeValue
	})
end

function SummerThemeActivityLayer:_gotoPuzzle()
	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_GAME_PUZZLE_MAIN, {
		themeValue = self._miniGameInfo.miniGameThemeValue
	})
end

function SummerThemeActivityLayer:_goToGuess()
	g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_GAME_GUESS_MAIN, {
		themeValue = self._miniGameInfo.miniGameThemeValue
	})
end

function SummerThemeActivityLayer:_onShopBtnClick()
	local var_47_0 = self:_getEntranceData()

	if not var_47_0:isMergedShopOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_47_1 = g.core.model.User.themeData
	local var_47_2 = var_47_0:getActivityThemeValueList()

	for iter_47_0, iter_47_1 in ipairs(var_47_2) do
		var_47_1:redDoNewThemeShopOpen(iter_47_1)
	end

	g.core.sound.SoundManager:playSound(var_0_7.Sound.UI_EVENT_CARDSTART_01)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_SHOP, {
		themeValue = self._activeThemeValue,
		activityValues = var_47_2
	})
end

function SummerThemeActivityLayer:_onTaskBtnClick()
	local var_48_0 = self:_getEntranceData()

	if not var_48_0:isMergedTaskOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_48_1

	if var_0_0.THEME_VALUE.GOLDENDANCE == self._activeThemeValue then
		g.core.sound.SoundManager:playSound(var_0_7.Sound.UI_WUZHUANG_GETMENUSLIDE)

		var_48_1 = {
			themeValue = self._activeThemeValue
		}
	end

	var_48_1.activityValues = var_48_0:getActivityThemeValueList()

	g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_TASK, var_48_1)
end

function SummerThemeActivityLayer:_onBossBattleBtnClick()
	if not self:_getEntranceData():isMergedBossEntryOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_49_0 = var_0_1:getThemeMergeConfigValueList(self._activeThemeValue)

	if #var_49_0 <= 1 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_BOSS_WAR, {
			themeValue = self._activeThemeValue
		})
		var_0_1:getThemeData(self._activeThemeValue):getBossData():redDoBossNewPhase()
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.mergeTheme.SummerThemeBossSelectLayer").new({
			activityValues = var_49_0,
			activeThemeValue = self._activeThemeValue
		})))
	end
end

function SummerThemeActivityLayer:_onThemeDungeonBtnClick()
	if self._activityState == var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_DUNGEON, {
			themeValue = self:_getOpenThemeValue()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

local var_0_9 = 1
local var_0_10 = 2

function SummerThemeActivityLayer:_initJumpList()
	if not self.m_jumpList then
		return
	end

	self._jumpListData = {}

	for iter_51_0, iter_51_1 in ipairs((var_0_1:getThemeMergeConfigValueList(self._activeThemeValue))) do
		local var_51_0 = var_0_1:getActivityData(iter_51_1)
		local var_51_1 = var_51_0 and var_51_0:getActivityState()

		if var_51_1 == var_0_2.ACTIVITY_STATE.START or var_51_1 == var_0_2.ACTIVITY_STATE.END or var_51_1 == var_0_2.ACTIVITY_STATE.EXPIRE then
			local var_51_2 = var_0_4.get(iter_51_1)

			if var_51_2.recruit_knight and var_51_2.recruit_knight > 0 then
				table.insert(self._jumpListData, {
					type = var_0_9,
					recruitKnight = var_51_2.recruit_knight,
					routeId = var_51_2.recruit_route,
					themeValue = iter_51_1
				})
			end

			if var_51_2.skin_id and var_51_2.skin_id > 0 then
				table.insert(self._jumpListData, {
					type = var_0_10,
					skinId = var_51_2.skin_id,
					themeValue = iter_51_1
				})
			end
		end
	end

	table.sort(self._jumpListData, function(arg_52_0, arg_52_1)
		return arg_52_0.type < arg_52_1.type
	end)

	local var_51_3 = false

	for iter_51_2, iter_51_3 in ipairs(self._jumpListData) do
		if iter_51_3.type == var_0_9 then
			var_51_3 = true

			break
		end
	end

	if var_51_3 and not self._holdingRecruitPkg then
		self._holdingRecruitPkg = true

		if g.core.module.ModuleManager:checkPackageEnable() then
			g.core.module.ModuleManager:checkPackage("recruit", 1)
		else
			fgui.UIPackage:addPackage("ui/recruit/recruit")
		end
	end

	self.m_jumpList:setVisible(#self._jumpListData > 0)
	self.m_jumpList:setNumItems(#self._jumpListData)
end

function SummerThemeActivityLayer:onRemoved()
	if self._holdingRecruitPkg and g.core.module.ModuleManager:checkPackageEnable() then
		self._holdingRecruitPkg = false

		g.core.module.ModuleManager:checkPackage("recruit", -1)
	end
end

function SummerThemeActivityLayer:_onJumpListItemRender(arg_54_1, arg_54_2)
	if not self._jumpListData[arg_54_1 + 1] then
		return
	end

	if self._jumpListData[arg_54_1 + 1].type == var_0_9 then
		local var_54_0 = g.core.model.User.recruitData:getDisplayInfoById(self._jumpListData[arg_54_1 + 1].recruitKnight)

		if var_54_0 then
			arg_54_2:setTitle(var_54_0.cfg.name)
			arg_54_2:setIcon("ui://recruit/" .. var_54_0.cfg.icon .. "2")
		end
	elseif self._jumpListData[arg_54_1 + 1].type == var_0_10 then
		local var_54_1 = g.core.config.skin_info.get(self._jumpListData[arg_54_1 + 1].skinId)

		if var_54_1 then
			arg_54_2:setTitle(var_54_1.name)
			arg_54_2:setIcon("ui://summerTheme/icon_pifutubiao_1")
		end
	end
end

function SummerThemeActivityLayer:_onJumpListClick(arg_55_1)
	local var_55_0 = self._jumpListData and self._jumpListData[arg_55_1:getDataValue() + 1]

	if not var_55_0 then
		return
	end

	local var_55_1 = var_0_1:getActivityData(var_55_0.themeValue)

	if (var_55_1 and var_55_1:getActivityState()) ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	if var_55_0.type == var_0_9 then
		g.view.entrance.ModuleGotoProxy:gotoModule(var_55_0.routeId)
	elseif var_55_0.type == var_0_10 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN,
			selectedContentSkinId = var_55_0.skinId
		})
	end
end

function SummerThemeActivityLayer:_onThemeGiftBtnClick()
	local var_56_0

	if self._activityState ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		do return end

		var_56_0 = {
			shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT
		}
	end

	var_56_0.shopValue = g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_THEME

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, var_56_0)
end

function SummerThemeActivityLayer:_onThemeRecruitBtnClick()
	if self._activityState ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		return
	end

	if self._recruitRouteId and self._recruitRouteId > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._recruitRouteId)
	end
end

function SummerThemeActivityLayer:_onThemeSkinBtnClick()
	local var_58_0

	if self._activityState ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		do return end

		var_58_0 = {}
	end

	var_58_0.shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.RECHARGE_SKIN
	var_58_0.selectedContentSkinId = self._displayInfo.skin_id

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, var_58_0)
end

function SummerThemeActivityLayer:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)

	if self._cdScheduler then
		self:cancelSchedule(self._cdScheduler)

		self._cdScheduler = nil
	end

	self.m_movieComp:removeAllCriSprite()
end

function SummerThemeActivityLayer:_onThemeBioBtnClick()
	if self._activityState ~= var_0_2.ACTIVITY_STATE.START then
		g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

		return
	end

	local var_60_0 = var_0_1:getThemeData(self._activeThemeValue)

	if var_60_0 then
		local var_60_1 = var_60_0:getThemeBioData():getThemeBioStartTime()

		if var_0_3:getTime() < var_60_1 then
			local var_60_2, var_60_3, var_60_4, var_60_5 = var_0_3:getLeftTimeParts(var_60_1)

			if var_60_2 == 0 and (var_60_3 > 0 or var_60_4 > 0 or var_60_5 > 0) then
				g.core.module.ModuleManager:tip(g.core.lang:get(405709))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(405710, {
					time = var_60_2
				}))
			end

			return
		end
	end

	self:_playOutTransition()

	if self._activeThemeValue == var_0_0.THEME_VALUE.AKIRA then
		self:addPopup(require("app.view.module.themeBio.view.ThemeBioChapterChooseLayer").new({
			themeValue = self._activeThemeValue
		}), {
			isUpdateBlack = false
		})
	elseif self._activeThemeValue == var_0_0.THEME_VALUE.GOLDENDANCE then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_CHAPTER, {
			themeValue = self._activeThemeValue
		})
	elseif self._activeThemeValue == var_0_0.THEME_VALUE.ANUBIS then
		g.core.module.ModuleManager:pushModule(g.view.entrance.THEME_BIO_CHAPTER, {
			themeValue = self._activeThemeValue
		})
	else
		self:addPopup(require("app.view.module.themeBio.view.ThemeBrownBioChapterChooseLayer").new({
			themeValue = self._activeThemeValue
		}), {
			isUpdateBlack = false
		})
	end
end

function SummerThemeActivityLayer:_onExitChapters()
	self:_playInTransition()
end

function SummerThemeActivityLayer:_playOutTransition()
	local var_62_0 = self:getTransition("out")

	if var_62_0 then
		var_62_0:play()
	end
end

function SummerThemeActivityLayer:_playInTransition()
	local var_63_0 = self:getTransition("in")

	if var_63_0 then
		var_63_0:play()
	end
end

return SummerThemeActivityLayer
