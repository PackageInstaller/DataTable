local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhn2r12d"

function var_0_0:__ctor()
	self.m_clickBg = self:getChild("clickBg")
	self.m_tipsBgImg = self:getChild("tipsBgImg")
	self.m_bgEff = self:getChild("bgEff")
	self.m_titleBg = self:getChild("titleBg")
	self.m_titleEff = self:getChild("titleEff")
	self.m_tips = self:getChild("tips")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
