local var_0_0 = g.core.common.Path
local FurnitureRoomBgComp = class("FurnitureRoomBgComp", require("app.fairyGUI.furniture.UI_FurnitureRoomBgComp"))

function FurnitureRoomBgComp:updatebBgWithFurnitureStruct(arg_1_1)
	self.m_bgLoader:setURL(var_0_0:getFurnitureRoomBgByRes(arg_1_1.res), true)
end

function FurnitureRoomBgComp:clearnFurnitureRoomBg()
	self.m_bgLoader:setURL("")
end

function FurnitureRoomBgComp:getGridPos()
	return 0, 0
end

return FurnitureRoomBgComp
