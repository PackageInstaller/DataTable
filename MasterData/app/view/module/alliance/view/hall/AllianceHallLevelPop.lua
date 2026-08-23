local var_0_0 = g.core.model.User.allianceData
local AllianceHallLevelPop = class("AllianceHallLevelPop", require("app.fairyGUI.alliance.UI_AllianceHallLevelPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceHallLevelPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceHallLevelPop:ctor()
	self:showAtCenter()
	self.m_levelList:setVirtual()
	self.m_levelList:setItemRenderer(handler(self, self._onRenderItem))

	self._list = var_0_0:getDilatationList()

	self.m_levelList:setNumItems(#self._list)
end

function AllianceHallLevelPop:_onRenderItem(arg_3_1, arg_3_2)
	arg_3_2:updateLevelCell(arg_3_1 + 1, self._list[arg_3_1 + 1])
end

return AllianceHallLevelPop
