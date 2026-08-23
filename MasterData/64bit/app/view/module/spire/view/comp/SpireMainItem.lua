local var_0_1 = g.core.model.User.spireData
local SpireMainItem = class("SpireMainItem", require("app.fairyGUI.spire.UI_SpireMainItem"))

function SpireMainItem:ctor()
	self._towerInfo = nil
end

function SpireMainItem:updateTowerInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	if not var_0_1:isActivityInSeason() then
		self.m_stateController:setSelectedIndex(4)
		self.m_buffCountController:setSelectedIndex(0)

		return
	end

	self._towerInfo = arg_2_1

	local var_2_0 = arg_2_1:getCfg()
	local var_2_1 = var_0_1:getBossTower()

	if var_2_1:getCfg().type == var_2_0.type and arg_2_1:isPass(true) and not self._isAddEff then
		self.m_bossloopTransition:play(-1, 0)
		self.m_effBossComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_spire_bossarise",
			isLoop = true
		})
		self.m_showBossController:setSelectedIndex(1)

		self._isAddEff = true
	end

	local var_2_2 = g.core.common.ServerTime:getNextNDayZeroTime(var_0_1:getActivityOpenTime(), var_2_0.unlock)
	local var_2_3, var_2_4 = var_0_1:isPreTowerPass(var_2_0.type)
	local var_2_5 = var_2_2 > g.core.common.ServerTime:getTime()

	if var_2_5 or not var_2_3 then
		local var_2_6 = g.core.lang:get(432030, {
			name = var_2_4.name
		})
		local var_2_7 = g.core.common.ServerTime:getDateMDFormat(var_2_2) .. g.core.lang:get(432007)

		if var_2_5 and not var_2_3 then
			self.m_timeText:setText(var_2_6 .. "\n" .. var_2_7)
		elseif var_2_5 then
			self.m_timeText:setText(var_2_7)
		else
			self.m_timeText:setText(var_2_6)
		end

		self.m_stateController:setSelectedIndex(2)
		self:_updateElementBuff(var_2_0)

		return
	end

	local var_2_8 = arg_2_1:getCurFloor()
	local var_2_9 = var_2_8:getCurPassStageStruct()

	if not var_2_9 then
		self:playUnlockEff()
		self:_updateElementBuff(var_2_0)

		return
	end

	if var_2_1:getCfg().type == var_2_0.type then
		local var_2_10, var_2_11 = var_0_1:getMyTotalRankAndScore()

		if var_2_11 > 0 then
			self.m_stateController:setSelectedIndex(0)
			self.m_stateText:setText(g.core.lang:get(432014, {
				score = var_2_11
			}))
			var_0_1:saveTowerOpenIndex(var_2_0.type)
			self:_updateElementBuff(var_2_0)

			return
		elseif arg_2_1:isPass(true) then
			self.m_stateController:setSelectedIndex(0)
			self.m_stateText:setText(g.core.lang:get(432032))
			var_0_1:saveTowerOpenIndex(var_2_0.type)
			self:_updateElementBuff(var_2_0)

			return
		end
	elseif arg_2_1:isPass() then
		self.m_stateController:setSelectedIndex(1)
		self.m_stateText:setText(g.core.lang:get(432012))
		var_0_1:saveTowerOpenIndex(var_2_0.type)
		self:_updateElementBuff(var_2_0)

		return
	end

	if var_2_9:getPassTime() > 0 then
		self.m_stateController:setSelectedIndex(0)
		self.m_stateText:setText(g.core.lang:get(432013, {
			floor = arg_2_1:getCurFloorIndex(),
			stage = var_2_8:getCurPassStage()
		}))
		var_0_1:saveTowerOpenIndex(var_2_0.type)
	else
		self:playUnlockEff()
	end

	self:_updateElementBuff(var_2_0)
end

function SpireMainItem:_updateElementBuff(arg_3_1)
	local var_3_0 = self.m_stateController:getSelectedIndex()

	if not ((var_3_0 == 0 or var_3_0 == 3) and arg_3_1.element_buff_show == 1) then
		self.m_buffCountController:setSelectedIndex(0)

		return
	end

	local var_3_1 = arg_3_1.element_buff_1
	local var_3_2 = arg_3_1.element_buff_2

	self.m_buffCountController:setSelectedIndex((arg_3_1.element_buff_1 > 0 and 1 or 0) + (arg_3_1.element_buff_2 > 0 and 1 or 0))

	if var_3_1 > 0 then
		self.m_buffType1Controller:setSelectedIndex(var_3_1)
	end

	if var_3_2 > 0 then
		self.m_buffType2Controller:setSelectedIndex(var_3_2)
	end
end

function SpireMainItem:playUnlockEff()
	if not self._towerInfo or self._isPlay then
		return
	end

	local var_4_0 = self._towerInfo:getCfg()

	if var_4_0.type > 1 and var_0_1:isTowerNewOpenByIndex(var_4_0.type) then
		self.m_timeText:setText(g.core.common.ServerTime:getDateMDFormat((g.core.common.ServerTime:getNextNDayZeroTime(var_0_1:getActivityOpenTime(), var_4_0.unlock))) .. g.core.lang:get(432007))
		self.m_stateController:setSelectedIndex(2)
		self.m_lockGroup:setVisible(false)
		self.m_effComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_spire_unlock",
			isLoop = false,
			remove = true
		})
		self.m_unlockTransition:play(handler(self, self._onPlayEnd))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_Unlock)

		self._isPlay = true
	else
		self.m_stateController:setSelectedIndex(3)
	end

	var_0_1:saveTowerOpenIndex(var_4_0.type)
end

function SpireMainItem:_onPlayEnd()
	self._isPlay = false

	self.m_stateController:setSelectedIndex(3)

	if self._towerInfo then
		self:_updateElementBuff(self._towerInfo:getCfg())
	end
end

return SpireMainItem
