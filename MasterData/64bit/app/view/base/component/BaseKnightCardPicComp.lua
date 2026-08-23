local BaseKnightCardPicComp = class("BaseKnightCardPicComp", require("app.fairyGUI.base_new.UI_BaseKnightCardPicComp"))
local var_0_1 = g.core.common.Path

function BaseKnightCardPicComp:updatePic(arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1:getBaseInfo()

	self.m_campComp:setIcon(var_0_1:getCampURL(var_1_0.group, 1))
	self.m_picComp:setIcon(var_0_1:getKnightBookPicRes(arg_1_1:getResInfo().painted_id))
	self.m_qualityLoader:setURL(var_0_1:getCardQualityLine(var_1_0.quality))
end

return BaseKnightCardPicComp
