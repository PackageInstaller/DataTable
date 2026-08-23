local var_0_0 = {}

var_0_0.URL = "ui://qa3xcguqerx10"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowEasyController = self:getController("isShowEasy")
	self.m_isShowSpriteController = self:getController("isShowSprite")
	self.m_isHideBottomController = self:getController("isHideBottom")
	self.m_isLackController = self:getController("isLack")
	self.m_isSweepLackController = self:getController("isSweepLack")
	self.m_topBar = self:getChild("topBar")
	self.m_list = self:getChild("list")
	self.m_listRightNode = self:getChild("listRightNode")
	self.m_contentRightNode = self:getChild("contentRightNode")
	self.m_limitTitleTxt = self:getChild("limitTitleTxt")
	self.m_limitLvTxt = self:getChild("limitLvTxt")
	self.m_setBtn = self:getChild("setBtn")
	self.m_bottomBg = self:getChild("bottomBg")
	self.m_timeText = self:getChild("timeText")
	self.m_recommendBtn = self:getChild("recommendBtn")
	self.m_esayGiftBtn = self:getChild("esayGiftBtn")
	self.m_allConfirmBtn = self:getChild("allConfirmBtn")
	self.m_allRefuseBtn = self:getChild("allRefuseBtn")
	self.m_allConfirmTipBtn = self:getChild("allConfirmTipBtn")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_numTxt = self:getChild("numTxt")
	self.m_sweepTimeText = self:getChild("sweepTimeText")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_nameInput = self:getChild("nameInput")
	self.m_contentGroup = self:getChild("contentGroup")
	self.m_tabList = self:getChild("tabList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TabTypeCtrl = {
	friendList = 0,
	requestList = 2,
	blackList = 3,
	tipList = 4
}
var_0_0.IsEmptyCtrl = {
	has = 0,
	empty = 1
}
var_0_0.IsShowEasyCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsShowSpriteCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsHideBottomCtrl = {
	hide = 1,
	show = 0
}
var_0_0.IsLackCtrl = {
	lack = 1,
	normal = 0
}
var_0_0.IsSweepLackCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
