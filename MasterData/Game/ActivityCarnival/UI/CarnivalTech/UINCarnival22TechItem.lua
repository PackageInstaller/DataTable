local UINCarnival22TechItem = class("UINCarnival22TechItem", UIBaseNode)
local base = UIBaseNode

function UINCarnival22TechItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.techItem, self, self.OnClickTechItem)
end

function UINCarnival22TechItem:InitCarnivalTechItem(techData, lockObjCallback, resloader, clickFunc, branchIndex)
  self._techData = techData
  self._clickFunc = clickFunc
  self._branchIndex = branchIndex
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._techData:GetWATechIcon())
  end)
  if lockObjCallback ~= nil and not self._techData:GetIsUnlock() then
    self._lockedItem = lockObjCallback()
    self._lockedItem.gameObject:SetActive(true)
    self._lockedItem.transform:SetParent(self.transform)
    self._lockedItem.transform.anchoredPosition = Vector2.zero
  end
  self:RefreshCarnivalTechItem()
end

function UINCarnival22TechItem:RefreshCarnivalTechItem()
  local unlock = self._techData:GetIsUnlock()
  if not unlock then
    self.ui.norGroup:SetIndex(3)
    self.ui.level:SetActive(false)
    self.ui.obj_CanLevelUp:SetActive(false)
    if self._lockedItem ~= nil then
      self._lockedItem:Show()
    end
    return
  end
  if self._lockedItem ~= nil then
    self._lockedItem:Hide()
  end
  self.ui.norGroup:SetIndex(self._branchIndex - 1)
  self.ui.level:SetActive(true)
  self.ui.tex_Level:SetIndex(0, tostring(self._techData:GetCurLevel()), tostring(self._techData:GetMaxLevel()))
  self.ui.obj_CanLevelUp:SetActive(self._techData:IsCouldLevelUp())
end

function UINCarnival22TechItem:SetCarnivalTechLockedAlpha(value)
  if self._lockedItem ~= nil and self._lockedItem.active then
    self._lockedItem:SetTechItemLockedAlpha(value)
  end
end

function UINCarnival22TechItem:OnClickTechItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self)
  end
end

function UINCarnival22TechItem:GetCarnivalTechData()
  return self._techData
end

return UINCarnival22TechItem
