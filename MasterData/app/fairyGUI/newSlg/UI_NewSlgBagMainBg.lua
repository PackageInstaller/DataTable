local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9gx9u4s"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_emptyController = self:getController("empty")
	self.m_timeController = self:getController("time")
	self.m_tab1 = self:getChild("tab1")
	self.m_listView = self:getChild("listView")
	self.m_img0 = self:getChild("img0")
	self.m_img3 = self:getChild("img3")
	self.m_Label_name = self:getChild("Label_name")
	self.m_Icon_item = self:getChild("Icon_item")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_txt0 = self:getChild("txt0")
	self.m_label1 = self:getChild("label1")
	self.m_button_use = self:getChild("button_use")
	self.m_txt1 = self:getChild("txt1")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_list1 = self:getChild("list1")
	self.m_itemInfo = self:getChild("itemInfo")
	self.m_ComBagEmpty = self:getChild("ComBagEmpty")
end

return var_0_0
