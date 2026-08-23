local var_0_0 = {}

var_0_0.URL = "ui://foyq921slyd73x"

function var_0_0:__ctor()
	self.m_knightPosController = self:getController("knightPos")
	self.m_imgPosTouch = self:getChild("imgPosTouch")
	self.m_knightPic = self:getChild("knightPic")
	self.m_touchComp = self:getChild("touchComp")
end

var_0_0.KnightPosCtrl = {
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
