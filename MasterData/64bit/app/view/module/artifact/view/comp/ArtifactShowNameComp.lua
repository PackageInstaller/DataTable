local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.common.Path
local ArtifactShowNameComp = class("ArtifactShowNameComp", require("app.fairyGUI.artifact.UI_ArtifactShowNameComp"))

function ArtifactShowNameComp:ctor()
	return
end

function ArtifactShowNameComp:updateNameInfo(arg_2_1, arg_2_2)
	self.m_nameTxt:setText(arg_2_1.name)
	self.m_starComp:initStar({
		style = 2,
		index = 3,
		max = arg_2_2:getMaxStar(),
		num = arg_2_1.star
	})
	self.m_quality:setURL(var_0_1:getNameQualityBg(arg_2_1.quality))
	self.m_qualityIcon:setURL(var_0_1:getQualityArtTxtURLNew(arg_2_1.quality))

	if arg_2_2:isHasWeaponSpirit() and arg_2_2:getSpiritStage() > 0 then
		self.m_spiritComp:updateCurWeapon(arg_2_2)
		self.m_urStageAddController:setSelectedIndex(1)
	else
		self.m_urStageAddController:setSelectedIndex(0)
	end
end

return ArtifactShowNameComp
