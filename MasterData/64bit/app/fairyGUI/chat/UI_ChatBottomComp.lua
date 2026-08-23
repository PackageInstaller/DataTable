local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87dhwcby2wx"

function var_0_0:__ctor()
	self.m_showFaceController = self:getController("showFace")
	self.m_hideFace = self:getChild("hideFace")
	self.m_faceComp = self:getChild("faceComp")
	self.m_inputComp = self:getChild("inputComp")
	self.m_sendBtn = self:getChild("sendBtn")
	self.m_imgBtn = self:getChild("imgBtn")
end

var_0_0.ShowFaceCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
