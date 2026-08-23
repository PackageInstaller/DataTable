local BattleConst = require("app.view.battle.const.BattleConst")
local BattleCommon = require("app.view.battle.common.BattleCommon")
local BattleControlComp = class("BattleControlComp", require("app.fairyGUI.battle.UI_BattleControlComp"))

function BattleControlComp:ctor()
	self._isAutoAnim = nil
	self._initSpeed = nil
	self._showBtnNum = 0
	self._debugForceSkip = false
end

function BattleControlComp:initBtn(arg_2_1)
	self._isPauseShow = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_PAUSE)
	self._isSpeedShow = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_FAST)
	self._isAutoShow = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_AUTO)
	self._isBattleSkipShow = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_SKIP)

	local var_2_0 = g.core.battle.BattleProxy:getType()

	if not BattleCommon:isCanOpeExitBattle() then
		self._isPauseShow = false

		self.m_pauseBtn:setVisible(false)
	end

	local var_2_1 = g.core.common.Storage:load("battle_skip_open.json", false)

	if (BattleConst.DEBUG or config.SHOW_DEBUG_BTN) and var_2_1 and var_2_1.open then
		self._debugForceSkip = true
	end

	if BattleConst.TYPE_DUNGEON == var_2_0 or BattleConst.TYPE_GAME_START == var_2_0 then
		if self._isBattleSkipShow or self._debugForceSkip then
			self.m_skipBtn:setVisible(true)
		else
			self.m_skipBtn:setVisible(false)

			self._showBtnNum = self._showBtnNum + 1
		end

		if self._isAutoShow then
			self.m_autoBtn:setVisible(true)

			local var_2_2 = self.m_autoBtn:getPosition()

			self.m_autoBtn:setPosition(cc.pAdd(cc.p(var_2_2.x, var_2_2.y), cc.p(self._showBtnNum * 94, 0)))
		else
			self.m_autoBtn:setVisible(false)

			self._showBtnNum = self._showBtnNum + 1
		end

		if self._isSpeedShow then
			self.m_speedBtn:setVisible(true)

			local var_2_3 = self.m_speedBtn:getPosition()

			self.m_speedBtn:setPosition(cc.pAdd(cc.p(var_2_3.x, var_2_3.y), cc.p(self._showBtnNum * 94, 0)))
		else
			self.m_speedBtn:setVisible(false)

			self._showBtnNum = self._showBtnNum + 1
		end

		if self._isPauseShow then
			self.m_pauseBtn:setVisible(true)

			local var_2_4 = self.m_pauseBtn:getPosition()

			self.m_pauseBtn:setPosition(cc.pAdd(cc.p(var_2_4.x, var_2_4.y), cc.p(self._showBtnNum * 94, 0)))
		else
			self.m_pauseBtn:setVisible(false)

			self._showBtnNum = self._showBtnNum + 1
		end
	end

	self._isPauseUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_PAUSE)
	self._isSpeedUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_FAST)
	self._isSpeedUnlock3 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_FAST_3)
	self._isAutoUnlock = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_AUTO)
	self._isBattleSkip = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_SKIP)

	if self._isPauseUnlock then
		self.m_pauseBtn:setSelectedIndex("lock", 0)
	else
		self.m_pauseBtn:setSelectedIndex("lock", 1)
	end

	if self._isSpeedUnlock then
		self.m_speedBtn:setSelectedIndex("lock", 0)
	else
		self.m_speedBtn:setSelectedIndex("lock", 1)
	end

	if self._isAutoUnlock then
		self.m_autoBtn:setSelectedIndex("lock", 0)
	else
		self.m_autoBtn:setSelectedIndex("lock", 1)
	end

	self:_checkSkipBtnStatus(arg_2_1)
	self.m_pauseBtn:addClickListener(handler(self, self._onClickPause))
	self.m_speedBtn:addClickListener(handler(self, self._onClickSpeed))
	self.m_autoBtn:addClickListener(handler(self, self._onClickAuto))
	self.m_skipBtn:addClickListener(handler(self, self._onClickSkip))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_KEY_PAD, handler(self, self._onBackClicked), self)

	local var_2_5 = g.core.battle.BattleProxy:getType()

	if var_2_5 == BattleConst.TYPE_SPIRE_NORMAL or var_2_5 == BattleConst.TYPE_SPIRE_BOSS then
		if config.DEBUG_VERSION and require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("spire_tower_auto") then
			self:newScheduleOnce(handler(self, function(arg_3_0)
				arg_3_0:dispatchCompEvent("BattleCtrl_Skip")
			end), 5)
		end
	end
end

