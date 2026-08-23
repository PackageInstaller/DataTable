local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnx3u3gibz3"

function var_0_0:__ctor()
	self.m_inheritTypeController = self:getController("inheritType")
	self.m_treasurePurifyController = self:getController("treasurePurify")
	self.m_qualityController = self:getController("quality")
	self.m_popPanel = self:getChild("popPanel")
	self.m_knightIcon1 = self:getChild("knightIcon1")
	self.m_levelTxt1 = self:getChild("levelTxt1")
	self.m_advLevelBg1 = self:getChild("advLevelBg1")
	self.m_advLevelTxt1 = self:getChild("advLevelTxt1")
	self.m_knightIcon2 = self:getChild("knightIcon2")
	self.m_levelTxt2 = self:getChild("levelTxt2")
	self.m_advLevelBg2 = self:getChild("advLevelBg2")
	self.m_advLevelTxt2 = self:getChild("advLevelTxt2")
	self.m_knightGroup = self:getChild("knightGroup")
	self.m_oldArtifact = self:getChild("oldArtifact")
	self.m_newArtifact = self:getChild("newArtifact")
	self.m_artifactGroup = self:getChild("artifactGroup")
	self.m_petIcon_1 = self:getChild("petIcon_1")
	self.m_petLvTxt_1 = self:getChild("petLvTxt_1")
	self.m_petBigStageTxt_1 = self:getChild("petBigStageTxt_1")
	self.m_petStageGroup_1 = self:getChild("petStageGroup_1")
	self.m_petIcon_2 = self:getChild("petIcon_2")
	self.m_petLvTxt_2 = self:getChild("petLvTxt_2")
	self.m_petBigStageTxt_2 = self:getChild("petBigStageTxt_2")
	self.m_petStageGroup_2 = self:getChild("petStageGroup_2")
	self.m_petGroup = self:getChild("petGroup")
	self.m_ETIcon1 = self:getChild("ETIcon1")
	self.m_ETLvTxt1 = self:getChild("ETLvTxt1")
	self.m_refineLvTxt1 = self:getChild("refineLvTxt1")
	self.m_refineGroup1 = self:getChild("refineGroup1")
	self.m_ETIcon2 = self:getChild("ETIcon2")
	self.m_ETLvTxt2 = self:getChild("ETLvTxt2")
	self.m_refineLvTxt2 = self:getChild("refineLvTxt2")
	self.m_refineGroup2 = self:getChild("refineGroup2")
	self.m_ETGroup = self:getChild("ETGroup")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
	self.m_changeBtn = self:getChild("changeBtn")
end

var_0_0.InheritTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.TreasurePurifyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.QualityCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 7,
	page0 = 0,
	page3 = 3
}

return var_0_0
