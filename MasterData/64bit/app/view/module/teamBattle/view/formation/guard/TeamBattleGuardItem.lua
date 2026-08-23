local TeamBattleGuardItem = class("TeamBattleGuardItem", require("app.fairyGUI.teamBattle.UI_TeamBattleGuardItem"))

function TeamBattleGuardItem:ctor()
	self._idx = 0
	self._knightStruct = nil

	self.m_addBtn:addClickListener(handler(self, self._onClickAddBtn))
	self.m_starGroupComp:initStar({
		index = 3,
		num = 0,
		style = 2,
		gap = -10
	})
end

function TeamBattleGuardItem:updateGuardItem(arg_2_1, arg_2_2)
	self._knightStruct = arg_2_1
	self._idx = arg_2_2

	if not arg_2_1 then
		self.m_hasKnightController:setSelectedIndex(0)

		return
	end

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._knightStruct:getBaseInfo().classical))
	self.m_knightLoader:setIcon((g.core.common.Path:getKnightIconById(self._knightStruct:getResInfo().painted_id)))
	self.m_leftQualityLoader:setURL((g.core.common.Path:getMulTeamLeftVerticalQualityBarURL((self._knightStruct:getQuality()))))
	self.m_starGroupComp:setStarNum(self._knightStruct:getStarLv())
	self.m_hasKnightController:setSelectedIndex(1)
end

function TeamBattleGuardItem:_onClickAddBtn()
	self:dispatchCompEvent("formationGuard", {
		pos = self._idx
	})
end

return TeamBattleGuardItem
