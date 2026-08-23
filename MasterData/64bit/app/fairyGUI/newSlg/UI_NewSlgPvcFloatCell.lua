local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9uzeu68cn"

function var_0_0:__ctor()
	self.m_count_downController = self:getController("count_down")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
	self.m_Btn_gather = self:getChild("Btn_gather")
end

var_0_0.Count_downCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
