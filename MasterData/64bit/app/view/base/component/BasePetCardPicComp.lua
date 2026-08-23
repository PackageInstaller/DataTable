local BasePetCardPicComp = class("BasePetCardPicComp", require("app.fairyGUI.base_new.UI_BasePetCardPicComp"))
local var_0_1 = g.core.common.Path

function BasePetCardPicComp:updatePic(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1:getCfg()

	self.m_picComp:setIcon((var_0_1:getPetPictorialBook(var_1_0.resource)))
	self.m_qualityLoader:setURL(g.core.common.Path:getPerCardQualityQualityFrame(var_1_0.quality))
end

return BasePetCardPicComp
