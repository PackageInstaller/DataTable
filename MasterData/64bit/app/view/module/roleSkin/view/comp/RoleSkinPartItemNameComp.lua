local RoleSkinPartItemNameComp = class("RoleSkinPartItemNameComp", require("app.fairyGUI.roleSkin.UI_RoleSkinPartItemNameComp"))

function RoleSkinPartItemNameComp:ctor()
	return
end

function RoleSkinPartItemNameComp:updateNameComp(arg_2_1, arg_2_2)
	self.m_name:setText(arg_2_1:getName())
	self.m_qualityLoader:setURL(g.core.common.Path:getQualityArtTxtURLNew(arg_2_1:getQuality()))
	self.m_stage:setText(g.core.lang:get(200042, {
		stage = arg_2_1:getStage()
	}))
	self.m_showStageController:setSelectedIndex(arg_2_2 == false and 0 or 1)
end

return RoleSkinPartItemNameComp
