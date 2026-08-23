local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.network.GameNetProxy
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local var_0_6 = g.core.sound.SoundManager
local var_0_7 = g.core.const.ConstMgr.SoundConst
local var_0_8 = g.core.model.User.commanderWorldData
local var_0_9 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldMainLayer = class("CommanderWorldMainLayer", require("app.fairyGUI.commanderWorld.UI_CommanderWorldMainLayer"), function()
	return fgui.GComponent:create({
		resName = "CommanderWorldMainLayer",
		pkgPath = "ui/commanderWorld/commanderWorld",
		isFullScreen = true,
		pkgName = "commanderWorld"
	}, ...)
end)

function CommanderWorldMainLayer:ctor()
	self._needFullBom = true
	self._curStage = var_0_9.STAGE.LOCALSERVICE
	self._startLevel = 0
	self._bonusPos = self.m_bonusHolder:getPosition()
	self._endPos = self.m_mainHolder:getPosition()
	self._cdHandler = nil
	self._startPos = {
		self.m_donateHolder1:getPosition(),
		(self.m_donateHolder2:getPosition())
	}
	self._flyItemPool = NodePool.new(self, "commanderWorld", "CommanderWorldItemComp", 15)

	self:_initListener()
	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.COMMANDER_WORLD)
end

function CommanderWorldMainLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_9.TOP_BAR_ID)
	self.m_lowDonateComp:updateDonateComp()
	self.m_premiumDonateComp:updateDonateComp()
	self.m_statusScreen:setVisible(true)
	self.m_marsRankBtn:setVisible(false)
end

function CommanderWorldMainLayer:_initListener()
	self:addListen(self.m_lowDonateComp)
	self:addListen(self.m_premiumDonateComp)
	self:addListen(self.m_rankComp)
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_marsRankBtn:addClickListener(handler(self, self._onClickMarsRankBtn))
	self.m_marsRankBtn2:addClickListener(handler(self, self._onClickMarsRankBtn))
	self.m_statusScreen:addClickListener(handler(self, self._onClickScreen))
end

function CommanderWorldMainLayer:_updateViewAfterDonate(arg_5_1)
	self.m_lowDonateComp:updateDonateComp()
	self.m_premiumDonateComp:updateDonateComp()
	self.m_progComp:updateSvrProgress({
		level = arg_5_1.guild_level,
		score = arg_5_1.guild_score
	})
	self.m_rankComp:updateRankComp()
	self.m_mainComp:playBallAnim()
end

function CommanderWorldMainLayer:_sendProgress(arg_6_1)
	g.core.network.GameNetProxy:send_C2S_OrderWorld_Donate({
		item_id = arg_6_1.itemId,
		num = arg_6_1.num or 1
	})
end

function CommanderWorldMainLayer:_addProgress(arg_7_1)
	local var_7_0 = arg_7_1.num or 1

	self.m_progComp:updateProgress({
		addScore = var_0_8:getItemAddScoreByItemId(arg_7_1.itemId).guildScore * var_7_0
	})
end

function CommanderWorldMainLayer:_pressAddProgress(arg_8_1, arg_8_2)
	self.m_progComp:updateProgress({
		addScore = var_0_8:getItemAddScoreByItemId(arg_8_1.itemId).guildScore * arg_8_1.num
	}, arg_8_2)
end

function CommanderWorldMainLayer:_playAddAnim(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_8:getItemAddScoreByItemId(arg_9_2.itemId)

	local function var_9_1()
		self:_sendProgress(arg_9_2)
	end

	if arg_9_1 == "Add_Item_1" then
		self:_playFlyToAnim(arg_9_2.itemIndex, var_9_0, handler(self, self._playDonateOneAnim), var_9_1)
		var_0_6:playSound(var_0_7.Sound.UI_Event_Wuqi_ClickSingle)
	elseif arg_9_1 == "Press_Add" then
		self:_playFlyToAnim(arg_9_2.itemIndex, var_9_0, handler(self, self._playPressDonateOneAnim))

		if not self._isPlaying then
			var_0_6:playSound(var_0_7.Sound.UI_Event_Wuqi_ClickMult)

			self._isPlaying = true
		end
	elseif arg_9_1 == "Press_Add_Item" then
		self:_playPressEndAnim(handler(self, var_9_1))
	end
end

function CommanderWorldMainLayer:_playDonateOneAnim()
	if self._needFullBom then
		self.m_mainComp:playDonateAnim()
	end
end

function CommanderWorldMainLayer:_playPressDonateOneAnim()
	if self._needFullBom then
		self.m_mainComp:playPressDonateAnim()
	end
end

function CommanderWorldMainLayer:_playPressEndAnim(arg_13_1)
	self.m_mainComp:playPressEndAnim()
	var_0_6:playSound(var_0_7.Sound.UI_Event_Wuqi_ClickMult_Stop)

	self._isPlaying = nil

	arg_13_1()
end

function CommanderWorldMainLayer:_playFlyToAnim(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = fgui.UIPackage:createObject("commanderWorld", "CommanderWorldItemComp")

	self:addChild(var_14_0)
	var_14_0:updateView((g.core.common.Goods:convert({
		type = var_0_9.DONATE_ITEM_TYPE,
		value = var_0_9.DONATE_ITEM_ID[arg_14_1]
	})))
	var_14_0:playFlyAnim({
		startPos = self._startPos[arg_14_1],
		endPos = self._endPos,
		flyCallback = arg_14_3,
		sendCallback = arg_14_4,
		removeCallback = function()
			self._flyItemPool:recoveryCompInPool(var_14_0)
		end,
		flyType = arg_14_1 == 2 and 2 or ""
	})
end

function CommanderWorldMainLayer:_playBonusCell(arg_16_1)
	local var_16_0 = fgui.UIPackage:createObject("commanderWorld", "CommanderWorldBonusCell")

	self:addChild(var_16_0)
	var_16_0:updateView({
		good = g.core.common.Goods:convert(g.core.utils.Tools.mergeAwardList(arg_16_1.awards)[1]),
		addScore = arg_16_1.num * var_0_8:getItemAddScoreByItemId(arg_16_1.item_id).guildScore
	})
	var_16_0:setPosition(self._bonusPos)
	var_16_0:playAnim()
end

function CommanderWorldMainLayer:receiveCompEvent(arg_17_1, arg_17_2)
	self._needFullBom = not var_0_8:isMaxLevel()

	if arg_17_1 == "Press_Add_Item" then
		self:_playAddAnim(arg_17_1, arg_17_2, true)
	elseif arg_17_1 == "Add_Item_1" then
		self:_addProgress(arg_17_2, false)
		self:_playAddAnim(arg_17_1, arg_17_2, true)
	elseif arg_17_1 == "Press_Add" then
		self:_pressAddProgress(arg_17_2, true)
		self:_playAddAnim(arg_17_1, arg_17_2)
	elseif arg_17_1 == "Change_ServerType" then
		self.m_donateRecord:updateRecord(self.m_rankComp:getServerType())
	elseif arg_17_1 == "receive_level_up_reward" then
		self.m_mainComp:playGetLevelUpRewardAnim()
	end
end

function CommanderWorldMainLayer:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_INFO, handler(self, self._onS2COrderWorldInfo), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_DONATE, handler(self, self._onS2COrderWorldDonate), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_GUILDNOTIFY, handler(self, self._onS2COrderWorldGuildNotify), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_RECORD_BROADCAST, handler(self, self._onS2COrderWorldRecordBroadcast), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_GUILDALLAWARD, handler(self, self._onS2CGetLevelAwards), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_NOTIFYRANK, handler(self, self._onS2COrderWorldNotifyRank), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onS2CGetCommonRankList), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onUpdateSnap), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_OPTABUSER, handler(self, self._onS2COrderWorldOPTabUser), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._updateDonateComp, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RECHARGE_AWARD, self._updateDonateComp, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_GETSERVERINFOS, self._updateRecordComp, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ORDER_WORLD_TASKAWARD, self._updateDonateComp, self)
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_sendGetInfo()
	self:_refreshRedPoint()
	self.m_enterTransition:play()
	var_0_6:playMusic(var_0_7.BGM.Music_Wuqi_Menu)
