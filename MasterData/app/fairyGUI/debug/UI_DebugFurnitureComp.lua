local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yhff95ibi1"

function var_0_0:__ctor()
	self.m_isRotateController = self:getController("isRotate")
	self.m_actionShowController = self:getController("actionShow")
	self.m_showCoverController = self:getController("showCover")
	self.m_gridComp = self:getChild("gridComp")
	self.m_furnitureCell = self:getChild("furnitureCell")
	self.m_gridCoverComp = self:getChild("gridCoverComp")
	self.m_center = self:getChild("center")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_nameText = self:getChild("nameText")
	self.m_typeText = self:getChild("typeText")
	self.m_gridText = self:getChild("gridText")
	self.m_cfgPosText = self:getChild("cfgPosText")
	self.m_spineBorderText = self:getChild("spineBorderText")
	self.m_actorPosText = self:getChild("actorPosText")
	self.m_srcNameText = self:getChild("srcNameText")
	self.m_srcTypeText = self:getChild("srcTypeText")
	self.m_rotateCheckBtn = self:getChild("rotateCheckBtn")
	self.m_coverCheckBtn = self:getChild("coverCheckBtn")
	self.m_actionCheckBtn = self:getChild("actionCheckBtn")
	self.m_searchActorComp = self:getChild("searchActorComp")
	self.m_selGroup = self:getChild("selGroup")
	self.m_insertBorderWidth = self:getChild("insertBorderWidth")
	self.m_insertBorderHeight = self:getChild("insertBorderHeight")
	self.m_borderEnsureText = self:getChild("borderEnsureText")
	self.m_borderEnsureBtn = self:getChild("borderEnsureBtn")
	self.m_borderGroup = self:getChild("borderGroup")
	self.m_touchPos = self:getChild("touchPos")
	self.m_posText = self:getChild("posText")
	self.m_xMinBtn = self:getChild("xMinBtn")
	self.m_xAddBtn = self:getChild("xAddBtn")
	self.m_yAddBtn = self:getChild("yAddBtn")
	self.m_yMinBtn = self:getChild("yMinBtn")
	self.m_posGroup = self:getChild("posGroup")
end

var_0_0.IsRotateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ActionShowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowCoverCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
