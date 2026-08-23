local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local var_0_2 = g.core.model.User.fogNightmareData
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local GuideConst = require("app.view.module.guide.const.GuideConst")
local FogNightmareStageComp = class("FogNightmareStageComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareStageComp"))

function FogNightmareStageComp:ctor(arg_1_1)
	self._curShowComp = nil
	self._childComps = {}
	self._selectWaveIdx = -1
	self._canSkipChallenge = true

	self:_initView()
end

function FogNightmareStageComp:_initView()
	self.m_firstAwardsList:setVirtual(self)
	self.m_firstAwardsList:doFairyBatching(false)
	self.m_firstAwardsList:setItemRenderer(handler(self, self._onRendererAwardItem))
	self.m_buffList:setVirtual(self)
	self.m_buffList:doFairyBatching(false)
	self.m_buffList:setItemRenderer(handler(self, self._onRendererBuffItem))
	self.m_waveList:setVirtual(self)
	self.m_waveList:doFairyBatching(false)
	self.m_waveList:setItemRenderer(handler(self, self._onRendererWaveItem))
	self.m_waveList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickWaveItem))
	self.m_btnLine:addClickListener(handler(self, self._onLineBtnClicked))
	self.m_btnLoad:addClickListener(handler(self, self._onLoadBtnClicked))
	self.m_btnStage:addClickListener(handler(self, self._onBtnStageClicked))
	self.m_btnCancel:addClickListener(handler(self, self._onBtnCancelClicked))
	self.m_btnPic:addClickListener(handler(self, self._onPicBtnClicked))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardBtnClicked))
	self.m_rewardBg:addClickListener(handler(self, self._onRewardBtnClicked))
	self.m_touchBg:addClickListener(handler(self, self._onTouchBg))
	self.m_frontClickNode:addClickListener(handler(self, self._onClickFrontTextNode))
	self.m_buffClickNode:addClickListener(handler(self, self._onTouchBg))
	self.m_skipFormation:setSelected((var_0_2:getFormationData():getStageSkipFormation()))
	self.m_skipFormation:addClickListener(handler(self, self._onClickSkipFormationBtn))
	self.m_skipChallenge:addClickListener(handler(self, self._onClickSkipChallengeBtn))

	self._debugFastBattle = false

	local DebugCommon = require("app.view.module.debug.common.DebugCommon")

	if DebugCommon.getDebugGlobalValueByKey("fog_skip_battle") ~= nil then
		self._debugFastBattle = DebugCommon.getDebugGlobalValueByKey("fog_skip_battle")
	end

	self.m_autoBtn:addClickListener(handler(self, self._onClickAutoBtn))
end

function FogNightmareStageComp:_onRendererAwardItem(arg_3_1, arg_3_2)
	local var_3_0 = clone(self._firstAwards[arg_3_1 + 1])

	var_3_0.scaleIndex = 4

	arg_3_2:updateIcon(var_3_0)
end

function FogNightmareStageComp:_onRendererBuffItem(arg_4_1, arg_4_2)
	arg_4_2:updateView(self._buffs[arg_4_1 + 1])
end

function FogNightmareStageComp:_onRendererWaveItem(arg_5_1, arg_5_2)
	arg_5_2:updateCell(arg_5_1 + 1, (self._waves[arg_5_1 + 1]:isFinish()))
end

function FogNightmareStageComp:_onClickWaveItem()
	local var_6_0 = self.m_waveList:getSelectedIndex()

	if var_6_0 == self._selectWaveIdx then
		if self._selectWaveIdx > -1 then
			self:_showChildComp(self._selectWaveIdx + 1, false)
		end

		return
	end

	self._stageStruct:setTempSelectWave(var_6_0 + 1)

	if self._waves[var_6_0 + 1]:isFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(500156))
		self.m_waveList:setSelectedIndex(self._selectWaveIdx)
	else
		self._selectWaveIdx = var_6_0

		self:_showChildComp(self._selectWaveIdx + 1)
	end
end

