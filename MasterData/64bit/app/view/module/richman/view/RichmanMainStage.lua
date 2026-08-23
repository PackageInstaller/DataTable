local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.model.User.bagData
local var_0_6 = g.core.config.richman_event_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_9 = g.core.model.User.richmanData
local RichmanMainStage = class("RichmanMainStage", require("app.fairyGUI.richman.UI_RichmanMainStage"), function()
	return fgui.GComponent:create({
		resName = "RichmanMainStage",
		pkgName = "richman",
		isFullScreen = true,
		pkgPath = "ui/richman/richman"
	})
end)

function RichmanMainStage:ctor()
	self.m_diceBtn:addClickListener(handler(self, self._onRiceBtnClick))
	self.m_selDiceNumBtn:addClickListener(handler(self, self._onSelDiceNumBtnClick))
	self.m_autoBtn:addClickListener(handler(self, self._onAutoClick))
	self.m_cancelAutoBtn:addClickListener(handler(self, self._onCancelAutoClick))
	self.m_eventList:setVirtual()
	self.m_eventList:doFairyBatching(false)
	self.m_eventList:setItemRenderer(handler(self, self._onEventItemRenderer))
	self.m_topBar:setReturnCallBack(handler(self, self._onRichmanReturnClick))
	self.m_logBtn:addClickListener(handler(self, self._onLogBtnClick))
	self.m_infoBtn:addClickListener(handler(self, self._onInfoBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_moduleBtn:addClickListener(handler(self, self._onModuleBtnClick))
	self.m_clickIgnoreMask:addClickListener(handler(self, self._onIgnoreMaskClick))

	self._isCrossDay = false

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RICH_MAN)
	self.m_topBar:hidePushGift()
	var_0_9:setInDiceAnim(false)
	self.m_topBar:setResInfoById(333, nil, {
		{
			type = 3,
			value = 124
		}
	})
	self.m_clickIgnoreMask:setVisible(false)
end

function RichmanMainStage:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_GETINFO, self.onRichManGetInfo, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_ROLLDICE, self.onRichManRollDice, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS, self.onRichManEventProcess, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_MAPUPLEVEL, self.onRichManLevelUp, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_ROBDATA, self.changeMapOperaState, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_CONSTRUCTAWARD, self.onRewardBuildItem, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ITEM_USE, self.onRichmanSelDice, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_CONSTRUCTAWARD, self.updateBuildView, self)
	var_0_1:addEventListener(var_0_2.EVENT_GAME_RESUME_FINISH, self.onGameResumeFinish, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_RICH_MAN_ROBBEGIN, self.onRobEventBegin, self)
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self.onCrossDayNotify, self)
	var_0_1:addEventListener(var_0_2.EVENT_RICH_MAN_ROLL_FINISH, self.onRollFinish, self)
	self:_onUpdateRedPoint()
	self:newSchedule(handler(self, self._updateTimeShow), 1)
	self:updateMainView()
	g.core.network.GameNetProxy:send_C2S_RichMan_GetLog({})
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Funny_Story)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function RichmanMainStage:onCrossDayNotify()
	g.core.network.GameNetProxy:send_C2S_RichMan_GetInfo({})

	self._isCrossDay = true
end

function RichmanMainStage:_onUpdateRedPoint()
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_logBtn
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_monsterComp
	})
end

function RichmanMainStage:_onRichmanReturnClick()
	if var_0_9:getCurRobData() then
		var_0_9:clearRobData()
		self:playCloudAnim()
	else
		g.core.module.ModuleManager:popModule()
	end
end

function RichmanMainStage:_onIgnoreMaskClick()
	g.core.module.ModuleManager:tip(g.core.lang:get(426022))
end

function RichmanMainStage:_onRiceBtnClick()
	if not self._initStartPos then
		self._initStartPos = true

		self.m_mapComp:initStartPos(self.m_diceBtn:localToGlobal(cc.p(0, 0)))
	end

	if var_0_9:isInDiceAnim() then
		g.core.module.ModuleManager:tip(g.core.lang:get(426001))

		return
	end

	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE) > 0 then
		g.core.network.GameNetProxy:send_C2S_RichMan_RollDice({})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426002))
	end
