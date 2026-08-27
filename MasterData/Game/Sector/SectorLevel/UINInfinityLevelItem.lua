local UINInfinityLevelItem = class("UINInfinityLevelItem", UIBaseNode)
local base = UIBaseNode
local ePlaceHolderType = require("Game.Sector.Enum.SectorLevelInfinityEnum").ePlaceHolderType

function UINInfinityLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_levelItem, self, self.OnClick)
  self.passCountList = {}
  table.insert(self.passCountList, self.ui.obj_Pass)
end

function UINInfinityLevelItem:InitInfinityLevel(levelData, onClickCallback)
  self.levelData = levelData
  self.ui.obj_isTopOrDownNode:SetActive(false)
  self.ui.obj_info:SetActive(true)
  self.onClickCallback = onClickCallback
  self:RefreshUI(levelData)
end

function UINInfinityLevelItem:InitPlaceHolder(levelData, topUiObject, buttonUiObject)
  self.levelData = levelData
  if levelData.placeHolederType == ePlaceHolderType.Top then
    topUiObject.transform:SetParent(self.ui.obj_isTopOrDownNode.transform)
    topUiObject.transform.anchoredPosition = Vector2.New(0, 0)
    topUiObject:SetActive(true)
    buttonUiObject:SetActive(false)
  elseif levelData.placeHolederType == ePlaceHolderType.Down then
    buttonUiObject.transform:SetParent(self.ui.obj_isTopOrDownNode.transform)
    buttonUiObject.transform.anchoredPosition = Vector2.New(0, 0)
    buttonUiObject:SetActive(true)
    topUiObject:SetActive(false)
  end
  self.ui.obj_isTopOrDownNode:SetActive(true)
  self.ui.obj_info:SetActive(false)
end

function UINInfinityLevelItem:RefreshUI(levelData)
  local cfg = levelData.cfg
  self.levelData = levelData
  self.ui.tex_MainTitle:SetIndex(0, tostring(cfg.index * 10))
  self.ui.obj_passList:SetActive(levelData.isUnlock and not levelData.isForbid)
  self.ui.obj_lock:SetActive(not levelData.isUnlock or levelData.isForbid)
  if levelData.isUnlock then
    if levelData.isComplete then
      self:RefeshPassCount(#levelData.cfg.layer)
    elseif 0 < levelData.passNum then
      self:RefeshPassCount(levelData.passNum)
    else
      self:RefeshPassCount(0)
    end
  end
end

function UINInfinityLevelItem:OnClick()
  if self.levelData.isForbid then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(self.levelData.forbidInfo)
    return
  end
  if not self.levelData.isUnlock then
    if self.levelData.lockInfo ~= nil then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(self.levelData.lockInfo)
    end
    return
  end
  if self.onClickCallback ~= nil then
    self.onClickCallback(self.levelData, self)
  end
end

function UINInfinityLevelItem:SetInfinityLvItemSelected(selected)
  self.ui.obj_selectNode:SetActive(selected)
end

function UINInfinityLevelItem:RefeshPassCount(num)
  for _, go in ipairs(self.passCountList) do
    go:SetActive(false)
  end
  for i = 1, num do
    if self.passCountList[i] ~= nil then
      self.passCountList[i]:SetActive(true)
    else
      local newGo = self.ui.obj_Pass:Instantiate()
      table.insert(self.passCountList, newGo)
      newGo:SetActive(true)
    end
  end
end

function UINInfinityLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINInfinityLevelItem
