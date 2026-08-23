local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qi4p2v"

function var_0_0:__ctor()
	self.m_levelNumController = self:getController("levelNum")
	self.m_icon = self:getChild("icon")
	self.m_title = self:getChild("title")
	self.m_curLv = self:getChild("curLv")
	self.m_nextLv = self:getChild("nextLv")
end

var_0_0.LevelNumCtrl = {
	page2 = 4,
	page1 = 3,
	page0 = 2
}

return var_0_0
