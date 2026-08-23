local OutpostKnightAvatarComp = class("OutpostKnightAvatarComp", require("app.fairyGUI.outpost.UI_OutpostKnightAvatarComp"))

function OutpostKnightAvatarComp:ctor()
	self._knightInfo = nil

	self.m_pro:setMax(100)
end

function OutpostKnightAvatarComp:updateAvatarComp(arg_2_1)
	self._knightInfo = arg_2_1

	self.m_iconComp:setIcon((g.core.common.Path:getRoleHeadIcon(g.core.config.avata_info.get((g.core.model.User.userAvatarFrameData:getAvatarIdByKnightAdvanceId(g.core.model.User.outpostData:getKnightsData():getKnightBySid(self._knightInfo.sid):getAdvId()))).res)))

	local var_2_0 = g.core.common.ServerTime:getTime()

	self.m_pro:setValue((math.floor((var_2_0 - arg_2_1.inTime) / (arg_2_1.time - arg_2_1.inTime) * 100)))
	self.m_pro:tweenValue(100, arg_2_1.time - var_2_0)
end

return OutpostKnightAvatarComp
