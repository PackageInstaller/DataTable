local var_0_0 = g.core.model.User.annoData
local AnnoTabBtn = class("AnnoTabBtn", require("app.fairyGUI.announcement.UI_AnnoTabBtn"))

function AnnoTabBtn:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function AnnoTabBtn:updateCell(arg_2_1)
	local var_2_0 = var_0_0:getWebInfo(arg_2_1)

	self:setTitle(var_2_0.name)

	if var_0_0:isRead(var_2_0.id) then
		self.m_showRedPointController:setSelectedIndex(0)
	else
		self.m_showRedPointController:setSelectedIndex(1)
	end
end

return AnnoTabBtn
