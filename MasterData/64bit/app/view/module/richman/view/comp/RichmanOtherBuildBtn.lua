local var_0_0 = g.core.model.User.richmanData
local RichmanOtherBuildBtn = class("RichmanOtherBuildBtn", require("app.fairyGUI.richman.UI_RichmanOtherBuildBtn"))

function RichmanOtherBuildBtn:ctor()
	self:addClickListener(handler(self, self._onBuildBtnClick))
end

function RichmanOtherBuildBtn:updateBuildIcon()
	local var_2_0 = self.m_typeController:getSelectedIndex() + 1
	local var_2_1 = var_0_0:getCurRobData()
	local var_2_2
	local var_2_3

	if not var_2_1 then
		var_2_2 = var_0_0:getBuildData()
	else
		var_2_2 = var_0_0:formatRobConstruct(var_2_1.construct)
		var_2_3 = var_2_1 and var_2_2:getBuildLevelByMapLvAndType(var_2_1.map_level, var_2_0) or var_2_2:getBuildLevel(var_2_0)
	end

	self:setIcon(g.core.common.Path:getRichmanBuildRes(3, var_0_0:getBuildCfgByTypeAndLv(var_2_0, var_2_3).res))
end

function RichmanOtherBuildBtn:_onBuildBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.richman.view.pop.RichmanBuildPop").new(self.m_typeController:getSelectedIndex() + 1)))
end

return RichmanOtherBuildBtn
