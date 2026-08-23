local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ni5y68sj"

function var_0_0:__ctor()
	self.m_hasElemController = self:getController("hasElem")
	self.m_title = self:getChild("title")
	self.m_knight1 = self:getChild("knight1")
	self.m_knight2 = self:getChild("knight2")
	self.m_knight3 = self:getChild("knight3")
	self.m_knight4 = self:getChild("knight4")
	self.m_knight5 = self:getChild("knight5")
	self.m_knight6 = self:getChild("knight6")
	self.m_authority = self:getChild("authority")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_authorityGroup = self:getChild("authorityGroup")
end

var_0_0.HasElemCtrl = {
	elem = 1,
	normal = 0
}

return var_0_0
