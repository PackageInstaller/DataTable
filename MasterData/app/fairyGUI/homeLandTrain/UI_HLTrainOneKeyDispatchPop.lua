local var_0_0 = {}

var_0_0.URL = "ui://p0nkxg53djr75r"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_releaseStatusController = self:getController("releaseStatus")
	self.m_openOneKeyController = self:getController("openOneKey")
	self.m_closePanel = self:getChild("closePanel")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_roomList = self:getChild("roomList")
	self.m_releaseBtn = self:getChild("releaseBtn")
	self.m_releaseBtn1 = self:getChild("releaseBtn1")
	self.m_oneKeyWorkBtn = self:getChild("oneKeyWorkBtn")
	self.m_roomGroup = self:getChild("roomGroup")
	self.m_selectProductComp = self:getChild("selectProductComp")
	self.m_selectKnightComp = self:getChild("selectKnightComp")
end

return var_0_0