function FogNightmareStageComp:_onLineBtnClicked()
	if not var_0_2:getAwardsPopIsShowOver() then
		return
	end

	local var_7_0 = var_0_2:getFormationData()

	var_7_0:updateSelectInfos()

	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(var_0_2:getFormationData():getPoolMember().knights) do
		local var_7_2 = {
			knight = iter_7_1,
			keepsake = iter_7_1:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.KEEPSAKE)
		}
		local var_7_3

		if iter_7_1:getOwner().id == g.core.model.User:getId() then
			var_7_1[2] = var_7_2
			var_7_3 = 2 + 1
		else
			var_7_1[1] = var_7_2
		end
	end

	var_7_0:updateKnightTempPoss(var_7_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreKnightPoolPop").new({
		showBtn = false,
		lastPoolDatas = var_7_1,
		lineUpMembers = clone(var_7_1)
	}), {
		touchDisappear = true
	})
end

function FogNightmareStageComp:_onLoadBtnClicked()
	if not var_0_2:getAwardsPopIsShowOver() then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreLoadPop").new({
		floor = self._floorStruct:getFloorId(),
		stage = self._stageStruct:getStageId()
	}), {
		touchDisappear = true
	})
end

function FogNightmareStageComp:_onBtnStageClicked()
	local var_9_0 = var_0_2:getFormationData()
	local var_9_1 = self:_isMonsterType()

	if not var_0_2:getAutoPlay():isAutoPlay() and var_9_0:getStageSkipChallenge() and var_9_1 then
		self:_skipFogNightmareChallenge()

		return
	end

	if var_9_0:getStageSkipFormation() and var_9_1 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE_SKIP_FORMATION) then
		self:_skipFogNightmareStageBattle()
	else
		self:_gotoFogFormation()
	end
end

function FogNightmareStageComp:_onBtnCancelClicked()
	self._curShowComp:doClickCancelAction()
end

function FogNightmareStageComp:_onPicBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_KEEPSAKE_BOOK)
end

function FogNightmareStageComp:_onRewardBtnClicked()
	if not var_0_2:getAwardsPopIsShowOver() then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareStageRewardPop").new(), {
		touchDisappear = true
	})
end

function FogNightmareStageComp:_addCustomEvent()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_BACK, handler(self, self._onFogBackSucc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEBEGIN, handler(self, self._onChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEFINISH, handler(self, self._onChallengeFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onSaveSucc), self)
end

function FogNightmareStageComp:onLoad()
	self.m_showCancelController:setSelectedIndex(0)
	self:_addCustomEvent()

	if self._floorStruct then
		self:updateView()
		self:_autoSelectWave()
	end

	self._isFirstEnter = false

	if var_0_2:getIsEnterFormation() then
		self:_onResetLeave()
	end

	self:checkSpeTickGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rewardBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_btnLine
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_btnPic
	})
end

function FogNightmareStageComp:debugUpdateView()
	self:updateView()
	self:_autoSelectWave()
end

function FogNightmareStageComp:_autoSelectWave()
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs((self._stageStruct:getAllWave())) do
		if not iter_16_1:isFinish() then
			var_16_0 = iter_16_1:getWaveId() - 1

			break
		end
	end

	if var_16_0 then
		self.m_waveList:setSelectedIndex(var_16_0)
		self:_onClickWaveItem()
	end
end

function FogNightmareStageComp:_onResetLeave()
	self._curShowComp:_doClickAction({
		floor = self._floorStruct,
		stage = self._stageStruct,
		wave = var_0_2:getBackWave()
	})
end

