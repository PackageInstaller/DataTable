local UINHalloweenSelectArchive = class("UINHalloweenSelectArchive", UIBaseNode)
local base = UIBaseNode
local UINHalloweenSelectArchiveItem = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectArchiveItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINHalloweenSelectArchive:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.newGameItem, self, self.OnClickNewArchive)
  self._itemPool = UIItemPool.New(UINHalloweenSelectArchiveItem, self.ui.checkPointItems)
  self.ui.checkPointItems:SetActive(false)
  self.__OnSelectArchiveCallback = BindCallback(self, self.__OnSelectArchive)
  for i, v in ipairs(self.ui.selectObjs) do
    v:SetActive(false)
  end
end

function UINHalloweenSelectArchive:InitHalloweenSelectArchive(hallowmasData, selectCallback)
  self._data = hallowmasData
  self._selectCallback = selectCallback
  local seasonDatas = WarChessSeasonManager:GetWCSSavingData()
  local saveCount = self._data:GetHallowmasMainCfg().max_save
  for i = 1, saveCount do
    local item = self._itemPool:GetOne()
    local seasonData = seasonDatas ~= nil and seasonDatas[i - 1] or nil
    item:InitSelectArchiveItem(self._data, i, seasonData, self.__OnSelectArchiveCallback)
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
end

function UINHalloweenSelectArchive:SetFileNameByEnvName()
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetFileNameByEnvName()
  end
end

function UINHalloweenSelectArchive:__OnSelectArchive(item)
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

function UINHalloweenSelectArchive:OnClickNewArchive()
  self._selectArchive = nil
  self._selectNewGame = true
  self.ui.img_Frame.color = self.ui.color_selected
  if self._selectCallback ~= nil then
    self._selectCallback()
  end
end

function UINHalloweenSelectArchive:__SetSelectObjs(localPosition)
end

function UINHalloweenSelectArchive:GetArchiveSelect()
  return self._selectNewGame, self._selectArchive
end

return UINHalloweenSelectArchive
