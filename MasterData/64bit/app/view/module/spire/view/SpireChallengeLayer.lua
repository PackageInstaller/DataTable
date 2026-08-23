local SpireChallengeLayer = class("SpireChallengeLayer", require("app.fairyGUI.spire.UI_SpireChallengeLayer"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		isFullScreen = true,
		pkgPath = "ui/spire/spire",
		resName = "SpireChallengeLayer"
	}, ...)
end)

function SpireChallengeLayer:ctor(arg_2_1)
	g.core.model.User.spireData:getMonsterPool():clearAllUsingList()

	self._tower = arg_2_1
	self._showCompIndex = 1
	self._originPointInfo = nil
	self._battleStageInfo = nil
	self._roleSpine = nil
	self._isFirst = true
	self._isPlaying = false
	self._btnEffSpine = nil
	self._needPlayDeepAnim = false
	self._ignoreDeepTxt = false

	self:_initLayer()
	self.m_standByTransition:play()
end

function SpireChallengeLayer:_initLayer()
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.SpireConst.MAIN_TOP_BAR_ID)
	self.m_deepComp:addClickListener(handler(self, self._onDeepCompClicked))
	self.m_normalBtn:addClickListener(handler(self, self._onChallengeBtnClicked))
	self.m_normal1Btn:addClickListener(handler(self, self._onChallengeBtnClicked))
	self.m_bossBtn:addClickListener(handler(self, self._onChallengeBtnClicked))
	self.m_touchMonsterNode:addClickListener(handler(self, self._onChallengeBtnClicked))
	self.m_autoBtn:addClickListener(handler(self, self._onAutoChallengeBtnClick))
	self.m_touchMapNode:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchMapNode:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	local var_3_0 = self.m_touchMapNode:getSize()

	var_3_0.width = display.width
	var_3_0.height = display.height / 750 * var_3_0.height

	self.m_touchMapNode:setSize(var_3_0)

	local var_3_1 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))

	var_3_1.isShowBack = true
	self._roleSpine = require("app.view.battle.BattleKnight").new(var_3_1)

	self:_onRolePlayIdle()
	self.m_roleSpineNode:addNode(self._roleSpine)
	self._roleSpine:setLocalZOrder(-1)
	self.m_transformComp:setHook("start", handler(self, self._willShowNextTurnAnim))
	self.m_roleMoveOutTransition:setHook("startStageTurn", handler(self, self._onPlayStageTurn))
	self.m_mapComp1:setBossInAnimHook("showBossUI", handler(self, self._onPlayBossUIShowAnim))
	self.m_mapComp2:setBossInAnimHook("showBossUI", handler(self, self._onPlayBossUIShowAnim))
	self:_updateBg()

	if self._tower:getCurFloor():getCurStageStruct():isBossStage() then
		self.m_isBossController:setSelectedIndex(1)
	end
end

function SpireChallengeLayer:_updateBg()
	local var_4_0 = table.concat({
		"bg/spire/",
		self._tower:getCfg().bg,
		".jpg"
	})

	self.m_bgLoader1:setURL(var_4_0)
	self:_fixBgLoader(self.m_bgLoader1)
	self.m_bgLoader2:setURL(var_4_0)
	self:_fixBgLoader(self.m_bgLoader2)

	local var_4_1 = self.m_bgLoader2:getPosition()

	var_4_1.x = display.width / 2 + self.m_bgLoader1:getSize().width * self.m_bgLoader1:getScaleX()

	self.m_bgLoader2:setPosition(var_4_1)

	if self._tower:isBossTower() then
		self.m_bgBossLoader:setURL((table.concat({
			"bg/spire/",
			self._tower:getCfg().bg,
			"_boss",
			".jpg"
		})))
	end
end

function SpireChallengeLayer:_fixBgLoader(arg_5_1)
	local var_5_0 = arg_5_1:getSize()

	if var_5_0.width == 0 then
		return
	end

	arg_5_1:setScale(display.width / var_5_0.width)
