local var_0_0 = g.core.const.ConstMgr.ChatConst
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = {
	1.2,
	1.6,
	2.6
}
local var_0_3 = g.core.model.User.chatData
local var_0_4 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local BattleUILayer = class("BattleUILayer", require("app.fairyGUI.battle.UI_BattleUILayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/battle/battle",
		resName = "BattleUILayer",
		pkgName = "battle"
	})
end)

function BattleUILayer:ctor(arg_2_1, arg_2_2, arg_2_3)
	self:setSize(display.width, display.height)

	self._battleLayer = arg_2_1
	self._battleReport = arg_2_2
	self._ownTokenList = self._battleReport.own_teams[1].combo.tokens or {}
	self._succubaList = self._battleReport.own_teams[1].succubas or {}
	self._isPause = false
	self._isAuto = false
	self._speedLv = BattleConst.SPEED_CONTROL.LV1
	self._isInAnime = nil
	self._battleConfig = g.core.common.Storage:load("battle.json") or {
		speedLv = 1
	}
	self._round = 1
	self._wave = 1
	self._headShow = true
	self._unitShow = true
	self._maskComp = nil
	self._criSprite = nil
	self._chatPop = nil
	self._chatRoot = nil
	self._isGetAddFriendChatMessage = false
	self._curtainData = {}
	self._hasClicked = false

	self.m_controlComp:initBtn(arg_2_3)
	self:_showChatComp()
	self.m_bgNode:setVisible(false)
	self.m_bgNode:addClickListener(handler(self, self.onClickBg))

	local var_2_0

	if (g.core.common.Setting:getValue(g.core.common.Setting.FUNC_FPS) or 0) == 1 then
		var_0_2 = {
			1.2,
			1.6,
			2.1
		}
	else
		var_0_2 = {
			1.2,
			1.6,
			2.6
		}
		var_2_0 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA) or self._battleLayer:isHasSuccuba()
	end

	self.m_succubaComp:setVisible(var_2_0)
end

function BattleUILayer:onLoad()
	if var_0_4 and var_0_4.judgeIsRefuseBioInviteIfEnterModule then
		var_0_4:judgeIsRefuseBioInviteIfEnterModule()
	end

	self:_initView()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_ADDFRIEND, handler(self, self._onRequestFriendAddBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIENDREQUEST, handler(self, self._onGetOtherAddSelfNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.APP_ENTER_BACKGROUND_EVENT, handler(self, self.onEnterBackgroundPause), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.APP_ENTER_FOREGROUND_EVENT, handler(self, self.onEnterForgeGroundPause), self)
end

function BattleUILayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:removeChatPop()
end

function BattleUILayer:setAutoStatus(arg_5_1)
	self._isAuto = arg_5_1
end

function BattleUILayer:getAutoStatus()
	return self._isAuto
end

function BattleUILayer:_initView()
	self.m_uniteComp:initUniteSkill(self._ownTokenList)
	self.m_succubaComp:initSuccubaSkill(self._succubaList)
	self.m_warBandComp:initData(self._battleLayer._battleField:getBattleData())
	self:updateBonusShow(self._battleLayer._drop)

	if self._battleReport.win_condition then
		self.m_conditionComp:setVisible(true)
		self.m_conditionComp:update(self._battleReport.win_condition)
	else
		self.m_conditionComp:setVisible(false)
	end

	self.m_headerComp:updateView(self._battleReport)
	self:initControlComp()

	if BattleConst.DEBUG then
		self:_initDebug()
	end

	self.m_succubaComp:setBattleData(self._battleLayer:getBattleData())
end

function BattleUILayer:initControlComp()
	local var_8_0 = self._battleLayer:isForceAuto()
	local var_8_1 = g.core.battle.BattleProxy:getType()

	if g.core.battle.BattleProxy:getBattleType() == BattleConst.BATTLE_TYPE.PVE then
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_AUTO) and not var_8_0 then
			local var_8_2 = g.core.common.Storage:load("battle_control.json") or {}

			if not var_8_2.isUnlock then
				g.core.common.Storage:save("battle_control.json", {
					autoGuide = false,
					isUnlock = true,
					isAuto = false
				})
			else
				self:setAutoStatus(var_8_2.isAuto)
				self:setAuto(var_8_2.isAuto)
			end
		else
			self:setAutoStatus(var_8_0)
			self:setAuto(var_8_0)
		end
	else
		if var_8_1 == BattleConst.TYPE_FRIEND_PVP then
			var_8_0 = true
		end

		self:setAutoStatus(var_8_0)
		self:setAuto(var_8_0)
	end

	self:_checkAndShowAutoGuide()
	self._battleLayer._battleField:setAuto(self._isAuto)

	self._speedLv = self._battleConfig.speedLv or BattleConst.SPEED_CONTROL.LV1

	self.m_controlComp:updateAutoBtnStatus(self._isAuto)
	self.m_controlComp:updateSpeedBtnStatus(self._speedLv)
	self._battleLayer:setSpeed(var_0_2[self._speedLv])

	if var_8_1 == BattleConst.TYPE_DEMON_BOSS then
		self.m_succubaComp:setVisible(false)
	end

	self:setShowShmcComp(true)
	self.m_shmcComp:setLastMaxDamage(self._battleReport.spire_max_damage or 0)
