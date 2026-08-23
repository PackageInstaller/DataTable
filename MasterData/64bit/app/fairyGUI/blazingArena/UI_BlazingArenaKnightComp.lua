local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9v3rk2h"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isRivalController = self:getController("isRival")
	self.m_knightPic = self:getChild("knightPic")
	self.m_addBtn = self:getChild("addBtn")
	self.m_imgPosTouch = self:getChild("imgPosTouch")
end

return var_0_0
