local var_0_0 = {}

var_0_0.URL = "ui://zwlhk6nx7disu"

function var_0_0:__ctor()
	self.m_levelController = self:getController("level")
	self.m_noticeController = self:getController("notice")
	self.m_activedController = self:getController("actived")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_qualityLeft = self:getChild("qualityLeft")
	self.m_qualityRight = self:getChild("qualityRight")
	self.m_nameHolder = self:getChild("nameHolder")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_bookValueTxt = self:getChild("bookValueTxt")
	self.m_englishName = self:getChild("englishName")
	self.m_englishLoader = self:getChild("englishLoader")
	self.m_gameName = self:getChild("gameName")
	self.m_btnDetail = self:getChild("btnDetail")
	self.m_activeEffHolder = self:getChild("activeEffHolder")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
