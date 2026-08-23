local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnp1v6c"

function var_0_0:__ctor()
	self.m_itemNumController = self:getController("itemNum")
	self.m_nameTxt1 = self:getChild("nameTxt1")
	self.m_nameTxt2 = self:getChild("nameTxt2")
	self.m_nameTxt3 = self:getChild("nameTxt3")
	self.m_nameTxt4 = self:getChild("nameTxt4")
	self.m_valueTxt1 = self:getChild("valueTxt1")
	self.m_valueTxt2 = self:getChild("valueTxt2")
	self.m_valueTxt3 = self:getChild("valueTxt3")
	self.m_valueTxt4 = self:getChild("valueTxt4")
end

var_0_0.ItemNumCtrl = {
	["2条"] = 3,
	["1条"] = 2,
	["0条"] = 1,
	["4条"] = 5,
	["3条"] = 4
}

return var_0_0