end

function RichmanMainStage:onGameResumeFinish()
	var_0_9:clearRobData()
	self:updateMainView()
end

function RichmanMainStage:updateMainView()
	local var_10_0 = var_0_9:getCurRobData()

	if not var_10_0 then
		self.m_stateController:setSelectedIndex(0)
		self:checkAndPlaySelNumDiceEff()
		self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE))
		self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE) > 0)
		self:checkAndPlaySelNumCanUseEff()
		self:checkAndPlayDiceEff()
		self.m_diceBtn:setNum(var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE))
		self:updateEventList()
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_stealComp:updateStealInfo()

		for iter_10_0 = 1, 4 do
			self["m_build" .. iter_10_0]:setTitle("LV." .. var_0_9:getBuildData():getBuildLevelByMapLvAndType(var_10_0.map_level, iter_10_0))
		end
	end

	self.m_levelComp:updateRichmanLvShow()
	self.m_mapComp:updateMapState()
end

function RichmanMainStage:changeMapOperaState(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.construct then
		if arg_11_3.construct.armistice > g.core.common.ServerTime:getTime() then
			return
		end

		if not var_0_9:isIgnoreChangeAnim() then
			self:playCloudAnim()
		end

		for iter_11_0 = 1, 4 do
			self["m_build" .. iter_11_0]:updateBuildIcon()
		end
	end
end

function RichmanMainStage:playCloudAnim()
	local var_12_0, var_12_1 = g.core.common.GlobalFunc.addCommonLoadingComp()

	local function var_12_2()
		var_12_0:removeFromParent()
	end

	var_12_1:setHook("start", handler(self, function()
		self:updateMainView()
	end))
	var_12_1:setHook("end", handler(self, function()
		var_12_2()
	end))
	var_12_1:play()
end

function RichmanMainStage:updateEventList()
	self._eventList = var_0_9:getRightEventList()

	self.m_eventList:setNumItems(#self._eventList)

	if var_0_9:isHasStealEvent() and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_STEAL) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.RICH_MAN_STEAL
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RICH_MAN_FIRST_STEAL)
	end

	self.m_monsterComp:updateMonsterList()
end

function RichmanMainStage:_onSelDiceNumBtnClick()
	if g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE) > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.pop.RichmanSelNumPop").new(), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426003))
	end
end

function RichmanMainStage:onRichManGetInfo(arg_18_1, arg_18_2, arg_18_3)
	self:updateMainView()

	if self._isCrossDay then
		self:_onUpdateRedPoint()

		self._isCrossDay = false
	end
end

function RichmanMainStage:onRichManRollDice(arg_19_1, arg_19_2, arg_19_3)
	var_0_9:setInDiceAnim(true)
	self.m_clickIgnoreMask:setVisible(true)
	self:checkAndPlayDiceEff()
	self.m_diceBtn:setNum(var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE))
	self.m_mapComp:startRich(arg_19_3.dice, handler(self, self.onRollDiceFinish))

	self._RichmanDiceContent = arg_19_3
	self._animedAnimNum = {}

	var_0_9:setNextDice(0)
end

function RichmanMainStage:onRollDiceFinish()
	if self._RichmanDiceContent then
		if self._RichmanDiceContent.awards then
			self:playEventAwardAnim()
		end

		if self._RichmanDiceContent.events then
			for iter_20_0, iter_20_1 in ipairs(self._RichmanDiceContent.events) do
				self.m_mapComp:playTickEventEffect(iter_20_1)
			end
		end

		self._RichmanDiceContent = nil
	end

	self.m_clickIgnoreMask:setVisible(false)
	self:updateMainView()
end