end

function SpireChallengeLayer:_onTouchBegin(arg_6_1)
	if not arg_6_1:getInput():getTouch() or self._isPlaying then
		return
	end

	arg_6_1:captureTouch()

	if self._isPlaying then
		return
	end

	local var_6_0 = arg_6_1:getInput()
	local var_6_1 = var_6_0:getTouch():getLocation()

	self:_onRoleMoveTo((var_6_0:getPosition()))
end

function SpireChallengeLayer:_onTouchEnd(arg_7_1)
	return
end

function SpireChallengeLayer:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_STAGEBEGIN, self._onS2CStageBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSBEGIN, self._onS2CBossBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_BOSSINFO, handler(self, self._onS2CBossInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
end

function SpireChallengeLayer:_initOriginPointInfo()
	self._originPointInfo = {}
	self._originPointInfo.left = -display.width
	self._originPointInfo.right = display.width

	local var_9_0 = self.m_mapComp1:getPosition()
	local var_9_1 = self.m_bgLoader1:getSize().width * self.m_bgLoader1:getScaleX()
	local var_9_2 = self.m_bgLoader1:getPosition()
	local var_9_3 = self.m_bgLoader2:getPosition()

	self.m_moveMap1Transition:setValue("endBgPos", {
		var_9_2.x - var_9_1,
		var_9_2.y
	})
	self.m_moveMap1Transition:setValue("startBgPos", {
		var_9_3.x,
		var_9_3.y
	})
	self.m_moveMap1Transition:setValue("starPoint", {
		self._originPointInfo.right,
		var_9_0.y
	})
	self.m_moveMap1Transition:setValue("endPoint", {
		self._originPointInfo.left,
		var_9_0.y
	})
	self.m_moveMap2Transition:setValue("endBgPos", {
		var_9_2.x - var_9_1,
		var_9_2.y
	})
	self.m_moveMap2Transition:setValue("startBgPos", {
		var_9_3.x,
		var_9_3.y
	})
	self.m_moveMap2Transition:setValue("starPoint", {
		self._originPointInfo.right,
		var_9_0.y
	})
	self.m_moveMap2Transition:setValue("endPoint", {
		self._originPointInfo.left,
		var_9_0.y
	})
	self.m_roleMoveOutTransition:setValue("endRunPos", {
		self._originPointInfo.right,
		self.m_roleSpineNode:getPosition().y
	})

	local var_9_4 = self.m_mapComp2:getPosition()

	var_9_4.x = display.width

	self.m_mapComp2:setPosition(var_9_4)
end

function SpireChallengeLayer:onLoad()
	if not self._originPointInfo then
		self:_initOriginPointInfo()
	end

	self:_addCustomListeners()

	local var_10_0 = 1

	if self._isFirst then
		self:_updateLayer()

		if self._tower:isShowChallenge() then
			self:_playEnterAnim()
		else
			self:_playFirstEnterAnim()
		end

		var_10_0 = 2
	elseif g.core.model.User.spireData:isBattleWin() then
		self:_onBattleWin()

		var_10_0 = -1
	else
		self._battleStageInfo = nil

		self:_updateLayer()
		self:_playEnterAnim()

		var_10_0 = -1
	end

	if self.m_isBossController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_Spire_BossInfo({})

		var_10_0 = -1
	end

	if config.DEBUG_VERSION and var_10_0 >= 0 then
		self:_checkAutoBattle(var_10_0)
	end

	self:_onCrossDay()
end

function SpireChallengeLayer:onUnload()
	g.core.model.User.spireData:getMonsterPool():clearAllUsingList()
	self:_setPlayingEnable(false)
end

function SpireChallengeLayer:_updateLayer()
	local var_12_0 = self._tower:getCurFloor()

	self:_updateMapComp(var_12_0)
	self:_updateUIComp(var_12_0)
	self:_updateDeepTxt()
	self.m_isUnlockAutoController:setSelectedIndex(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE_AUTO_CHALLENGE) and 1 or 0)

	if self._tower:isPass() then
		self.m_isPassAllController:setSelectedIndex(1)
		self.m_isUnlockAutoController:setSelectedIndex(0)
	else
		self.m_isPassAllController:setSelectedIndex(0)
	end

	self._isFirst = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_autoBtn
	})
