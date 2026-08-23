local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.const.ConstMgr.DomainConst
local var_0_2 = g.core.model.User.domainData
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_4 = g.core.const.ConstMgr.SpineConst
local var_0_5 = g.core.model.User.mulFormationData
local DomainDungeonMainLayer = class("DomainDungeonMainLayer", require("app.fairyGUI.domainDungeon.UI_DomainDungeonMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/domainDungeon/domainDungeon",
		resName = "DomainDungeonMainLayer",
		pkgName = "domainDungeon",
		isFullScreen = true
	}, ...)
end)

function DomainDungeonMainLayer:ctor(arg_2_1)
	self._dungeonId = arg_2_1.dungeonId
	self._selectStageId = 1
	self._isClickBattle = false
	self._isClickSweep = false
	self._isAfterSweep = false
	self._dungeonData = var_0_2:getDungeon(self._dungeonId)

	self:addBg("bg/domain/" .. self._dungeonId .. "/bg_mnly_wanfa.jpg")
	self:_initRegisterUI()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_BLUE_PURPLE_PRIZE)
end

function DomainDungeonMainLayer:_initRegisterUI()
	self.m_lineUpBtn:addClickListener(handler(self, self._onClickedFormaition))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_topBarComp:setResInfoById(self._dungeonData:getTopResId())
	self.m_topBarComp:setTitle(self._dungeonData:getName())
	self.m_battleBtn:setIcon(var_0_2:getDungeonResource(self._dungeonId, "btn_mnly_zhandou.png"))
end

function DomainDungeonMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onS2CFormationGet), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DOMAIN_CHALLENGEBEGIN, handler(self, self._onS2CDomainChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DOMAIN_SWEEP, handler(self, self._onS2CDomainSweep), self)
	self:_sendC2SFormationGet()
end

function DomainDungeonMainLayer:_onS2CFormationGet()
	self:_updateMainView()
end

function DomainDungeonMainLayer:_updateMainView()
	self:_checkHaveSurprise()
end

function DomainDungeonMainLayer:_afterSweepRefreshView()
	if tolua.isnull(self) then
		return
	end

	self:newScheduleOnce(handler(self, function()
		self:_checkHaveSurprise(true)

		self._isClickSweep = false
	end), 0.3)
end

function DomainDungeonMainLayer:_checkHaveSurprise(arg_9_1)
	self._isAfterSweep = arg_9_1

	if var_0_2:isHaveSurprise() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.domain.view.DomainSurpriseDrawPop").new({
			dungeonId = self._dungeonId,
			callback = handler(self, self.showSurprisePop)
		})))
	elseif self._isAfterSweep then
		self:_updateStageInfo(self._selectStageId)
	else
		self:_updateStageInfo()
	end
end

function DomainDungeonMainLayer:showSurprisePop()
	if var_0_2:getSurprise().type == var_0_1.SURPRISE_TYPE.TURNTABLE then
		g.core.module.ModuleManager:pushModule(g.view.entrance.DOMAIN_TURN_GAME, {
			dungeon = self._dungeonData,
			stageId = self._selectStageId
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.DOMAIN_SLOT_MACHINE, {
			dungeon = self._dungeonData
		})
	end

	if self._isAfterSweep then
		self:_updateStageInfo(self._selectStageId)
	else
		self:_updateStageInfo()
	end
end

function DomainDungeonMainLayer:_sendC2SFormationGet()
	local var_11_0 = self._dungeonData:getFormationType()

	if not var_0_5:isInitWithSvrData(var_11_0) then
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = var_11_0
		})
	else
		self:_updateMainView()
	end
end

