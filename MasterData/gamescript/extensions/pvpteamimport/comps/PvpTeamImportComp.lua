local PvpTeamImportComp, Super = NewViewComponent("PvpTeamImportComp")

function PvpTeamImportComp:ctor(uiNode, view, collectionTid)
  Super.ctor(self, uiNode, view)
  self.ui = UIBaseResource(uiNode)
  self.collectionTid = collectionTid
end

function PvpTeamImportComp:OnBuildComponent()
end

function PvpTeamImportComp:OnEnterComponent()
  self:_UpdateViewData()
end

function PvpTeamImportComp:RegisterEvents()
end

function PvpTeamImportComp:_UpdateViewData()
  self:SetCollection(self.collectionTid)
end

function PvpTeamImportComp:SetCollection(collectionTid)
  self:SetActive(self.ui.Group_Info, true)
  local collectCfg = PvpCollectCfgUtils.GetCfg(collectionTid)
  if not collectCfg then
    return
  end
  if collectCfg.Type == CommonDefine.PVPCollectionType.Awaker then
    self:SetImage(self.ui.Image_Card, PvpCollectCfgUtils.GetCollectionFormationImage(collectionTid), false)
    self:SetImage(self.ui.Image_Quality, PVPCollectionDataUtils.GetCollectionNameFrameImage(collectionTid))
    self:SetActive(self.ui.Image_Quality, true)
  elseif collectCfg.Type == CommonDefine.PVPCollectionType.Weapon then
    self:SetImage(self.ui.Image_Card, PVPCollectionDataUtils.GetWeaponCollectionPortrait(collectionTid), false)
    self:SetActive(self.ui.Image_Quality, false)
  elseif collectCfg.Type == CommonDefine.PVPCollectionType.KeeperSkill then
    self:SetImage(self.ui.Image_Card, PVPCollectionDataUtils.GetKeeperSkillDetailsImage(collectionTid), false)
    self:SetActive(self.ui.Image_Quality, false)
  end
end

return PvpTeamImportComp
