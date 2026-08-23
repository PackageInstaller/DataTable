local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.playerInfoData
local PlayerInfoTissueCell = class("PlayerInfoTissueCell", require("app.fairyGUI.playerInfo.UI_PlayerInfoTissueCell"))

function PlayerInfoTissueCell:updateCell(arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 then
		return
	end

	self.m_showLoader:setURL((var_0_0:getArtifactTissuePic(arg_1_1.icon)))

	if arg_1_3 and g.core.model.User.knightTissueData:isKnightTissueActive(arg_1_1.id) or var_0_1:getKnightTissueById(arg_1_1.id) ~= nil then
		self.m_showLoader:setOpacity(255)
	else
		self.m_showLoader:setOpacity(76.5)
	end
end

return PlayerInfoTissueCell
