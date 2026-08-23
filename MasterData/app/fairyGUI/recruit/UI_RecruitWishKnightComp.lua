local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46nqhjgibw2"

function var_0_0:__ctor()
	self.m_wishStateController = self:getController("wishState")
	self.m_knightPic = self:getChild("knightPic")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.WishStateCtrl = {
	wish = 1,
	done = 2,
	none = 0
}

return var_0_0
