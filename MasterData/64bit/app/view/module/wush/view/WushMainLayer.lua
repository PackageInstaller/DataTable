local WushMainLayer = class("WushMainLayer", require("app.fairyGUI.wush.UI_WushMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/wush/wush",
		resName = "WushMainLayer",
		pkgName = "wush",
		isFullScreen = true
	}, ...)
end)
local var_0_1 = g.core.config.dead_battle_floor_info
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.const.ConstMgr.ShopConst.PLAY_TYPE.WUSH
local var_0_4 = g.core.model.User.wushData
local var_0_5 = g.core.model.User.shopData
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = 2

function WushMainLayer:ctor()
	self._isInit = false
	self._isReset = false
	self._isFirstBuss = false
	self._selfRank = 0
	self._touchCount = 0
	self._canFailTimes = 0
	self._curFloorId = 1
	self._wushBussiness = {}
	self._isAutoShowBattle = true

	self:initBg()
	self:_initMainView()
end

function WushMainLayer:initBg()
	local var_3_1 = self:addBg("bg/wush/shenruheiyuan0" .. ((g.core.config.dead_battle_floor_info.fetch((var_0_4:getCurFloorId())) or {}).background or 1) .. ".png")

	var_3_1:setOpacity(50)
	var_3_1:runFGAction((fgui.FSequence:create(fgui.FFadeIn:create(0.5), (fgui.FCallFunc:create(function()
		var_3_1:removeFromParent()
	end)))))
end

function WushMainLayer:_initMainView()
	self.m_topBarComp:setResInfoById(30)
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRank))
	self.m_wushBtn:addClickListener(handler(self, self._onClickWushShop))
	self.m_wushBtn:setVisible(false)
	self.m_attrComp:addClickListener(handler(self, self._onClickAttr))
	self.m_lineupBtn:addClickListener(handler(self, self._onLineupClick))
	self.m_blitzBtn:addClickListener(handler(self, self._onClickBlitz))
	self.m_autoBtn:addClickListener(handler(self, self.onAutoActionClick))
	self.m_blitzAllBtn:addClickListener(handler(self, self._onClickAllWipeOut))
	self.m_posHolderComp:addClickListener(handler(self, self._onHideBattleInfoComp))
	self.m_isShowInfoController:setSelectedIndex(0)
	self.m_playTimesComp:initView({
		playNum = 999,
		getTimesFunc = function()
			return g.core.model.User.wushData:getLeftFailTimes()
		end,
		fullTime = var_0_2.get(g.core.const.ConstMgr.PARAMETER_CONST.WUSH_FAIL_TIMES).parameter
	})
	self.m_lineUpList:setIniter()
	self.m_lineUpList:setItemRenderer(handler(self, self._onLineupList))
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 1,
		id = 4
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_TRIAL)
end

function WushMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._onRcvReset, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_GETINFO, self._onRcvWushInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRecvRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_FASTCHALLENGE, self._onRcvBlitz, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_ALLCHALLENGE, self._onRcvAllBlitz, self)

	if var_0_5:getLeftCount(var_0_3) > 0 and not g.core.guide.GuideProxy:isGuideRunning() then
		g.core.network.GameNetProxy:send_C2S_BuyCommonPlayNum({
			num = 1,
			id = var_0_3
		})
	end

	if not var_0_4:hasData() then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
	elseif var_0_4:isExpired() then
		var_0_4:resetExpired()
		g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
	else
		self:_updateBussiness()
		self:_updateMainView()
		self:_initFloorComp()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

		self._waitState = true

		self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
	end

	if g.core.model.User.guideData:getWushFightFail() then
		self:_checkSpeWeakGuide()
	end

	self:_updateLineupList()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
	self.m_autoBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_AUTO_CHALLENGE)))
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ABYSS)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function WushMainLayer:_onEnterAnimEnd()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end
end

