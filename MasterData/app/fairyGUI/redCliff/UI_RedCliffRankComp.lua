local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sddye3h"

function var_0_0:__ctor()
	self.m_isDownController = self:getController("isDown")
	self.m_rankList = self:getChild("rankList")
	self.m_myRank = self:getChild("myRank")
	self.m_myScore = self:getChild("myScore")
	self.m_downBtn = self:getChild("downBtn")
end

return var_0_0
