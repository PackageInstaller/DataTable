local var_0_0 = g.core.model.User.furnitureData
local FurnitureFriendComfortLvComp = class("FurnitureFriendComfortLvComp", require("app.fairyGUI.furniture.UI_FurnitureFriendComfortLvComp"))

function FurnitureFriendComfortLvComp:ctor()
	self._dormId = nil
	self._comfort = 0
end

function FurnitureFriendComfortLvComp:updateComp(arg_2_1)
	self._dormId = arg_2_1

	local var_2_0 = var_0_0:getFriendRoomInfo(arg_2_1)

	self._comfort = var_2_0:getComfort()

	self.m_roomLvTxt:setText(var_2_0:getLevel())
	self.m_comfortLvTxt:setText(self._comfort)
end

return FurnitureFriendComfortLvComp
