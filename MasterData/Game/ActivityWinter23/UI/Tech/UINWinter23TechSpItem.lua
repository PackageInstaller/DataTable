local UINWinter23TechSpItem = class("UINWinter23TechSpItem", UIBaseNode)
local base = UIBaseNode

function UINWinter23TechSpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Effct, self, self.OnClickLv)
  UIUtil.AddButtonListener(self.ui.techItem, self, self.OnClickDetail)
end

function UINWinter23TechSpItem:InitWin23TechSpItem(techData, resloader, callback, clickFunc)
  self._techData = techData
  self._callback = callback
  self._clickFunc = clickFunc
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._techData:GetWATechIcon())
  end)
  self:RefreshWin23TechSpItem()
  if self.ui.img_Color ~= nil then
    local techColor = self._techData:GetTechIconColor()
    self.ui.img_Color.color = techColor
  end
  if self.ui.img_Bottom ~= nil then
    local techBgIndex = self._techData:GetTechBgIndex()
    self.ui.img_Bottom:SetIndex(techBgIndex)
  end
end

function UINWinter23TechSpItem:SetWin23LogicDesType(desType)
  self._desType = desType
end

function UINWinter23TechSpItem:RefreshWin23TechSpItem()
  self.ui.tex_TechDes.text = self._techData:GetTechDescription(nil, self._desType)
  self.ui.tex_TechLvl:SetIndex(0, tostring(self._techData:GetActTechPrfeTotleLevel()))
  if not self._techData:GetIsUnlock() then
    self.ui.btn_Effct.gameObject:SetActive(false)
    self.ui.obj_Lock:SetActive(true)
    self.ui.obj_ItemLocked:SetActive(true)
    self.ui.tex_Level.gameObject:SetActive(false)
    return
  end
  self.ui.obj_Lock:SetActive(false)
  self.ui.obj_ItemLocked:SetActive(false)
  local isInEffect = 0 < self._techData:GetCurLevel()
  self.ui.btn_Effct.gameObject:SetActive(true)
  self.ui.image_Effct.color = isInEffect and self.ui.color_effect or self.ui.color_unlock
  self.ui.tex_Text:SetIndex(isInEffect and 0 or 1)
  self.ui.tex_Level.gameObject:SetActive(true)
  self.ui.tex_Level:SetIndex(0, tostring(self._techData:GetCurLevel()), tostring(self._techData:GetMaxLevel()))
end

function UINWinter23TechSpItem:OnClickLv()
  if self._callback ~= nil then
    self._callback(self._techData)
  end
end

function UINWinter23TechSpItem:OnClickDetail()
  if self._clickFunc ~= nil then
    self._clickFunc(self, self._techData)
  end
end

return UINWinter23TechSpItem
