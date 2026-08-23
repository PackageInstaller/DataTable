local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ov6g3r"

function var_0_0:__ctor()
	self.m_equip_typeController = self:getController("equip_type")
	self.m_show_arrowController = self:getController("show_arrow")
	self.m_scaleController = self:getController("scale")
	self.m_Loader_icon = self:getChild("Loader_icon")
end

var_0_0.Equip_typeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Show_arrowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ScaleCtrl = {
	["0.6"] = 3,
	["0.7"] = 2,
	["0.8"] = 1,
	["1.0"] = 0,
	["0.4"] = 5,
	["0.5"] = 4
}

return var_0_0
