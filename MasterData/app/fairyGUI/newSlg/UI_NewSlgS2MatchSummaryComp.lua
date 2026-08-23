local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb96949"

function var_0_0:__ctor()
	self.m_scoreController = self:getController("score")
	self.m_Txt_desc1 = self:getChild("Txt_desc1")
	self.m_Txt_desc2 = self:getChild("Txt_desc2")
	self.m_Txt_desc3 = self:getChild("Txt_desc3")
end

var_0_0.ScoreCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
