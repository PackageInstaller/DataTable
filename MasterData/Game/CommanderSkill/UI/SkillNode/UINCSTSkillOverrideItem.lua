local UINCSTSkillOverrideItem = class("UINCSTSkillOverrideItem", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillFairyReplaceItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillFairyReplaceItem")

function UINCSTSkillOverrideItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.lineDefaultColor = self.ui.lineList[1].color
  self.sizeDeltaDefault = self.transform.sizeDelta
  self.ui.obj_Select:SetActive(false)
  self.fairyReplaceItem = UINCSTSkillFairyReplaceItem.New()
  self.fairyReplaceItem:Init(self.ui.obj_uINFairyCSTSkill)
  self.fairyReplaceItem:Hide()
end

function UINCSTSkillOverrideItem:InitCSTSkillOverrideItem(cmdSkillData, resLoader, clickFunc, curSkillId, fairyRepalceSkillData, treeData)
  self.cmdSkillData = cmdSkillData
  self.resLoader = resLoader
  self.clickFunc = clickFunc
  self.curSkillId = curSkillId
  self.fairyRepalceSkillData = fairyRepalceSkillData
  self.treeData = treeData
  if self.fairyRepalceSkillData ~= nil then
    self.isEquip = curSkillId == self.fairyRepalceSkillData:GetCSTSkillRealSkilllId()
  else
    self.isEquip = curSkillId == cmdSkillData:GetCSTSkillRealSkilllId()
  end
  self.ui.img_Icon.enabled = false
  self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    local srcName
    if self.fairyRepalceSkillData ~= nil then
      srcName = self.fairyRepalceSkillData:GetCSTSkillIcon()
    else
      srcName = cmdSkillData:GetCSTSkillIcon()
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, srcName)
    self.ui.img_Icon.enabled = true
  end)
  self:RefreshCSTSkillOverrideItem()
  self:RefreshCSTFairyReplaceItem()
end

function UINCSTSkillOverrideItem:ResetCSTSkillOverrideItemAnim()
  self.ui.dtAnim:DOPause()
  self.transform.sizeDelta = self.sizeDeltaDefault
end

function UINCSTSkillOverrideItem:PlayCSTSkillOverrideItemAnim(isMiddle)
  local v2 = self.ui.dtAnim.endValueV2
  local x = self.sizeDeltaDefault.x
  if self.isEquip then
    x = x + 65
  elseif isMiddle then
  else
    x = x - 65
  end
  v2.x = x
  if self.transform.sizeDelta.x == v2.x then
    return
  end
  v2.y = self.sizeDeltaDefault.y
  self.ui.dtAnim.tween:ChangeEndValue(v2, true)
  self.ui.dtAnim:DORestart()
end

function UINCSTSkillOverrideItem:RefreshCSTSkillOverrideItem()
  local cmdSkillData = self.cmdSkillData
  self.ui.obj_Lock:SetActive(not cmdSkillData:IsCmdSkillUnlock())
  self:_SetEquipState(self.isEquip)
end

function UINCSTSkillOverrideItem:_SetEquipState(isEquip)
  self.ui.equip.gameObject:SetActive(isEquip)
  for k, imgLine in ipairs(self.ui.lineList) do
    imgLine.color = isEquip and self.ui.equip.color or self.lineDefaultColor
  end
  if self.fairyRepalceSkillData ~= nil then
    self.fairyReplaceItem:SetCSTSkillItemEquipState(isEquip)
  end
  local equpColor
  if isEquip then
    equpColor = self.ui.equip.color
  end
end

function UINCSTSkillOverrideItem:SetCSTSkillOverrideItemEquip(isEquip)
  self.isEquip = isEquip
  self:_SetEquipState(self.isEquip)
end

function UINCSTSkillOverrideItem:SetCSTSkillItemSelect(select)
  self.ui.obj_Select:SetActive(select)
  self.ui.obj_Select.transform:SetParent(self.ui.skill)
  self.ui.obj_Select.transform.anchoredPosition = Vector2.zero
end

function UINCSTSkillOverrideItem:ShowRedDotCSTSkillItem(show)
  self.ui.redDot:SetActive(show)
end

function UINCSTSkillOverrideItem:RefreshCSTFairyReplaceItem()
  if self.fairyRepalceSkillData == nil then
    self.fairyReplaceItem:Hide()
    return
  end
  self.fairyReplaceItem:Show()
  self.fairyReplaceItem:RefreshCSTSkillFairyReplaceItem(self.treeData, self.fairyRepalceSkillData, self.resLoader)
end

function UINCSTSkillOverrideItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    if self.fairyRepalceSkillData ~= nil then
      self.clickFunc(self.fairyRepalceSkillData, self)
    else
      self.clickFunc(self.cmdSkillData, self)
    end
  end
end

function UINCSTSkillOverrideItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillOverrideItem
