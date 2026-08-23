local var_0_0 = g.core.common.Path
local UniteTokenNameComp = class("UniteTokenNameComp", require("app.fairyGUI.uniteToken.UI_UniteTokenNameComp"))

function UniteTokenNameComp:updateNameShow(arg_1_1)
	self.m_nameTxt:setText(arg_1_1.name)
	self.m_starComp:initStar({
		index = 3,
		style = 2,
		max = 5,
		num = arg_1_1.star
	})
	self.m_quality:setURL(var_0_0:getNameQualityBg(arg_1_1.quality))
	self.m_qualityIcon:setURL(var_0_0:getQualityArtTxtURL(arg_1_1.quality))
end

return UniteTokenNameComp