function WushMainLayer:receiveCompEvent(arg_9_1, arg_9_2)
	self.m_autoBtn:setVisible((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_AUTO_CHALLENGE)))

	if arg_9_1 == "NEXT_FLOOR" then
		self:_updateMainView()
		self.m_showBtnController:setSelectedIndex(0)
		self:_updateNextFloorEffectTouch(false)
		self.m_bgComp:goToNextFloorTrainstion(handler(self, function()
			self._curFloorId = var_0_4:getCurFloorId()

			self:_onHideBattleInfoComp()
			self:_moveToNextFloor(self._curFloorId)
			self.m_depthComp:playRollUpTransition()

			if self._isAutoShowBattle then
				self.m_floorComp:onFirstAutoShowBattleInfo()
			end

			self._isAutoShowBattle = true

			self:_updateSweepBtnState()
			self:_updateNextFloorEffectTouch(true)
		end))
	elseif arg_9_1 == "BUFF_CHOOSE_END" then
		self.m_floorComp:goNextFloor()
	elseif arg_9_1 == "BLITZ_FINISH" then
		g.core.module.ModuleManager:popComponent()
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 1,
			id = 4
		})
		self:_updateMainView()
		self.m_depthComp:playRollUpTransition()
		self.m_floorComp:checkFloorInfoByBlitz()
	elseif arg_9_1 == "ONCE_BLITZ_FINISH" then
		g.core.module.ModuleManager:popComponent()
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 1,
			id = 4
		})
		self:_updateMainView()
		self.m_floorComp:update({
			floorId = arg_9_2.endFloorId
		})
		self.m_depthComp:playRollUpTransition()
		self.m_floorComp:checkFloorInfoByBlitz(arg_9_2.floor_star)
	elseif arg_9_1 == "WUSH_SHOP_TIME_ZERO" then
		self:_updateWushShop()
	elseif arg_9_1 == "WUSHFLOORCOMP_PASS_FINISH" then
		self:updateLayerTouchable(true)
		self.m_floorComp:update({
			floorId = self._curFloorId
		})
		g.core.network.GameNetProxy:send_C2S_DeadBattle_GetInfo({})
		self:_onHideBattleInfoComp()
		self.m_showBtnController:setSelectedIndex(0)
	elseif arg_9_1 == "WUSHMAINLAYER_SHOW_BATTLEINFO" then
		self.m_floorComp:setSelectedMonsterState(true)
		self.m_battleInfoComp:updateBattleInfo(arg_9_2)

		if arg_9_2.floorId == 2 and arg_9_2.stageId == 4 and self:checkGuideAutoChallenge() then
			return
		end

		self:_onShowBattleInfoComp()
	elseif arg_9_1 == "WUSHMAINLAYER_UPDATE_BATTLEINFO" then
		self.m_battleInfoComp:updateBattleInfo(arg_9_2)
	elseif arg_9_1 == "WUSHMAINLAYER_HIDE_BATTLEINFO" then
		self:_onHideBattleInfoComp()
		self.m_floorComp:checkSpeWeakGuide()
	elseif arg_9_1 == "WUSHMONSTER_PASS_STAGE" then
		self.m_floorComp:playMainRoleMove((g.core.model.User.wushData:getNewStageIndex()))
	end
end

function WushMainLayer:updateLayerTouchable(arg_11_1)
	self._touchCount = arg_11_1 and math.max(self._touchCount - 1, 0) or self._touchCount + 1

	self:setTouchable(self._touchCount == 0)
end

function WushMainLayer:_updateNextFloorEffectTouch(arg_12_1)
	self.m_floorComp:setVisible(arg_12_1)
	self.m_rankBtn:setTouchable(arg_12_1)
	self.m_shopBtn:setTouchable(arg_12_1)
	self.m_topBarComp:setTouchable(arg_12_1)
end

function WushMainLayer:_updateMainView()
	self:_updateFloorInfo()
	self:_updateWushShop()
end

function WushMainLayer:_updateFloorInfo()
	self._curFloorId = var_0_4:getCurFloorId()
	self._canFailTimes = var_0_4:getLeftFailTimes()

	if var_0_4:getFailState() then
		self:_onShowBattleInfoComp()
		var_0_4:resetFailState()
	end

	self:_updateSweepBtnState()

	self._selfRank = var_0_4:getSelfWeekRank()

	self.m_playTimesComp:updateView()
	self.m_bgComp:playInTransition()
end

function WushMainLayer:_updateSweepBtnState()
	local var_15_0 = var_0_4:getCurStageIndex()
	local var_15_1 = var_0_1.getLength()
	local var_15_2 = var_0_1.fetch(self._curFloorId)

	if var_15_2.type == var_0_7 then
		if var_15_0 >= 1 then
			self.m_showBtnController:setSelectedIndex(0)

			return
		end
	elseif var_15_0 > 2 then
		self.m_showBtnController:setSelectedIndex(0)

		return
	end

	if self._curFloorId == var_15_1 then
		self.m_showBtnController:setSelectedIndex(0)

		return
	end

	if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_BLITZ) and var_0_4:isWushCanSwapeLevel(var_15_2["stage" .. var_15_0 + 1], var_15_2.type == var_0_7) then
		if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.WUSHUANG_ONCE_WIPE_OUT) then
			self.m_showBtnController:setSelectedIndex(2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "WUSH_ENTRUST_FIGHT",
				targetBtn = self.m_guideComp
			})
		else
			self.m_showBtnController:setSelectedIndex(1)
		end
	else
		self.m_showBtnController:setSelectedIndex(0)
	end
