local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostBarrierComp = class("OutpostBarrierComp", require("app.fairyGUI.outpost.UI_OutpostBarrierComp"))

function OutpostBarrierComp:ctor()
	self._objType = var_0_1.EntityType.Barrier
	self._basePos = self.m_buildIcon:getPosition()
	self._virtualObj = nil

	self:setTouchable(false)
end

function OutpostBarrierComp:getEntityType()
	return self._objType
end

function OutpostBarrierComp:updateEntityShowParam(arg_3_1)
	self.m_buildIcon:setScaleX(1)

	self._virtualObj = arg_3_1
	self._objType = arg_3_1.entityType

	local var_3_0 = arg_3_1:getBarrierInfo()
	local var_3_1 = OutpostCommon.DIR_X[var_3_0.x_w * 100 + var_3_0.y_w] or cc.p(0, 0)
	local var_3_2, var_3_3 = OutpostCommon.parseTiledGidNoFirstGid(var_3_0.gid)

	self.m_buildIcon:setURL("ui://outpost/" .. var_3_2)

	if var_3_3.h then
		self.m_buildIcon:setScaleX(-1)
	end

	self.m_buildIcon:setPosition(cc.pAdd(self._basePos, var_3_1))
end

return OutpostBarrierComp
