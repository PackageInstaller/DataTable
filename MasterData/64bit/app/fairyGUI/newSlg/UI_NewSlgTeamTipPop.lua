local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jdif969m5"

function var_0_0:__ctor()
	self.m_hasElemController = self:getController("hasElem")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_elemNumTxt = self:getChild("elemNumTxt")
	self.m_desList = self:getChild("desList")
	self.m_closeBtn = self:getChild("closeBtn")
end

var_0_0.HasElemCtrl = {
	normal = 0,
	has = 1
}

return var_0_0
