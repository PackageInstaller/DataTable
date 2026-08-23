local var_0_0 = g.core.config.massive_monster_team_info
local var_0_1 = g.core.config.tower_stage_info
local var_0_2 = g.core.model.User.towerHardData
local var_0_3 = g.core.model.User.mulFormationData
local var_0_4 = g.core.config.multi_team_formation_info
local var_0_5 = g.core.model.User
local var_0_6 = g.core.const.ConstMgr.TowerConst
local TowerCommon = require("app.view.module.tower.const.TowerCommon")
local var_0_8 = g.core.module.ModuleManager
local BattleKnight = require("app.view.battle.BattleKnight")
local TowerHardFormationLayer = class("TowerHardFormationLayer", require("app.fairyGUI.tower.UI_TowerHardFormationLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/tower/tower",
		resName = "TowerHardFormationLayer",
		pkgName = "tower"
	}, ...)
end)

function TowerHardFormationLayer:ctor(arg_2_1)
	self._stageType = arg_2_1 or var_0_6.STAGE_TYPE_HARD.JIAO_GUO
	self._mulTeamType = TowerCommon:getMultiTeamType(self._stageType)
	self._knightPosIds = {}
	self._isInitKnight = false
	self._isDragKnight = false
	self._starPos = 0
	self._localPos = 0
	self._stageInfo = 0
	self._isAllowPos = {}
	self._knightData = {}
	self._formationMap = {}
	self._curCount = 0
	self._rewardList = {}
	self._oldPower = 0
	self._tabNum = 1
	self._curTabIndex = 1
	self._enterBattle = false
	self._mulFormationInfo = var_0_4.get(self._mulTeamType)
	self._formationEnterTrans = self.m_teamFormationComp:getSharedTrans("enter")

	self.m_teamFormationComp:addBgByName()
	self:initData()
	self:initView()
end

function TowerHardFormationLayer:_onAwardRender(arg_3_1, arg_3_2)
	if self._awards[arg_3_1 + 1] then
		arg_3_2:update(self._awards[arg_3_1 + 1], true)
	end
end

function TowerHardFormationLayer:initData()
	local var_4_0, var_4_1 = var_0_2:getCurTowerIdByType(self._stageType)

	self._stageInfo = var_0_1.get(var_4_1)
	self._tabNum = math.min(self._stageInfo.enemy_num, var_0_6.TOWER_MULTI_TEAM_MAX)

	for iter_4_0 = 2, self._tabNum do
		self.m_tabController:addPage(tostring(iter_4_0), tostring(iter_4_0))
	end

	local var_4_2, var_4_3 = var_0_2:getCurTowerIdByType(self._stageType)

	self._awards = var_0_2:getCapacityAddListDataById(var_4_2, var_4_3)
end

function TowerHardFormationLayer:initView()
	self.m_topBar:setResInfoById(302)
	self.m_tabList:setVirtual(self)
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_tabList:setNumItems(self._tabNum)
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRender))
	self.m_awardList:setNumItems(#self._awards)
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabControllerChanged))
	self.m_tabList:getChildAt(0):setSelected(true)
	self.m_tabController:setSelectedIndex(0)
	self:_onTabControllerChanged()
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self.m_topBar:setReturnCallBack(handler(self, self._onClickClose))
	self.m_topBar:setHomeCallBack(handler(self, self._onClickHomeBtn))
end

function TowerHardFormationLayer:_onTabItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateComp({
		idx = arg_6_1 + 1,
		process = self:_getTeamProcess(arg_6_1 + 1),
		stageType = self._mulTeamType,
		group = self._mulFormationInfo.knight_group
	})
end

function TowerHardFormationLayer:_onTabControllerChanged()
	local var_7_0 = self.m_tabController:getSelectedIndex() + 1

	if var_7_0 == 0 then
		var_7_0 = 1
	end

	self._curTabIndex = var_7_0

	for iter_7_0, iter_7_1 in ipairs((self.m_tabList:getChildren())) do
		if iter_7_0 == var_7_0 then
			iter_7_1:playBtnEffect()
		else
			iter_7_1:closeBtnEffect()
		end
	end

	self:_onChangeFormation()
end

function TowerHardFormationLayer:_onChangeFormation()
	self._formationEnterTrans:play()
	self:_updateView()

	if self._curTabIndex == self._tabNum then
		self.m_btnTypeController:setSelectedIndex(1)
	else
		self.m_btnTypeController:setSelectedIndex(0)
	end
end

function TowerHardFormationLayer:_initCapacityList()
	local var_9_0, var_9_1 = var_0_2:getCurTowerIdByType(self._stageType)
	local var_9_2 = var_0_2:getCapacityAddListDataById(var_9_0, var_9_1)

	if table.nums(var_9_2) == 0 then
		self.m_hasAddCapacityController:setSelectedIndex(0)

		return
	else
		self.m_hasAddCapacityController:setSelectedIndex(1)

		for iter_9_0 = 1, 4 do
			local var_9_3 = var_9_2[iter_9_0]
			local var_9_4 = self["m_addRes" .. iter_9_0]

			if self["m_addRes" .. iter_9_0] then
				var_9_4:update(var_9_3, true)
				var_9_4:setVisible(var_9_3 ~= nil)
			end
		end
	end
end

function TowerHardFormationLayer:_onRendererRewardList(arg_10_1, arg_10_2)
	self._rewardList[arg_10_1 + 1].scaleIndex = 3

	arg_10_2:updateIcon(self._rewardList[arg_10_1 + 1])
end

function TowerHardFormationLayer:_checkIdIsInPos(arg_11_1)
	if arg_11_1 == 0 then
		return false
	end

	for iter_11_0, iter_11_1 in pairs(self._knightPosIds) do
		if iter_11_1 == arg_11_1 then
			return true
		end
	end

	return false
end

function TowerHardFormationLayer:_onClickInfoBtn()
	var_0_8:pushPopup(require("app.view.module.tower.view.TowerBuffPop").new(self._stageType), {
		touchDisappear = true,
		hideContinue = true
	})
end

function TowerHardFormationLayer:_onClickChallengeBtn()
	local var_13_0 = true

	if self._curTabIndex == self._tabNum then
		for iter_13_0 = 1, self._tabNum do
			var_13_0 = var_13_0 and var_0_3:getFormationStruct(self._mulTeamType, iter_13_0):hasAnyGoodsLineUp(g.core.common.Goods.TYPE_KNIGHT)

			if not var_13_0 then
				break
			end
		end
	end

	if not var_13_0 then
		var_0_8:tip(g.core.lang:get(308029))

		return
	end

	local var_13_1 = false

	if self._stageType == var_0_6.STAGE_TYPE_HARD.MAIN then
		var_13_1 = var_0_2:getMainTowerIsOpen()
	else
		local var_13_3

		var_13_1, var_13_3 = var_0_2:getSubTowerIsOpen(self._stageType)
	end

	if var_13_1 then
		self:checkSetFromationData()

		if self._curTabIndex == self._tabNum then
			self._enterBattle = true
		else
			self.m_tabController:setSelectedIndex(self.m_tabController:getSelectedIndex() + 1)
		end
	else
		var_0_8:tip(g.core.lang:get(308019))
		self:dispatchCompEvent("TowerHardFormationLayer_remove_noOpen")
	end
end

function TowerHardFormationLayer:_onClickClose()
	self:_checkCloseLayer((handler(self, function()
		self.m_topBar:checkFullPageExitAnim()
	end)))
end

function TowerHardFormationLayer:_onClickHomeBtn()
	self:_checkCloseLayer((handler(self, function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end)))
end

function TowerHardFormationLayer:_checkCloseLayer(arg_18_1)
	if var_0_3:isModified(self._mulTeamType) then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(302032),
			desc = g.core.lang:get(308034),
			onCancel = handler(self, function()
				if arg_18_1 then
					arg_18_1()
				end
			end),
			onConfirm = handler(self, function()
				self.m_teamFormationComp:sendC2SFormationSave()

				if arg_18_1 then
					arg_18_1()
				end
			end)
		}))
	elseif arg_18_1 then
		arg_18_1()
	end
end

function TowerHardFormationLayer:_startChallengeStage()
	if self._isSendChallenge then
		return
	end

	self._isSendChallenge = true

	local var_21_0, var_21_1 = var_0_2:getCurTowerIdByType(self._stageType)

	g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
		play_type = 2,
		id = var_21_1,
		formation_knight_ids = self._knightPosIds
	})
end

function TowerHardFormationLayer:_onCheckBtnClick()
	var_0_2:setIsSelectPopFormation((self.m_checkBtn:isSelected()))
	self:dispatchCompEvent("SelectNotPopFormation_change")
end

function TowerHardFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._onS2CFormationGet), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self._onS2CFormationSave), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN, handler(self, self._onRcvBattleBegin), self)

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self:_updateView()
end

function TowerHardFormationLayer:_onS2CFormationGet()
	self.m_tabList:refreshVirtualList()
end

