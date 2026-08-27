local UINTechItem = class("UINTechItem", UIBaseNode)
local base = UIBaseNode

function UINTechItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_techItem, self, self.OnClickTechItem)
end

function UINTechItem:InitWATechItem(techData, resloader, clickCallback)
  self.techData = techData
  self.resloader = resloader
  self.clickCallback = clickCallback
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, techData:GetWATechIcon())
  end)
  self:RefreshTechItem()
end

function UINTechItem:RefreshTechItem()
  local curLevel = self.techData:GetCurLevel()
  local maxLevel = self.techData:GetMaxLevel()
  local isMaxLevel = curLevel == maxLevel
  self.ui.tex_Level:SetIndex(0, tostring(curLevel), tostring(maxLevel))
  self.ui.obj_IsLock:SetActive(not self.techData:GetIsUnlock())
  if isMaxLevel then
    self.ui.img_bottom:SetIndex(1)
  else
    self.ui.img_bottom:SetIndex(0)
  end
  local couldLevelUp = self.techData:IsCouldLevelUp()
  self.ui.obj_TypeLevelUp:SetActive(couldLevelUp)
end

function UINTechItem:OnClickTechItem()
  if self.clickCallback ~= nil then
    self.clickCallback(self)
  end
end

function UINTechItem:OnDelete()
  base.OnDelete(self)
end

return UINTechItem
