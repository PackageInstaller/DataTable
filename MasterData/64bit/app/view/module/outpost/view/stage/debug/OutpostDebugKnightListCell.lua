local OutpostDebugKnightListCell = class("OutpostDebugKnightListCell", require("app.fairyGUI.outpost.UI_OutpostDebugKnightListCell"))

function OutpostDebugKnightListCell:ctor()
	self:disableAutoChange()
	self:getChild("title"):disableAutoChange()
end

function OutpostDebugKnightListCell:updateKnight(arg_2_1)
	local var_2_0 = arg_2_1:getEntityKnightStruct()

	self:setTitle((string.format("%s(map:%d)\n(sid:%d)", var_2_0:getCfg().name, arg_2_1:getMapType(), var_2_0:getServerId())))
end

function OutpostDebugKnightListCell:updateMonster(arg_3_1)
	local var_3_0 = arg_3_1:getMonsterInfo()

	self:setTitle((string.format("%s(map:%d)\n(infoId:%s)(sid:%d)", var_3_0.name, arg_3_1:getMapType(), var_3_0.id, arg_3_1:getUid())))
end

return OutpostDebugKnightListCell
