local TeamBattleKnightBagItem = class("TeamBattleKnightBagItem", require("app.fairyGUI.teamBattle.UI_TeamBattleKnightBagItem"))

function TeamBattleKnightBagItem:ctor()
	self._knightStruct = nil

	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = g.core.const.ConstMgr.KNIGHT_CONST.STAR_MAX
	})
	self.m_hpBar:setMax(100)
	self:addClickListener(handler(self, self._onClick))
	self.m_qualityIcon:addClickListener(handler(self, self._onClick))
end

function TeamBattleKnightBagItem:updateItem(arg_2_1)
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_2_1:getBaseInfo().classical))

	local var_2_0 = arg_2_1:getHpPercent()

	self.m_hpBar:setValue(var_2_0)
	self.m_knightIcon:setIcon(g.core.common.Path:getKnightPicRes(arg_2_1:getResInfo().id))
	self.m_qualityIcon:setURL(g.core.common.Path:getTeamBattleBagItemQuality(arg_2_1:getQuality()))
	self.m_starComp:setStarNum(arg_2_1:getStarLv())

	self._knightStruct = arg_2_1

	if var_2_0 <= 0 then
		self.m_isDeadController:setSelectedIndex(1)
	else
		self.m_isDeadController:setSelectedIndex(0)
	end
end

function TeamBattleKnightBagItem:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightStruct = self._knightStruct
	}), {
		touchDisappear = true
	})
end

return TeamBattleKnightBagItem