end

function WushMainLayer:_updateWushShop()
	if var_0_4:isExistWushShop() then
		local var_16_0 = var_0_4:getShopInfo()
		local var_16_1 = false
		local var_16_2 = 0

		for iter_16_0 = 1, #var_16_0 do
			if g.core.common.ServerTime:getLeftSeconds(var_16_0[iter_16_0].due_time) > 0 and var_16_2 < var_16_0[iter_16_0].due_time then
				var_16_2 = var_16_0[iter_16_0].due_time

				if not self._wushBussiness[var_16_0[iter_16_0].id] then
					self._wushBussiness[var_16_0[iter_16_0].id] = 1
					var_16_1 = true
				end
			end
		end

		if var_16_2 <= 0 then
			self.m_wushBtn:update({
				isUnschedule = true
			})
			self.m_wushBtn:setVisible(false)

			self._wushBussiness = {}
		else
			if var_16_1 then
				var_0_4:saveBussinessNew(true)
				self:addPopup(require("app.view.module.wush.view.wushPop.WushBussinessPop").new(), {
					withoutAni = true
				})
			end

			self.m_wushBtn:update({
				deadLine = var_16_2
			})
			self.m_wushBtn:setVisible(true)
		end
	else
		self.m_wushBtn:setVisible(false)

		self._wushBussiness = {}
	end
end

function WushMainLayer:_initFloorComp()
	if not self._isInit then
		self._isInit = true

		self.m_floorComp:setVisible(true)
		self.m_depthComp:updataDepth(self._curFloorId)
	end

	self:_addFloorComp(self._curFloorId)
end

function WushMainLayer:_moveToNextFloor(arg_18_1)
	var_0_4:resetBoxState()
	self:_addFloorComp(arg_18_1)
end

function WushMainLayer:_addFloorComp(arg_19_1)
	self.m_floorComp:update({
		floorId = arg_19_1
	})
end

function WushMainLayer:_updateBussiness()
	if not self._isFirstBuss then
		self._isFirstBuss = true

		local var_20_0 = var_0_4:getWushShopIdArr()

		for iter_20_0 = 1, #var_20_0 do
			if g.core.common.ServerTime:getLeftSeconds(var_20_0[iter_20_0].time) > 0 then
				self._wushBussiness[var_20_0[iter_20_0].id] = 1
			end
		end
	end
end

function WushMainLayer:_onRcvWushInfo()
	self:_updateBussiness()
	self:_updateMainView()
	self:_initFloorComp()

	if self._isReset then
		self.m_switchTransition:setHook("switch", handler(self, function()
			self:_moveToNextFloor(1)

			self._isReset = false
		end))
	end
end

function WushMainLayer:_onRcvReset(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_3.info and arg_23_3.info.id == var_0_3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(303034))
		var_0_4:reset()

		self._isReset = true
	end
end

function WushMainLayer:_onRcvBlitz(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3.awards == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(303002))
	else
		local var_24_0 = arg_24_3.box_awards
		local var_24_1 = arg_24_3.drop_type
		local var_24_2 = var_0_1.get(self._curFloorId).type == 2

		self._isAutoShowBattle = false

		g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH_BLITZ, {
			floorId = self._curFloorId,
			isBoss = var_24_2,
			boxData = var_24_0,
			dropType = var_24_1,
			awards = arg_24_3.awards
		})
	end
end

function WushMainLayer:_onRcvAllBlitz(arg_25_1, arg_25_2, arg_25_3)
	if arg_25_3.awards == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(303002))
	else
		local var_25_0 = arg_25_3.drop_type
		local var_25_1 = math.min(arg_25_3.dbattle.floor, (var_0_1.getLength()))
		local var_25_2 = {
			isOnceWipeOut = true,
			floorId = self._curFloorId,
			isBoss = var_0_1.get(self._curFloorId).type == 2
		}

		var_25_2.boxData = arg_25_3.box_awards
		var_25_2.dropType = var_25_0
		var_25_2.awards = arg_25_3.awards
		var_25_2.endFloorId = var_25_1
		var_25_2.allAddstar = arg_25_3.add_star
		var_25_2.floor_star = arg_25_3.dbattle.floor_star

		g.core.module.ModuleManager:pushModule(g.view.entrance.WUSH_BLITZ, var_25_2)
	end
end

function WushMainLayer:_onClickRank()
	self:addPopup((require("app.view.module.wush.view.wushPop.WushRankPop").new()))
end

function WushMainLayer:_onRecvRankList(arg_27_1, arg_27_2, arg_27_3)
	self._selfRank = arg_27_3.self_rank or 0

	var_0_4:updateSelfWeekRank(self._selfRank)
