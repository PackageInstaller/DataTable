local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dl359lgic51"

function var_0_0:__ctor()
	self.m_wishStateController = self:getController("wishState")
	self.m_colorController = self:getController("color")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_memberPic = self:getChild("memberPic")
	self.m_tipText = self:getChild("tipText")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_knightComp = self:getChild("knightComp")
end

var_0_0.WishStateCtrl = {
	wish = 1,
	done = 2,
	none = 0
}
var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
