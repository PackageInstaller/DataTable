local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.const.ConstMgr.WushTowerConst
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.config.parameter_info
local var_0_4 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_5 = g.core.config.dead_tower_parcel_info
local var_0_6 = g.core.config.knight_base_info
local var_0_7 = g.core.common.Goods
local var_0_8 = g.core.const.ConstMgr.GuideConst
local WushTowerMonsterLayer = class("WushTowerMonsterLayer", require("app.fairyGUI.wushTower.UI_WushTowerMonsterLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/wushTower/wushTower",
		resName = "WushTowerMonsterLayer",
		pkgName = "wushTower",
		isFullScreen = true
	}, ...)
end)

function WushTowerMonsterLayer:ctor(arg_2_1)
	self._zoneId = arg_2_1.zoneId
	self._gridId = arg_2_1.gridId
	self._parcelId = arg_2_1.parcelId
	self._isInBattle = false

	self:_initRegisterListen()
	self:_initMonsterLayerUI()
end

function WushTowerMonsterLayer:_initMonsterLayerUI()
	self.m_topBarComp:setResInfoById(var_0_1.WUSHTOWER_SUB_TOPBAR)
	self:addBg(var_0_0:getBackGroundUrlByZoneId(self._zoneId, false), nil, nil, 1)

	self._parcelCfg = var_0_5.get(self._parcelId)

	local var_3_0 = var_0_0:getDisplayVersion()
	local var_3_1, var_3_2

	if var_3_0 == 1 then
		var_3_1 = self._parcelCfg.monster_id

		if not self._parcelCfg.monster_id then
			var_3_1 = self._parcelCfg["monster_id_" .. var_3_0]
			var_3_2 = {
				useMidKnight = true
			}
		end
	end

	var_3_2.resId = var_0_6.get(var_3_1).painted_id

	self.m_knightPicComp:updateKnight(var_3_2)
	self.m_knightPicComp:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)

	local var_3_3 = var_0_0:isSkipBattle()

	self.m_skipBattleCheckBtn:setVisible(var_3_3)

	if var_3_3 then
		self.m_skipBattleCheckBtn:setSelected(var_0_0:getStorageSkipBattleStatus())
		self.m_skipBattleCheckBtn:addClickListener(handler(self, self._onClickSkipBattleCheckBtn))
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_EXPLORE_OPEN)
	self:_updateMonsterMainView()
end

function WushTowerMonsterLayer:_initRegisterListen()
	self.m_goToBtn:addClickListener(handler(self, self._onClickGoToGridBtn))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
end

function WushTowerMonsterLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_CHOOSEGRID, self._onS2CDeadTowerChooseGrid, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_BATTLESTART, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.WUSH_TOWER_BATTLE_RESULT_EXIT, self._S2CDeadTowerBattleResultExit, self)
end

function WushTowerMonsterLayer:_updateMonsterMainView()
	local var_6_0 = var_0_0:getSumUserHp()
	local var_6_1 = table.nums((var_0_0:getWushTowerFormationHpMap())) * 1000

	self.m_userHpProgress:setPercent({
		cur = var_6_0,
		max = var_6_1
	})
	self.m_hpText:setText(g.core.lang:get(408417, {
		hp = math.floor(var_6_0 / var_6_1 * 100)
	}))
	self.m_monsterInfoComp:updateMonsterInfo(self._parcelId)
	self.m_ownCardComp:updateCardList(self._parcelCfg)
	self.m_chooseCardComp:updateBattleComp(self._parcelCfg)
	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_7.TYPE_RESOURCE, var_0_7.RESOURCE.TYPE_WUSH_TOWER_STEP, true)))
	self.m_costNum:setText(g.core.lang:get(408413))
	self.m_playTimeComp:initView({
		playNum = 999,
		getTimesFunc = function()
			return var_0_0:getChallengeNum()
		end,
		fullTime = var_0_3.get(var_0_4.WUSH_TOWER_FAIL_TIME).parameter
	})

	if self._gridId == var_0_0:getCurIndex() then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_enterTransition:play(handler(self, self._checkTipsGuide))
end

function WushTowerMonsterLayer:_onS2CDeadTowerChooseGrid()
	self:_updateMonsterMainView()
