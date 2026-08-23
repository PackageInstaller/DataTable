local BattleConst = require("app.view.battle.const.BattleConst")
local BattleSuccubaItem = class("BattleSuccubaItem", require("app.fairyGUI.battle.UI_BattleSuccubaItem"))

function BattleSuccubaItem:ctor()
	self.succubaId = 0
	self._skillId = 0
	self._skillLevel = 0
	self._costNum = 0
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

function BattleSuccubaItem:initSuccubaSkill(arg_2_1, arg_2_2)
	self._haveSuccuba = arg_2_1 ~= nil

	if self._haveSuccuba then
		self.succubaId = arg_2_1.succubaId

		local var_2_0 = g.core.config.succuba_info.get(self.succubaId)

		self._skillId = var_2_0.skill_id
		self._skillLevel = var_2_0.star
		self._advId = var_2_0.advance_id

		self.m_icon:setIcon(g.core.common.Path:getSuccubaHeadIcon(var_2_0.advance_id))

		self._roundNum = g.core.config.skill_info.get(self._skillId).extra_cost_value
		self._curCdRound = arg_2_2 or 0

		if self._curCdRound == 0 then
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_cdTxt:setText(self._curCdRound)
			self.m_stateController:setSelectedIndex(1)
		end
	else
		self.m_icon:setIcon("")
		self.m_stateController:setSelectedIndex(2)
	end
end

function BattleSuccubaItem:getSuccubaId()
	return self.succubaId
end

function BattleSuccubaItem:getSkillId()
	return self._skillId
end

function BattleSuccubaItem:updateRoundCD(arg_5_1)
	self._curCdRound = arg_5_1 or self._roundNum

	if self._curCdRound == 0 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_cdTxt:setText(self._curCdRound)
	end

	self:updateUseStatus()
end

function BattleSuccubaItem:updateUseStatus()
	return
end

function BattleSuccubaItem:getAdvId()
	return self._advId
end

return BattleSuccubaItem