end

function CommanderWorldMainLayer:_refreshRedPoint()
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lowDonateComp,
		customData = {
			itemValue = 88
		}
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_premiumDonateComp,
		customData = {
			itemValue = 89
		}
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn
	})
end

function CommanderWorldMainLayer:_sendGetInfo()
	var_0_4:send_C2S_OrderWorld_Info({})
	var_0_4:send_C2S_OrderWorld_GetServerInfos({})
	var_0_4:send_C2S_GetCommonRankList({
		size = 10,
		id = var_0_9.RANKTYPE.LOCALSERVICERANK
	})
	var_0_4:send_C2S_GetCommonRankList({
		size = 20,
		id = var_0_9.RANKTYPE.CROSSSERVICERANK
	})
	var_0_4:send_C2S_OrderWorld_OpTabUser({
		Op = 0
	})
end

function CommanderWorldMainLayer:onUnload()
	var_0_4:send_C2S_OrderWorld_OpTabUser({
		Op = 1
	})
end

function CommanderWorldMainLayer:_updateDonateComp()
	self.m_lowDonateComp:updateDonateComp()
	self.m_premiumDonateComp:updateDonateComp()
end

function CommanderWorldMainLayer:_onS2COrderWorldInfo(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self:_refreshRedPoint()
	self.m_lowDonateComp:updateDonateComp()
	self.m_premiumDonateComp:updateDonateComp()
	self.m_progComp:setCurLevel(arg_23_4.guild_level)
	self.m_progComp:setProgress({
		level = arg_23_4.guild_level,
		score = arg_23_4.guild_score
	})
	self.m_progComp:setNoGuildView()
	self.m_donateRecord:updateRecord(self.m_rankComp:getServerType())

	local var_23_1

	self._curStage, var_23_1 = var_0_8:getActivityStageAndRemainTime()

	self:_setCountDown()

	self._cdHandler = self._cdHandler or self:newSchedule(handler(self, function()
		self:_setCountDown()
	end), 1)

	self.m_rankComp:updateTab()
	self.m_stageController:setSelectedIndex(self._curStage)
	self.m_btnCtrlController:setSelectedIndex(self._curStage == var_0_9.STAGE.REWARDDAY and 1 or 0)

	self._guildId = g.core.model.User:getGuildId()

	self.m_statusScreen:setVisible(self._curStage == var_0_9.STAGE.REWARDDAY or self._guildId == 0)
end

function CommanderWorldMainLayer:_setCountDown()
	local var_25_1

	self._curStage, var_25_1 = var_0_8:getActivityStageAndRemainTime()

	self.m_timeTxt:setText(var_25_1 > 86400 and var_0_0:getLeftDHFormat(var_0_0:getTime() + var_25_1) or var_0_0:getLeftHMFormat(var_0_0:getTime() + var_25_1))
end

function CommanderWorldMainLayer:_updateRecordComp()
	self.m_donateRecord:updateRecord(self.m_rankComp:getServerType())
end

function CommanderWorldMainLayer:_onS2COrderWorldDonate(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self:_playBonusCell(arg_27_4)
	self:_updateViewAfterDonate(arg_27_4)
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lowDonateComp,
		customData = {
			itemValue = 88
		}
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_premiumDonateComp,
		customData = {
			itemValue = 89
		}
	})
end

