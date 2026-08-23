local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local BattleResultExplorationBuffIcon = class("BattleResultExplorationBuffIcon", require("app.fairyGUI.battleResult.UI_BattleResultExplorationBuffIcon"))

function BattleResultExplorationBuffIcon:ctor()
	return
end

function BattleResultExplorationBuffIcon:updateBuffIcon(arg_2_1, arg_2_2)
	local var_2_0 = {}

	var_2_0 = arg_2_2 == var_0_0.BUFF.SELECT_TYPE and g.core.config.exploration_buff_info.get(arg_2_1) or g.core.config.exploration_guild_buff_info.get(arg_2_1)

	self.m_bgLoader:setURL(g.core.common.Path:getExplorationBuffIconQuality(var_2_0.quality))
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_2_0.image))
end

return BattleResultExplorationBuffIcon
