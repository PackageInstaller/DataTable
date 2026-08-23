local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationBuffIcon = class("ExplorationBuffIcon", require("app.fairyGUI.exploration.UI_ExplorationBuffIcon"))

function ExplorationBuffIcon:ctor()
	return
end

function ExplorationBuffIcon:updateBuffIcon(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	var_2_0 = arg_2_2 == var_0_0.BUFF.SELECT_TYPE and g.core.config.exploration_buff_info.get(arg_2_1) or arg_2_3 and g.core.config.exploration_guild_buff_info.match(function(arg_3_0)
		if arg_3_0.group == arg_2_1 then
			return arg_3_0
		end
	end)[1] or g.core.config.exploration_guild_buff_info.get(arg_2_1)

	self.m_bgLoader:setURL(g.core.common.Path:getExplorationBuffIconQuality(var_2_0.quality))
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_2_0.image))
end

return ExplorationBuffIcon
