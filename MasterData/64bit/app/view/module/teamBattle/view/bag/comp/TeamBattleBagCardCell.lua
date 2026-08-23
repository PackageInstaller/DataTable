local var_0_0 = g.core.module.ModuleManager
local TeamBattleBagCardCell = class("TeamBattleBagCardCell", require("app.fairyGUI.teamBattle.UI_TeamBattleBagCardCell"))

function TeamBattleBagCardCell:ctor()
	self.m_starComp:initStar({
		num = 0,
		gap = 0,
		index = 3,
		style = 1,
		max = g.core.const.ConstMgr.KNIGHT_CONST.STAR_MAX
	})
	self.m_hpProgress:setMax(100)
	self:addClickListener(handler(self, self._onClickStruct))
end

function TeamBattleBagCardCell:_onClickStruct()
	var_0_0:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightStruct = self._struct
	}), {
		touchDisappear = true
	})
end

function TeamBattleBagCardCell:updateItem(arg_3_1)
	local var_3_0 = arg_3_1:getHpPercent()

	self.m_hpProgress:setValue(var_3_0)
	self.m_cardIcon:setIcon(g.core.common.Path:getKnightPicRes(arg_3_1:getResInfo().id))
	self.m_quality:setURL(g.core.common.Path:getTeamBattleBagItemQuality(arg_3_1:getQuality()))
	self.m_starComp:setStarNum(arg_3_1:getStarLv())

	self._struct = arg_3_1

	if var_3_0 <= 0 then
		self.m_isDeadController:setSelectedIndex(1)
	else
		self.m_isDeadController:setSelectedIndex(0)
	end
end

return TeamBattleBagCardCell
