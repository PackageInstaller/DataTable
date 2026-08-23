local var_0_0 = {}

var_0_0.URL = "ui://h35b870bpozw1h"

function var_0_0:__ctor()
	self.m_isShowBtnController = self:getController("isShowBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_rankList = self:getChild("rankList")
	self.m_myRankTxt = self:getChild("myRankTxt")
end

return var_0_0
