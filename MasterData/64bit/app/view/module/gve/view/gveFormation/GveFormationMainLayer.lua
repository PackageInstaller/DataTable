local var_0_0 = g.core.model.User.succubaData
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_2 = g.core.const.ConstMgr.FormationConst
local var_0_3 = g.core.config.monster_team_info
local var_0_4 = g.core.config.gve_boss_info
local var_0_5 = g.core.config.massive_monster_team_info
local var_0_6 = g.core.config.gve_base_info
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.model.User.gveDataMgr
local var_0_9 = g.core.module.ModuleManager
local var_0_10 = g.core.const.ConstMgr.LineUpConst
local var_0_11 = {
	MONST = 1,
	USER = 0,
	BOSS = 2
}
local var_0_12 = 1
local GveFormationMainLayer = class("GveFormationMainLayer", require("app.fairyGUI.gve.UI_GveFormationMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/gve/gve",
		resName = "GveFormationMainLayer",
		pkgName = "gve",
		isFullScreen = true
	}, ...)
end)

function GveFormationMainLayer:ctor(arg_2_1, arg_2_2)
	self._params = arg_2_2 or {}
	self._monsterInfo = {}
	self._monsterIndex = self._params.wave or 1
	self._isBigBossStage = false
	self._isBoss = arg_2_1
	self._stageInfo = nil
	self._bossInfo = nil
	self._formationData = var_0_8:getGveFormationData()
	self._oldPower = 0
	self._isInBattle = false
	self._isClickReturn = false
	self._isClickHome = false
	self._targetPos = 0
	self._moveComp = nil
	self._selectedComp = nil
	self._isTouched = false
	self._touchStep = 0
	self._touchIndex = 0
	self._debugFastBattle = false
	self._isSaveAndBattling = false
	self._curUsedFormationIndex = self._formationData:getCurUserFormationIndex()

	self:_initData(self._params.monsterId, self._params.baseId)
	self:_initView()
	self.m_enterTransition:play()
end

function GveFormationMainLayer:_initData(arg_3_1, arg_3_2)
	if self._isBoss then
		local var_3_0 = var_0_4.get(arg_3_1 or 1)

		self._bossInfo = var_3_0
		self._isBigBossStage = var_3_0.boss_form_interface == var_0_12 and self._monsterIndex == 0
		self._monsterInfo = {
			isBossInfo = true,
			info = var_3_0,
			monsterIndex = self._monsterIndex
		}
	else
		self._stageInfo = var_0_6.get(arg_3_2 or 1)
		self._monsterInfo = {
			isBossInfo = false,
			info = var_0_5.get(arg_3_1 or 1)
		}
	end
end

function GveFormationMainLayer:_initView()
	self.m_topBar:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_FORMATION_LAYER)
	self:addBg("bg/gve/bg_pshc_1.jpg")
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
	self.m_topBar:setHomeCallBack(handler(self, self._onClickHome))
	self.m_tabComp:getChild("tabBtn"):addClickListener(handler(self, self._onChangeTab))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_hasStarCompController:setSelectedIndex(self._isBoss and 0 or 1)
	self.m_bottomComp:initComp()

	if self._stageInfo then
		self.m_starComp:initComp(self._stageInfo)
	end

	if self._isBigBossStage then
		self.m_bossPic:setURL(var_0_7:getGveBossPath(self._bossInfo.image))
		self.m_bossBottomComp:initComp(self._bossInfo)
	end

	self.m_costActionText:setText(var_0_8:getGveBaseCfg().action_cost)
end

function GveFormationMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCHALLENGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, self._onGetFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_CHALLENGEBOSSBEGIN, self._onRcvBossBattleFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD, self._onBossNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_CHALLENGE_BEGIN_ERROR, self._onRcvError, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_FLUSH, handler(self, self._onGetPresetFormationFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onS2CNoticeAllianceState), self)
	self._formationData:refreshAllKnightArtifact()

	if self._formationData:isGetFormation() then
		self:updateView()
	else
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = 3
		})
	end

	if not self._formationData:isGetPresetFormationData() then
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Flush({
			tp = var_0_2.PRESET_FORMATION_TYPE.GVE
		})
	else
		self.m_dropList:updateListView()
		self:setFormationByPreset(self._curUsedFormationIndex)
	end

	if DebugCommon.getDebugGlobalValueByKey("gve_skip_battle") ~= nil then
		self._debugFastBattle = DebugCommon.getDebugGlobalValueByKey("gve_skip_battle")
	end

	self:checkTipsGuide()
	self:_onS2CNoticeAllianceState()
