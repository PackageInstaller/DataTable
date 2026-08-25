local PVPCollectUnitItem, Super = System.NewComponent("PVPCollectUnitItem")

function PVPCollectUnitItem:ctor(uiNode, collectTid)
  Super.ctor(self)
  self.ui = UI_Social_Item_PvpDispositionResource(uiNode)
  self.collectTid = collectTid
  self.awakerTidOrNil = PvpCollectCfgUtils.GetCollectAwakerTid(collectTid)
end

function PVPCollectUnitItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, System.fn(self, self.GetName))
  if self:IsKeeperSkill() then
    binder:SetActive(self.ui.Image_Mask, false)
    binder:SetActive(self.ui.Image_Icon, self:IsKeeperSkill())
    binder:BindToImage(self.ui.Image_Icon, System.fn(self, self.GetKeeperSkillIcon))
  elseif self:IsAwaker() then
    binder:SetActive(self.ui.Image_Mask, false)
    binder:SetActive(self.ui.Image_Icon, self:IsAwaker())
    binder:BindToImage(self.ui.Image_Icon, System.fn(self, self.GetAwakerIcon))
  elseif self:IsWeapon() then
    binder:SetActive(self.ui.Image_Mask, self:IsWeapon())
    binder:SetActive(self.ui.Image_Skill, self:IsWeapon())
    binder:BindToImage(self.ui.Image_Skill, System.fn(self, self.GetWeaponIcon))
  end
  binder:BindToImage(self.ui.Image_Name, System.fn(self, self.GetFrameIcon))
end

function PVPCollectUnitItem:IsAwaker()
  return PvpCollectCfgUtils.GetCollectionType(self.collectTid) == cd.PVPCollectionType.Awaker
end

function PVPCollectUnitItem:IsWeapon()
  return PvpCollectCfgUtils.GetCollectionType(self.collectTid) == cd.PVPCollectionType.Weapon
end

function PVPCollectUnitItem:IsKeeperSkill()
  return PvpCollectCfgUtils.GetCollectionType(self.collectTid) == cd.PVPCollectionType.KeeperSkill
end

function PVPCollectUnitItem:GetName()
  if self:IsAwaker() then
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, self.awakerTidOrNil
  end
  do return PvpCollectCfgUtils.GetCollectionName end
  return PvpCollectCfgUtils.GetCollectionName, self.collectTid
end

function PVPCollectUnitItem:GetKeeperSkillIcon()
  do return PVPCollectionDataUtils.GetCollectionPotrait end
  return PVPCollectionDataUtils.GetCollectionPotrait, self.collectTid
end

function PVPCollectUnitItem:GetAwakerIcon()
  do return PvpCollectCfgUtils.GetCollectAwakerCollectImage end
  return PvpCollectCfgUtils.GetCollectAwakerCollectImage, self.collectTid
end

function PVPCollectUnitItem:GetWeaponIcon()
  do return PVPCollectionDataUtils.GetCollectionPotrait end
  return PVPCollectionDataUtils.GetCollectionPotrait, self.collectTid
end

function PVPCollectUnitItem:GetFrameIcon()
  do return PVPCollectionDataUtils.GetCollectionNameFrameImage end
  return PVPCollectionDataUtils.GetCollectionNameFrameImage, self.collectTid
end

return PVPCollectUnitItem
