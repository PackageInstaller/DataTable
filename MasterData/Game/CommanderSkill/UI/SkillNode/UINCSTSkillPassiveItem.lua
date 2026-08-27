local UINCSTSkillPassiveItem = class("UINCSTSkillPassiveItem", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillPassiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.ui.obj_Select:SetActive(false)
end

function UINCSTSkillPassiveItem:InitCSTSkillPassiveItem(cmdSkillData, resLoader, clickFunc)
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self.ui.img_Icon.enabled = false
  self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cmdSkillData:GetIcon())
    self.ui.img_Icon.enabled = true
  end)
  self:RefreshCSTSkillPassiveItem()
end

function UINCSTSkillPassiveItem:RefreshCSTSkillPassiveItem()
  local cmdSkillData = self.cmdSkillData
  self.ui.obj_Lock:SetActive(not cmdSkillData.isUnlock)
  if not cmdSkillData.isUnlock then
    self.ui.tex_UnlockLevel:SetIndex(0, tostring(cmdSkillData.unlockLevel))
  end
  self.ui.img_Icon.color = cmdSkillData.isUnlock and Color.white or Color.gray
end

function UINCSTSkillPassiveItem:SetCSTSkillItemSelect(select)
  if self.ui.obj_Select.activeInHierarchy ~= select then
    self.ui.obj_Select:SetActive(select)
  end
end

function UINCSTSkillPassiveItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.cmdSkillData, self)
  end
  self:ShowCSTSkillItemBlueDot(false)
end

function UINCSTSkillPassiveItem:ShowCSTSkillItemBlueDot(show)
  if self.ui.blueDot.activeInHierarchy ~= show then
    self.ui.blueDot:SetActive(show)
  end
end

function UINCSTSkillPassiveItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillPassiveItem
