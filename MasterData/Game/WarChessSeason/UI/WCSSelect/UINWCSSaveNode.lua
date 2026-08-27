local UINWCSSaveNode = class("UINWCSSaveNode", UIBaseNode)
local base = UIBaseNode
local UINWCSSaveNodeItem = require("Game.WarChessSeason.UI.WCSSelect.UINWCSSaveNodeItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINWCSSaveNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.newGameItem, self, self.OnClickNewArchive)
  self._itemPool = UIItemPool.New(UINWCSSaveNodeItem, self.ui.checkPointItems)
  self.ui.checkPointItems:SetActive(false)
  self.__OnSelectArchiveCallback = BindCallback(self, self.__OnSelectArchive)
  for i, v in ipairs(self.ui.selectObjs) do
    v:SetActive(false)
  end
end

function UINWCSSaveNode:InitWCSSelectSaves(seasonId, selectCallback)
  self._selectCallback = selectCallback
  local savingDatas = WarChessSeasonManager:GetWCSSavingData()
  local saveCount = WarChessSeasonManager:GetWCSSaveNum(seasonId)
  for i = 1, saveCount do
    local item = self._itemPool:GetOne()
    local seasonData = savingDatas ~= nil and savingDatas[i - 1] or nil
    item:InitSelectSavingItem(seasonId, i, seasonData, self.__OnSelectArchiveCallback)
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
end

function UINWCSSaveNode:SetFileNameByEnvName()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetFileNameByEnvName()
  end
end

function UINWCSSaveNode:__OnSelectArchive(item)
  local archive = item:GetArchiveData()
  if archive == nil then
    return
  end
  self.ui.img_Frame.color = Color.white
  self._selectArchive = archive
  self._selectNewGame = nil
  if self._selectCallback ~= nil then
    self._selectCallback()
  end
end

function UINWCSSaveNode:OnClickNewArchive()
  self._selectArchive = nil
  self._selectNewGame = true
  self.ui.img_Frame.color = self.ui.color_selected
  if self._selectCallback ~= nil then
    self._selectCallback()
  end
end

function UINWCSSaveNode:__SetSelectObjs(localPosition)
end

function UINWCSSaveNode:GetArchiveSelect()
  return self._selectNewGame, self._selectArchive
end

function UINWCSSaveNode:ShowWCSSaveNewGameBlueDot(isShow)
  self.ui.newGame_blueDot:SetActive(isShow)
end

return UINWCSSaveNode