function DomainDungeonMainLayer:_updateLeftStage()
	local var_12_0 = self._dungeonData:getStageList()

	for iter_12_0 = 1, var_0_1.STAGE_COUNT do
		local var_12_1 = var_12_0[iter_12_0]

		if var_12_0[iter_12_0] then
			self["m_stageComp" .. iter_12_0]:updateStageComp(self._dungeonData, var_12_1)
			self["m_stageComp" .. iter_12_0]:setSelected(var_12_1 == self._selectStageId)
			self["m_stageComp" .. iter_12_0]:setVisible(true)
		else
			self["m_stageComp" .. iter_12_0]:setVisible(false)
		end
	end

	local var_12_2, var_12_3 = self._dungeonData:getNewStageGrade()

	if var_12_2 > 0 then
		self.m_stageComp1:getGradeEffComp():addEffectSpine({
			anim = "play_1",
			name = "eff_ui_domainDungeon_gradelight",
			isLoop = false,
			eventHandler = handler(self, self._onSpineEvent)
		})
		self.m_stageComp2:setStateCtrl(var_0_1.STAGE_STATE.LOCK)
		self.m_stageComp2:setSelected(false)

		local var_12_4 = self._dungeonData:getStage(var_12_2 - 1)

		self.m_stageInfoComp:updateInfoComp(self._dungeonData, var_12_4)
		self.m_enemyComp:updateEnemyComp(var_12_4)
	elseif var_12_3 > 0 then
		if self._curStageId == self._dungeonData:getMaxStageId() then
			self.m_stageComp1:getGradeEffComp():addEffectSpine({
				name = "eff_ui_domainDungeon_gradelight",
				isLoop = false,
				anim = "play_" .. var_12_3
			})
		else
			self.m_stageComp2:getGradeEffComp():addEffectSpine({
				name = "eff_ui_domainDungeon_gradelight",
				isLoop = false,
				anim = "play_" .. var_12_3
			})
		end

		self._dungeonData:resetNewStageGrade()
	end
end

function DomainDungeonMainLayer:_onSpineEvent(arg_13_1)
	if arg_13_1.type == "event" and arg_13_1.eventData.name == "unlock" then
		self.m_stageComp2:getUnlockEffComp():addEffectSpine({
			isLoop = false,
			name = "eff_ui_domainDungeon_tablight_" .. self._dungeonId,
			eventHandler = handler(self, self._onUnlcokSpineEvent)
		})
	end
end

function DomainDungeonMainLayer:_onUnlcokSpineEvent(arg_14_1)
	if arg_14_1.type == "event" and arg_14_1.eventData.name == "cut" then
		self.m_stageComp2:setSelected(true)
		self.m_stageComp2:setStateCtrl(var_0_1.STAGE_STATE.OPEN)
		self._dungeonData:resetNewStageGrade()
		self:_updateStageInfo(self._curStageId)
		self:playResetAnim()
	end
end

function DomainDungeonMainLayer:_updateStageInfo(arg_15_1)
	self._curStageId, self._curGrade = self._dungeonData:getCurStageAndGrade()
	self._isPassFinal = self._curStageId == self._dungeonData:getMaxStageId() and self._curGrade == var_0_1.GRADE.S
	self._selectStageId = arg_15_1 or self._curStageId
	self._stageStruct = self._dungeonData:getStage(self._selectStageId)

	self.m_stageInfoComp:updateInfoComp(self._dungeonData, self._stageStruct)
	self.m_enemyComp:updateEnemyComp(self._stageStruct)
	self:_updateLeftStage()
	self:_createShowKnight()

	local var_15_0 = self._dungeonData:getDungeonLeftTime()

	self.m_leftCountTxt:setText(g.core.lang:get(433157, {
		cur = var_15_0,
		max = self._dungeonData:getDungeonMaxTime()
	}))
	self.m_attackEff:removeAllEffect()

	self._stageState = self._stageStruct:getStageState()

	if self._stageState == var_0_1.STAGE_STATE.SWEEP or self._isPassFinal then
		self.m_battleBtn:setTitle(g.core.lang:get(433155))
	else
		if var_15_0 > 0 and self._dungeonData:getDungeonFreeLeftTime() > 0 then
			self.m_attackEff:addEffectSpine({
				isLoop = true,
				name = "eff_ui_domainDungeon_btnattack_" .. self._dungeonId
			})
		end

		self.m_battleBtn:setTitle(g.core.lang:get(433154))
	end

	self.m_guideHolderComp:removeChildren()
end