end

function GveFormationMainLayer:_onGetPresetFormationFlush()
	self:setFormationByPreset(self._curUsedFormationIndex)
	self.m_dropList:updateListView()
end

function GveFormationMainLayer:_onS2CNoticeAllianceState()
	if not g.core.model.User.allianceData:isInAlliance() then
		var_0_9:tip(g.core.lang:get(309198))
		self:newScheduleOnce(function()
			var_0_9:switchModuleIntelligent(g.view.entrance.HOME)
		end, 0)
	end
end

function GveFormationMainLayer:_onGetFormation()
	self:updateView()
end

function GveFormationMainLayer:_onRcvError(arg_10_1, arg_10_2, arg_10_3)
	if self._isBoss then
		g.core.network.GameNetProxy:send_C2S_GVE_BossGetInfo({
			boss_id = self._bossInfo.id,
			x = self._params.x,
			y = self._params.y
		})
	end

	self:_closeView(false)
end

function GveFormationMainLayer:_onBossNotify(arg_11_1, arg_11_2, arg_11_3)
	if not self._isBoss or self._isInBattle then
		return
	end

	if arg_11_3.boss_id == self._bossInfo.id then
		local var_11_0 = arg_11_3.guard_id or 0

		if var_11_0 == 0 then
			var_0_9:tip(g.core.lang:get(309010))
		else
			var_0_9:tip(g.core.lang:get(309024, {
				wave = var_11_0
			}))
		end

		self:_closeView(false)
	end
end

function GveFormationMainLayer:_onSaveSucc(arg_12_1, arg_12_2, arg_12_3)
	self:_reqChallenge()
end

function GveFormationMainLayer:_reqChallenge()
	local var_13_0 = var_0_8:getGveData():getTargetPath({
		x = self._params.x,
		y = self._params.y
	})

	if not var_13_0 then
		var_0_9:tip(g.core.lang:get(309140))
		self:_closeView(false)

		return
	end

	if self._isBoss then
		g.core.network.GameNetProxy:send_C2S_GVE_ChallengeBossBegin({
			seq = 1,
			guard_id = self._monsterIndex,
			challenge_type = self._monsterIndex == 0 and 1 or 2,
			boss_id = self._bossInfo.id,
			path = var_13_0
		})
	else
		g.core.network.GameNetProxy:send_C2S_GVE_WorldChallengeBegin({
			seq = 1,
			wave = self._monsterIndex,
			x = self._params.x,
			y = self._params.y,
			path = var_13_0
		})
	end
end

function GveFormationMainLayer:checkTipsGuide()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "GVE_FORMATION_NEW",
			objects = {
				[2] = self.m_formationComp:getChild("knight1"),
				[3] = self.m_dropList
			}
		})
	end, 0.5)
end

function GveFormationMainLayer:_onRcvBattleBegin(arg_16_1, arg_16_2, arg_16_3)
	if self._debugFastBattle then
		self:_closeView(false)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_GVE_BASE,
		battle_id = arg_16_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		isClientSkip = self._stageInfo.type == 2,
		bgId = self._stageInfo.battle_stage
	})

	self._isInBattle = true

	self:_closeView(false)

	self._isSaveAndBattling = false
end

function GveFormationMainLayer:_onRcvBossBattleFinish(arg_17_1, arg_17_2, arg_17_3)
	if self._debugFastBattle then
		self:_closeView(false)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")
	local var_17_1 = (arg_17_3.wave or self._monsterIndex) == 0 and self._bossInfo.boss_battle_stage or self._bossInfo.guard_battle_stage

	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_GVE_BOSS,
		battle_id = arg_17_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgId = var_17_1
	})

	self._isInBattle = true
	self._isSaveAndBattling = false

	self:_closeView(false)
end

function GveFormationMainLayer:_onChangeTab()
	if self.m_stateController:getSelectedIndex() == var_0_11.USER then
		self.m_starComp:setIsUserSelf(false)
		self.m_stateController:setSelectedIndex((self._isBigBossStage or nil) and (var_0_11.BOSS or var_0_11.MONST))
	else
		self.m_starComp:setIsUserSelf(true)
		self.m_stateController:setSelectedIndex(var_0_11.USER)
	end

	self:updateView()
end

function GveFormationMainLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "gve_formation_click_add_knight" then
		self._targetPos = arg_19_2.pos

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wujing_YouhuatiMenu_Slide)
		var_0_9:pushPopup(require("app.view.module.gve.view.gveFormation.GveLineUpKnightPop").new(), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_19_1 == "gve_formation_lineup_knight" then
		self._formationData:lineupKnight(self._targetPos, arg_19_2.struct)
		self:updateFormation(self.m_stateController:getSelectedIndex() == var_0_11.USER)
		self:updateChallengeBtn()
	elseif arg_19_1 == "gve_formation_click_add_unite" then
		self._targetPos = arg_19_2.pos

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.Recruit_Jiesuan_Single_01)
		var_0_9:pushPopup(require("app.view.module.gve.view.gveFormation.GveLineUpUniteTokenPop").new(), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_19_1 == "gve_formation_lineup_unite" then
		self._formationData:lineupUnite(self._targetPos, arg_19_2.struct)
		self.m_bottomComp:updateComp(self._monsterInfo)
	elseif arg_19_1 == "gve_formation_click_add_pet" then
		self._targetPos = arg_19_2.pos

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wujing_YouhuatiMenu_Slide)
		var_0_9:pushPopup(require("app.view.module.gve.view.gveFormation.GveLineUpPetPop").new(), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_19_1 == "gve_formation_click_add_succuba" then
		self._targetPos = arg_19_2.pos

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wujing_YouhuatiMenu_Slide)
		var_0_9:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
			isFilter = true,
			itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
			allList = var_0_0:getSuccubaList(),
			isLineUpCall = handler(self, self._isLineupSuccubaCall),
			clickCheckFunc = handler(self, self._clickLineupSuccuba),
			cellParam = {
				formationType = var_0_10.MulTeamType.GVE
			}
		}), {
			blackOpacity = 0.5,
			ignoreTouch = false,
			touchDisappear = false
		})
	elseif arg_19_1 == "gve_formation_lineup_pet" then
		self._formationData:lineupPet(self._targetPos, arg_19_2.struct)
		self.m_bottomComp:updateComp(self._monsterInfo)
	elseif arg_19_1 == "gve_click_preset_formation_index" then
		if arg_19_2.formationIndex ~= self._curUsedFormationIndex then
			local var_19_0 = self._formationData:getPresetFormationStruct(self._curUsedFormationIndex)

			var_19_0:loadFormationWithFightFormation(self._formationData:getFormationRequestParam(1).formations[1])

			if var_19_0:isChangeFormation() then
				self:popConfirmView(var_19_0, function()
					var_19_0:resetSvrData()
				end)
			end

			self._curUsedFormationIndex = arg_19_2.formationIndex

			self:setFormationByPreset(arg_19_2.formationIndex)
		end
	end
end

function GveFormationMainLayer:setFormationByPreset(arg_21_1)
	self.m_dropList:setShowText(g.core.lang:get(309185, {
		index = arg_21_1
	}))
	self._formationData:setFormationByPresetIndex(arg_21_1)
	self:updateView()
end

function GveFormationMainLayer:updatePreciousSuitBtn(arg_22_1)
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - 294)
			self:addChild(self._preciousSuitBtn)
		end

		if arg_22_1 then
			self._preciousSuitBtn:setVisible(true)
			self._preciousSuitBtn:setBtnFormationData(var_0_10.MulTeamType.GVE, 1)
		else
			self._preciousSuitBtn:setVisible(false)
		end
	end
end

function GveFormationMainLayer:updateView()
	local var_23_0 = self.m_stateController:getSelectedIndex() == var_0_11.USER

	self:updateFormation(var_23_0)
	self:updateBottom(var_23_0)
	self:updateChallengeBtn()
end

function GveFormationMainLayer:updateChallengeBtn()
	self.m_challengeBtn:setGrayed(not (self._formationData:isCanChallengeByKnight() and self._formationData:isEnoughKnightsAction(var_0_8:getGveBaseCfg().action_cost)))
end

function GveFormationMainLayer:_onClickChallengeBtn()
	if self._isSaveAndBattling then
		return
	end

	if not var_0_8:getGveData():getTargetPath({
		x = self._params.x,
		y = self._params.y
	}) then
		var_0_9:tip(g.core.lang:get(309140))
		self:_closeView(false)

		return
	end

	if not self._formationData:isCanChallengeByKnight() then
		var_0_9:tip(g.core.lang:get(309105))
	elseif not self._formationData:isEnoughKnightsAction(var_0_8:getGveBaseCfg().action_cost) then
		var_0_9:tip(g.core.lang:get(309107))
	elseif not self._formationData:isLockKnights() then
		var_0_9:tip(g.core.lang:get(309106))
	elseif self:checkBaseChallengeState() then
		local var_25_0 = self._formationData:getFormationRequestParam(1)

		self:checkAndSaveFormation(var_25_0)
		g.core.network.GameNetProxy:send_C2S_Formation_Save(var_25_0)

		self._isSaveAndBattling = true

		self._formationData:setCurUserFormationIndex(self._curUsedFormationIndex)
	end
end

function GveFormationMainLayer:checkAndSaveFormation(arg_26_1)
	local var_26_0 = self._formationData:getPresetFormationStruct(self._curUsedFormationIndex)

	var_26_0:loadFormationWithFightFormation(arg_26_1.formations[1])

	if var_26_0:isChangeFormation() then
		self._formationData:setNeedSaveFormation(var_26_0)
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(var_26_0:toOutBaseFormation())
			}
		})
	end
end

function GveFormationMainLayer:checkBaseChallengeState()
	local var_27_0 = var_0_8:getGveData()

	if self._isBoss then
		return not var_27_0:getBossData(self._bossInfo.id):isDeadByIndex(self._monsterIndex)
	else
		local var_27_1 = var_27_0:getCurGridBaseData(self._params.x, self._params.y)

		if (var_27_1.wave or 0) >= self._monsterIndex then
			g.core.module.ModuleManager:tip(g.core.lang:get(309192))

			return false
		end

		local var_27_2 = var_27_1.own_user_id

		if not var_27_1.own_user_id then
			return true
		end

		if (var_27_1.lock_ts or 0) > g.core.common.ServerTime:getTime() and var_27_2 ~= g.core.model.User:getId() then
			g.core.module.ModuleManager:tip(g.core.lang:get(309192))

			return false
		end

		return true
	end
end

function GveFormationMainLayer:updateBottom(arg_28_1)
	self.m_bottomComp:setIsShowSelf(arg_28_1)
	self.m_bottomComp:updateComp(self._monsterInfo)
end

function GveFormationMainLayer:updateFormation(arg_29_1)
	self.m_formationComp:updateComp(arg_29_1, self._monsterInfo, self._params.x, self._params.y)
	self:updatePreciousSuitBtn(arg_29_1)

	if arg_29_1 then
		local var_29_0 = self._formationData:getFormationFightValue()

		self.m_fightValueText:setText(var_29_0)

		if self._oldPower ~= var_29_0 then
			self.m_fightValueText:runChangeAni(self._oldPower, var_29_0, false)

			self._oldPower = var_29_0
		end
	elseif self._monsterInfo.isBossInfo then
		self.m_fightValueText:setText(var_0_3.get(self._monsterInfo.monsterIndex == 0 and self._monsterInfo.info.boss_team or self._monsterInfo.info["guard_" .. self._monsterInfo.monsterIndex], 1).fight)
	else
		self.m_fightValueText:setText(self._monsterInfo.info.fight)
	end
end

function GveFormationMainLayer:_onTouchBegin(arg_30_1)
	if self._isTouched then
		return
	end

	arg_30_1:captureTouch()

	local var_30_0 = arg_30_1:getInput():getTouch():getLocation()

	if self.m_isShowDropListController:getSelectedIndex() == 1 and not self.m_dropList:checkPosIsInComp(var_30_0) then
		self.m_isShowDropListController:setSelectedIndex(0)
	end

	if self.m_starComp:onTouchBegin(var_30_0) then
		return
	end

	if self.m_stateController:getSelectedIndex() ~= var_0_11.USER then
		return
	end

	self._touchStep = 0

	local var_30_1, var_30_2 = self.m_formationComp:checkPosInComp(var_30_0, false, true)

	if var_30_1 > 0 and var_30_2 then
		self._isTouched = true
		self._touchIndex = var_30_1
		self._selectedComp = var_30_2

		if not self._moveComp then
			self._moveComp = fgui.UIPackage:createObject("gve", "GveFormationKnightComp")

			self._moveComp:setTouchable(false)
			self:addChild(self._moveComp, 1)
		end

		self._moveComp:setVisible(false)
		self._moveComp:updateComp(var_30_1, self._formationData:getKnightByPos(var_30_1))

		local var_30_3 = self.m_formationComp:getPosition()
		local var_30_4 = var_30_2:getPosition()

		var_30_3.x = var_30_3.x + var_30_4.x
		var_30_3.y = var_30_3.y + var_30_4.y

		self._moveComp:setPosition(var_30_3)

		self._movePos = var_30_3

		arg_30_1:captureTouch()
	end
