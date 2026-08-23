local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wdspb7u"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_typeController = self:getController("type")
	self.m_name = self:getChild("name")
	self.m_descText = self:getChild("descText")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_awardList = self:getChild("awardList")
	self.m_receiveBtn = self:getChild("receiveBtn")
end

var_0_0.DrawStateCtrl = {
	可领取 = 1,
	前往 = 0,
	已领取 = 2
}
var_0_0.TypeCtrl = {
	每期 = 1,
	每日 = 0
}

return var_0_0
