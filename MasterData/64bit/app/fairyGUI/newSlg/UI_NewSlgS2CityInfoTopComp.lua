local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693r"

function var_0_0:__ctor()
	self.m_is_occupiedController = self:getController("is_occupied")
	self.m_isOtherController = self:getController("isOther")
	self.m_showElemController = self:getController("showElem")
	self.m_elemTypeController = self:getController("elemType")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Txt_cityName = self:getChild("Txt_cityName")
	self.m_Txt_pos = self:getChild("Txt_pos")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_Btn_share = self:getChild("Btn_share")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Txt_prog = self:getChild("Txt_prog")
	self.m_firstScore = self:getChild("firstScore")
	self.m_occupyScore = self:getChild("occupyScore")
	self.m_Txt_alliance = self:getChild("Txt_alliance")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_elemTipTypeIcon = self:getChild("elemTipTypeIcon")
	self.m_elemDesTxt = self:getChild("elemDesTxt")
end

var_0_0.Is_occupiedCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowElemCtrl = {
	hide = 0,
	show = 1
}
var_0_0.ElemTypeCtrl = {
	down = 2,
	up = 1,
	none = 0
}

return var_0_0
