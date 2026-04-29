_class("UIPetEquipRefineLevelBtn", UICustomWidget)
UIPetEquipRefineLevelBtn = UIPetEquipRefineLevelBtn

function UIPetEquipRefineLevelBtn:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIPetEquip.spriteatlas", LoadType.SpriteAtlas)
end

function UIPetEquipRefineLevelBtn:InitWidget()
  self.imgLevel = self:GetUIComponent("Image", "imgLevel")
  self.maskGo = self:GetGameObject("maskGo")
  self.selectGo = self:GetGameObject("selectGo")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIPetEquipRefineLevelBtn:SetData(bgName, clickCall)
  self.imgLevel.sprite = self._atlas:GetSprite(bgName)
  self.clickCall = clickCall
end

function UIPetEquipRefineLevelBtn:ImgLevelOnClick(go)
  if self.clickCall then
    self.clickCall()
  end
end

function UIPetEquipRefineLevelBtn:SetSelect(bSelect)
end

function UIPetEquipRefineLevelBtn:HideMask(bHide)
end

function UIPetEquipRefineLevelBtn:PlayAni(aniName)
  if self.animation then
    self.animation:Play(aniName)
  end
end
