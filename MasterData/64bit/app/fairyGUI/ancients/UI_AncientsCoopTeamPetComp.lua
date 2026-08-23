local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ef6438"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_Img_bg = self:getChild("Img_bg")
	self.m_Comp_petSpine = self:getChild("Comp_petSpine")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
