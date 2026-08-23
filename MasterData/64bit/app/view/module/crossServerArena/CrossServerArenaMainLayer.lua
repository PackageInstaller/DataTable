local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.crossServerArenaData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.const.ConstMgr.SpineConst
local var_0_5 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_6 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_7 = g.core.const.ConstMgr.ShopConst
local var_0_8 = g.core.module.ModuleManager
local var_0_9 = g.core.model.User
local var_0_10 = g.core.model.User.mulFormationData
local var_0_11 = g.core.common.Goods
local var_0_12 = g.core.common.Path
local var_0_13 = g.core.const.ConstMgr.LineUpConst
local var_0_14 = g.core.network.GameNetProxy
local var_0_15 = g.core.const.ConstMgr.LineUpConst.MulTeamType.CROSS_SERVER_ARENA

local function var_0_16(arg_1_0)
	return arg_1_0 + 1
end

local CrossServerArenaMainLayer = class("CrossServerArenaMainLayer", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "crossServerArena",
		isFullScreen = true,
		pkgPath = "ui/crossServerArena/crossServerArena",
		resName = "CrossServerArenaMainLayer"
	}, ...)
end)

function CrossServerArenaMainLayer:ctor()
	self._newlyCreated = true
	self._myRank = 0
	self._curSelectIndex = 1
	self._needPlayRankUp = false

	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)

	self._seasonStatus = nil
	self._sweepPopBuy = false
	self._mulFormationStruct = nil
	self._mulFormationDict = nil
	self._inWaitState = true
	self._targetGroup = 0

	self:_initListView()
	self:_addBtnClick()
	self:_initView()
	self.m_challengeListComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_3.FUNCTION_TYPE.CROSS_SERVER_ARENA)
end

function CrossServerArenaMainLayer:_onTouchBegin(arg_4_1)
	self._sweepPopBuy = false
end

function CrossServerArenaMainLayer:_onEnterAnimEnd()
	self:_showAdditionComp()

	if self._inWaitState then
		-- block empty
	end
end

function CrossServerArenaMainLayer:onLoad()
	local var_6_0 = var_0_2:getSeasonStatus()

	if var_6_0 ~= var_0_5.CTRL_ON_SEASON and var_6_0 ~= var_0_5.CTRL_OFF_SEASON then
		var_0_8:tip(g.core.lang:get(411014))
		self:newScheduleOnce(function()
			var_0_8:switchModuleIntelligent(g.view.entrance.HOME)
		end)

		return
	end

	self.m_robotHolder:removeChildren()
	self.m_lineupHolder:removeChildren()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CHIEF_ARENA_GETINFO, self._onCSArenaGetMainInfo, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_GET, self._onS2CFormationGet, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CHIEF_ARENA_GETRANKLIST, self._onS2CArenaGetRankList, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_1:addEventListener(var_0_0.CROSS_SERVER_ARENA_GUIDE_FORMATION, self._checkTipsGuideFormation, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onCSArenaGetMainInfo), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CHIEF_ARENA_ONEKEYCHALLENGE, self._onOneKeyChallenge, self)
	var_0_14:send_C2S_ChiefArena_GetInfo({})
	var_0_14:send_C2S_Formation_Get({
		tp = var_0_15
	})
	var_0_14:send_C2S_GetModuleTaskInfo({
		module_id = var_0_3.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	})
	var_0_14:send_C2S_ChiefArena_GetServerInfos({})
	var_0_14:send_C2S_ChiefArena_GuildHonorRank({})

	if var_6_0 == var_0_5.CTRL_OFF_SEASON then
		var_0_14:send_C2S_ChiefArena_GetRankList({})
	end

	if not var_0_10:isInitWithSvrData(var_0_15) then
		var_0_14:send_C2S_Formation_Get({
			tp = var_0_15
		})
	else
		self._mulFormationDict = var_0_10:getFormationStructDict(var_0_15)

		self:initRedEvent()
	end

	if self._needPlayRankUp then
		self:_playRankUp()
	end

	self:_checkTipsGuideAddition()
	self:_initMyInfo()
	self:_updateView()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP)
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_guildRankBtn
	})
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_aidBtn
	})
end

function CrossServerArenaMainLayer:onUnload()
	var_0_1:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function CrossServerArenaMainLayer:initRedEvent()
	if var_0_2:getSeasonStatus() == var_0_5.CTRL_OFF_SEASON then
		return
	end

	for iter_9_0 = 1, 3 do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self["m_selectBtn" .. iter_9_0]:getChild("redPointComp"),
			customData = {
				group = 0,
				formationType = var_0_13.MulTeamType.CROSS_SERVER_ARENA,
				formationIndex = iter_9_0
			}
		})
	end
