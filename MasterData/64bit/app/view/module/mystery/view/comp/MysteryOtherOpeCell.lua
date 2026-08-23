local var_0_0 = g.core.model.User.mysteryData
local MysteryOtherOpeCell = class("MysteryOtherOpeCell", require("app.fairyGUI.mystery.UI_MysteryOtherOpeCell"))

function MysteryOtherOpeCell:updateOtherCell(arg_1_1)
	self._userInfo = var_0_0:getRoomUserData()[arg_1_1:getBindID()]

	self:setTitle(self._userInfo.snapShot.name)
	self.m_iconComp:updateAsUser(self._userInfo.snapShot)
end

function MysteryOtherOpeCell:getCellData()
	return self._userInfo
end

return MysteryOtherOpeCell