end

function WushMainLayer:_onClickWushShop()
	self:addPopup(require("app.view.module.wush.view.wushPop.WushBussinessPop").new(), {
		withoutAni = true
	})
end

function WushMainLayer:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.WUSH
	})
end

function WushMainLayer:_onClickBlitz()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_BLITZ) then
		return
	end

	if var_0_4:isFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(303030))

		return
	end

	local var_30_0 = var_0_4:getCurStageIndex()
	local var_30_1 = var_0_1.fetch((var_0_4:getCurFloorId()))

	if var_30_1.type == var_0_7 then
		if var_30_0 >= 1 then
			return
		end
	elseif var_30_0 > 2 then
		return
	end

	if var_0_4:isWushCanSwapeLevel(var_30_1["stage" .. var_30_0 + 1], var_30_1.type == var_0_7) then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_FastChallenge({})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303015))
	end
end

function WushMainLayer:_onClickAllWipeOut()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WUSHUANG_ONCE_WIPE_OUT) then
		return
	end

	if var_0_4:isFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(303030))

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH, false, {
		finish = true
	})

	local var_31_0 = var_0_4:getCurStageIndex()
	local var_31_1 = var_0_1.fetch((var_0_4:getCurFloorId()))

	if var_31_1.type == var_0_7 then
		if var_31_0 >= 1 then
			return
		end
	elseif var_31_0 > 2 then
		return
	end

	if var_0_4:isWushCanSwapeLevel(var_31_1["stage" .. var_31_0 + 1], var_31_1.type == var_0_7) then
		g.core.network.GameNetProxy:send_C2S_DeadBattle_AllChallenge({})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303015))
	end
end

function WushMainLayer:_onClickAttr()
	self:addPopup(require("app.view.module.wush.view.wushPop.WushDetailAttrPop").new(), {
		touchDisappear = true
	})
end

function WushMainLayer:_onLineupClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function WushMainLayer:_onHideBattleInfoComp()
	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_isShowInfoController:setSelectedIndex(0)
		self.m_floorComp:setSelectedMonsterState(false)
	end
end

function WushMainLayer:_onShowBattleInfoComp()
	if self.m_isShowInfoController:getSelectedIndex() == 0 then
		self.m_isShowInfoController:setSelectedIndex(1)
	end
end

function WushMainLayer:_checkSpeWeakGuide()
	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		self.m_battleInfoComp:checkSpeWeakGuide()
	end
end

function WushMainLayer:_onLineupList(arg_37_1, arg_37_2)
	local var_37_0
	local var_37_1 = 0

	if self._formation[arg_37_1 + 1] and self._formation[arg_37_1 + 1] ~= 0 then
		local var_37_2 = var_0_6:getKnight({
			id = self._formation[arg_37_1 + 1]
		})

		var_37_0 = {
			struct = var_37_2
		}
		var_37_1 = var_37_2:getLevel()
	end

	arg_37_2:getChild("iconComp"):updateComp(arg_37_1 + 1, var_37_0, nil, true, nil, var_37_1)
end

function WushMainLayer:_updateLineupList()
	self._formation = var_0_6:getFormation()

	self.m_lineUpList:setNumItems(#self._formation)
end

function WushMainLayer:onAutoActionClick()
	if g.core.model.User.wushData:getLeftFailTimes() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(303030))

		return
	end

	local var_39_0 = self.m_showBtnController:getSelectedIndex()
	local var_39_1 = g.core.lang:get((var_39_0 == 1 or var_39_0 == 0) and 303048 or 303047) or ""

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(303049),
		desc = var_39_1,
		onConfirm = handler(self, self.onStartAutoAction)
	}), {
		touchDisappear = true
	})
end

function WushMainLayer:onStartAutoAction()
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_40_0 = fgui.UIPackage:createObject("wush", "WushAutoRunComp")

	var_40_0:setPosition(display.width / 2 + display.cx, display.height / 2 + display.height)
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_40_0)
end

function WushMainLayer:doAutoAction()
	if self.m_isShowInfoController:getSelectedIndex() == 1 then
		return self.m_battleInfoComp:doAutoAction()
	else
		self.m_floorComp:doAutoAction()
	end
end

function WushMainLayer:checkGuideAutoChallenge()
	if self.m_autoBtn:isVisible() then
		if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.WUSH_AUTO_CHALLENGE_GUIDE) then
			g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.WUSH_AUTO_CHALLENGE_GUIDE)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.WUSH_AUTO_GUIDE
			})

			return true
		end
	end

	return false
end

function WushMainLayer:onUnload()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return WushMainLayer