end

function BattleUILayer:setShowShmcComp(arg_9_1, arg_9_2)
	if g.core.battle.BattleProxy:getType() == BattleConst.TYPE_SPIRE_BOSS then
		self.m_shmcComp:setVisible(true)
	else
		self.m_shmcComp:setVisible(false)
	end
end

function BattleUILayer:updateShmcDamage(arg_10_1)
	self.m_shmcComp:updateCurDamage(arg_10_1)
end

function BattleUILayer:_checkAndShowAutoGuide()
	local var_11_0 = g.core.common.Storage:load("battle_control.json")
	local var_11_1

	if not var_11_0 or var_11_0.autoGuide then
		do return end

		var_11_1 = {
			key = "FIRST_ENTER_FIGHT_WITH_AUTO_OPEN"
		}
	end

	var_11_1.targetBtn = self.m_controlComp.m_autoBtn

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, var_11_1)
end

function BattleUILayer:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "BattleCtrl_Pause" then
		self:_onClickPause()
	elseif arg_12_1 == "BattleCtrl_Speed" then
		self:_onClickSpeed(arg_12_2.isAllOpen)
	elseif arg_12_1 == "BattleCtrl_Auto" then
		self:_onClickAuto()
	elseif arg_12_1 == "BattleCtrl_Skip" then
		self:_onClickSkip()
	elseif arg_12_1 == "BattleCtrl_Unite" then
		self._battleLayer:_onUniteFire(arg_12_2.skillId, arg_12_2.cost)
	end
end

function BattleUILayer:onEnterBackgroundPause()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if self._isPause then
		return
	end

	if not g.core.battle.BattleProxy:isInBattle() then
		return
	end

	if not self._battleLayer or not self._battleLayer.isBattleFinish then
		g.core.battle.BattleProxy:exitBattle()

		return
	end

	if self._battleLayer:isBattleFinish() then
		return
	end

	self._isPause = not self._isPause

	self._battleLayer:setPause(self._isPause)
	self._battleLayer:checkExtraTxt()

	if self._isPause then
		self._battleLayer:showPauseLayer()
	end
end

function BattleUILayer:onEnterForgeGroundPause()
	self._battleLayer:checkBackGroundReverse()
end

function BattleUILayer:_onClickPause()
	self._isPause = not self._isPause

	self._battleLayer:setPause(self._isPause)
	self._battleLayer:checkExtraTxt()

	if self._isPause then
		self._battleLayer:showPauseLayer()
	else
		self._battleLayer:removePauseLayer()
	end
end

