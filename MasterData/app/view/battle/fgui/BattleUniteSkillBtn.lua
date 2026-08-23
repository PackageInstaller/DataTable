local BattleUniteSkillBtn = class("BattleUniteSkillBtn", require("app.fairyGUI.battle.UI_BattleUniteSkillBtn"))

function BattleUniteSkillBtn:ctor()
	self._tokenId = 0
	self._skillId = 0
	self._skillLevel = 0
	self._baseCostNum = 0
	self._costMod = 0
	self._costNum = 0
	self._curUniteNum = 0
	self._roundNum = 0
	self._curCdRound = 0
	self._isUnlock = true
	self._progressTimer = nil
	self._canUse = false
	self._isUseFakeVisible = false
	self._uniteAnimation = nil
	self._bgEffect = nil
	self._advId = 0
end

function BattleUniteSkillBtn:initUniteSkill(arg_2_1)
	self._haveToken = arg_2_1.tokenId ~= nil
	self._isUnlock = arg_2_1.isUnLock

	if self._haveToken and not self._bgEffect then
		self._bgEffect = self.m_effActivated:addEffectSpine({
			name = "eff_ui_battle_activated",
			scale = 1,
			isLoop = true
		})

		self._bgEffect:setVisible(false)
	end

	if self._haveToken then
		self._tokenId = arg_2_1.tokenId

		local var_2_0 = g.core.config.unite_token_info.get(self._tokenId)

		self._skillId = var_2_0.skill_id
		self._skillLevel = var_2_0.star
		self._advId = var_2_0.advance_id

		local var_2_1 = g.core.config.skill_info.get(self._skillId)

		self._baseCostNum = var_2_1.rage_value
		self._costMod = 0
		self._costNum = self._baseCostNum
		self._roundNum = var_2_1.extra_cost_value

		if self._isUseFakeVisible then
			self.m_iconComp:updateIcon()
		else
			self.m_iconComp:updateIcon({
				skillId = self._tokenId
			})
		end

		self.m_iconComp:updateIcon({
			skillId = self._tokenId
		})
		self.m_costText:setText(self._costNum)
		self:initCDCircleProgress()
	else
		self.m_iconComp:updateIcon()
	end

	if not self._isUseFakeVisible then
		self.m_hasSkillController:setSelectedIndex(self._haveToken and 1 or 0)
	end
end

function BattleUniteSkillBtn:initCDCircleProgress()
	self.m_cdText:setVisible(false)
	self.m_maskImg1:setFillAmount(0)

	self._curCdRound = 0
end

function BattleUniteSkillBtn:_setMaskVisible(arg_4_1)
	self.m_maskImg1:setVisible(arg_4_1)
	self.m_maskImg2:setVisible(arg_4_1)
end

function BattleUniteSkillBtn:updateRoundCD(arg_5_1)
	self._curCdRound = arg_5_1 or self._roundNum

	local var_5_0 = self._curCdRound

	if self._curCdRound == 0 then
		self.m_cdText:setVisible(false)
		self.m_cdText:setText(self._curCdRound)

		var_5_0 = self._roundNum
	else
		self.m_cdText:setText(self._curCdRound)
		self.m_cdText:setVisible(true)
	end

	self.m_maskImg1:setFillAmount(var_5_0 / self._roundNum)
	self:updateUseStatus()
end

function BattleUniteSkillBtn:updateUseStatus()
	local var_6_0 = true
	local var_6_1 = true
	local var_6_2 = true

	if not self._isUnlock then
		var_6_0 = false
	end

	if self:getCurCDRound() > 0 then
		var_6_1 = false
	end

	if self:getCostNum() > self._curUniteNum then
		var_6_2 = false
	end

	local var_6_3 = self._canUse

	self._canUse = var_6_0 and var_6_1 and var_6_2

	self:_setMaskVisible(true)

	if not var_6_3 and self._canUse then
		self.m_activatedTransition:play()
		self.m_activatedTransition:setHook("play", handler(self, self._onPlayRefresh))
	end

	if self._canUse and self._haveToken and not self._isUseFakeVisible then
		self._bgEffect:setVisible(true)
	elseif self._bgEffect then
		self._bgEffect:setVisible(false)
	end

	local var_6_4 = 0

	if not var_6_0 then
		var_6_4 = 1
	end

	self.m_lockStatusController:setSelectedIndex(var_6_4)
	self.m_lockImg:setVisible(var_6_4 == 1)

	if not self._canUse then
		self.m_maskImg1:setOpacity(102)
		self.m_maskImg2:setOpacity(102)
	end
end

function BattleUniteSkillBtn:_onPlayRefresh()
	if not self._uniteAnimation then
		self._uniteAnimation = self.m_effSkillRefresh:addEffectSpine({
			isLoop = false,
			name = "eff_ui_battle_skillRefresh"
		})
	else
		self._uniteAnimation:setAnimation(0, "play", false)
	end
end

function BattleUniteSkillBtn:updateCost(arg_8_1)
	self._curUniteNum = arg_8_1 or 0

	self:updateUseStatus()
end

function BattleUniteSkillBtn:getHaveToken()
	return self._haveToken
end

function BattleUniteSkillBtn:getTokenId()
	return self._tokenId
end

function BattleUniteSkillBtn:getSkillId()
	return self._skillId
end

function BattleUniteSkillBtn:getAdvId()
	return self._advId
end

function BattleUniteSkillBtn:getCostNum()
	return self._baseCostNum + self._costMod
end

function BattleUniteSkillBtn:setCostMod(arg_14_1)
	self._costMod = arg_14_1 or 0
	self._costNum = self._baseCostNum + self._costMod

	if self.m_costText then
		self.m_costText:setText(self._costNum)
	end

	self:updateUseStatus()
end

function BattleUniteSkillBtn:getCurCDRound()
	return self._curCdRound
end

function BattleUniteSkillBtn:setFakeVisible(arg_16_1)
	local var_16_0 = 1

	if not arg_16_1 then
		var_16_0 = 0
	end

	self._isUseFakeVisible = not arg_16_1

	self.m_hasSkillController:setSelectedIndex(var_16_0)

	if arg_16_1 then
		self.m_iconComp:updateIcon({
			skillId = self._tokenId
		})
	else
		self.m_iconComp:updateIcon()
	end

	self:updateUseStatus()
end

function BattleUniteSkillBtn:isFakeHide()
	return self._isUseFakeVisible
end

function BattleUniteSkillBtn:isCanUse()
	return self._canUse
end

function BattleUniteSkillBtn:_playActivedAction()
	return
end

return BattleUniteSkillBtn
