local WushMonsterComp = class("WushMonsterComp", require("app.fairyGUI.wush.UI_WushMonsterComp"))
local var_0_1 = g.core.config.dead_battle_checkpoint_info

function WushMonsterComp:ctor()
	self._isBoss = false
	self._curStar = 0
	self._stageId = 1
	self._floorId = 1
	self._preIndex = nil
	self._stageIndex = 1
	self._canAttack = false
	self._isBattleWin = false

	self:addClickListener(handler(self, self._onClick))
	self.m_changeEffect:addEffectSpine({
		isLoop = true,
		name = "eff_ui_wush_gklight"
	})
end

function WushMonsterComp:update(arg_2_1)
	if arg_2_1 then
		self._isBoss = arg_2_1.isBoss or false
	end

	if arg_2_1 then
		self._stageId = arg_2_1.stageId or 1
	end

	if arg_2_1 then
		self._floorId = arg_2_1.floorId or 1
	end

	if arg_2_1 then
		self._stageIndex = arg_2_1.stageIndex or 0
	end

	if arg_2_1 then
		self._isBattleWin = arg_2_1.isWin or false
	end

	local var_2_0 = g.core.model.User.wushData:getCurStageIndex()
	local var_2_1 = var_2_0 > self._stageIndex

	self._canAttack = self._stageIndex == var_2_0

	local var_2_2 = var_2_0 < self._stageIndex and self._stageIndex ~= 0

	self:setCtrlState("stageState", {
		index = var_2_1 and 1 or 0
	})
	self:setCtrlState("challenge", {
		index = var_2_2 and 0 or 1
	})
	self:setCtrlState("isBoss", {
		index = self._isBoss and 1 or 0
	})

	self._curStar = g.core.model.User.wushData:getStageStarByStageIndex(self._stageIndex)

	if self._curStar > 0 then
		if self._curStar > 3 then
			self._curStar = 3
		end

		self.m_starNumController:setSelectedIndex(self._curStar - 1)
	end

	local var_2_3 = var_0_1.get(self._stageId)

	self.m_stageLabel:setText("NO." .. self._stageIndex + 1)

	local var_2_4 = g.core.model.User.wushData:getDisplayVersion()

	self.m_nameLabel:setText((var_2_4 == 1 or nil) and (var_2_3.monster_name or var_2_3["monster_name_" .. var_2_4]))

	if var_2_1 and self._stageIndex == var_2_0 - 1 then
		if self._isBattleWin then
			if self._isBoss then
				self.m_passBossTransition:play(function()
					self:dispatchCompEvent("WUSHMONSTER_PASS_STAGE")
				end)
			else
				self.m_passNomalTransition:play(function()
					self:dispatchCompEvent("WUSHMONSTER_PASS_STAGE")
				end)
			end
		end
	elseif self._canAttack then
		if self._isBattleWin then
			self.m_changeEffect:setVisible(false)
		else
			self.m_changeEffect:setVisible(true)
		end

		self:dispatchCompEvent("WUSHMAINLAYER_UPDATE_BATTLEINFO", {
			stageId = self._stageId,
			floorId = self._floorId,
			stageIndex = self._stageIndex
		})
	else
		self._preIndex = self._stageIndex

		self:removeAllEffect()
	end
end

function WushMonsterComp:playUnLockEffect(arg_5_1)
	if self._canAttack then
		self.m_unlockTransition:play()
		self.m_effUnlock:addEffectSpine({
			isLoop = false,
			name = "eff_ui_wush_unlock"
		})
		self.m_changeEffect:setVisible(true)
		self:newScheduleOnce(handler(self, function()
			self:dispatchCompEvent("WUSHMAINLAYER_SHOW_BATTLEINFO", {
				isAutoSel = true,
				stageId = self._stageId,
				floorId = self._floorId,
				stageIndex = self._stageIndex
			})
		end), 1)
	end

	if arg_5_1 then
		arg_5_1()
	end
end

function WushMonsterComp:_onClick()
	if g.core.model.User.wushData:isFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(303030))

		return
	end

	local var_7_0 = g.core.model.User.wushData:getCurStageIndex()

	if self._canAttack then
		self:dispatchCompEvent("WUSHMAINLAYER_SHOW_BATTLEINFO", {
			stageId = self._stageId,
			floorId = self._floorId,
			stageIndex = self._stageIndex
		})
	elseif var_7_0 < self._stageIndex then
		g.core.module.ModuleManager:tip(g.core.lang:get(303028))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(303029))
	end
end

function WushMonsterComp:doAutoAction()
	if g.core.model.User.wushData:isFinish() then
		return false
	end

	if self._canAttack then
		self:onAutoShowBattleInfo()

		return true
	end

	return false
end

function WushMonsterComp:onAutoShowBattleInfo()
	self:dispatchCompEvent("WUSHMAINLAYER_SHOW_BATTLEINFO", {
		stageId = self._stageId,
		floorId = self._floorId,
		stageIndex = self._stageIndex
	})
end

return WushMonsterComp
