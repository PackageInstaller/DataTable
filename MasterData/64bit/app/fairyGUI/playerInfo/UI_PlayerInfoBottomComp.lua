local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6untql2b"

function var_0_0:__ctor()
	self.m_unLockStateController = self:getController("unLockState")
	self.m_dungeonText = self:getChild("dungeonText")
	self.m_wushText = self:getChild("wushText")
	self.m_arenaText = self:getChild("arenaText")
	self.m_praiseText = self:getChild("praiseText")
	self.m_honorNumText = self:getChild("honorNumText")
	self.m_charmText = self:getChild("charmText")
	self.m_curKnightText = self:getChild("curKnightText")
	self.m_allKnightCountText = self:getChild("allKnightCountText")
	self.m_tissueList = self:getChild("tissueList")
end

var_0_0.UnLockStateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
