local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693h"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_inRankController = self:getController("inRank")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Comp_guildIcon = self:getChild("Comp_guildIcon")
	self.m_Txt_alliName = self:getChild("Txt_alliName")
	self.m_Txt_score = self:getChild("Txt_score")
end

var_0_0.RankCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.InRankCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