end

function GveFormationMainLayer:_onTouchMove(arg_31_1)
	if not self._isTouched then
		return
	end

	local var_31_0 = arg_31_1:getInput():getTouch():getDelta()

	self._movePos.x = self._movePos.x + var_31_0.x
	self._movePos.y = self._movePos.y - var_31_0.y

	self._moveComp:setPosition(self._movePos)

	self._touchStep = self._touchStep + 1

	if self._touchStep > 6 then
		if self._selectedComp then
			self._selectedComp:setCompTouch(false)
			self._selectedComp:updateComp(0, nil)

			self._selectedComp = nil
		end

		if self._moveComp then
			self._moveComp:setVisible(true)
		end
	end
end

function GveFormationMainLayer:_onTouchEnd(arg_32_1)
	if self._isTouched then
		self._isTouched = false

		self._moveComp:setVisible(false)

		if self._touchIndex > 0 then
			local var_32_0, var_32_1 = self.m_formationComp:checkPosInComp(arg_32_1:getInput():getTouch():getLocation(), true, false)

			if var_32_0 ~= self._touchIndex then
				if var_32_0 > 0 then
					self._formationData:lineupKnight(var_32_0, self._formationData:getKnightByPos(self._touchIndex))
				else
					self._formationData:lineupKnight(self._touchIndex, nil)
				end
			end

			self._touchIndex = 0

			self:updateFormation(self.m_stateController:getSelectedIndex() == var_0_11.USER)
			self:updateChallengeBtn()
		end
	else
		self.m_bottomComp:checkIsTouchEnd(arg_32_1)
	end
end

function GveFormationMainLayer:_closeView(arg_33_1)
	local var_33_0 = self._formationData:getPresetFormationStruct(self._curUsedFormationIndex)

	var_33_0:loadFormationWithFightFormation(self._formationData:getFormationRequestParam(1).formations[1])

	if var_33_0:isChangeFormation() then
		self._formationData:setNeedSaveFormation(var_33_0)
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(var_33_0:toOutBaseFormation())
			}
		})
	end

	self:closeView()
end

function GveFormationMainLayer:_onClickClose()
	local var_34_0 = self._formationData:getPresetFormationStruct(self._curUsedFormationIndex)

	var_34_0:loadFormationWithFightFormation(self._formationData:getFormationRequestParam(1).formations[1])

	if var_34_0:isChangeFormation() then
		self:popConfirmView(var_34_0, handler(self, self.closeView))
	else
		self:closeView()
	end
end

function GveFormationMainLayer:_onClickHome()
	local var_35_0 = self._formationData:getPresetFormationStruct(self._curUsedFormationIndex)

	var_35_0:loadFormationWithFightFormation(self._formationData:getFormationRequestParam(1).formations[1])

	if var_35_0:isChangeFormation() then
		self:popConfirmView(var_35_0, handler(self, self.switchHome))
	else
		self:switchHome()
	end
end

function GveFormationMainLayer:popConfirmView(arg_36_1, arg_36_2)
	local var_36_0 = require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(309186),
		onConfirm = function()
			self._formationData:setNeedSaveFormation(arg_36_1)
			g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
				formations = {
					(arg_36_1:toOutBaseFormation())
				}
			})

			if arg_36_2 then
				arg_36_2()
			end

			g.core.module.ModuleManager:tip(g.core.lang:get(308504))
		end,
		onCancel = arg_36_2
	})

	var_0_9:pushPopup(var_36_0)
	var_36_0:updateConfirmBtnText(g.core.lang:get(309187))
end

function GveFormationMainLayer:closeView()
	self.m_formationComp:setVisible(false)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveFormationMainLayer:switchHome()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GveFormationMainLayer:_isLineupSuccubaCall(arg_40_1)
	return self._formationData:checkSuccubaIsLineUp(arg_40_1:getSid())
end

function GveFormationMainLayer:_clickLineupSuccuba(arg_41_1)
	self._formationData:lineupSuccuba(self._targetPos, arg_41_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.GVE_CHANGE_SUCCUBA)
	self.m_bottomComp:updateComp(self._monsterInfo)

	return true
end

return GveFormationMainLayer
