local BaseArtifactRelateKnightMask = class("BaseArtifactRelateKnightMask", require("app.fairyGUI.base_new.UI_BaseArtifactRelateKnightMask"))
local var_0_1 = g.core.common.Path

function BaseArtifactRelateKnightMask:ctor()
	return
end

function BaseArtifactRelateKnightMask:updateBelongToIcon(arg_2_1)
	self.m_iconLoader:setURL((var_0_1:getKnightIconById(g.core.model.User.knightsData:getKnightByAdvanceId(arg_2_1):getResInfo().icon_id)))
end

return BaseArtifactRelateKnightMask
