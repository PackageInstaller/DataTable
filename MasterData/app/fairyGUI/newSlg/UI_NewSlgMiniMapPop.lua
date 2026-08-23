local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9d6ds68dz"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Comp_map_panel = self:getChild("Comp_map_panel")
	self.m_TxtUnSelect = self:getChild("TxtUnSelect")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_pos = self:getChild("Txt_pos")
	self.m_Btn_goto = self:getChild("Btn_goto")
	self.m_Group_info = self:getChild("Group_info")
	self.m_cityNumTxt = self:getChild("cityNumTxt")
	self.m_s2Desc = self:getChild("s2Desc")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsSelectCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
