local var_0_0 = g.core.const.ConstMgr.BattleResultConst
local BattleArenaCardComp = class("BattleArenaCardComp", require("app.fairyGUI.battleResult.UI_BattleArenaCardComp"))

function BattleArenaCardComp:ctor()
	return
end

function BattleArenaCardComp:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	arg_2_1.hideNum = false

	self.m_awardIconComp:updateIcon(arg_2_1)

	local var_2_0 = g.core.common.Goods:convert(arg_2_1)

	self.m_nameText:setText((var_2_0 or nil) and (var_2_0.name or ""))
	self.m_isOpenController:setSelectedIndex(var_0_0.CTRL_CARD_OPEN)
	self.m_isSelectController:setSelectedIndex((arg_2_2 or nil) and (var_0_0.CTRL_CARD_SEL or var_0_0.CTRL_CARD_UNSEL))
end

return BattleArenaCardComp
