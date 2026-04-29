_class("UITrapSkillEnergyItem", UICustomWidget)
UITrapSkillEnergyItem = UITrapSkillEnergyItem

function UITrapSkillEnergyItem:Constructor()
end

function UITrapSkillEnergyItem:OnShow()
  self._curImage = self:GetUIComponent("Image", "image")
  self._curImageBG = self:GetUIComponent("Image", "imageBG")
end

function UITrapSkillEnergyItem:OnHide()
end

function UITrapSkillEnergyItem:Dispose()
end

function UITrapSkillEnergyItem:OnVisible(visible)
  self._curImage.gameObject:SetActive(visible)
end

function UITrapSkillEnergyItem:OnRefreshImage(spriteImage, spriteImageBG, imageOffset)
  self._curImage.sprite = spriteImage
  self._curImageBG.sprite = spriteImageBG
  self._curImage:SetNativeSize()
  self._curImageBG:SetNativeSize()
  self._curImage.transform.localPosition = imageOffset
end
