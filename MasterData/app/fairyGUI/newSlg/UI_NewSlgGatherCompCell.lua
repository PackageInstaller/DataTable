local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v65"

function var_0_0:__ctor()
	self.m_gather_typeController = self:getController("gather_type")
	self.m_count_downController = self:getController("count_down")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
	self.m_Btn_gather = self:getChild("Btn_gather")
	self.m_iconGatherNum = self:getChild("iconGatherNum")
	self.m_gatherNumTxt = self:getChild("gatherNumTxt")
end

var_0_0.Gather_typeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Count_downCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
