local var_0_0 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassAwardIcon = class("ServerPassAwardIcon", require("app.fairyGUI.serverPassActivity.UI_ServerPassAwardIcon"))

function ServerPassAwardIcon:ctor()
	self._data = nil

	self:addClickListener(handler(self, self._onClickSelf))
end

function ServerPassAwardIcon:updateIcon(arg_2_1)
	self._data = arg_2_1

	if arg_2_1.isPrivilege then
		self.m_otherIcon:setIcon(arg_2_1.icon)
		self.m_qualityIcon:setIcon(g.core.common.Path:getBaseItemIconQualityBg(arg_2_1.quality))
		self.m_upValueTxt:setText(string.format("+%d%%", math.floor(arg_2_1.value / 10)))
		self.m_showUpValueController:setSelectedIndex(1)
	else
		self.m_iconComp:updateIcon(arg_2_1)
		self.m_showUpValueController:setSelectedIndex(0)
	end
end

function ServerPassAwardIcon:_onClickSelf()
	local var_3_0

	if self.m_showUpValueController:getSelectedIndex() == 0 then
		do return end

		var_3_0 = {
			ratio = self._data.value / 10
		}
	end

	var_3_0.level = g.core.config.parameter_info.get(var_0_0.PARAMETER_ID.PRIVILEGE_LIMIT_LEVEL_ID).parameter

	g.core.module.ModuleManager:tip(g.core.lang:get(433201, var_3_0))
end

return ServerPassAwardIcon
