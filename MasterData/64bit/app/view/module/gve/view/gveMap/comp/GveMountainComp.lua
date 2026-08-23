local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GveMountainComp = class("GveMountainComp", require("app.fairyGUI.gve.UI_GveMountainComp"))

function GveMountainComp:ctor()
	var_0_1 = var_0_0:getGveData()
	self._mountainId = 0
	self._basePos = self.m_mountainLoader:getPosition()
end

function GveMountainComp:updateMountainInfo(arg_2_1, arg_2_2)
	self:updateInFogState(arg_2_2)

	if not arg_2_1 or self._mountainId == arg_2_1 then
		return
	end

	self._mountainId = arg_2_1

	self.m_mountainLoader:setPosition(self._basePos.x, self._basePos.y + ((arg_2_1 == 379 or nil) and 100))
	self.m_mountainLoader:setURL("ui://gve/" .. arg_2_1)
end

function GveMountainComp:updateInFogState(arg_3_1)
	if var_0_1:isCurPosInFogCloud(arg_3_1) then
		self.m_mountainLoader:setColor(cc.c3b(77, 77, 77))
	else
		self.m_mountainLoader:setColor(cc.c3b(255, 255, 255))
	end
end

return GveMountainComp