function CommanderWorldMainLayer:_onS2COrderWorldGuildNotify(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	if arg_28_4 then
		self.m_progComp:setProgress({
			level = arg_28_4.level,
			score = arg_28_4.score
		})
	end
end

function CommanderWorldMainLayer:_onS2COrderWorldRecordBroadcast(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	self.m_donateRecord:updateRecord(self.m_rankComp:getServerType())
end

function CommanderWorldMainLayer:_onS2CGetLevelAwards(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	if arg_30_4 and arg_30_4.awards then
		var_0_3:awardSummary(arg_30_4.awards, nil, nil, nil, handler(self, self._refreshAnimStatusAfterGetReward))
	end
end

function CommanderWorldMainLayer:_refreshAnimStatusAfterGetReward()
	self.m_progComp:playHasAwardAnim()
	self.m_mainComp:playBallAnim()
end

function CommanderWorldMainLayer:_onS2COrderWorldNotifyRank(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	self:_refreshMarsRankBtn()
	self.m_rankComp:updateRankComp()
end

function CommanderWorldMainLayer:_onS2CGetCommonRankList(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self:_refreshMarsRankBtn()
	self.m_rankComp:updateRankComp()
end

function CommanderWorldMainLayer:_onUpdateSnap()
	g.core.model.User.commanderWorldData:updateMarsRankInfo()
	self:_refreshMarsRankBtn()
	self.m_rankComp:updateRankComp()
end

function CommanderWorldMainLayer:_refreshMarsRankBtn()
	self._curStage = var_0_8:getActivityStageAndRemainTime()

	if self._curStage == var_0_9.STAGE.LOCALSERVICE then
		self.m_marsRankBtn:setVisible(false)
	elseif self._curStage == var_0_9.STAGE.CROSSSERVICE then
		self._marsList = var_0_8:getCommanderMarsRankInfo(var_0_9.SERVER_TYPE.LOCAL)

		self.m_marsRankBtn:setVisible(#self._marsList > 0 and var_0_8:isJoinGuildBefore(var_0_9.STAGE.CROSSSERVICE))
	else
		self._marsList = var_0_8:getCommanderMarsRankInfo(var_0_9.SERVER_TYPE.CROSS)

		self.m_marsRankBtn2:setVisible((#self._marsList > 0 or #var_0_8:getCommanderMarsRankInfo(var_0_9.SERVER_TYPE.LOCAL) > 0) and var_0_8:isJoinGuildBefore(var_0_9.STAGE.REWARDDAY))
	end
end

function CommanderWorldMainLayer:_onS2COrderWorldOPTabUser(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	return
end

function CommanderWorldMainLayer:_onCrossDayUpdate()
	if not var_0_8:checkActivityOpen() then
		var_0_3:tip(g.core.lang:get(410311))
		var_0_3:onlyPopSelfByDisplay(self)

		return
	end

	g.core.network.GameNetProxy:send_C2S_OrderWorld_Info({})
	var_0_4:send_C2S_GetCommonRankList({
		size = 15,
		id = var_0_9.RANKTYPE.LOCALSERVICERANK
	})
	var_0_4:send_C2S_GetCommonRankList({
		size = 20,
		id = var_0_9.RANKTYPE.CROSSSERVICERANK
	})
end

function CommanderWorldMainLayer:_onClickShopBtn()
	if var_0_8:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_SHOP)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

function CommanderWorldMainLayer:_onClickTaskBtn()
	if var_0_8:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_TASK)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

function CommanderWorldMainLayer:_onClickGiftBtn()
	if var_0_8:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_GIFT)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

function CommanderWorldMainLayer:_onClickRankBtn()
	if var_0_8:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_RANK)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

function CommanderWorldMainLayer:_onClickMarsRankBtn()
	if var_0_8:isProcess() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.COMMANDER_MARS_RANK)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(410308))
	end
end

function CommanderWorldMainLayer:_onClickScreen()
	local var_43_0 = {
		title = g.core.lang:get(1257),
		onConfirm = handler(self, function()
			self.m_statusScreen:setVisible(false)
		end),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037)
	}

	if self._guildId == 0 and self._curStage == var_0_9.STAGE.REWARDDAY then
		var_43_0.desc = g.core.lang:get(410318)
	elseif self._guildId == 0 then
		var_43_0.desc = g.core.lang:get(410319)
	elseif self._curStage == var_0_9.STAGE.REWARDDAY then
		var_43_0.desc = g.core.lang:get(410315)
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_43_0)))
end

return CommanderWorldMainLayer
