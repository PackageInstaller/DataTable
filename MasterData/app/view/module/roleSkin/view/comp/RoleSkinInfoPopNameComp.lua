local RoleSkinInfoPopNameComp = class("RoleSkinInfoPopNameComp", require("app.fairyGUI.roleSkin.UI_RoleSkinInfoPopNameComp"))

function RoleSkinInfoPopNameComp:ctor()
	return
end

function RoleSkinInfoPopNameComp:updateNameComp(arg_2_1)
	self.m_nameTxt:setText(arg_2_1:getName())
	self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURLNew(arg_2_1:getQuality()))
	self.m_partTxt:setText(g.core.model.User.roleSkinData:getPartNameByPart(arg_2_1:getPart()))
end

return RoleSkinInfoPopNameComp
