local UINHeroTalentNode = class("UINHeroTalentNode", UIBaseNode)
local base = UIBaseNode

function UINHeroTalentNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.OnClickTalentItem)
  self._defaultColor = self.ui.buttom.image.color
  self._maxColor = self._defaultColor
end

function UINHeroTalentNode:SetTalentMaxColor(color)
  self._maxColor = color
end

function UINHeroTalentNode:InitHeroTalentNode(heroTalentNode, clickCallback)
  self._heroTalentNode = heroTalentNode
  self._clickCallback = clickCallback
  local effect = self._heroTalentNode:GetHeroTalentNodeCurLevelEffect()
  if effect == nil then
    effect = self._heroTalentNode:GetHeroTalentNodeNexLevelEffect()
  end
  if effect ~= nil then
    self.ui.img_Icon.sprite = CRH:GetSprite(effect.icon)
  end
  self:RefreshHeroTalentNodeUI()
end

function UINHeroTalentNode:RefreshHeroTalentNodeUI()
  local curLv = self._heroTalentNode:GetHeroTalentNodeCurLevel()
  local maxLv = self._heroTalentNode:GetHeroTalentNodeMaxLevel()
  local isUnlock = self._heroTalentNode:IsHeroTalentNodeUnlock()
  local isMaxLv = self._heroTalentNode:IsHeroTalentNodeMaxLevel()
  local color = isMaxLv and self.ui.maxColor or Color.white
  if not IsNull(self.ui.tex_Count) then
    self.ui.tex_Count.text = tostring(curLv) .. "/" .. tostring(maxLv)
  end
  self.ui.img_Lock:SetActive(not isUnlock)
  self.ui.buttom:SetIndex(isMaxLv and 1 or 0)
  self.ui.buttom.image.color = isMaxLv and self._maxColor or self._defaultColor
end

function UINHeroTalentNode:OnClickTalentItem()
  if self._clickCallback ~= nil then
    self._clickCallback(self)
  end
end

function UINHeroTalentNode:GetHeroTalentNode()
  return self._heroTalentNode
end

function UINHeroTalentNode:GetLineTargetPoint(horizontalDir, verticalDir)
  local index = 0
  if horizontalDir == 0 and 0 < verticalDir then
    index = 1
  elseif 0 < horizontalDir and 0 < verticalDir then
    index = 2
  elseif 0 < horizontalDir and verticalDir == 0 then
    index = 3
  elseif 0 < horizontalDir and verticalDir < 0 then
    index = 4
  elseif horizontalDir == 0 and verticalDir < 0 then
    index = 5
  elseif horizontalDir < 0 and verticalDir < 0 then
    index = 6
  elseif horizontalDir < 0 and verticalDir == 0 then
    index = 7
  elseif horizontalDir < 0 and 0 < verticalDir then
    index = 8
  end
  return self.ui.broadPoints[index]
end

return UINHeroTalentNode
