local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb2d"

function var_0_0:__ctor()
	self.m_dropDownController = self:getController("dropDown")
	self.m_title = self:getChild("title")
	self.m_curLineTxt = self:getChild("curLineTxt")
	self.m_lineList = self:getChild("lineList")
end

return var_0_0
