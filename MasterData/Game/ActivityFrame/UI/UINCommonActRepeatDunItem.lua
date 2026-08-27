local UINCommonActRepeatDunItem = class("UINCommonActRepeatDunItem", UIBaseNode)
local base = UIBaseNode

function UINCommonActRepeatDunItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickDunItem)
end

function UINCommonActRepeatDunItem:InitActRepeatDunItem(dungeonlLevel, index, callback, resLoader)
  self._dungeonlLevel = dungeonlLevel
  self._callback = callback
  self.ui.tex_ChapterNum.text = tostring(index)
  self.ui.tex_CNName.text = self._dungeonlLevel:GetDungeonLevelName()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._dungeonlLevel:GetSpecialUnlockInfo())
  self.ui.tex_ENName.text = self._dungeonlLevel:GetDungeonNameEn()
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    if spriteAtlas ~= nil and not IsNull(self.transform) then
      local spriteIcon = AtlasUtil.GetResldSprite(spriteAtlas, self._dungeonlLevel:GetDungeonIcon())
      self.ui.icon.sprite = spriteIcon
    end
  end)
  self:RefreshActRepeatDunItem()
end

function UINCommonActRepeatDunItem:RefreshActRepeatDunItem()
  self.ui.obj_Lock:SetActive(not self._dungeonlLevel:GetIsLevelUnlock())
end

function UINCommonActRepeatDunItem:OnClickDunItem()
  if self._callback ~= nil then
    self._callback(self._dungeonlLevel, self)
  end
end

return UINCommonActRepeatDunItem
