local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.shopData
local var_0_2 = g.core.const.ConstMgr.TowerConst
local var_0_3 = g.core.const.ConstMgr.ShopConst
local var_0_4 = g.core.model.User.towerHardData
local var_0_5 = g.core.module.ModuleManager
local TowerHardSubStageLayer = class("TowerHardSubStageLayer", require("app.fairyGUI.tower.UI_TowerHardSubStageLayer"), function()
	return fgui.GComponent:create({
		resName = "TowerHardSubStageLayer",
		pkgPath = "ui/tower/tower",
		isFullScreen = true,
		pkgName = "tower"
	}, ...)
end)

function TowerHardSubStageLayer:ctor(arg_2_1)
	if self.m_difficultyController then
		self.m_difficultyController:setSelectedIndex(1)
	end

	self._stageType = arg_2_1.stageType or var_0_2.STAGE_TYPE_HARD.JIAO_GUO
	self._maxPosX = 0
	self._minPosX = 0
	self._autoMovingSchedule = nil
	self._isAutoMoving = false
	self._autoMoveSpeed = 0
	self._assSpeed = 0
	self._assTime = 0
	self._maxSpeed = 0
	self._totalTime = 0
	self._curStagePos = 0
	self._curViewPos = 0
	self._movePos = 0
	self._lastImageState = 0
	self._isClose = false
	self._challengeComp = nil
	self._skipLineUp = false

	self:_initView()
end

function TowerHardSubStageLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_FASTROLLING, self._onRcvFastRolling, self)
	self:initData()

	if var_0_4:getChallengeIsWin() then
		self:_checkIsShowPop()
	else
		self:updateView(true)
	end
end

function TowerHardSubStageLayer:initData()
	local var_4_0, var_4_1 = var_0_4:getSubTowerMaxCount(self._stageType)
	local var_4_2 = math.floor((var_4_0 - 1) / var_0_2.SUB_TOWER_MAP_COUNT)

	self._maxPosX = (var_4_2 + 1) * var_0_2.SUB_TOWER_MAP_X - display.cx
	self._minPosX = var_4_2 * var_0_2.SUB_TOWER_MAP_X + display.cx
	self._curStagePos = var_4_2 * var_0_2.SUB_TOWER_MAP_X + (var_0_2.SUB_TOWER_STAGE_POSLIST[var_4_0 % var_0_2.SUB_TOWER_MAP_COUNT] or 0)
	self._curViewPos = self:getFinishPos(self._curStagePos)
	self._movePos = self._curViewPos - self._curStagePos
end

function TowerHardSubStageLayer:checkPosCanMove()
	if self._curStagePos + self._movePos <= self._minPosX then
		self._curViewPos = self._minPosX
		self._movePos = self._curViewPos - self._curStagePos
	end

	if self._curStagePos + self._movePos >= self._maxPosX then
		self._curViewPos = self._maxPosX
		self._movePos = self._curViewPos - self._curStagePos
	end

	self._curViewPos = self._curStagePos + self._movePos
end

function TowerHardSubStageLayer:getFinishPos(arg_6_1)
	local var_6_0 = arg_6_1 % var_0_2.SUB_TOWER_MAP_X

	if arg_6_1 % var_0_2.SUB_TOWER_MAP_X < display.cx then
		var_6_0 = display.cx
	elseif var_6_0 > var_0_2.SUB_TOWER_MAP_X - display.cx then
		var_6_0 = var_0_2.SUB_TOWER_MAP_X - display.cx
	end

	return math.floor(arg_6_1 / var_0_2.SUB_TOWER_MAP_X) * var_0_2.SUB_TOWER_MAP_X + var_6_0
end

function TowerHardSubStageLayer:_initView()
	local var_7_0 = fgui.GLoader:create()

	var_7_0:setURL("bg/tower/bg_yizhitansuo_2.jpg")
	var_7_0:setSize(2688, 998)
	var_7_0:setFill(5)
	var_7_0:setAlign(1)
	var_7_0:setVerticalAlign(1)
	self.m_bgComp:addChildAt(var_7_0, 0)
	var_7_0:setPivot(0, 0.5, true)
	var_7_0:setPosition(0, display.height / 2)
	self.m_bgComp:setScale(1.5)
	self.m_bgComp:runFGAction(fgui.FSequence:create({
		fgui.FEaseOut:create(fgui.FScaleTo:create(0.5, 1), 0.5)
	}))
	self.m_topBar:setResInfoById(302)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	if self._mapView == nil then
		self._mapView = fgui.UIPackage:createObject("tower", "TowerHardMapComp")

		self._mapView:setSize(2400, 750)
		self._mapView:setPivot(0, 0.5, true)
		self.m_mapView:addChild(self._mapView)
		self._mapView:setInitData(self._stageType, 0)
		self._mapView:initView()
	end

	if self._subMapView == nil then
		self._subMapView = fgui.UIPackage:createObject("tower", "TowerHardMapComp")

		self._subMapView:setSize(2400, 750)
		self._subMapView:setPivot(0, 0.5, true)
		self.m_mapView:addChild(self._subMapView)
		self._subMapView:setInitData(self._stageType, var_0_2.SUB_TOWER_MAP_COUNT)
		self._subMapView:initView()
	end

	self.m_touchlLayer:setVisible(false)
	self.m_touchlLayer:setTouchable(false)
	self.m_rankRewardBtn:addClickListener(handler(self, self._onRankRewardBtnClick))
	self.m_onekeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_checkBtn:setSelected(var_0_4:getIsSelectPopFormation())
	self.m_stageTypeController:setSelectedIndex((self._stageType - 2) % 5)
	self:_initImageNode()
end

function TowerHardSubStageLayer:_onCheckBtnClick()
	var_0_4:setIsSelectPopFormation((self.m_checkBtn:isSelected()))
end

function TowerHardSubStageLayer:_onOneKeyClick()
	if var_0_1:getLeftCount(var_0_3.PLAY_TYPE["TOWER_HARD_CHALLENGE_COUNT_" .. self._stageType]) <= 0 then
		var_0_5:tip(g.core.lang:get(308024))

		return
	end

	local var_9_0, var_9_1, var_9_2 = var_0_4:getCurTowerIdByType(self._stageType)

	if var_9_2 then
		var_0_5:tip(g.core.lang:get(308014))

		return
	end

	if var_0_4:isPassBattleById(var_9_1) then
		g.core.network.GameNetProxy:send_C2S_Tower_FastRolling({
			play_type = 2,
			stage_type = self._stageType
		})
		self.m_onekeyBtn:setVisible(false)
	else
		var_0_5:tip(g.core.lang:get(308023))
	end
end

function TowerHardSubStageLayer:_initImageNode()
	self._imageStageIndex = math.floor((self._curViewPos - display.cx) / var_0_2.SUB_TOWER_MAP_X) * var_0_2.SUB_TOWER_MAP_COUNT
end

function TowerHardSubStageLayer:_onTouchBegin(arg_11_1)
	if self._isAutoMoving then
		return
	end

	self._prevTouchPos, self._isTouched = arg_11_1:getInput():getTouch():getLocation(), true

	arg_11_1:captureTouch()
end

function TowerHardSubStageLayer:_onTouchMove(arg_12_1)
	if not self._isTouched then
		return
	end

	local var_12_0 = arg_12_1:getInput():getTouch():getLocation()

	if not self._isScroll then
		if math.abs(self._prevTouchPos.x - var_12_0.x) >= var_0_2.TOUCH_MOVE_DELTA then
			self._isScroll = true
		else
			return
		end
	end

	self._prevTouchPos = var_12_0
	self._movePos = self._movePos + (self._prevTouchPos.x - var_12_0.x)

	self:checkPosCanMove()
	self:updateImagePos()
	self.m_bgComp:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X, display.cy)
end

function TowerHardSubStageLayer:_onTouchEnd()
	self._isTouched = false
	self._isScroll = false
end

function TowerHardSubStageLayer:autoMove(arg_14_1)
	self._nextPos = self:getFinishPos(arg_14_1)

	local var_14_0 = math.abs(math.atan(self._nextPos - self._curViewPos) - 0.3)

	if self._nextPos - self._curViewPos < 7000 then
		var_14_0 = (self._nextPos - self._curViewPos) / 5000
	end

	if self._autoMovingSchedule == nil and var_14_0 > 0 then
		self._assTime = var_14_0 * 0.25
		self._assSpeed = (self._nextPos - self._curViewPos) / (5 * self._assTime * self._assTime)
		self._autoMovingSchedule = g.core.common.Scheduler:newSchedule(handler(self, self._move), 0.01)
		self._isAutoMoving = true

		self.m_touchlLayer:setVisible(true)
		self.m_touchlLayer:setTouchable(true)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_ONE_KEY_BATTLE)
		g.core.sound.SoundManager:setGroupState(g.core.const.ConstMgr.SoundConst.Sound.TOWER_ONE_KEY_BATTLE, "start")
		g.core.sound.SoundManager:setGroupState(g.core.const.ConstMgr.SoundConst.Sound.TOWER_ONE_KEY_BATTLE, "stop")
	else
		self:_stopAutoMove()
	end
end

function TowerHardSubStageLayer:_move(arg_15_1, arg_15_2)
	self._totalTime = self._totalTime + arg_15_2

	if self._totalTime < self._assTime then
		self._movePos = self._movePos + (self._autoMoveSpeed * arg_15_2 + 0.5 * (self._assSpeed * 2) * (arg_15_2 * arg_15_2))
		self._autoMoveSpeed = self._autoMoveSpeed + arg_15_2 * (self._assSpeed * 2)
	elseif self._totalTime < 2 * self._assTime then
		self._autoMoveSpeed = self._assTime * self._assSpeed * 2
		self._movePos = self._movePos + self._autoMoveSpeed * arg_15_2
	else
		self._movePos = self._movePos + math.max(self._autoMoveSpeed * arg_15_2 - 0.5 * self._assSpeed * (arg_15_2 * arg_15_2), 0)
		self._autoMoveSpeed = self._autoMoveSpeed - arg_15_2 * self._assSpeed

		if self._autoMoveSpeed <= 0 then
			self._autoMoveSpeed = 0
		end
	end

	self._curViewPos = self._curStagePos + self._movePos

	if self._totalTime > self._assTime * 4 then
		self:updateImagePos(true)
		self:_stopAutoMove()
	else
		self:updateImagePos(true)
	end
end

function TowerHardSubStageLayer:updateImagePos(arg_16_1)
	if self._curViewPos % var_0_2.SUB_TOWER_MAP_X < display.cx then
		if arg_16_1 and self._lastImageState ~= 1 then
			self:updateImageNodeInScroll()

			self._lastImageState = 1
		end

		self._mapView:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X - var_0_2.SUB_TOWER_MAP_X, 0)
		self._subMapView:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X, 0)
	else
		if arg_16_1 and self._lastImageState ~= 2 then
			self:updateImageNodeInScroll()

			self._lastImageState = 2
		end

		self._mapView:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X, 0)
		self._subMapView:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X + var_0_2.SUB_TOWER_MAP_X, 0)
	end
end

function TowerHardSubStageLayer:updateView(arg_17_1)
	if not self or not self._stageType then
		return
	end

	self.m_layerName:setText(g.core.lang:get(308001 + self._stageType - 5))

	local var_17_0, var_17_1, var_17_2 = var_0_4:getCurTowerIdByType(self._stageType)
	local var_17_3 = var_0_0.get(var_17_1)

	if var_17_3.details == "" or var_17_3.details == "0" then
		self.m_buffGroup:setVisible(false)
	else
		self.m_buffGroup:setVisible(true)
		self.m_buffDesc:setText(var_17_3.details)
	end

	self.m_debuffDesc:setText(var_17_3.details_2)
	self.m_onekeyBtn:getChild("effectNode"):removeAllEffect()

	if not var_0_4:isShowAutoBtn(self._stageType) then
		self.m_onekeyBtn:setVisible(false)
	else
		self.m_onekeyBtn:setVisible(true)
		self.m_onekeyBtn:getChild("effectNode"):addEffectSpine({
			anim = "play",
			name = "eff_ui_towerHard_sweeping",
			isLoop = true
		})
	end

	self:updateImagePos()
	self:updateImageNode(arg_17_1)
	self.m_bgComp:setPosition(display.cx - self._curViewPos % var_0_2.SUB_TOWER_MAP_X, display.cy)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rankRewardBtn
	})
end

function TowerHardSubStageLayer:updateImageNodeInScroll()
	local var_18_0 = math.floor((self._curViewPos - display.cx) / var_0_2.SUB_TOWER_MAP_X) * var_0_2.SUB_TOWER_MAP_COUNT
	local var_18_1, var_18_2, var_18_3 = var_0_4:getSubTowerMaxCount(self._stageType)

	self._mapView:updateImageNodeInScroll(math.clamp(var_18_1 - var_18_0, 0, 10), var_18_1, var_18_0, var_18_3)
	self._subMapView:updateImageNodeInScroll(math.clamp(var_18_1 - (var_18_0 + var_0_2.SUB_TOWER_MAP_COUNT), 0, 10), var_18_1, var_18_0 + var_0_2.SUB_TOWER_MAP_COUNT, var_18_3)
end

function TowerHardSubStageLayer:updateImageNode(arg_19_1)
	local var_19_0 = math.floor((self._curViewPos - display.cx) / var_0_2.SUB_TOWER_MAP_X) * var_0_2.SUB_TOWER_MAP_COUNT

	self._imageStageIndex = var_19_0

	self._mapView:setImageStageIndex(var_19_0)
	self._subMapView:setImageStageIndex(var_19_0 + var_0_2.SUB_TOWER_MAP_COUNT)
	self._mapView:updateImageNode(arg_19_1)
	self._subMapView:updateImageNode(arg_19_1)
end

function TowerHardSubStageLayer:_stopAutoMove()
	if self._autoMovingSchedule then
		g.core.common.Scheduler:cancelSchedule(self._autoMovingSchedule)

		self._autoMovingSchedule = nil
		self._isAutoMoving = false
		self._totalTime = 0
		self._assSpeed = 0

		self.m_touchlLayer:setVisible(false)
		self.m_touchlLayer:setTouchable(false)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_ONE_KEY_BATTLE_STOP)
	end

	self:initData()
	self:_showAwardSummaryPop()
end

function TowerHardSubStageLayer:_onRcvBattleBegin(arg_21_1, arg_21_2, arg_21_3)
	local BattleConst = require("app.view.battle.const.BattleConst")

	self._skipLineUp = not var_0_4:checkIsNeedPopFormation(self._stageType)

	if self._skipLineUp then
		self._skipLineUp = false

		g.core.battle.BattleProxy:enterBattle({
			cloudLoading = true,
			bgId = 126,
			canSkip = true,
			type = BattleConst.TYPE_TOWER,
			battle_id = arg_21_3.battle_id,
			battleType = BattleConst.BATTLE_TYPE.PVE
		})
	end
end

function TowerHardSubStageLayer:_showAwardSummaryPop()
	local var_22_0 = var_0_4:getOneKeyBattleReward()

	if #var_22_0 > 0 then
		var_0_5:awardSummary(var_22_0, false, nil, nil, handler(self, self._checkIsShowPop))
	else
		self:_checkIsShowPop()
	end
end

function TowerHardSubStageLayer:_checkIsShowPop()
	if not self or not self.updateView then
		return
	end

	if var_0_4:getRunSpeedAddEffect() then
		self:pushCapacityPop()
	else
		self:updateView()
	end
end

function TowerHardSubStageLayer:_onRcvFastRolling(arg_24_1, arg_24_2, arg_24_3)
	if (rawget(arg_24_3, "stage_type") or 0) ~= self._stageType then
		return
	end

	local var_24_0 = var_0_4:getSubTowerMaxCount(self._stageType)

	self:autoMove(math.floor((var_24_0 - 1) / var_0_2.SUB_TOWER_MAP_COUNT) * var_0_2.SUB_TOWER_MAP_X + (var_0_2.SUB_TOWER_STAGE_POSLIST[var_24_0 % var_0_2.SUB_TOWER_MAP_COUNT] or 0))
	self:dispatchCompEvent("TowerHardSubStageLayer_update")
end

function TowerHardSubStageLayer:pushCapacityPop()
	local var_25_0 = {}

	var_25_0.touchDisappear = true
	var_25_0.hideContinue = true
	var_25_0.blackOpacity = 0.7
	var_25_0.withoutAni = true
	var_25_0.ignoreTouch = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = true,
		data = var_0_4:getCapacityAddListData(self._stageType),
		title = g.core.lang:get(308018),
		func = handler(self, self.updateView),
		showComp = fgui.UIPackage:createObject("tower", "TowerCapacotyUpPop")
	}), var_25_0)
end

function TowerHardSubStageLayer:receiveCompEvent(arg_26_1, arg_26_2)
	if arg_26_1 == "SelectNotPopFormation_change" then
		self.m_checkBtn:setSelected(var_0_4:getIsSelectPopFormation())
	elseif arg_26_1 == "TowerFormationLayer_remove_noOpen" then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function TowerHardSubStageLayer:_onRankRewardBtnClick()
	var_0_5:pushPopup(require("app.view.module.tower.view.hard.TowerHardRankRewardPop").new(self._stageType), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function TowerHardSubStageLayer:onUnload()
	self._isClose = true

	if self._autoMovingSchedule then
		g.core.common.Scheduler:cancelSchedule(self._autoMovingSchedule)

		self._autoMovingSchedule = nil
		self._isAutoMoving = false

		self.m_touchlLayer:setVisible(false)
		self.m_touchlLayer:setTouchable(false)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_ONE_KEY_BATTLE_STOP)
	var_0_4:saveFormationJsonData()
	var_0_4:setRunSpeedAddEffect(false)
end

return TowerHardSubStageLayer
