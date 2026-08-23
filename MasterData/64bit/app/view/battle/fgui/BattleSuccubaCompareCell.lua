local var_0_0 = cc.FileUtils:getInstance()
local BattleSuccubaCompareCell = class("BattleSuccubaCompareCell", require("app.fairyGUI.battle.UI_BattleSuccubaCompareCell"))

function BattleSuccubaCompareCell:updateCompareCell(arg_1_1)
	local var_1_0 = g.core.common.Path:getRoleHeadIcon(arg_1_1:getBaseKnightInfo().icon_id)

	if var_0_0:isFileExist(var_1_0) then
		self.m_iconComp:setIcon(var_1_0)
	else
		self.m_iconComp:setIcon(g.core.common.Path:getRoleHeadIcon(301040))
	end
end

return BattleSuccubaCompareCell