function TowerHardFormationLayer:_onS2CFormationSave()
	self.m_tabList:refreshVirtualList()

	if self._enterBattle then
		self._enterBattle = false

		self:_startChallengeStage()
	end
end

function TowerHardFormationLayer:_onRcvBattleBegin(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		bgId = 126,
		cloudLoading = true,
		type = BattleConst.TYPE_TOWER,
		battle_id = arg_26_4.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
	var_0_8:popByDisplay(self)
end

function TowerHardFormationLayer:_updateView()
	local var_27_0 = "monster_team_id"

	if self._curTabIndex > 1 then
		var_27_0 = var_27_0 .. "_" .. self._curTabIndex
	end

	local var_27_1 = var_0_0.get((var_0_2:getSwitchMonsterTeamId(self._stageInfo[var_27_0])))

	self.m_recommendValue:setText(var_27_1.fight)

	if var_0_0.hasKey("description") and var_27_1.description ~= "" then
		self.m_showTipController:setSelectedIndex(1)
		self.m_monsterDescTxt:setText(var_27_1.description)
	else
		self.m_showTipController:setSelectedIndex(0)
	end

	self:_updateKnight()
end

function TowerHardFormationLayer:_updateKnight()
	self.m_teamFormationComp:updateComp(self._mulTeamType, self._curTabIndex)
	self:updatePreciousSuitBtn()
end

function TowerHardFormationLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(display.width - 126 - cc.Director:getInstance():getSafeAreaRect().x, display.height - (self.m_teamFormationComp.m_readFormationBtn:isVisible() and 445 or 345))
		end

		self._preciousSuitBtn:setBtnFormationData(self._mulTeamType, self._curTabIndex)
	end
end

function TowerHardFormationLayer:_dragMoveKnight(arg_30_1)
	if not self._isDragKnight then
		return
	end

	local var_30_0 = arg_30_1:getInput():getTouch()

	if not var_30_0 then
		return
	end

	local var_30_1 = var_30_0:getLocation()

	var_30_1.y = var_30_1.y - 50

	local var_30_2 = false
	local var_30_3

	for iter_30_0 = 1, 6 do
		if self._isAllowPos[iter_30_0] and self._knightComps[iter_30_0].m_touchComp:hitTest(var_30_1, cc.Camera:create()) then
			var_30_2 = true

			if iter_30_0 ~= self._localPos then
				var_30_3 = iter_30_0
			end
		end
	end

	if var_30_3 then
		self._nextPos = var_30_3

		self:_updateExchangeKnight()
	elseif not var_30_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function TowerHardFormationLayer:checkSetFromationData()
	if not self.m_teamFormationComp:sendC2SFormationSave() and self._curTabIndex == self._tabNum then
		self:_startChallengeStage()
	end
end

function TowerHardFormationLayer:_dragLineupKnight(arg_32_1)
	self._isDragKnight = true

	arg_32_1:preventDefault()

	self._curComp = arg_32_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	for iter_32_0 = 1, 6 do
		self._knightComps[iter_32_0]:checkTouchable(false)
	end

	if self._knightPosIds[self._starPos] > 0 then
		local var_32_0 = arg_32_1:getInput()
		local var_32_1 = fgui.DragDropManager:getInstance()

		var_32_1.startDrag(var_32_0, "common/ui_cocos/lineUp/pic_touming.png", nil, (var_32_0:getTouchId()))

		local var_32_2 = BattleKnight.new({
			scale = 1.2,
			breath = true,
			base = true,
			resId = var_0_5.knightsData:getKnight({
				id = self._knightPosIds[self._starPos]
			}):getResInfo().fight_id
		})

		var_32_2:setScale(1.2)
		var_32_2:setName("knight")
		var_32_1:getAgent():displayObject():addChild(var_32_2)
		var_32_2:setPosition(50, 0)
		self:_updateKnightOpacity(204)
	end
end

function TowerHardFormationLayer:_updateKnightOpacity(arg_33_1)
	for iter_33_0 = 1, 6 do
		self._knightComps[iter_33_0]:updateKnightOpacity(arg_33_1)
	end
end

function TowerHardFormationLayer:_updateExchangeKnight()
	return
end

function TowerHardFormationLayer:onUnload()
	self._curComp = nil
end

function TowerHardFormationLayer:_getTeamProcess(arg_36_1)
	return var_0_3:getFormationStruct(self._mulTeamType, arg_36_1):getTeamProcess() / 1000
end

function TowerHardFormationLayer:receiveCompEvent(arg_37_1, arg_37_2)
	if arg_37_1 == "CompEventFormationChanged" then
		self.m_tabList:refreshVirtualList()
	end
end

return TowerHardFormationLayer
