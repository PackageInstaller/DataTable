local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local var_0_1 = g.core.model.User.mysteryBossData
local var_0_2 = g.core.common.ServerTime
local MysteryBossPosComp = class("MysteryBossPosComp", require("app.fairyGUI.mystery.UI_MysteryBossPosComp"))

function MysteryBossPosComp:ctor()
	self._challengePos = 0
	self._cdSchedule = nil

	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleButton))
	self.m_lineUpLoader:addClickListener(handler(self, self._onClickBattleButton))
	self.m_stateController:setSelectedIndex(2)
end

function MysteryBossPosComp:updatePosInfo(arg_2_1, arg_2_2, arg_2_3)
	self._boss = arg_2_2
	self._challengePos = arg_2_3
	self._posData = arg_2_1

	if arg_2_1 then
		local var_2_0 = arg_2_1.user_id
		local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

		if var_2_1 then
			self.m_userIcon:updateAsUser(var_2_1)
			self.m_userNameTxt:setText(var_2_1.name)
			self.m_fightValueTxt:setText(var_2_1.fight_value)
			self.m_stateController:setSelectedIndex(0)
		end

		self.m_userIcon:setVisible(checkbool(var_2_1))
		self.m_userNameTxt:setVisible(checkbool(var_2_1))
		self.m_fightValueTxt:setVisible(checkbool(var_2_1))

		local var_2_2, var_2_3 = var_0_1:isSelfAttackUserCD()
		local var_2_4 = var_0_2:getLeftSeconds(var_2_3)

		if var_2_2 and var_2_4 > 0 then
			self.m_stateController:setSelectedIndex(1)
			self.m_rebornTimeTxt:setText(g.core.lang:get(423512, {
				time = var_2_4
			}))

			self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._updateAttckCD), 1)
		end

		self.m_isMySelfController:setSelectedIndex(checkbool(var_2_0 == g.core.model.User:getId()) and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(2)
	end

	local var_2_5 = arg_2_2:getBossConfig().buff_normal / 10

	self.m_addValTxt:setText(g.core.lang:get(423511, {
		value = (self._boss:getBossType() == var_0_0.BOSS_TYPE.LIMIT and self._challengePos == 1 or nil) and arg_2_2:getBossConfig().buff_special / 10
	}))
end

function MysteryBossPosComp:_updateAttckCD()
	local var_3_0, var_3_1 = var_0_1:isSelfAttackUserCD()
	local var_3_2 = var_0_2:getLeftSeconds(var_3_1)

	if var_3_0 and var_3_2 > 0 then
		self.m_rebornTimeTxt:setText(g.core.lang:get(423512, {
			time = var_3_2
		}))
	else
		if self._cdSchedule then
			self:cancelSchedule(self._cdSchedule)

			self._cdSchedule = nil
		end

		self:updatePosInfo(self._posData, self._boss, self._challengePos)
	end
end

function MysteryBossPosComp:_onClickBattleButton()
	if self:_checkCanBattleUser() then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_ShangZhen)
		self:dispatchCompEvent("MYSTERYBOSS_CHALLENGE_POS", self._challengePos)
	end
end

function MysteryBossPosComp:_checkCanBattleUser()
	local var_5_0 = self._boss:getMySelfPos()

	if self._boss:getBossType() == var_0_0.BOSS_TYPE.NOMARL then
		if var_5_0 > 0 and not self._posData then
			g.core.module.ModuleManager:tip(g.core.lang:get(423514))

			return false
		end
	else
		if var_5_0 == var_0_0.LIMIT_SPECIAL_POS then
			g.core.module.ModuleManager:tip(g.core.lang:get(423515))

			return false
		end

		if self._challengePos == var_0_0.LIMIT_SPECIAL_POS and var_5_0 == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(423516))

			return false
		elseif self._challengePos ~= var_0_0.LIMIT_SPECIAL_POS and var_5_0 > 0 and not self._posData then
			g.core.module.ModuleManager:tip(g.core.lang:get(423514))

			return false
		end
	end

	if var_0_1:isSelfAttackUserCD() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423518))

		return false
	end

	if self._boss:isProtectPos((self._boss:getMySelfPos())) or self._boss:isProtectPos(self._challengePos) then
		g.core.module.ModuleManager:tip(g.core.lang:get(423519))

		return false
	end

	if not self._boss:getBossAlive() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423525))

		return false
	end

	return true
end

return MysteryBossPosComp