function RichmanMainStage:playEventAwardAnim(arg_21_1)
	if self._RichmanDiceContent and self._RichmanDiceContent.events then
		local var_21_0 = {}
		local var_21_1 = {}
		local var_21_2 = RichmanConst.BUILD_REWARD_SHOW[RichmanConst.EVENT_TYPE.KNIGHT_RESOURCE]

		for iter_21_0, iter_21_1 in ipairs(self._RichmanDiceContent.events) do
			if not self._animedAnimNum[iter_21_1.unique_id .. "_" .. iter_21_1.base_id] and (not arg_21_1 or iter_21_1.tp == arg_21_1) then
				local var_21_3 = var_0_6.get(iter_21_1.base_id).num or 5

				if RichmanConst.BUILD_REWARD_SHOW[iter_21_1.tp] then
					var_21_1.flyNum = var_21_3

					table.insertto(var_21_1, iter_21_1.awards or {})

					var_21_2 = RichmanConst.BUILD_REWARD_SHOW[iter_21_1.tp]
				else
					var_21_0.flyNum = var_21_3

					table.insertto(var_21_0, iter_21_1.awards or {})
				end

				self._animedAnimNum[iter_21_1.unique_id .. "_" .. iter_21_1.base_id] = true
			end
		end

		if next(var_21_0) then
			self.m_mapComp:showPlayerHeardReward(var_21_0)
		end

		if next(var_21_1) then
			self.m_mapComp:showBuildHeardReward(var_21_1, var_21_2)
		end
	end
end

function RichmanMainStage:onRichManEventProcess(arg_22_1, arg_22_2, arg_22_3)
	self._eventList = var_0_9:getRightEventList()

	self.m_eventList:setNumItems(#self._eventList)

	if arg_22_3.battle_id then
		g.core.battle.BattleProxy:enterBattle({
			soundType = 3,
			canSkip = true,
			bgId = 132,
			type = BattleConst.TYPE_RICHMAN_MONSTER,
			battle_id = arg_22_3.battle_id,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVE
		})
	end

	self.m_monsterComp:updateMonsterList()
	self.m_levelComp:updateRichmanLvShow()
	var_0_1:addEventListener(g.core.event.enum.EVENT_BATTLE_SKIP_NOTIFY_REFRESH, handler(self, self.onBattleNotifyRefresh), self)
end

function RichmanMainStage:receiveCompEvent(arg_23_1, arg_23_2)
	if arg_23_1 == "RICH_MAN_PASS_START_GRID" then
		self:playEventAwardAnim(RichmanConst.EVENT_TYPE.START_GRID)
		self:playAwardFlyAnim({
			type = 3,
			value = 110
		}, arg_23_2.worldPos, 1, (self.m_diceBtn:localToGlobal(cc.p(0, 0))))
		self.m_diceBtn:getChild("eff2"):addEffectSpine({
			isLoop = false,
			remove = true,
			name = "eff_ui_richman_number",
			scale = 2,
			anim = "play1"
		})
		self.m_tipComp:setTitle(g.core.lang:get(426028))
		self.m_refreshTipTransition:play()

		return true
	elseif arg_23_1 == "RICH_MAN_SHOW_ICON_EFF" then
		self:newScheduleOnce(handler(self, function(arg_24_0)
			arg_24_0:playAwardFlyAnim(arg_23_2.award, arg_23_2.worldPos, arg_23_2.flyNum)
		end), 0.5)

		return true
	elseif arg_23_1 == "RICH_MAN_MAP_GRID_ERR_PLAY" then
		self.m_tipComp:setTitle(g.core.lang:get(426029))
		self.m_refreshTipTransition:play()

		return true
	elseif arg_23_1 == "RICH_MAN_PAUSE_STEAL" then
		var_0_9:setNeedStealAnim(true)
		self:updateEventList()
	elseif arg_23_1 == "RICH_MAN_PAUSE_MONSTER" then
		var_0_9:setNeedMonsterAnim(true)
		self.m_monsterComp:updateMonsterList()
	end
end

function RichmanMainStage:onRewardBuildItem(arg_25_1, arg_25_2, arg_25_3)
	g.core.module.ModuleManager:awardSummary(arg_25_3.awards)
	self:updateMainView()
end

function RichmanMainStage:onRichmanSelDice(arg_26_1, arg_26_2, arg_26_3)
	var_0_9:setNextDice(arg_26_3.index)
	self:checkAndPlaySelNumDiceEff()
	self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE))
	self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE) > 0)
	self:checkAndPlaySelNumCanUseEff()