end

function WushTowerMonsterLayer:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		posHpList = var_0_0:getWushTowerFormationHpMap()
	})
end

function WushTowerMonsterLayer:_onClickGoToGridBtn()
	if not var_0_0:checkCardOrChallengeLimit() then
		return
	end

	if self._gridId ~= var_0_0:getCurIndex() then
		g.core.network.GameNetProxy:send_C2S_DeadTower_ChooseGrid({
			grid_id = self._gridId
		})
	end
end

function WushTowerMonsterLayer:_onClickBattleBtn()
	if not var_0_0:checkCardOrChallengeLimit() then
		return
	end

	if self._isInBattle then
		return
	end

	local var_11_0 = var_0_0:getC2SUsingCards()
	local var_11_1 = var_0_0:getCanUseCardCount()

	if var_11_1 > 0 and not var_0_0:getPeriodCardTips() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(408408),
			desc = g.core.lang:get(408409, {
				count = var_11_1
			}),
			confirmText = g.core.lang:get(408410),
			cancelText = g.core.lang:get(408411),
			onConfirm = function()
				return
			end,
			onCancel = function()
				self._isInBattle = true

				g.core.network.GameNetProxy:send_C2S_DeadTower_BattleStart({
					grid_id = self._gridId,
					cards = var_11_0
				})
			end,
			onCheck = function(arg_14_0)
				var_0_0:setPeriodCardTips(arg_14_0)
			end,
			tip = {
				txt = g.core.lang:get(408412)
			}
		}))
	else
		self._isInBattle = true

		g.core.network.GameNetProxy:send_C2S_DeadTower_BattleStart({
			grid_id = self._gridId,
			cards = var_11_0
		})
	end
end

function WushTowerMonsterLayer:_onClickSkipBattleCheckBtn()
	var_0_0:saveStorageSkipBattleStatus((self.m_skipBattleCheckBtn:isSelected()))
end

function WushTowerMonsterLayer:_onRcvBattleBegin(arg_16_1, arg_16_2, arg_16_3)
	if self.m_skipBattleCheckBtn:isSelected() then
		g.core.battle.BattleProxy:fastBattle(arg_16_3.battle_id)

		return
	end

	if require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("wushTower_skip_battle") then
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_16_3.battle_id)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()

			local var_17_0 = g.core.module.ModuleManager:getCurModule()

			if var_17_0.display and var_17_0.display.debugFastBattleUpdateView then
				var_17_0.display:debugFastBattleUpdateView()
			end

			g.core.module.ModuleManager:tip("battle end")
			g.core.module.ModuleManager:popByDisplay(self)

			self._isInBattle = false
		end, 1)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")
	local var_16_1 = {
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_WUSH_TOWER,
		battle_id = arg_16_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE
	}

	if self._gridId == var_0_1.WUSH_TOWER_STAGE_COUNT then
		var_16_1.bgId = var_0_1.BOSS_BATTLE_BG or var_0_1.MONSTER_BATTLE_BG
	end

	g.core.battle.BattleProxy:enterBattle(var_16_1)
	g.core.module.ModuleManager:popByDisplay(self)
end

function WushTowerMonsterLayer:_S2CDeadTowerBattleResultExit()
	self._isInBattle = false

	if self.m_skipBattleCheckBtn:isSelected() then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end, 0)
	end
end

function WushTowerMonsterLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if g.core.model.User.guideData:getServerDataById(var_0_8.SAVE_SERVER_DATA_IDS.WUSH_TOWER_FIRST_USE_CARD) then
		return
	end

	local var_20_0 = var_0_0:getCards()

	if var_20_0 and #var_20_0 > 0 and self.m_stateController:getSelectedIndex() == 1 then
		local var_20_1 = self.m_chooseCardComp:getFirstCardCell()

		if var_20_1 then
			self:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
					key = "WUSH_TOWER_USE_CARD",
					objects = {
						var_20_1,
						var_20_1,
						self.m_chooseCardComp
					}
				})
			end, 0)
			g.core.model.User.guideData:setSaveServerData(var_0_8.SAVE_SERVER_DATA_IDS.WUSH_TOWER_FIRST_USE_CARD)
		end
	end
end

return WushTowerMonsterLayer