function FogNightmareStageComp:updateComp(arg_18_1)
	self._stageStruct = arg_18_1.stage
	self._floorStruct = arg_18_1.floor
	self._knightId = arg_18_1.knightResId
	self._firstAwards = self._floorStruct:getFirstAwards()
	self._waves = self._stageStruct:getAllWave()
	self._selectWaveIdx = -1
	self._buffs = {}

	self:_autoSelectWave()
	self:updateView()

	self._frontTexts = self._stageStruct:getFrontTexts()

	if not self._stageStruct:isReadAllFrontTexts() and #self._frontTexts > 0 then
		self.m_isFrontStyleController:setSelectedIndex(1)
		self.m_frontShowTransition:play(handler(self, self._callNextFrontText))
	else
		self._stageStruct:readAllFrontTexts()
		self.m_isFrontStyleController:setSelectedIndex(0)
		self.m_effectNode:addEffectSpine({
			anim = "title",
			isLoop = false,
			name = "eff_ui_fogNightmare_StageTitle"
		})
		self.m_effectBg:addEffectSpine({
			anim = "bg",
			isLoop = false,
			name = "eff_ui_fogNightmare_StageBg"
		})
		self.m_enter2Transition:play()
	end

	self.m_suitListComp:updateComp()
	self.m_suitListComp:setSelectedIndex("button", 1)

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE_AUTO_PLAY) then
		if g.core.model.User.fogNightmareData:getAutoPlay():isForceOpenAuto() then
			self.m_autoBtn:setVisible(true)

			goto label_18_0
		end
	end

	self.m_autoBtn:setVisible(false)

	::label_18_0::
end

function FogNightmareStageComp:_onClickAutoBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(500253),
		desc = g.core.lang:get(500256),
		tip = {
			txt = g.core.lang:get(500255)
		},
		onCheck = function(arg_20_0)
			if arg_20_0 then
				g.core.model.User.fogNightmareData:getAutoPlay():setLowHpNum(1)
			else
				g.core.model.User.fogNightmareData:getAutoPlay():setLowHpNum(6)
			end
		end,
		onConfirm = handler(self, self._onAutoPlay)
	}), {
		touchDisappear = true
	})
end

function FogNightmareStageComp:_onAutoPlay()
	if var_0_2:getFormationData():getStageSkipFormation() and self:_isMonsterType() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE_SKIP_FORMATION) then
		self:_skipFogNightmareStageBattle(true)
	else
		self:_autoPlay()
	end
end

function FogNightmareStageComp:_autoPlay()
	g.core.layer.LayerManager:getTipLayer():addChild((require("app.view.module.fogNightmare.view.explore.pop.FogNightmareAutoPlayPop").new((g.core.model.User.fogNightmareData:getAutoPlay():prepareAutoPlay()))))
end

function FogNightmareStageComp:updateView(arg_23_1)
	if arg_23_1 then
		var_0_2:getFormationData():updateFormationByRequestFormations()
	else
		var_0_2:getFormationData():getAllLineUpFormations(true)
	end

	self.m_frontText:setText("")
	self.m_floorText:setText(g.core.lang:get(500140, {
		floor = self._floorStruct:getFloorId()
	}))

	self._buffs = var_0_2:getTowerData():getAllBuffs((self._stageStruct:getStageId())) or {}
	self._buffs = clone(self._buffs)

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self._buffs) do
		local var_23_1 = iter_23_1.buffIds or {}

		for iter_23_2 = 1, #var_23_1 do
			local var_23_2 = clone(iter_23_1)

			var_23_2.buff_id = var_23_1[iter_23_2]

			table.insert(var_23_0, var_23_2)
		end
	end

	self._buffs = var_23_0

	self.m_buffList:setNumItems((table.nums(self._buffs)))
	self.m_waveList:setNumItems(#self._waves)
	self.m_waveList:setVisible(#self._waves > 1)
	self:_updateRewardProText()

	if var_0_2:getTowerData():isFirstPassWave(self._floorStruct:getFloorId()) then
		self.m_isHideFirstAwardController:setSelectedIndex(0)
		self.m_firstAwardsList:setNumItems(#self._firstAwards)
	else
		self.m_isHideFirstAwardController:setSelectedIndex(1)
	end
end

function FogNightmareStageComp:_updateRewardProText()
	local var_24_0 = var_0_2:getTowerData()
	local var_24_1 = math.max(var_24_0:getHistoryMaxFloorNum(), (math.max(var_24_0:getCurrentMaxFloorNum(), var_24_0:getCurrentFloorNum() - 1)))
	local var_24_2 = var_24_1
	local var_24_3

	for iter_24_0, iter_24_1 in ipairs((var_24_0:getPhaseRewardData())) do
		if var_24_1 < iter_24_1.floor and iter_24_1.showInfo then
			var_24_2 = iter_24_1.floor
			var_24_3 = iter_24_1.showInfo

			break
		end
	end

	self.m_proText:setText(var_24_1 .. "/" .. var_24_2)
	self.m_probar:setValue(var_24_1)
	self.m_probar:setMax(var_24_2)

	if var_24_3 then
		self.m_rewardBtn:setIcon((g.core.common.Path:getIconByTypeValue(var_24_3.type, var_24_3.value)))
	end
end

function FogNightmareStageComp:_playFrontText(arg_25_1)
	self._typeWriter = require("app.view.common.TypeWriter").new({
		label = self.m_frontText,
		str = arg_25_1,
		callback = handler(self, self._onOneFrontTextPlayEnd)
	})

	self._typeWriter:start()
end

function FogNightmareStageComp:_onClickFrontTextNode()
	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	else
		self:_callNextFrontText()
	end
end

function FogNightmareStageComp:_onOneFrontTextPlayEnd()
	self._typeWriter = nil
end

function FogNightmareStageComp:_callNextFrontText()
	if #self._frontTexts == 0 then
		self._stageStruct:readAllFrontTexts()
		self.m_isFrontStyleController:setSelectedIndex(0)
		self.m_effectNode:addEffectSpine({
			anim = "title",
			isLoop = false,
			name = "eff_ui_fogNightmare_StageTitle"
		})
		self.m_effectBg:addEffectSpine({
			anim = "bg",
			isLoop = false,
			name = "eff_ui_fogNightmare_StageBg"
		})
		self.m_enterTransition:play()
	else
		self:_playFrontText((table.remove(self._frontTexts, 1)))
	end
end

function FogNightmareStageComp:_showChildComp(arg_29_1, arg_29_2)
	if arg_29_1 >= 2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = GuideConst.ENUM_TICK.FOG_FIRST_SELECT_SECOND_MONSTER
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end

	if self._curShowComp then
		self._curShowComp:setVisible(false)
	end

	local var_29_0 = self._waves[arg_29_1]
	local var_29_1 = self._waves[arg_29_1]:getCurEffects()[1]
	local var_29_2 = var_29_1:getCompName()
	local var_29_3 = self._childComps[var_29_2]

	if not self._childComps[var_29_2] then
		var_29_3 = require("app.view.module.fogNightmare.view.explore.comp.stageWaveComp." .. var_29_2).new()

		self.m_childCompRoot:addChild(var_29_3)

		self._childComps[var_29_2] = var_29_3
	end

	var_29_3:updateComp(var_29_1, #self._waves, arg_29_2)
	var_29_3:setVisible(true)

	local var_29_4 = var_29_0:getStageTypeCfg()

	self.m_btnStage:setTitle(var_29_4.btn_str)

	self._curShowComp = var_29_3

	self.m_titleLoader:setURL("ui://text_new/txt_wjmy_guanqia_title" .. var_29_4.id)

	local var_29_5 = var_29_0:getCfg()
	local var_29_6 = 0

	self.m_skipFormation:setVisible(false)

	if var_29_5.type == var_0_1.WAVE_EFFECT_TYPE.EFFECT_SACRIFICE then
		self.m_showCancelController:setSelectedIndex(1)
	elseif var_29_5.type == var_0_1.WAVE_EFFECT_TYPE.MONSTER_NORMAL or var_29_5.type == var_0_1.WAVE_EFFECT_TYPE.MONSTER_HARD or var_29_5.type == var_0_1.WAVE_EFFECT_TYPE.MONSTER_BOSS then
		var_29_6 = #var_29_1:getALLUniteTokens() > 0 and 2 or 0

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FOG_NIGHTMARE_SKIP_FORMATION) then
			self.m_skipFormation:setVisible(true)
		end
	end

	if #self._waves > 1 then
		self.m_skipChallenge:setVisible(true)
		var_0_2:getFormationData():setStageSkipChallengeBtnVisible(true)
		self.m_skipChallenge:setSelected(var_0_2:getFormationData():getStageSkipChallenge())
	else
		self.m_skipChallenge:setVisible(false)
		var_0_2:getFormationData():setStageSkipChallengeBtnVisible(false)
	end

	self.m_wavePosStateController:setSelectedIndex(var_29_6)
	self.m_hasLoadController:setSelectedIndex(var_29_0:canRecall() and 1 or 0)

	local var_29_7 = var_29_0:getType()

	if var_29_7 == var_0_1.WAVE_EFFECT_TYPE.EFFECT_RECOVER then
		self.m_spKnightIconController:setSelectedIndex(1)
		self.m_spIconLoader:setURL("ui://fogNightmare/pic_wjmy_guanqia_role2")
	elseif var_29_7 == var_0_1.WAVE_EFFECT_TYPE.EFFECT_REVIVAL then
		self.m_spKnightIconController:setSelectedIndex(1)
		self.m_spIconLoader:setURL("ui://fogNightmare/pic_wjmy_guanqia_role3")
	elseif var_29_7 == var_0_1.WAVE_EFFECT_TYPE.EFFECT_CHOICE then
		self.m_spKnightIconController:setSelectedIndex(1)
		self.m_spIconLoader:setURL("ui://fogNightmare/pic_wjmy_guanqia_role1")
	elseif var_29_7 == var_0_1.WAVE_EFFECT_TYPE.EFFECT_SACRIFICE then
		self.m_spKnightIconController:setSelectedIndex(1)
		self.m_spIconLoader:setURL("ui://fogNightmare/pic_wjmy_guanqia_role4")
	else
		self.m_spKnightIconController:setSelectedIndex(0)
		self.m_knightPicComp:updateKnight({
			resId = var_29_0:getShowRes()
		})
		self.m_knightPicComp:setAlphaLRDistance(300)
		self.m_knightPicComp:setScale(0.8)
	end
end

function FogNightmareStageComp:checkSpeTickGuide()
	if var_0_2:getTowerData():isNeedPhaseRewardGuide() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_STAGE_REWARD",
			targetBtn = self.m_rewardBtn
		})
	end
end

function FogNightmareStageComp:_onFogBackSucc(arg_31_1, arg_31_2, arg_31_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(500196))
	self:updateView()
	self:_showChildComp(math.max(self._selectWaveIdx + 1, 1))
end

function FogNightmareStageComp:onUnload()
	if self._typeWriter then
		self._typeWriter:finish()

		self._typeWriter = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightmareStageComp:_onTouchBg()
	self.m_buffTipController:setSelectedIndex(0)
end

function FogNightmareStageComp:receiveCompEvent(arg_34_1, arg_34_2)
	if self.m_buffTipController:getSelectedIndex() == 1 then
		self.m_buffTipController:setSelectedIndex(0)

		return
	end

	if arg_34_1 == "Event_fog_click_buff_icon" then
		self.m_buffTipController:setSelectedIndex(1)
		self.m_buffTipText:setText(arg_34_2.desc)
	end
end

function FogNightmareStageComp:_onClickSkipFormationBtn(arg_35_1)
	print("FogNightmareStageComp:_onClickSkipFormationBtn----------->")
	var_0_2:getFormationData():setStageSkipFormation((arg_35_1:getSender():isSelected()))
end

function FogNightmareStageComp:_onClickSkipChallengeBtn()
	var_0_2:getFormationData():setStageSkipChallenge((self.m_skipChallenge:isSelected()))
end

function FogNightmareStageComp:_gotoFogFormation()
	if self._waves[self._selectWaveIdx + 1]:isFinish() then
		return
	end

	self._curShowComp:_doClickAction({
		floor = self._floorStruct,
		stage = self._stageStruct,
		wave = self._selectWaveIdx + 1
	})
end

function FogNightmareStageComp:_skipFogNightmareChallenge()
	local var_38_0 = var_0_2:getFormationData()

	var_38_0:getAllLineUpFormations(true)

	if table.nums((var_38_0:getLineUpFormation(self._selectWaveIdx + 1):getKnightPosList())) == var_0_1.FORMATION_TIP_COUNT then
		if self._canSkipChallenge then
			self:_checkFormaion()

			self._canSkipChallenge = false
		end
	else
		local var_38_1 = require("app.view.base.pop.BaseConfirmPop").new

		self._confirmPop = g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(500268),
			onConfirm = handler(self, function(arg_39_0)
				arg_39_0:_gotoFogFormation()
			end),
			onCancel = handler(self, function(arg_40_0)
				arg_40_0:_skipBattle()
			end)
		}), {
			touchDisappear = true
		})
	end
end

function FogNightmareStageComp:_skipBattle()
	if table.nums((var_0_2:getFormationData():getLineUpFormation(self._selectWaveIdx + 1):getKnightPosList())) == 0 then
		self:_gotoFogFormation()
		var_0_0:tip(g.core.lang:get(500188, {
			formationName = g.core.lang:get(500142, {
				num = self._selectWaveIdx + 1
			})
		}))

		return
	end

	self:_checkFormaion()
end

function FogNightmareStageComp:_skipFogNightmareStageBattle(arg_42_1)
	local var_42_0 = g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay()

	if not var_0_2:getFormationData():checkCanSkipFormation() then
		if var_42_0 then
			if g.core.model.User.fogNightmareData:getAutoPlay():isAutoSkipEnable() then
				if arg_42_1 then
					self:_autoPlay()
				else
					self:_goBattle()
				end

				goto label_42_0
			end
		end

		if var_42_0 then
			if g.core.model.User.fogNightmareData:getAutoPlay():isAutoSkipEnable() then
				if not var_42_0 then
					local var_42_1 = require("app.view.base.pop.BaseConfirmPop").new

					self._confirmPop = g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
						title = g.core.lang:get(111026),
						desc = g.core.lang:get(500268),
						onConfirm = handler(self, function(arg_43_0)
							if g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
								arg_43_0:newScheduleOnce(function()
									g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay("")
								end, 0.5)
							end

							arg_43_0:_gotoFogFormation()
						end),
						onCancel = handler(self, function(arg_45_0)
							if arg_42_1 then
								g.core.model.User.fogNightmareData:getAutoPlay():setAutoSkipEnable(true)
								arg_45_0:_autoPlay()
							elseif g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
								g.core.model.User.fogNightmareData:getAutoPlay():setAutoSkipEnable(true)
								g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_KEEPSAKE_HIDE, false)
								arg_45_0:_goBattle()
							else
								arg_45_0:_goBattle()
							end
						end)
					}), {
						touchDisappear = true
					})
				end
			end
		end
	end

	::label_42_0::
end

function FogNightmareStageComp:_goBattle()
	local var_46_0 = var_0_2:getFormationData():getLineUpFormation(self._selectWaveIdx + 1):getKnightPosList()

	if table.nums(var_46_0) == 0 then
		var_0_0:tip(g.core.lang:get(500188, {
			formationName = g.core.lang:get(500142, {
				num = self._selectWaveIdx + 1
			})
		}))

		return
	end

	if not g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() and table.nums(var_46_0) < var_0_1.FORMATION_TIP_COUNT and not var_0_2:getNotPopParam("notPopKnightNotCountTip") then
		var_0_0:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(500182),
			desc = g.core.lang:get(500183, {
				num = var_0_1.FORMATION_TIP_COUNT
			}),
			onConfirm = handler(self, self._onClickConfirm),
			onCheck = function(arg_47_0)
				var_0_2:setNotPopParam("notPopKnightNotCountTip", arg_47_0)
			end,
			tip = {
				txt = g.core.lang:get(500186)
			}
		}))
	else
		self:_checkFormaion()
	end
end

function FogNightmareStageComp:_checkFormaion()
	if var_0_2:getFormationData():checkFormaionString() then
		self:_reqSaveFormation()
	else
		self:_reqChallenge()
	end
end

function FogNightmareStageComp:_reqSaveFormation()
	g.core.network.GameNetProxy:send_C2S_Formation_Save((var_0_2:getFormationData():getAndSaveFormationRequestParam()))
end

function FogNightmareStageComp:_reqChallenge()
	local var_50_0 = var_0_2:getTowerData()
	local var_50_1 = var_0_2:getTowerData():getFloorStruct((var_50_0:getCurrentFloorNum())):getSelectedStage()[1]

	var_50_1.setSelectWave(var_50_0, self._selectWaveIdx + 1)

	self._waveType = var_50_1:getAllWave()[self._selectWaveIdx + 1]:getType()

	g.core.network.GameNetProxy:send_C2S_Fog_ChallengeBegin({
		floor = self._floorStruct:getFloorId(),
		stage = self._stageStruct:getStageId(),
		wave = self._selectWaveIdx + 1
	})
end

function FogNightmareStageComp:_onSaveSucc()
	local var_51_0 = g.core.module.ModuleManager:getCurModule()

	if ((var_51_0 and var_51_0.display or nil) and var_51_0.display:getName()) ~= "FogNightmareExploreFormationPop" then
		self:_reqChallenge()
	end
end

function FogNightmareStageComp:_onChallengeBegin(arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	var_0_2:getFormationData():setBattleFormation(self._selectWaveIdx + 1)

	if self._debugFastBattle then
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_52_4.battle_id)

		local var_52_0 = self

		g.core.common.Scheduler:newScheduleOnce(function()
			var_52_0:debugUpdateView()
			g.core.battle.BattleShowResult:enableAll()
		end, 0.5)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")
	local var_52_2 = 1

	if self._waveType == var_0_1.WAVE_EFFECT_TYPE.MONSTER_BOSS then
		var_52_2 = 2
	end

	local var_52_3 = var_0_2:getAutoPlay()

	if not var_52_3:isAutoPlay() and var_0_2:getFormationData():getStageSkipChallenge() and g.core.module.ModuleManager:getCurModule().display.getName(var_52_3) ~= "FogNightmareExploreFormationPop" then
		g.core.battle.BattleShowResult:enableAll()
		g.core.battle.BattleProxy:fastBattle(arg_52_4.battle_id)

		return
	end

	g.core.battle.BattleProxy:enterBattle({
		id = arg_52_4.id,
		battle_id = arg_52_4.battle_id,
		type = BattleConst.TYPE_FOG_NIGHTMARE,
		typeQuality = var_52_2,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		BattleConst.SKIP_TYPE.ACTIVE,
		canSkip = true,
		cloudLoading = true,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MENU_WUJINGMENGYAN_BATTLE,
		bgId = self:getBattleBg()
	})
end

function FogNightmareStageComp:_onChallengeFinish(arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	if var_0_2:getFormationData():getStageSkipChallenge() then
		self._canSkipChallenge = true

		self:updateView(true)
		self:_autoSelectWave()
	end
end

function FogNightmareStageComp:getBattleBg()
	local var_55_0

	for iter_55_0 = 1, g.core.config.fog_stage_info.getLength() do
		local var_55_1 = g.core.config.fog_stage_info.indexOf(iter_55_0)

		if var_55_1.stage_id == self._stageStruct:getStageId() and var_55_1.wave == self._selectWaveIdx + 1 then
			var_55_0 = var_55_1.battle_field

			break
		end
	end

	return var_55_0
end

function FogNightmareStageComp:_isMonsterType()
	local var_56_0 = self._waves[self._selectWaveIdx + 1]:getType()

	if var_56_0 == var_0_1.WAVE_EFFECT_TYPE.MONSTER_NORMAL or var_56_0 == var_0_1.WAVE_EFFECT_TYPE.MONSTER_HARD or var_56_0 == var_0_1.WAVE_EFFECT_TYPE.MONSTER_BOSS then
		return true
	end

	return false
end

function FogNightmareStageComp:_onClickConfirm()
	self:_checkFormaion()
	var_0_2:saveNotPopParamJson()
end

return FogNightmareStageComp