end

function RichmanMainStage:checkAndPlayDiceEff()
	if (tonumber(self.m_diceBtn:getChild("numTxt"):getText()) or 999999) < var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE) then
		self.m_diceBtn:getChild("eff2"):addEffectSpine({
			isLoop = false,
			remove = true,
			name = "eff_ui_richman_number",
			scale = 2,
			anim = "play1"
		})
	end
end

function RichmanMainStage:checkAndPlaySelNumDiceEff()
	if (tonumber(self.m_selDiceNumBtn:getChild("numTxt"):getText()) or 999999) < var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_DICE) then
		self.m_diceBtn:getChild("eff2"):addEffectSpine({
			isLoop = false,
			name = "eff_ui_richman_number",
			remove = true,
			anim = "play2"
		})
	end
end

function RichmanMainStage:onRichManLevelUp(arg_29_1, arg_29_2, arg_29_3)
	self.m_levelComp:updateRichmanLvShow()
	self.m_clickIgnoreMask:setVisible(true)
	self.m_mapComp:updateMapState(true, handler(self, self.onRollDiceFinish))
end

function RichmanMainStage:_onEventItemRenderer(arg_30_1, arg_30_2)
	arg_30_2:updateEventShow(self._eventList[arg_30_1 + 1])
end

function RichmanMainStage:_onLogBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.pop.RichmanLogPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function RichmanMainStage:_onInfoBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.pop.RichmanTipsPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function RichmanMainStage:_updateTimeShow()
	local var_33_0 = false
	local var_33_1 = g.core.common.ServerTime:getTime()

	if self._eventList ~= nil then
		for iter_33_0, iter_33_1 in ipairs(self._eventList) do
			if var_33_1 > iter_33_1.list[1].finishTime then
				var_33_0 = true

				break
			end
		end
	end

	if var_33_0 then
		self._eventList = var_0_9:getRightEventList()

		self.m_eventList:setNumItems(#self._eventList)
	else
		for iter_33_2, iter_33_3 in ipairs((self.m_eventList:getChildren())) do
			iter_33_3:refreshEventTime()
		end
	end
end

function RichmanMainStage:updateBuildView()
	return
end

function RichmanMainStage:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.pop.RichmanTaskPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function RichmanMainStage:_onModuleBtnClick()
	local var_36_0, var_36_1 = g.core.common.GlobalFunc.addCommonLoadingComp()

	local function var_36_2()
		var_36_0:removeFromParent()
	end

	var_36_1:setHook("start", handler(self, function()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.TREE_MAIN)
	end))
	var_36_1:setHook("end", handler(self, function()
		var_36_2()
	end))
	var_36_1:play()
end

function RichmanMainStage:onUnload()
	var_0_9:clearRobData()
	var_0_9:setInDiceAnim(false)
	var_0_9:setNeedStealAnim(false)
	var_0_9:setNeedMonsterAnim(false)
end

function RichmanMainStage:onRobEventBegin(arg_41_1, arg_41_2, arg_41_3)
	if arg_41_3.battle_id then
		g.core.battle.BattleProxy:enterBattle({
			soundType = 2,
			canSkip = true,
			bgId = 132,
			type = BattleConst.TYPE_RICHMAN_ROB,
			battle_id = arg_41_3.battle_id,
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVP
		})
	end
end

