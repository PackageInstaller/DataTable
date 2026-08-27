local base = UIBaseNode
local UINWCBuffList = class("UINWCBuffList", UIBaseNode)
local UINWCBuffListBuffItem = require("Game.WarChess.UI.Main.BuffList.UINWCBuffListBuffItem")
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")

function UINWCBuffList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.buffItemPool = UIItemPool.New(UINWCBuffListBuffItem, self.ui.obj_buffItem)
  self.ui.obj_buffItem:SetActive(false)
  self.__btnBufDescActive = self.ui.btn_BuffDescriptionPage.gameObject.activeSelf
  UIUtil.AddButtonListener(self.ui.btn_BuffDescriptionPage, self, self._OnBuffDescriptionClick)
end

function UINWCBuffList:RefreshWCBuffList(buffDic)
  self.buffItemPool:HideAll()
  local buffCount = 0
  self.buffList = {}
  for buffUID, buffData in pairs(buffDic) do
    if buffData:GetWCBuffIsNeedShow() then
      local buffItem = self.buffItemPool:GetOne()
      buffItem:RefreshWCBuffItem(buffData)
      table.insert(self.buffList, buffData)
      buffCount = buffCount + 1
    end
  end
  if 0 < buffCount and not self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(true)
    self.__btnBufDescActive = true
  elseif buffCount == 0 and self.__btnBufDescActive then
    self.ui.btn_BuffDescriptionPage.gameObject:SetActive(false)
    self.__btnBufDescActive = false
  end
end

function UINWCBuffList:_OnBuffDescriptionClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(buffDescWin)
    buffDescWin:InitDescriptPageEpBuffShow(self.buffList, function()
      buffDescWin:Hide()
    end)
  end)
end

function UINWCBuffList:OnDelete()
  self.buffList = nil
  base.OnDelete(self)
end

return UINWCBuffList
