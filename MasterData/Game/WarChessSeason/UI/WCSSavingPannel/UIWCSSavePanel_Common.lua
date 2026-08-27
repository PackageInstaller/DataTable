local base = UIBaseWindow
local UIWCSSavePanel_Common = class("UIWCSSavePanel_Common", UIBaseWindow)
local UINWCSSaveNodeItem = require("Game.WarChessSeason.UI.WCSSelect.UINWCSSaveNodeItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UIWCSSavePanel_Common:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_NewGame, self, self.__OnClickSave)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Delete)
  self.itemPool = UIItemPool.New(UINWCSSaveNodeItem, self.ui.checkPointItems)
  self.ui.checkPointItems:SetActive(false)
  self.__curSelectIndex = nil
  self.__OnSelectArchiveCallback = BindCallback(self, self.__OnSelectSaving)
  self.__reGenSavingItems = BindCallback(self, self.__ReGenSavingItems)
  MsgCenter:AddListener(eMsgEventId.WCS_SavingDataRefresh, self.__reGenSavingItems)
  self._colorDefaultBottom = self.ui.bottom.color
end

function UIWCSSavePanel_Common:InitWCSSavePanel(saveCallback)
  self.saveCallback = saveCallback
  self:__ReGenSavingItems()
end

function UIWCSSavePanel_Common:__ReGenSavingItems()
  local seasonId = WarChessSeasonManager:GetWCSSeasonId()
  local savingDataDic = WarChessSeasonManager:GetWCSSavingData()
  local saveCount = WarChessSeasonManager:GetWCSSaveNum(seasonId)
  self.itemPool:HideAll()
  local selectItem
  for index = 1, saveCount do
    local item = self.itemPool:GetOne()
    local savingData = savingDataDic ~= nil and savingDataDic[index - 1] or nil
    item:InitSelectSavingItem(seasonId, index, savingData, self.__OnSelectArchiveCallback)
    item:SetFileNameByEnvName()
    if selectItem == nil and savingData ~= nil then
      selectItem = item
    end
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.checkPointNode)
  if selectItem == nil then
    selectItem = self.itemPool.listItem[1]
  end
  self:__OnSelectSaving(selectItem)
end

function UIWCSSavePanel_Common:__OnSelectSaving(item)
  self.__selectOne = item
  self.__curSelectIndex = item:GetArchiveIndex()
  self:__SetSelectObjs(item.transform.localPosition)
  local isHaveSavingData = item:GetArchiveData() ~= nil
  if isHaveSavingData then
    self.ui.tex_Text:SetIndex(1)
    self.ui.bottom.color = Color.white
    if self.ui.color_overrideSave ~= nil then
      self.ui.tex_Text.text.color = self.ui.color_overrideSave
    else
      self.ui.tex_Text.text.color = Color.black
    end
  else
    self.ui.tex_Text:SetIndex(0)
    self.ui.bottom.color = self._colorDefaultBottom
    self.ui.tex_Text.text.color = Color.white
  end
  for i, v in ipairs(self.itemPool.listItem) do
    v:RefreshSelectArchiveState(v == item)
  end
end

function UIWCSSavePanel_Common:__OnClickSave()
  if self.__selectOne == nil then
    return
  end
  local index = self.__selectOne:GetArchiveIndex()
  if self.saveCallback ~= nil then
    self.saveCallback(index - 1)
    self:Delete()
  end
end

function UIWCSSavePanel_Common:__SetSelectObjs(localPosition)
  for i, v in ipairs(self.ui.selectObjs) do
    v.transform.localPosition = localPosition
    v:SetActive(true)
  end
end

function UIWCSSavePanel_Common:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WCS_SavingDataRefresh, self.__reGenSavingItems)
  base.OnDelete(self)
end

return UIWCSSavePanel_Common