end

function SpireChallengeLayer:_updateMapComp(arg_13_1)
	local var_13_0 = self.m_mapComp1
	local var_13_1 = self.m_mapComp2

	self._showCompIndex = 1

	local var_13_2

	if self.m_mapComp2:getPosition().x < self.m_mapComp1:getPosition().x then
		var_13_0 = self.m_mapComp2
		var_13_1 = self.m_mapComp1
		self._showCompIndex = 2
		var_13_2 = arg_13_1:getNextStageStruct()
	end

	var_13_0:updateMapComp((arg_13_1:getCurStageStruct()))
	var_13_0:setVisible(true)

	if var_13_2 then
		var_13_1:updateMapComp(var_13_2)
		var_13_1:setVisible(false)
	end
end

function SpireChallengeLayer:_updateDeepTxt()
	if self._ignoreDeepTxt then
		return
	end

	local var_14_0 = self._tower:getDeepBuffList()

	if self._needPlayDeepAnim then
		self.m_deepComp:playUpDeepAnim(#var_14_0)

		self._needPlayDeepAnim = false
	else
		self.m_deepComp:setTitle(#var_14_0)
	end
end

function SpireChallengeLayer:_updateUIComp(arg_15_1)
	arg_15_1 = arg_15_1 or self._tower:getCurFloor()

	local var_15_0 = arg_15_1:getCurStageStruct()
	local var_15_1 = self.m_isBossController:getSelectedIndex()
	local var_15_2

	if var_15_0:isBossStage() then
		self.m_bossUIComp:updateUI(arg_15_1)
		self.m_isBossController:setSelectedIndex(1)
		self.m_floorTxt:setText(g.core.lang:get(432006))

		var_15_2 = 1
	else
		self.m_normalUIComp:updateUI(arg_15_1)
		self.m_isBossController:setSelectedIndex(0)
		self.m_floorTxt:setText(g.core.lang:get(432005, {
			cur = arg_15_1:getFloorId(),
			max = #self._tower:getFloorList()
		}))

		var_15_2 = 0
	end

	self.m_lineUpComp:updateLineUpComp(self._tower:getMulFormationType(), self._tower:isPass(), self._tower:getCfg())

	if self._isFirst then
		self:_updateBtnEff(var_15_2 == 1)
	elseif var_15_1 ~= var_15_2 then
		self:_updateBtnEff(var_15_2 == 1)
	end
end

function SpireChallengeLayer:_onCrossDay()
	if not g.core.model.User.spireData:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0.5)
	end
end

function SpireChallengeLayer:_onChallengeBtnClicked()
	if g.core.model.User.spireData:getCurStage() == g.core.const.ConstMgr.SpireConst.STAGE.SHOW_RESULT then
		g.core.module.ModuleManager:tip(g.core.lang:get(432036))

		return
	end

	if not self._tower:getCurFloor():getCurStageStruct():isBossStage() and not g.core.model.User.spireData:hasChallengeTimes(self._tower) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432021))

		return
	end

	if #g.core.model.User.mulFormationData:getFormationStructDict(self._tower:getMulFormationType())[1]:getValidKnightSidList() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432001))

		return
	end

	self:_onRoleAttack()
end

