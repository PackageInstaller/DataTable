local UINChristmas22TechSpecialItem = class("UINChristmas22TechSpecialItem", UIBaseNode)
local base = UIBaseNode
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function UINChristmas22TechSpecialItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Active, self, self.OnClickUnlock)
end

function UINChristmas22TechSpecialItem:SetChristmas22LogicDesType(desType)
  self._desType = desType
end

function UINChristmas22TechSpecialItem:InitChristmas22TechSpecialItem(techData, resloader, callback)
  self._techData = techData
  self._callback = callback
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._techData:GetWATechIcon())
  end)
  self.ui.tex_Des.text = self._techData:GetTechDescription(nil, self._desType)
  self.ui.tex_Lvl:SetIndex(0, tostring(self._techData:GetActTechPrfeTotleLevel()))
  self:RefreshChristmas22TechSpecialItem()
end

function UINChristmas22TechSpecialItem:RefreshChristmas22TechSpecialItem()
  if not self._techData:GetIsUnlock() then
    self.ui.obj_Effect:SetActive(false)
    self.ui.obj_Lock:SetActive(true)
    self.ui.btn_Active.gameObject:SetActive(false)
    return
  end
  self.ui.obj_Lock:SetActive(false)
  local isInEffect = self._techData:GetCurLevel() > 0
  self.ui.obj_Effect:SetActive(isInEffect)
  self.ui.btn_Active.gameObject:SetActive(not isInEffect)
end

function UINChristmas22TechSpecialItem:OnClickUnlock()
  if self._callback ~= nil then
    self._callback(self._techData)
  end
end

return UINChristmas22TechSpecialItem
