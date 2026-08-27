local UINChristmas22TechItem = class("UINChristmas22TechItem", UIBaseNode)
local base = UIBaseNode

function UINChristmas22TechItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.techItem, self, self.OnClickTech)
end

function UINChristmas22TechItem:InitChristmas22TechItem(techData, resloader, clickCallback)
  self._techData = techData
  self._clickCallback = clickCallback
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._techData:GetWATechIcon())
  end)
  self:RefreshChristmas22TechItem()
  if self.ui.img_Color ~= nil then
    local techColor = self._techData:GetTechIconColor()
    self.ui.img_Color.color = techColor
  end
  if self.ui.img_Bottom ~= nil then
    local techBgIndex = self._techData:GetTechBgIndex()
    self.ui.img_Bottom:SetIndex(techBgIndex)
  end
end

function UINChristmas22TechItem:BindChristmas22TechItemLockFunc(lockObjFunc)
  self._lockObjFunc = lockObjFunc
end

function UINChristmas22TechItem:RefreshChristmas22TechItem()
  local isUnlock = self._techData:GetIsUnlock()
  if not isUnlock then
    if self._lockObjFunc ~= nil then
      if self._lockedObj == nil then
        self._lockedObj = self._lockObjFunc()
        self._lockedObj.transform:SetParent(self.transform)
        self._lockedObj.transform.anchoredPosition = Vector2.zero
      end
      self._lockedObj:SetActive(true)
    end
    self.ui.tex_Level.gameObject:SetActive(false)
    self.ui.obj_CanLevelUp:SetActive(false)
    return
  end
  if self._lockedObj ~= nil then
    self._lockedObj:SetActive(false)
  end
  self.ui.tex_Level.gameObject:SetActive(true)
  self.ui.tex_Level:SetIndex(0, tostring(self._techData:GetCurLevel()), tostring(self._techData:GetMaxLevel()))
  self.ui.obj_CanLevelUp:SetActive(self._techData:IsCouldLevelUp())
end

function UINChristmas22TechItem:OnClickTech()
  if self._clickCallback ~= nil then
    self._clickCallback(self, self._techData)
  end
end

function UINChristmas22TechItem:GetChristmas22TechData()
  return self._techData
end

return UINChristmas22TechItem