function SpireChallengeLayer:_onAutoChallengeBtnClick()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE_AUTO_CHALLENGE)

	if g.core.model.User.spireData:getCurStage() == g.core.const.ConstMgr.SpireConst.STAGE.SHOW_RESULT then
		g.core.module.ModuleManager:tip(g.core.lang:get(432036))

		return
	end

	if not self._tower:getCurFloor():getCurStageStruct():isBossStage() and not g.core.model.User.spireData:hasChallengeTimes(self._tower) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432021))

		return
	end

	local var_19_0

	if #g.core.model.User.mulFormationData:getFormationStructDict(self._tower:getMulFormationType())[1]:getValidKnightSidList() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432001))

		do return end

		var_19_0 = {
			title = g.core.lang:get(303049)
		}
	end

	var_19_0.desc = g.core.lang:get(303047)
	var_19_0.onConfirm = handler(self, self.onStartAutoAction)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_19_0), {
		touchDisappear = true
	})
end

function SpireChallengeLayer:onStartAutoAction()
	local var_20_0 = fgui.UIPackage:createObject("spire", "SpireAutoRunComp")

	var_20_0:setTowerData(self._tower)
	var_20_0:setPosition(display.width / 2 + display.cx, display.height / 2 + display.height)
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_20_0)
end

function SpireChallengeLayer:doAutoAction()
	if not self._isPlaying then
		self:_onChallengeBtnClicked()

		return true
	end

	return false
end

function SpireChallengeLayer:_doChallenge()
	self[table.concat({
		"m_mapComp",
		self._showCompIndex
	})]:playSpineAnim(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.IDLE, true)

	if self.m_isBossController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_Spire_BossBegin({})
	else
		g.core.network.GameNetProxy:send_C2S_Spire_StageBegin({
			tp = self._tower:getCfg().type
		})
	end

	self:_setPlayingEnable(false)
	self:_onRolePlayIdle()
end

function SpireChallengeLayer:_onDeepCompClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.pop.SpireDeepDetailPop").new((self._tower:getDeepBuffList())), {
		touchDisappear = true,
		hideContinue = true
	})
end

function SpireChallengeLayer:onClickBackBtn()
	if self._isPlaying then
		g.core.module.ModuleManager:tip(g.core.lang:get(432024))

		return
	end

	self.m_backTransition:play(handler(self, self._onCloseChallengeLayer))
end

function SpireChallengeLayer:_onCloseChallengeLayer()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function SpireChallengeLayer:_onBattleWin()
	if self.m_isBossController:getSelectedIndex() ~= 1 then
		self:_checkAndPlayAnim()
	end
end

function SpireChallengeLayer:_setPlayingEnable(arg_27_1)
	self._isPlaying = arg_27_1

	self.m_maskComp:setVisible(self._isPlaying)
end

function SpireChallengeLayer:_checkAndPlayAnim()
	self.m_roleSpineNode:stopAllFGActions()
	self:_setPlayingEnable(true)

	if self._tower:isPass() then
		self:_playPassTowerAnim()
	elseif self._battleStageInfo.isNextBoss then
		self:_playMoveToBossAnim()
	else
		local var_28_0 = self._tower:getFloor(self._battleStageInfo.floor)

		self._needPlayDeepAnim = (tonumber(self.m_deepComp:getChild("title"):getText()) or 0) ~= #self._tower:getDeepBuffList()

		if var_28_0:isPass() then
			self:_playPassFloorAnim()
		else
			self:_playPassNormalAnim()
		end
	end
end

function SpireChallengeLayer:_playFirstEnterAnim()
	self._tower:showChallenge()

	if self.m_isBossController:getSelectedIndex() == 1 then
		self:_playEnterAnim()

		return
	end

	self:_setPlayingEnable(true)
	self._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN, true)
	self.m_roleMoveInTransition:play((handler(self, function(arg_30_0)
		arg_30_0:_onRolePlayIdle((handler(arg_30_0, function(arg_31_0)
			arg_31_0:_onShowStagePopUp(handler(arg_31_0, arg_31_0._onUpdateUIWhenAnimEnd))
		end)))
	end)))
	self:_playEnterAnim()

	local var_29_0 = self._tower:getCurFloor()
	local var_29_1 = {
		floor = var_29_0:getFloorId(),
		stage = var_29_0:getCurStage() - 1
	}

	var_29_1.isNextBoss = false
	self._battleStageInfo = var_29_1
