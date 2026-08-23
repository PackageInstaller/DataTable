local var_0_0 = {}

var_0_0.URL = "ui://454a48jpot5r12"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_cornerController = self:getController("corner")
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_LUStateController = self:getController("LUState")
	self.m_isFragController = self:getController("isFrag")
	self.m_isShowGroupController = self:getController("isShowGroup")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_effectBg = self:getChild("effectBg")
	self.m_item = self:getChild("item")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_comfortBgImg = self:getChild("comfortBgImg")
	self.m_comfortIconLoader = self:getChild("comfortIconLoader")
	self.m_comfortTxt = self:getChild("comfortTxt")
	self.m_collectBg = self:getChild("collectBg")
	self.m_noCollectTxt = self:getChild("noCollectTxt")
	self.m_comfortGroup = self:getChild("comfortGroup")
	self.m_tipBg = self:getChild("tipBg")
	self.m_num = self:getChild("num")
	self.m_cornerTxt = self:getChild("cornerTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_tips = self:getChild("tips")
	self.m_oneCostComp = self:getChild("oneCostComp")
	self.m_twoCostComp = self:getChild("twoCostComp")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_touchBg = self:getChild("touchBg")
end

var_0_0.TypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.CornerCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsUnBuyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.LUStateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsFragCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowGroupCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
