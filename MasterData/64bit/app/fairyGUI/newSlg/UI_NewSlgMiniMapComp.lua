local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9d6ds68e0"

function var_0_0:__ctor()
	self.m_hide_mapController = self:getController("hide_map")
	self.m_Img_map = self:getChild("Img_map")
	self.m_posImg = self:getChild("posImg")
end

var_0_0.Hide_mapCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
