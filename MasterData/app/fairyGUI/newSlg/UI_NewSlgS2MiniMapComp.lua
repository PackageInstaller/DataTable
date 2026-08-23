local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9694i"

function var_0_0:__ctor()
	self.m_hide_mapController = self:getController("hide_map")
	self.m_Img_map = self:getChild("Img_map")
	self.m_Img_map2 = self:getChild("Img_map2")
	self.m_Img_map3 = self:getChild("Img_map3")
	self.m_Img_map4 = self:getChild("Img_map4")
	self.m_eff = self:getChild("eff")
	self.m_posImg = self:getChild("posImg")
end

var_0_0.Hide_mapCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
