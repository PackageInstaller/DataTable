local var_0_0 = {}

var_0_0.URL = "ui://kdymz22pbfn4l"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_typeController = self:getController("type")
	self.m_btn = self:getChild("btn")
	self.m_name = self:getChild("name")
	self.m_descText = self:getChild("descText")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