function DomainDungeonMainLayer:_createShowKnight()
	self._knightSpine = DrawKnight.new({
		scale = 1,
		isShowBg = true,
		isAlphaNode = true,
		resId = g.core.config.knight_base_info.get(self._stageStruct:getShowKnightInfo().res_id).painted_id
	})

	self._knightSpine:setAlphaRect(var_0_4.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:removeChildren()
	self.m_knightComp:addChild(self._knightSpine)
end

function DomainDungeonMainLayer:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "CLICK_DOMAIN_STAGE" then
		if self._selectStageId == arg_17_2.stageId then
			return
		end

		self:_updateStageInfo(arg_17_2.stageId)
		self:playResetAnim()
	end
end

function DomainDungeonMainLayer:playResetAnim()
	self.m_resetTransition:play(handler(self, self.playSwitchAnim))
end

function DomainDungeonMainLayer:playSwitchAnim()
	self.m_switchTransition:play()
end

function DomainDungeonMainLayer:_onClickedFormaition()
	g.core.module.ModuleManager:pushModule(g.view.entrance.DOMAIN_FORMATION_LAYER, {
		formationType = self._dungeonData:getFormationType(),
		dungeonId = self._dungeonId
	})
end

function DomainDungeonMainLayer:_onClickBattleBtn()
	if self._stageState == var_0_1.STAGE_STATE.SWEEP or self._isPassFinal then
		self:_goSweep()
	elseif self._stageState == var_0_1.STAGE_STATE.LOCK then
		g.core.module.ModuleManager:tip(g.core.lang:get(433158))
	else
		self:_goBattle()
	end
end

function DomainDungeonMainLayer:_checkCanBattle()
	if self._curGrade == 0 then
		if self._dungeonData:getDungeonLeftTime() == 0 and self._dungeonData:getDungeonFreeLeftTime() == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(432021))

			return false
		end
	elseif self._curGrade > 0 and self._dungeonData:getDungeonLeftTime() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432021))

		return false
	end

	local var_22_0 = g.core.model.User.mulFormationData:getFormationStructDict(self._dungeonData:getFormationType())[1]

	if not var_22_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433161))
		self:_addWeakGuideComp()

		return false
	end

	if #var_22_0:getValidKnightSidList() < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(433161))
		self:_addWeakGuideComp()

		return false
	end

	return true
end

function DomainDungeonMainLayer:_goBattle()
	if self:_checkCanBattle() then
		local var_23_0 = self._dungeonData:getFormationType()

		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_23_0,
			formations = var_0_5:getOutBaseFormationArr(var_23_0)
		})
	end
end

function DomainDungeonMainLayer:_goSweep()
	if self._dungeonData:getDungeonLeftTime() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432021))

		return
	end

	if not self._isClickSweep then
		g.core.network.GameNetProxy:send_C2S_Domain_Sweep({
			id = self._dungeonData:getId()
		})

		self._isClickSweep = true
	end
end

function DomainDungeonMainLayer:_onSaveSucc(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if not self._isClickBattle then
		g.core.network.GameNetProxy:send_C2S_Domain_ChallengeBegin({
			id = self._dungeonData:getId()
		})

		self._isClickBattle = true
	end
end

function DomainDungeonMainLayer:_onS2CDomainChallengeBegin(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	self._isClickBattle = false

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		canSkip = true,
		battle_id = arg_26_4.battle_id,
		type = BattleConst.TYPE_DOMAIN_STAGE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
end

function DomainDungeonMainLayer:_onS2CDomainSweep(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	g.core.module.ModuleManager:awardSummary(arg_27_4.grade_awards or {}, true, nil, nil, handler(self, self._afterSweepRefreshView))
end

function DomainDungeonMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.SHOP_TYPE.DOMAIN_SHOP
	})
end

function DomainDungeonMainLayer:_addWeakGuideComp()
	self.m_guideHolderComp:removeChildren()
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_29_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_29_0:setTouchable(false)
	var_29_0:updateView()
	self.m_guideHolderComp:addChild(var_29_0)
end

return DomainDungeonMainLayer