end

function SpireChallengeLayer:_playPassNormalAnim()
	local var_32_0 = handler(self, function(arg_33_0)
		arg_33_0:_onRolePlayIdle((handler(arg_33_0, function(arg_34_0)
			arg_34_0:_onShowStagePopUp(handler(arg_34_0, arg_34_0._onTransformationAnimEnd))
		end)))
	end)

	self:_onPlayMonsterDead((handler(self, function(arg_35_0)
		arg_35_0:_onPlayMoveNextStage(var_32_0)
	end)))
end

function SpireChallengeLayer:_onShowStagePopUp(arg_36_1)
	self._battleStageInfo.stage = self._battleStageInfo.stage + 1

	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.pop.SpireStageTransformationPop").new(self._battleStageInfo, arg_36_1), {
		touchDisappear = false,
		hideContinue = true
	})
end

function SpireChallengeLayer:_playPassFloorAnim()
	local var_37_0 = handler(self, function(arg_38_0)
		arg_38_0:_onRolePlayIdle((handler(arg_38_0, function(arg_39_0)
			arg_39_0:_onShowFloorPopUp(handler(arg_39_0, arg_39_0._onUpdateUIWhenAnimEnd))
		end)))
	end)

	self:_onPlayMonsterDead((handler(self, function(arg_40_0)
		arg_40_0._moveInCallback = var_37_0

		arg_40_0:_onPlayMoveOutAnim()
	end)))
end

function SpireChallengeLayer:_onShowFloorPopUp(arg_41_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.pop.SpireFloorTransformationPop").new(self._tower, arg_41_1), {
		touchDisappear = false,
		hideContinue = true
	})
end

function SpireChallengeLayer:_playMoveToBossAnim()
	self:_onPlayMonsterDead((handler(self, function(arg_43_0)
		arg_43_0._moveInCallback = handler(arg_43_0, function(arg_44_0)
			arg_44_0:_onShowBossPopUp(handler(arg_44_0, arg_44_0._onBossPopShowEnd))
		end)

		arg_43_0._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN, true)
		arg_43_0:_onPlayMoveOutAnim()
		arg_43_0.m_bossUIComp:setVisible(false)
		arg_43_0.m_normalUIComp:playProAnim()
	end)))
end

function SpireChallengeLayer:_onShowBossPopUp(arg_45_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.pop.SpireBossTransformationPop").new(self._tower:getCurFloor():getBossStage(), arg_45_1), {
		touchDisappear = false,
		hideContinue = true
	})
end

function SpireChallengeLayer:_onBossPopShowEnd()
	local var_46_0 = self[table.concat({
		"m_mapComp",
		self._showCompIndex
	})]

	var_46_0:playBossInAnim((handler(self, self._onUpdateUIWhenAnimEnd)))
	var_46_0:setVisible(true)
end

function SpireChallengeLayer:_onPlayBossUIShowAnim()
	self.m_bossUIComp:setVisible(true)
	self:_playEnterAnim()
end

function SpireChallengeLayer:_onPlayMoveOutAnim(arg_48_1)
	if arg_48_1 then
		self.m_roleMoveOutTransition:play(arg_48_1)
	else
		self.m_roleMoveOutTransition:play()
	end

	self._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN, true)
end

function SpireChallengeLayer:_willShowNextTurnAnim()
	self:_updateLayer()

	if self.m_isBossController:getSelectedIndex() == 1 then
		self[table.concat({
			"m_mapComp",
			self._showCompIndex
		})]:setVisible(false)
	end
end

function SpireChallengeLayer:_onPlayStageTurn()
	self._ignoreDeepTxt = true

	self.m_transformComp:play(handler(self, function(arg_51_0)
		if arg_51_0.m_isBossController:getSelectedIndex() ~= 1 then
			arg_51_0:_playEnterAnim()
			arg_51_0.m_roleMoveInTransition:play(arg_51_0._moveInCallback)
		elseif arg_51_0._moveInCallback then
			arg_51_0._moveInCallback()
		end
	end))
	self.m_backTransition:play()
end

function SpireChallengeLayer:_playPassTowerAnim()
	self:_onPlayMonsterDead((handler(self, function(arg_53_0)
		arg_53_0:_onShowTowerPassPopUp(handler(arg_53_0, arg_53_0._onUpdateUIWhenAnimEnd))
	end)))
end

function SpireChallengeLayer:_onShowTowerPassPopUp(arg_54_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.pop.SpirePassTransformationPop").new(arg_54_1), {
		touchDisappear = false,
		hideContinue = true
	})
end

function SpireChallengeLayer:_onPlayMonsterDead(arg_55_1)
	if self._showCompIndex == 1 then
		self.m_mapComp1:playMonsterDead()
		self.m_mapComp2:setVisible(true)
	else
		self.m_mapComp2:playMonsterDead()
		self.m_mapComp1:setVisible(true)
	end

	self:newScheduleOnce(arg_55_1, 1)
end

function SpireChallengeLayer:_onPlayMoveNextStage(arg_56_1)
	self._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN, true)

	if self._showCompIndex == 1 then
		self.m_moveMap1Transition:play(arg_56_1)
	else
		self.m_moveMap2Transition:play(arg_56_1)
	end

	self.m_normalUIComp:playProAnim()
end

function SpireChallengeLayer:_onTransformationAnimEnd()
	local var_57_0 = self[table.concat({
		"m_mapComp",
		self._showCompIndex
	})]
	local var_57_1 = var_57_0:getPosition()

	var_57_1.x = self._originPointInfo.right

	var_57_0:setPosition(var_57_1)

	local var_57_2 = self._tower:getCurFloor():getNextStageStruct()

	if var_57_2 then
		var_57_0:updateMapComp(var_57_2)
		var_57_0:setVisible(false)
	end

	self:_onUpdateUIWhenAnimEnd()
end

function SpireChallengeLayer:_onRolePlayIdle(arg_58_1)
	self._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.IDLE, true)

	if arg_58_1 then
		self:newScheduleOnce(arg_58_1, 0.5)
	end
end

function SpireChallengeLayer:_onUpdateUIWhenAnimEnd()
	self._ignoreDeepTxt = false

	self:_setPlayingEnable(false)

	self._battleStageInfo = nil

	self:_onRolePlayIdle()
	self:_updateLayer()

	self._needPlayDeepAnim = false

	if config.DEBUG_VERSION then
		self:_checkAutoBattle()
	end
end

function SpireChallengeLayer:_playEnterAnim(arg_60_1)
	local var_60_0 = self.m_isBossController:getSelectedIndex() == 1 and self.m_enterBossTransition or self.m_enterTransition

	if arg_60_1 then
		var_60_0:play(arg_60_1)
	else
		var_60_0:play()
	end
end

function SpireChallengeLayer:_updateBtnEff(arg_61_1)
	local var_61_0 = arg_61_1 and {
		anim = "boss",
		isLoop = true,
		name = "eff_ui_spire_btnchallenge"
	} or {
		anim = "normal",
		isLoop = true,
		name = "eff_ui_spire_btnchallenge"
	}

	if not self._btnEffSpine then
		self._btnEffSpine = self.m_btnEffNode:addEffectSpine(var_61_0)
	else
		self._btnEffSpine:setAnimation(0, var_61_0.anim, true)
	end
end