function BattleUILayer:_onClickSpeed(arg_16_1)
	if self._battleLayer:getChangeSpeedLock() then
		return
	end

	self._speedLv = self._speedLv + 1

	if self._speedLv > BattleConst.SPEED_CONTROL.LV3 then
		self._speedLv = BattleConst.SPEED_CONTROL.LV1
	end

	if not arg_16_1 and self._speedLv > BattleConst.SPEED_CONTROL.LV2 then
		self._speedLv = BattleConst.SPEED_CONTROL.LV1
	end

	self._battleConfig.speedLv = self._speedLv

	g.core.common.Storage:save("battle.json", self._battleConfig)
	self._battleLayer:setSpeed(var_0_2[self._speedLv])
	self.m_controlComp:updateSpeedBtnStatus(self._speedLv)
end

function BattleUILayer:_onClickAuto()
	local var_17_0 = self._battleLayer:getAtkType()

	if var_17_0 == BattleConst.BATTLE_TYPE.PVP or var_17_0 == BattleConst.BATTLE_TYPE.VIDEO or self._battleLayer:isForceAuto() then
		g.core.module.ModuleManager:tip(g.core.lang:get(110010))

		return
	end

	local var_17_1 = g.core.common.Storage:load("battle_control.json") or {}

	self._isAuto = not self._isAuto
	var_17_1.isAuto = self._isAuto

	local var_17_2 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_AUTO)

	self._battleLayer:setAuto(self._isAuto)
	self.m_controlComp:updateAutoBtnStatus(self._isAuto)

	if self._isAuto and not var_17_1.autoGuide then
		var_17_1.autoGuide = true
	end

	g.core.common.Storage:save("battle_control.json", var_17_1)
end

function BattleUILayer:setAuto()
	self._battleLayer:setAuto(self._isAuto)
	self.m_controlComp:updateAutoBtnStatus(self._isAuto)
end

function BattleUILayer:_onClickSkip()
	self._battleLayer:skipPVE()
end

function BattleUILayer:doAutoSkip()
	self._battleLayer:skipPVE()
end

function BattleUILayer:updateCurRound(arg_21_1)
	self.m_roundComp:updateCurRound(arg_21_1, (self:getMaxRound()))
end

function BattleUILayer:updateCurWave(arg_22_1, arg_22_2)
	self.m_roundComp:updateCurWave(arg_22_1, arg_22_2)
end

function BattleUILayer:updateUniteSkillCD(arg_23_1, arg_23_2, arg_23_3)
	self.m_uniteComp:updateUniteSkillCD(arg_23_1, arg_23_2, arg_23_3)
end

function BattleUILayer:updateSuccubaSkillCD(arg_24_1, arg_24_2, arg_24_3)
	self.m_succubaComp:updateSuccubaSkillCD(arg_24_1, arg_24_2, arg_24_3)
end

function BattleUILayer:updateUniteAdvCD(arg_25_1, arg_25_2)
	self.m_uniteComp:updateUniteAdvCD(arg_25_2, self._battleLayer:getBattleData():getComboInfo(arg_25_1):getSkillByAdvId(arg_25_2):getCD())
end

function BattleUILayer:updateUniteCostMod(arg_26_1, arg_26_2)
	self.m_uniteComp:updateUniteCostMod(arg_26_1, arg_26_2)
end

function BattleUILayer:updateCurUnite(arg_27_1)
	self.m_uniteComp:updateCurUnite(arg_27_1)
end

function BattleUILayer:updateCurSuccuba(arg_28_1)
	self.m_succubaComp:updateCurSuccuba(arg_28_1)
end

function BattleUILayer:addUniteValue(arg_29_1)
	self.m_uniteComp:addUniteValue(arg_29_1)
end

function BattleUILayer:addWarBandValue(arg_30_1)
	self.m_warBandComp:addWarBandValue(arg_30_1)
end

function BattleUILayer:addSuccubaValue(arg_31_1)
	self.m_succubaComp:addSuccubaValue(arg_31_1)
end

function BattleUILayer:updateUniteView(arg_32_1, arg_32_2)
	self.m_uniteComp:updateUniteView(arg_32_1, arg_32_2)
end

function BattleUILayer:updateSuccubaView(arg_33_1, arg_33_2)
	self.m_succubaComp:updateSuccubaView(arg_33_1, arg_33_2)
end

function BattleUILayer:updateWarBandView()
	self.m_warBandComp:initData(self._battleLayer._battleField:getBattleData())
end

function BattleUILayer:_onClickSkillIcon(arg_35_1)
	self.m_uniteComp:_onClickSkillIcon(arg_35_1)
end

function BattleUILayer:updatePauseBtnStatus(arg_36_1)
	self._isPause = arg_36_1

	self.m_controlComp:updatePauseBtnStatus(arg_36_1)
end

function BattleUILayer:updateUniteShow(arg_37_1)
	self.m_uniteComp:setVisible(arg_37_1)
	self.m_effectGroup:setVisible(arg_37_1)
end

function BattleUILayer:getTokenIds()
	return self.m_uniteComp:getTokenIds()
end

function BattleUILayer:updateBonusShow(arg_39_1)
	if arg_39_1 then
		self:updateBonusNum(0, 0)
	end
end

function BattleUILayer:updateBonusNum(arg_40_1, arg_40_2)
	return
end

function BattleUILayer:showAutoTips(arg_41_1, arg_41_2)
	if arg_41_2 == self._isInAnime then
		return
	end

	self._isInAnime = arg_41_2
end

function BattleUILayer:hideAutoTips()
	self._isInAnime = false
end

function BattleUILayer:updateConditionComp(arg_43_1)
	self.m_conditionComp:updateCurStateInfo(arg_43_1)
end

function BattleUILayer:addNodeToPlaceHolder(arg_44_1, arg_44_2)
	if not arg_44_2 then
		return
	end

	if self["m_skillPlaceHolder" .. arg_44_2] then
		self["m_skillPlaceHolder" .. arg_44_2]:addChild(arg_44_1)
	end
end

function BattleUILayer:addNodeToUnitePlaceHolder(arg_45_1)
	self.m_unitePlaceHolder:addChild(arg_45_1)
end

function BattleUILayer:isToday(arg_46_1)
	arg_46_1 = arg_46_1 or 0

	return os.date("%Y-%m-%d", arg_46_1) == os.date("%Y-%m-%d", os.time())
end

function BattleUILayer:addCriSpriteToNode(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	self._curtainData = {}
	self._hasClicked = false
	self._curtainData = arg_47_3

	self.m_skipTIpController:setSelectedIndex(0)

	self._maskComp = fgui.UIPackage:createObject("battle", "BattleFullScreenMaskComp")

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CLICK_JUMP_CG) then
		local var_47_0 = g.core.common.Storage:load("battle_cg_skip.json") or {}

		if var_47_0.timeStamp and self:isToday(var_47_0.timeStamp) and var_47_0.times and var_47_0.times >= 3 then
			self.m_skipTIpController:setSelectedIndex(0)
			self._maskComp:getChild("mask"):addClickListener(function()
				self._hasClicked = true

				arg_47_2("complete", false)
			end)
		else
			self.m_skipTIpController:setSelectedIndex(1)
			self._maskComp:getChild("mask"):addClickListener(function()
				self._hasClicked = true

				arg_47_2("complete", false)
			end)

			local var_47_1 = {
				timeStamp = os.time()
			}

			var_47_1.times = (var_47_0.times or 0) + 1

			g.core.common.Storage:save("battle_cg_skip.json", var_47_1)
		end
	end

	self.m_criSprPlaceHolder:addChild(self._maskComp)

	self._criSprite = self.m_criSprPlaceHolder:addCriSprite({
		fullScreenState = 2,
		moduleName = "battle",
		y = 0,
		x = 0,
		movieName = arg_47_1.cg,
		listener = arg_47_2,
		isReverse = arg_47_1.isReverse
	})

	self._criSprite:setPlaySpeed(self._battleLayer:getCurSpeed())
end

function BattleUILayer:delCriSprite()
	if self._maskComp then
		self._maskComp:removeFromParent()
	end

	if self._criSprite then
		self._criSprite:removeFromParent()
	end

	self.m_skipTIpController:setSelectedIndex(0)

	self._maskComp = nil
	self._criSprite = nil

	local var_50_0 = false

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_SKILL_ENTRANCE) then
		local var_50_1 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_TWEEN) or 0

		if var_50_1 == 0 and self._curtainData then
			if not g.core.common.Setting:isTweenFirstData(self._curtainData.actor:getKnightId() .. "_1") then
				var_50_0 = true
			end
		elseif var_50_1 == 1 then
			var_50_0 = true
		end
	end

	if self._hasClicked and self._curtainData and not ((self._curtainData and g.core.model.User.homeData:getCensorListById(self._curtainData.actor:getKnightId(), 2) or nil) and true) then
		local var_50_2 = self._curtainData.skillCfg
		local var_50_3 = self._curtainData.actor:isMonster()

		if not self._curtainData.skillCfg then
			local var_50_6 = ((var_50_3 or nil) and g.core.config.monster_info).get((self._curtainData.actor:getKnightId())).active_skill_id

			var_50_2 = g.core.config.skill_info.get(var_50_6)

			local var_50_7 = g.core.config.skill_info.get(var_50_6).curtain_name
		end

		local var_50_8 = var_50_2.curtain_name

		if var_50_2.curtain_name then
			local var_50_9 = {
				battleLayer = self._battleLayer,
				identity = self._curtainData.actor:getIdentity(),
				skillInfo = var_50_2,
				knightInfo = self._curtainData.actor:getKnightInfo(),
				skillName = var_50_8,
				isMonster = var_50_3,
				actor = self._curtainData.actor
			}
			local var_50_10 = self._battleLayer:getBattleEntryManager():getFromPool("attackCurtain")

			if var_50_10 then
				var_50_10:setData(var_50_9)
			else
				var_50_10 = require("app.view.battle.entry.BattleSkillSmallCurtainEntry").new(var_50_9)
			end

			self._battleLayer:addNewEntry(var_50_10)
		end
	end
end

function BattleUILayer:defeated(arg_51_1)
	self.m_headerComp:defeated(arg_51_1)
end

function BattleUILayer:fighting(arg_52_1)
	self.m_headerComp:fighting(arg_52_1)
end

function BattleUILayer:nextFighting(arg_53_1)
	self.m_headerComp:nextFighting(arg_53_1)
end

function BattleUILayer:setWaveResult(arg_54_1, arg_54_2)
	self.m_headerComp:setWaveResult(arg_54_1, arg_54_2)
end

function BattleUILayer:addRound()
	self._round = self._round + 1

	self.m_roundComp:updateCurRound(self._round, (self:getMaxRound()))
end

function BattleUILayer:getRound()
	return self._round
end

function BattleUILayer:updateAttackRound(arg_57_1)
	assert(type(arg_57_1) == "number", "value can't be nil")

	if arg_57_1 < 1 then
		arg_57_1 = 1
	end

	self.m_roundComp:updateCurRound(arg_57_1, (self:getMaxRound()))
end

function BattleUILayer:updateWave(arg_58_1, arg_58_2)
	if arg_58_2 < 2 then
		self.m_roundComp:updateCurWave(1, 1)

		return
	end

	wordReport("updateWave", {
		cur = arg_58_1,
		total = arg_58_2
	})

	self._round = 1

	self:updateAttackRound(self._round, (self:getMaxRound()))
	self.m_roundComp:updateCurWave(arg_58_1, arg_58_2)
end

function BattleUILayer:updateHP()
	self:updateEachHp(1, (self._battleLayer:getTotalHpPer(1)))
	self:updateEachHp(2, (self._battleLayer:getTotalHpPer(2)))
end

function BattleUILayer:updateEachHp(arg_60_1, arg_60_2)
	if arg_60_1 == 1 then
		self._battleLayer:updateCondition({
			hp = arg_60_2
		})
	else
		self._battleLayer:updateCondition({
			ehp = arg_60_2
		})
	end
end

function BattleUILayer:setCompVisible(arg_61_1)
	self.m_controlComp:setVisible(arg_61_1)
	self.m_roundComp:setVisible(arg_61_1)

	if self._battleReport.win_condition then
		self.m_conditionComp:setVisible(arg_61_1)
	end

	self.m_headerComp:setVisible(arg_61_1)
	self.m_uniteComp:setVisible(arg_61_1)
	self.m_autoNode:setVisible(arg_61_1)
	self:setHeadAndUnitShow()
end

function BattleUILayer:setHeaderCompVisible(arg_62_1)
	self.m_headerComp:setVisible(arg_62_1)

	self._headShow = arg_62_1
end

function BattleUILayer:updateUniteList(arg_63_1)
	self._ownTokenList = arg_63_1

	self.m_uniteComp:initUniteSkill(self._ownTokenList)
end

function BattleUILayer:updateSuccubaList(arg_64_1)
	self._succubaList = arg_64_1

	self.m_succubaComp:initSuccubaSkill(self._succubaList)
end

function BattleUILayer:setSkillShow(arg_65_1, arg_65_2)
	self.m_uniteComp:setSkillShow(arg_65_1, arg_65_2)
end

function BattleUILayer:setSkillUIShow(arg_66_1)
	self.m_uniteComp:setVisible(arg_66_1)

	self._unitShow = arg_66_1
end

function BattleUILayer:setHeadAndUnitShow()
	self.m_headerComp:setVisible(self._headShow)
	self.m_uniteComp:setVisible(self._unitShow)
end

function BattleUILayer:getSubComp(arg_68_1, arg_68_2)
	local var_68_0 = self

	for iter_68_0, iter_68_1 in ipairs((string.split(arg_68_1, "/"))) do
		var_68_0 = var_68_0:getChild(iter_68_1)
	end

	return var_68_0
end

function BattleUILayer:setUniteBtnTouchEnable()
	self.m_uniteComp:setUniteBtnTouchEnable()
end

function BattleUILayer:addActorDebugBtn(arg_70_1, arg_70_2)
	self.m_debugComp:getChild("place" .. arg_70_1):removeChildren()
	self.m_debugComp:getChild("place" .. arg_70_1):addChild(arg_70_2)
end

function BattleUILayer:getMaxRound()
	local var_71_0 = 20

	if self._battleReport.win_condition then
		local var_71_1 = g.core.config.battle_rating_info.get(self._battleReport.win_condition)

		if var_71_1 and (var_71_1.rating_type == 3 or var_71_1.rating_type == 4 or var_71_1.rating_type == 7 or var_71_1.rating_type == 10) then
			var_71_0 = var_71_1.rating_value
		elseif var_71_1 and (var_71_1.rating_type == 8 or var_71_1.rating_type == 9) and var_71_1.rating_type2 and var_71_1.rating_type2 == 10 then
			var_71_0 = var_71_1.rating_value2
		end
	end

	return var_71_0
end

function BattleUILayer:_initDebug()
	local var_72_0 = fgui.UIPackage:createObject("battle", "BattleActorDebugIcon")

	var_72_0:getChild("name"):setText("printReport")
	var_72_0:addClickListener(function()
		self._battleLayer:onPrintLogToFile()
	end)
	self.m_debugComp:getChild("printReport"):addChild(var_72_0)

	local var_72_1 = fgui.UIPackage:createObject("battle", "BattleActorDebugIcon")

	var_72_1:getChild("name"):setText("开关")
	var_72_1:addClickListener(function()
		self.m_debugComp:setVisible(not self.m_debugComp:isVisible())
	end)
	self:addChild(var_72_1)
	var_72_1:setPosition(0, 700)
end

function BattleUILayer:setGuideUIVisible(arg_75_1)
	self.m_uniteComp:setGuideUIVisible(arg_75_1)
end

function BattleUILayer:_onRequestFriendAddBack(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(1011))
end

