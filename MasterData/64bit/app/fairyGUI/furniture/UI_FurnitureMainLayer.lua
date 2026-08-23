local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsex280"

function var_0_0:__ctor()
	self.m_editRoomController = self:getController("editRoom")
	self.m_hideUIController = self:getController("hideUI")
	self.m_isShowCharmBubbleController = self:getController("isShowCharmBubble")
	self.m_bgComp = self:getChild("bgComp")
	self.m_roomComp = self:getChild("roomComp")
	self.m_furnitureShopBtn = self:getChild("furnitureShopBtn")
	self.m_actionRecoveryComp = self:getChild("actionRecoveryComp")
	self.m_comfortLvComp = self:getChild("comfortLvComp")
	self.m_gotoHLTrainBtn = self:getChild("gotoHLTrainBtn")
	self.m_charmBtn = self:getChild("charmBtn")
	self.m_charmNumTxt = self:getChild("charmNumTxt")
	self.m_charmShowComp = self:getChild("charmShowComp")
	self.m_comfortBuffBubbleComp = self:getChild("comfortBuffBubbleComp")
	self.m_shareComp = self:getChild("shareComp")
	self.m_menuBtn = self:getChild("menuBtn")
	self.m_comfortBuffBtn = self:getChild("comfortBuffBtn")
	self.m_editRoomBtn = self:getChild("editRoomBtn")
	self.m_checkInRoomBtn = self:getChild("checkInRoomBtn")
	self.m_bottomGroup = self:getChild("bottomGroup")
	self.m_tabListBg = self:getChild("tabListBg")
	self.m_floorTabList = self:getChild("floorTabList")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_leftGroup = self:getChild("leftGroup")
	self.m_zoomSlider = self:getChild("zoomSlider")
	self.m_subTypeComp = self:getChild("subTypeComp")
	self.m_typeTab = self:getChild("typeTab")
	self.m_hideGroup = self:getChild("hideGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