function SpireChallengeLayer:_onRoleAttack()
	if self.m_isBossController:getSelectedIndex() == 1 then
		self:_doChallenge()

		return
	end

	self:_setPlayingEnable(true)

	local var_62_0 = self[table.concat({
		"m_mapComp",
		self._showCompIndex
	})]

	self:_onRoleMoveTo(var_62_0:getSpinePos(), (handler(self, function(arg_63_0)
		arg_63_0.m_roleSpineNode:setScaleX(1)
		arg_63_0._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.ACTION.ATTACK, false)
		arg_63_0:newScheduleOnce(handler(arg_63_0, arg_63_0._doChallenge), 1)
		arg_63_0:newScheduleOnce(handler(arg_63_0, function(arg_64_0)
			var_62_0:playSpineAnim(0, g.core.const.ConstMgr.SpineConst.ACTION.HIT)
		end), 0.7)
	end)))
end

function SpireChallengeLayer:_onRoleMoveTo(arg_65_1, arg_65_2)
	local var_65_0 = self.m_roleSpineNode:getPosition()

	if self._roleSpine:getCurAnimationName() ~= g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN then
		self._roleSpine:setAnimation(0, g.core.const.ConstMgr.SpineConst.LOOP_ACTION.RUN, true)
	end

	local var_65_1 = cc.pGetDistance(var_65_0, arg_65_1) / (display.width / 2)

	self.m_roleSpineNode:stopAllFGActions()

	local var_65_2

	if arg_65_1.x >= var_65_0.x then
		self.m_roleSpineNode:setScaleX(1)
	else
		self.m_roleSpineNode:setScaleX(-1)

		var_65_2 = {}
	end

	var_65_2[1] = fgui.FMoveTo:create(var_65_1, {
		x = arg_65_1.x,
		y = arg_65_1.y
	})
	var_65_2[2] = fgui.FCallFunc:create(handler(self, function(arg_66_0)
		if arg_65_2 then
			arg_65_2()
		else
			arg_66_0:_onRolePlayIdle()
		end
	end))

	self.m_roleSpineNode:runFGAction(fgui.FSequence:create(var_65_2))
	self:_checkRoleZOrder(arg_65_1)
end

function SpireChallengeLayer:_checkRoleZOrder(arg_67_1)
	local var_67_0 = self[table.concat({
		"m_mapComp",
		self._showCompIndex
	})]
	local var_67_1 = var_67_0:getSpinePos()

	if (arg_67_1.x - var_67_1.x) * (self.m_roleSpineNode:getPosition().x - var_67_1.x) < 0 then
		self.m_roleSpineNode:displayObject():setLocalZOrder(var_67_0:displayObject():getLocalZOrder() + (arg_67_1.y >= var_67_1.y and 1 or -1))
	end
end

function SpireChallengeLayer:_onS2CBossInfo(arg_68_1, arg_68_2, arg_68_3, arg_68_4)
	self:_updateLayer()
end

function SpireChallengeLayer:_onS2CStageBegin(arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = self._tower:getCurFloor()
	local var_69_1 = var_69_0:getCurStage()
	local var_69_2 = var_69_0:getCurStageStruct()

	self._battleStageInfo = {
		floor = var_69_0:getFloorId(),
		stage = var_69_1,
		isNextBoss = var_69_1 == var_69_0:getMaxStage() and var_69_0:hasBossStage()
	}

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		type = BattleConst.TYPE_SPIRE_NORMAL,
		typeQuality = var_69_2:getCfg().quality,
		battle_id = arg_69_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgm = var_69_2:getCfg().bgm
	})
end

function SpireChallengeLayer:_onS2CBossBegin(arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = self._tower:getCurFloor()
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		type = BattleConst.TYPE_SPIRE_BOSS,
		battle_id = arg_70_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgm = var_70_0:getCurStageStruct():getCfg().bgm,
		extraParams = {
			bossCfg = var_70_0:getCurStageStruct():getCfg()
		}
	})
end

function SpireChallengeLayer:_checkAutoBattle(arg_71_1)
	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("spire_tower_auto") and not self._tower:isPass() then
		self:newScheduleOnce(handler(self, self._onChallengeBtnClicked), arg_71_1 or 1)
	end
end

return SpireChallengeLayer
