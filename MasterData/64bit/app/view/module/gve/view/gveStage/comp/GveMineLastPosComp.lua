local GveMineLastPosComp = class("GveMineLastPosComp", require("app.fairyGUI.gve.UI_GveMineLastPosComp"))

function GveMineLastPosComp:ctor()
	self.m_headText:getChild("icon"):updateAsUser(g.core.model.User:getUserData())
end

function GveMineLastPosComp:updateArrow(arg_2_1, arg_2_2)
	local var_2_0 = math.radian2angle((cc.pToAngleSelf(cc.pSub(arg_2_2, arg_2_1))))

	self.m_rotateImg:setRotation(-var_2_0)

	return -var_2_0 % 360
end

return GveMineLastPosComp