end

function CrossServerArenaMainLayer:_showSeasonPop()
	local var_10_0 = var_0_2:getSeasonInfo()

	if not var_10_0 then
		if self._inWaitState then
			self._inWaitState = false

			var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
		end

		return
	end

	local var_10_1 = var_0_2:getSeasonStatus()
	local var_10_2 = var_10_1 == var_0_5.CTRL_OFF_SEASON

	if not var_0_2:checkSeasonPopStatus(var_10_0.term, var_0_5.JSON_SEASON_STATUS_START) and var_10_1 == var_0_5.CTRL_ON_SEASON then
		var_0_8:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaSeasonPop").new({
			seasonInfo = var_10_0,
			seasonStatus = var_10_1
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	elseif not var_0_2:checkSeasonPopStatus(var_10_0.term, var_0_5.JSON_SEASON_STATUS_END) and var_10_2 then
		var_0_8:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaSeasonPop").new({
			seasonInfo = var_10_0,
			seasonStatus = var_10_1,
			rank = var_0_2:getCurRank()
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	elseif self._inWaitState then
		self._inWaitState = false

		var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end

	self:_checkTipsGuide()
end

function CrossServerArenaMainLayer:_addBtnClick()
	self.m_rankBtn:addClickListener(handler(self, self._onRankClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskClick))
	self.m_lineUpBgLoader:addClickListener(handler(self, self._onLineUpClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onLineUpClick))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_serverTipBtn:addClickListener(handler(self, self._onClickTipBtn))
	self.m_guildRankBtn:addClickListener(handler(self, self._onClickGuildRankBtn))
	self.m_aidBtn:addClickListener(handler(self, self._onClickAidBtn))
	self.m_skipFormationBtn:addClickListener(handler(self, self._onClickSkipFormation))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
end

function CrossServerArenaMainLayer:_initListView()
	self.m_lineupList:setVirtual()
	self.m_lineupList:setItemRenderer(handler(self, self._onRenderLineUpList))
end

function CrossServerArenaMainLayer:_initView()
	self:addBg("bg/arena/bg_jjc_zhujiemian.jpg")
	self.m_topBarComp:setResInfoById(var_0_5.TOP_BAR_MAIN_LAYER)
	self.m_deployWordLoader:setURL("ui://text_new/txt_jjc_zhenrong")
	self.m_seasonTimeTxt:setText((var_0_2:getDurationString()))

	local var_13_0 = var_0_2:getSeasonStatus()

	self._seasonStatus = var_13_0

	if var_13_0 == var_0_5.CTRL_ON_SEASON then
		self.m_seasonTxt:setText(g.core.lang:get(411003, {
			num = var_0_2:getSeasonInfo().term
		}))
		self.m_matchServerGroup:setVisible(true)
	elseif var_13_0 == var_0_5.CTRL_OFF_SEASON then
		self.m_seasonTxt:setText(g.core.lang:get(411012))
		self.m_matchServerGroup:setVisible(false)
	elseif var_13_0 == var_0_5.CTRL_NONE_SEASON then
		var_0_8:tip(g.core.lang:get(411014))
		var_0_8:popToRoot()
	end

	self:_initMyInfo()
end

function CrossServerArenaMainLayer:_initMyInfo()
	self.m_knightPicComp:updateKnight({
		scale = 0.9,
		resId = var_0_9:getAssistantResInfo().painted_id
	})
	self.m_knightPicComp:setAlphaRect(var_0_4.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
	self:_updateLineupList()
end

function CrossServerArenaMainLayer:_updateView()
	self.m_skipFormationController:setSelectedIndex(var_0_2:isSkipFormation() and 1 or 0)

	local var_15_0 = var_0_2:getCurRank()

	if var_15_0 > 0 then
		self.m_myRankText:setText(var_15_0)
		self.m_myRankText:setVisible(true)
		self.m_noRankTxt:setVisible(false)
	else
		self.m_myRankText:setVisible(false)
		self.m_noRankTxt:setVisible(true)
		self.m_noRankTxt:setText(g.core.lang:get(302501))
	end

	self.m_challengeListComp:updateView()

	if var_0_2:getEnterBattleStatus() then
		self._needPlayRankUp = true
	end

	if self._newlyCreated then
		self._newlyCreated = false

		if not var_0_2:getEnterBattleStatus() then
			self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
			self.m_challengeListComp:playRollAni()
			var_0_2:setEnterBattleStatus(false)
		end
	end

	self.m_challengesNumComp:initView({
		playNum = 1,
		getTimesFunc = function()
			return var_0_9.shopData:getLeftCount(var_0_5.BUY_TIMES_ID) or 0
		end,
		fullTime = var_0_5.BUY_MAX_TIMES,
		onGetTimes = handler(self, self._onClickBuy),
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})

	local var_15_1 = var_0_2:getBuffInfo()

	if var_15_1 then
		local var_15_2, var_15_3 = var_0_2:getBuffGroupAndTalentSkillInfo(var_15_1.buff)

		self.m_buffGroupController:setSelectedIndex(var_15_2)

		self._targetGroup = var_15_2

		self:addBg(var_0_12:getChiefArenaBg(var_15_1.pic))
		self.m_buffTxt:setText(g.core.lang:get(411033, {
			name = var_15_3.name,
			num = var_15_3.affect_value_1 / 10
		}))
	end

	if g.core.model.User:getGuildId() > 0 then
		local var_15_4 = var_0_2:getGuildRank()

		self.m_guildRankStatusController:setSelectedIndex((var_15_4 > 0 or nil) and (var_0_5.GUILD_STATE.HAS_RANK or var_0_5.GUILD_STATE.NO_RANK))
		self.m_isTop3Controller:setSelectedIndex(var_15_4 <= 3 and 1 or 0)
		self.m_topGuildRank:updateRankIndex({
			rank = var_15_4
		})
		self.m_guildRankText:setText(var_15_4)
	else
		self.m_guildRankStatusController:setSelectedIndex(var_0_5.GUILD_STATE.NO_GUILD)
	end
end

function CrossServerArenaMainLayer:_showAdditionComp()
	if not var_0_2:checkAdditionPop() then
		local var_17_0, var_17_1 = var_0_2:getAddition()

		self.m_additionComp:setVisible(var_17_0)
		self.m_additionComp:playShow(var_17_1)
		var_0_2:saveAdditionPop()
	end
end

function CrossServerArenaMainLayer:_updateLineupList()
	if not self._mulFormationDict then
		return
	end

	self._mulFormationStruct = self._mulFormationDict[self._curSelectIndex] or var_0_10:getFormationStruct(var_0_15, self._curSelectIndex)

	self.m_lineupList:setNumItems(var_0_6.LINEUP_MAX)

	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(self._mulFormationDict) do
		iter_18_1:refreshFixedAttr()

		var_18_0 = var_18_0 + iter_18_1:getFightValue()
	end

	self.m_powerNumText:setText(var_18_0)
end

function CrossServerArenaMainLayer:_onRenderLineUpList(arg_19_1, arg_19_2)
	local var_19_0 = var_0_16(arg_19_1)
	local var_19_1 = self._mulFormationStruct:getKnightSid(var_19_0)

	arg_19_2:updateComp(var_19_0, (var_19_1 and var_19_1 ~= 0 or nil) and {
		scaleIndex = 3,
		sid = var_19_1
	}, nil, false)
end

function CrossServerArenaMainLayer:_onTabSelChanged()
	self._curSelectIndex = var_0_16(self.m_tabSelController:getSelectedIndex())

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_PVP_CLICK)
	self:_updateLineupList()
end

function CrossServerArenaMainLayer:_onLineUpClick()
	if var_0_2:getSeasonStatus() ~= var_0_5.CTRL_ON_SEASON then
		var_0_8:tip(g.core.lang:get(411017))

		return
	end

	var_0_8:pushModule(g.view.entrance.CROSS_SERVER_FORMATION)
end

function CrossServerArenaMainLayer:_onRankClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.CrossServerArenaRankLayer").new(), {
		ignoreTouch = true
	})
end

function CrossServerArenaMainLayer:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.CROSS_SERVER_ARENA
	})
end

function CrossServerArenaMainLayer:_onTaskClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaTaskPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function CrossServerArenaMainLayer:_onClickBuy()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_11.TYPE_ITEM,
		value = var_0_11.ITEM.TYPE_CROSS_SERVER_ARENA_TOKEN,
		shopId = var_0_7.SHOP_ITEM_ID.CROSS_SERVER_ARENA_TOKEN
	}), {
		touchDisappear = true
	})

	self._sweepPopBuy = false
end

function CrossServerArenaMainLayer:_onClickTipBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaMatchServerPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function CrossServerArenaMainLayer:_onClickGuildRankBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.CrossServerArenaGuildRankLayer").new(), {
		ignoreTouch = true
	})
end

function CrossServerArenaMainLayer:_onClickAidBtn()
	if g.core.model.User:getGuildId() > 0 then
		var_0_8:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaSkillPop").new(), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		var_0_8:tip(g.core.lang:get(411037))
	end
end