function BattleUILayer:_onGetOtherAddSelfNotify(arg_77_1, arg_77_2, arg_77_3, arg_77_4)
	if not self._isGetAddFriendChatMessage then
		self._isGetAddFriendChatMessage = true

		self:_showMessageAtChatComp(arg_77_4)
	end
end

function BattleUILayer:_isCanShowChatComp()
	return g.core.battle.BattleProxy:getType() == BattleConst.TYPE_BIOTEAM
end

function BattleUILayer:_showChatComp()
	if self:_isCanShowChatComp() then
		local var_79_0 = fgui.GComponent:create()

		self.m_baseChatComp = fgui.UIPackage:createObject("base_new", "BaseChatBarComp")

		var_79_0:addChild(self.m_baseChatComp)
		self:addChild(var_79_0)
		self.m_baseChatComp:setCurChannel(g.core.const.ConstMgr.ChatConst.TROOPS)
		self.m_baseChatComp:setPosition(cc.p(0, display.height - 65))
		self.m_baseChatComp:setOverClick(handler(self, self._onClickChatComp))
	end
end

function BattleUILayer:_onClickChatComp()
	self._chatRoot = self._chatRoot or fgui.GComponent:create()

	g.core.layer.LayerManager:getBattleChatLayer():addChild(self._chatRoot)

	self._chatPop = require("app.view.module.chat.view.ChatMainPop").new({
		hideSet = true,
		type = var_0_0.TROOPS
	})

	self._chatRoot:addChild(self._chatPop)
end

function BattleUILayer:removeChatPop()
	if self._chatRoot then
		self._chatRoot:removeFromParent()

		self._chatRoot = nil
		self._chatPop = nil
	end
end

function BattleUILayer:_showMessageAtChatComp(arg_82_1)
	local var_82_0 = self:_getOtherTeamPlayerInfo(arg_82_1.id)

	if not g.core.model.User.bioData:isBioTeamBattleFriend(arg_82_1.id) then
		return
	end

	local var_82_1 = g.core.model.User.bioData:getTeamInfo()
	local var_82_2, var_82_3

	if var_82_1 then
		var_82_2 = var_82_1.id

		if not var_82_1.id then
			var_82_2 = 0
			var_82_3 = {
				isBioTeamBattleAddFriend = true,
				talk = 0,
				look = 0,
				invite_id = 0,
				channel = g.core.const.ConstMgr.ChatConst.TROOPS
			}
		end
	end

	var_82_3.content = var_0_3:getBioTeamBattleAddFriendChatMessage({
		inviter = var_82_0
	})
	var_82_3.unique_id = var_82_2 or 0
	var_82_3.user = var_82_0

	var_0_3:setAllChatInfo(var_82_3)
	var_0_3:setChatFloatInfo(var_82_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, false, 10144, var_82_3)
end

function BattleUILayer:_getOtherTeamPlayerInfo(arg_83_1)
	for iter_83_0, iter_83_1 in ipairs(self._battleReport.own_teams) do
		if iter_83_1.user and iter_83_1.user.id == arg_83_1 and not g.core.model.User:isSelfById(iter_83_1.user.id) then
			return iter_83_1.user
		end
	end
end

function BattleUILayer:onClickBg()
	self.m_bgNode:setVisible(false)

	if self._buffComp then
		self._buffComp:setVisible(false)
	end
end

function BattleUILayer:showBuffInfo(arg_85_1)
	if not self._buffComp then
		self._buffComp = require("app.view.battle.fgui.BattleBuffInfoComp").new()

		self.m_buffInfoPlaceHolder:addChild(self._buffComp)
	end

	self.m_bgNode:setVisible(true)
	self._buffComp:setVisible(true)
	self._buffComp:updateView(arg_85_1)
end

function BattleUILayer:updateBossReward(arg_86_1)
	return
end

function BattleUILayer:isCanSkipBattle()
	return self.m_controlComp:isCanSkip()
end

function BattleUILayer:updateWarBandState()
	self.m_warBandComp:updateGrayStatue()
end

return BattleUILayer