function RichmanMainStage:playAwardFlyAnim(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	if not arg_42_1 then
		return
	end

	local var_42_0 = arg_42_3 or 5
	local var_42_1 = g.core.common.Goods:convert(arg_42_1)
	local var_42_2 = arg_42_4 or self.m_topBar:getResComWorldPos(arg_42_1)

	if not var_42_2 then
		return
	end

	local var_42_3 = self.m_iconEffHolder:globalToLocal(var_42_2)

	self._flyIndex = 0
	self._iconPlay = nil
	self._flyAward = arg_42_1

	local var_42_4 = self.m_iconEffHolder:globalToLocal(arg_42_2)

	for iter_42_0 = 1, var_42_0 do
		local var_42_5 = fgui.UIPackage:createObject("richman", "RichmanEffLoaderComp")

		var_42_5:setIcon(var_42_1.icon)
		var_42_5:setPosition(var_42_4)
		self.m_iconEffHolder:addChild(var_42_5)

		local var_42_6 = math.random(35, 50) / 100
		local var_42_7 = math.random(35, 45) / 100
		local var_42_8 = {
			fgui.FSpawn:create(fgui.FSpawn:create(fgui.FEaseQuinticActionOut:create(fgui.FMoveBy:create(var_42_6, cc.p(math.random(-200, 200), math.random(-150, 150)))), fgui.FRotateBy:create(var_42_6 + 0.3, math.random(-45, 45))), (fgui.FSequence:create(fgui.FDelayTime:create(var_42_6 - math.random(5, 10) / 100), fgui.FSpawn:create(fgui.FMoveTo:create(var_42_7, var_42_3), fgui.FScaleTo:create(var_42_7, 0.5))))),
			fgui.FCallFunc:create(handler(self, self._onFlyAnimFinish)),
			fgui.FRemoveSelf:create()
		}
		local var_42_9 = {
			["3_120"] = {
				iconPlay = "play2",
				eff = "eff_ui_common_flyBoom2"
			},
			["3_121"] = {
				iconPlay = "play4",
				eff = "eff_ui_common_flyBoom4"
			},
			["3_122"] = {
				iconPlay = "play1",
				eff = "eff_ui_common_flyBoom1"
			},
			["3_123"] = {
				iconPlay = "play3",
				eff = "eff_ui_common_flyBoom3"
			},
			["3_124"] = {
				iconPlay = "play0",
				eff = "eff_ui_common_flyBoom0"
			}
		}

		if var_42_9[arg_42_1.type .. "_" .. arg_42_1.value] then
			self._iconPlay = var_42_9[arg_42_1.type .. "_" .. arg_42_1.value].iconPlay

			self.m_iconEffHolder:addEffectSpine({
				isLoop = false,
				remove = true,
				name = var_42_9[arg_42_1.type .. "_" .. arg_42_1.value].eff,
				x = var_42_4.x,
				y = -var_42_4.y
			}):setOpacity(128)
		end

		var_42_5:runFGAction(fgui.FSequence:create(var_42_8))
	end
end

function RichmanMainStage:_onFlyAnimFinish()
	self._flyIndex = self._flyIndex + 1

	if self._flyIndex == 1 then
		self.m_topBar:playIconEffect(self._flyAward, "eff_ui_common_flyGlow", self._iconPlay)
	end
end

function RichmanMainStage:_onAutoClick()
	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(426002))

		return
	end

	var_0_9:setAuto(true)

	if var_0_9:isAuto() then
		self:_onRiceBtnClick()
	end

	self.m_isAutoController:setSelectedIndex(1)
end

function RichmanMainStage:_onCancelAutoClick()
	var_0_9:setAuto(false)

	if var_0_9:isAuto() then
		self:_onRiceBtnClick()
	end

	self.m_isAutoController:setSelectedIndex(0)
end

function RichmanMainStage:checkAndPlaySelNumCanUseEff()
	if self._diceEff then
		self._diceEff:removeSelf()

		self._diceEff = nil
	end

	if var_0_9:getNextDice() > 0 then
		self._diceEff = self.m_diceBtn:getChild("eff"):addEffectSpine({
			isLoop = true,
			name = "eff_ui_richman_use",
			remove = false
		})
	end
end

function RichmanMainStage:onRollFinish()
	if var_0_9:isAuto() then
		if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.RICH_MAN_DICE_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.RICH_MAN_RUN_DICE) <= 0 then
			var_0_9:setAuto(false)
			g.core.module.ModuleManager:tip(g.core.lang:get(426032))
			self.m_isAutoController:setSelectedIndex(0)

			return
		end

		self:_onRiceBtnClick()
	end
end

function RichmanMainStage:onUnload()
	var_0_9:setAuto(false)
end

return RichmanMainStage