function BattleControlComp:_checkSkipBtnStatus(arg_4_1)
	self._skipFuncId = nil
	self._isBattleSkip = false

	local var_4_0 = g.core.battle.BattleProxy:getType()
	local var_4_1 = g.core.battle.BattleProxy:getTypeQuality()
	local var_4_2 = g.core.config.battle_skip_info.match(function(arg_5_0)
		return arg_5_0.type == var_4_0
	end)

	if not next(var_4_2) then
		self.m_skipBtn:setSelectedIndex("lock", 1)

		return
	end

	local var_4_3 = var_4_2[1]

	while var_4_1 do
		local var_4_4 = table.remove(var_4_2, 1)

		if var_4_4.quality == var_4_1 then
			var_4_3 = var_4_4

			break
		end
	end

	self._skipFuncId = var_4_3.function_id
	self._isBattleSkip = g.core.common.ModuleUnlock:isModuleUnlock(self._skipFuncId) or self._debugForceSkip

	if arg_4_1 then
		self._isBattleSkip = arg_4_1.isSkip
		self._skipLockTip = arg_4_1.lockTip
	end

	local var_4_5 = g.core.common.Storage:load("battle_skip_open.json", false)

	if var_4_5 and var_4_5.open then
		self.m_skipBtn:setSelectedIndex("lock", 0)
	elseif self._isBattleSkip then
		self.m_skipBtn:setSelectedIndex("lock", 0)

		if g.core.common.ModuleUnlock:isModuleUnlock(26001) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
			self:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "SKIP_BATTLE_OPEN",
					targetBtn = self.m_skipBtn
				})
			end, 0.1)
		end
	else
		self.m_skipBtn:setSelectedIndex("lock", 1)
	end
end

function BattleControlComp:isCanSkip()
	local var_7_0 = self.m_skipBtn:isVisible()

	if var_7_0 then
		var_7_0 = self.m_skipBtn:getController("lock"):getSelectedIndex() == 0
	end

	return var_7_0
end

function BattleControlComp:_onClickPause()
	if self._isPauseUnlock then
		self:dispatchCompEvent("BattleCtrl_Pause")
	else
		g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_PAUSE)
	end
end

function BattleControlComp:_onClickSpeed()
	if self._debugForceSkip then
		self:dispatchCompEvent("BattleCtrl_Speed", {
			isAllOpen = true
		})
	elseif self._isSpeedUnlock then
		self:dispatchCompEvent("BattleCtrl_Speed", {
			isAllOpen = self._isSpeedUnlock3
		})
	else
		g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_FAST)
	end
end

function BattleControlComp:_onClickAuto()
	if self._debugForceSkip then
		self:dispatchCompEvent("BattleCtrl_Auto")
	elseif self._isAutoUnlock then
		self:dispatchCompEvent("BattleCtrl_Auto")
	else
		g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_AUTO)
	end
end

function BattleControlComp:_onClickSkip()
	local var_11_0 = g.core.common.Storage:load("battle_skip_open.json", false)

	if var_11_0 and var_11_0.open then
		self:dispatchCompEvent("BattleCtrl_Skip")

		return
	end

	if self._isBattleSkip then
		self:dispatchCompEvent("BattleCtrl_Skip")
	elseif self._skipFuncId then
		if self._skipLockTip then
			g.core.module.ModuleManager:tip(self._skipLockTip)
		else
			g.core.common.ModuleUnlock:checkModuleUnlockStatus(self._skipFuncId)
		end
	end
end

function BattleControlComp:_onBackClicked(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
		g.core.module.ModuleManager:tip(g.core.lang:get(500252))

		return
	end

	local var_12_0 = g.core.battle.BattleProxy:isPlaying()

	if arg_12_4 ~= "backClicked" or g.core.guide.GuideProxy:isGuideRunning() then
		-- block empty
	elseif g.core.model.User.storyData:isInStory() then
		-- block empty
	elseif self._isPauseShow and var_12_0 and not g.core.battle.BattleProxy:isLoading() then
		self:_onClickPause()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1163))
	end
end

function BattleControlComp:updatePauseBtnStatus(arg_13_1)
	return
end

function BattleControlComp:updateSpeedBtnStatus(arg_14_1)
	if not self._initSpeed then
		self._initSpeed = arg_14_1

		if self._isSpeedUnlock then
			if self._initSpeed == 1 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FIGHT_2X_OPEN",
					targetBtn = self.m_speedBtn
				})
			elseif self._isSpeedUnlock3 and self._initSpeed == 2 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FIGHT_3X_OPEN",
					targetBtn = self.m_speedBtn
				})
			end
		end
	end

	if arg_14_1 >= 1 or arg_14_1 <= 3 then
		self.m_speedBtn:setSelectedIndex("btnType", arg_14_1)
	end
end

function BattleControlComp:updateAutoBtnStatus(arg_15_1)
	self.m_autoBtn:setSelectedIndex("btnType", BattleConst.AUTO_CONTROL.AUTO)

	if self._isAutoAnim == arg_15_1 then
		return
	end

	self._isAutoAnim = arg_15_1

	if self._isAutoAnim then
		self.m_autoBtn:getChild("iconLoader"):runFGAction((fgui.FRepeatForever:create((fgui.FRotateBy:create(0.2, 30)))))
	else
		self.m_autoBtn:getChild("iconLoader"):stopAllFGActions()
		self.m_autoBtn:getChild("iconLoader"):setRotation(0)
	end
end

function BattleControlComp:update(arg_16_1)
	return
end

return BattleControlComp