function CrossServerArenaMainLayer:_onClickSkipFormation()
	var_0_2:setSkipFormationState()
end

function CrossServerArenaMainLayer:_onOneKeyClick()
	if var_0_2:getSeasonStatus() ~= var_0_5.CTRL_ON_SEASON then
		g.core.module.ModuleManager:tip(g.core.lang:get(411040))

		return
	end

	if var_0_2.checkLeftCount() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.crossServerArena.pop.CrossServerArenaOneKeyPop").new()))
	else
		self._sweepPopBuy = true

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_11.TYPE_ITEM,
			value = var_0_11.ITEM.TYPE_CROSS_SERVER_ARENA_TOKEN,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.CROSS_SERVER_ARENA_TOKEN
		}), {
			touchDisappear = true
		})
	end
end

function CrossServerArenaMainLayer:_playRankUp()
	self._needPlayRankUp = false

	var_0_2:setEnterBattleStatus(false)

	local var_31_0 = var_0_2:getCachedRank()
	local var_31_1 = var_0_2:getCurRank()

	if var_31_1 < var_31_0.maxRank then
		local var_31_2 = g.core.battle.BattleShowResult:getLastBattle()

		if var_31_2 and var_31_2.break_awards then
			var_0_8:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaRankUpPop").new({
				curRank = var_31_1,
				oldRank = var_31_0.maxRank,
				break_awards = var_31_2.break_awards
			}), {
				ignoreTouch = true
			})
		end
	end
end

function CrossServerArenaMainLayer:receiveCompEvent(arg_32_1, arg_32_2)
	if arg_32_1 == "continueSweep" then
		self:newScheduleOnce(handler(self, self._onOneKeyClick), 0.5)

		return true
	end
end

function CrossServerArenaMainLayer:_onCSArenaGetMainInfo(arg_33_1, arg_33_2, arg_33_3)
	if var_0_2:isNeedWaitUserSnapshot() then
		return
	end

	self:_updateView()
	self:_showSeasonPop()
end

function CrossServerArenaMainLayer:_onS2CFormationGet()
	self._mulFormationDict = var_0_10:getFormationStructDict(var_0_15)

	self:initRedEvent()
	self:_updateLineupList()
end

function CrossServerArenaMainLayer:_onS2CArenaGetRankList()
	self.m_challengeListComp:updateView()
end

function CrossServerArenaMainLayer:_onCrossDayUpdate()
	if var_0_2:getSeasonStatus() ~= self._seasonStatus then
		var_0_8:tip(g.core.lang:get(411013))
		var_0_8:popToRoot()

		return
	end

	var_0_14:send_C2S_GetModuleTaskInfo({
		module_id = var_0_3.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	})
	var_0_14:send_C2S_ChiefArena_GetInfo({})
	var_0_2:resetGuildReceiveState()
end

function CrossServerArenaMainLayer:_onRcvShopping(arg_37_1, arg_37_2, arg_37_3)
	if self._sweepPopBuy then
		self._sweepPopBuy = false
	else
		return
	end

	local var_37_0 = arg_37_3.awards

	if arg_37_3.awards and var_37_0[1] and var_37_0[1].type == 3 and var_37_0[1].value == 87 then
		self:newScheduleOnce(handler(self, self._onOneKeyClick), 0.5)
	end
end

function CrossServerArenaMainLayer:_onOneKeyChallenge(arg_38_1, arg_38_2, arg_38_3)
	var_0_14:send_C2S_GetModuleTaskInfo({
		module_id = var_0_3.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	})
end

function CrossServerArenaMainLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_2:isNeedGuide() then
		return
	end

	if var_0_2:getSeasonStatus() ~= var_0_5.CTRL_ON_SEASON then
		return
	end

	var_0_1:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "CS_ARENA_ROBOT_GUIDE",
			targetBtn = self.m_robotHolder
		})
	end, 0)
end

function CrossServerArenaMainLayer:_checkTipsGuideFormation()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not var_0_2:isNeedGuide() then
		return
	end

	if var_0_2:getSeasonStatus() ~= var_0_5.CTRL_ON_SEASON then
		return
	end

	var_0_1:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.service.ServiceManager:getServiceByName("GuideService"):reset()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "CS_ARENA_ROBOT_FORMATION",
			targetBtn = self.m_lineupHolder
		})
	end, 0)
end

function CrossServerArenaMainLayer:_checkTipsGuideAddition()
	if var_0_2:isNeedGuide() then
		return
	end

	var_0_1:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)

	if g.core.model.User:getGuildId() > 0 then
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "CS_ARENA_ADDITION",
				targetBtn = self.m_aidBtn
			})
		end)
	end
end

return CrossServerArenaMainLayer
