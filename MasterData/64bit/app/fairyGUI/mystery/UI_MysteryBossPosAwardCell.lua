local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8ebwsw43"

function var_0_0:__ctor()
	self.m_isPlaceHolderController = self:getController("isPlaceHolder")
	self.m_isHaveBgController = self:getController("isHaveBg")
	self.m_idxTxt = self:getChild("idxTxt")
	self.m_addValueTxt = self:getChild("addValueTxt")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
