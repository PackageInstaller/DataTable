local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local var_0_2 = g.core.common.Goods
local DailyRecruitLinkComp = class("DailyRecruitLinkComp", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLinkComp"))

function DailyRecruitLinkComp:updateItemByInfo(arg_1_1)
	if arg_1_1.type == var_0_2.TYPE_PET then
		self.m_isPetLinkController:setSelectedIndex(1)
	elseif arg_1_1.type == var_0_2.TYPE_ARTIFACT then
		self.m_isPetLinkController:setSelectedIndex(0)

		local var_1_0 = var_0_1.knightsData:getKnightByAdvanceId((var_0_1.artifactData:getArtifactByAdvacnceId(arg_1_1.value):getBelongToKnightAvdIdIncludingMainRole()))

		self.m_knightComp:setIcon((var_0_0:getKnightIconById(var_1_0:getResInfo().icon_id)))
		self.m_qualityController:setSelectedIndex(var_1_0:getQuality() - 1)
	end
end

return DailyRecruitLinkComp
