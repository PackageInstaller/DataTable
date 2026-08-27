local UINWarChessSellList = class("UINWarChessSellList", UIBaseNode)
local base = UIBaseNode
local UINWarChessTeamNodeItem = require("Game.WarChess.UI.Store.UINWarChessTeamNodeItem")

function UINWarChessSellList:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINWarChessSellList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self.ui.teamNodeItem:SetActive(false)
  self.teamNodeItemPool = UIItemPool.New(UINWarChessTeamNodeItem, self.ui.teamNodeItem)
  self.teamNodeItemDic = {}
  self:SetSellListEmptyUI(false)
  self.__onWCChipChanged = BindCallback(self, self.OnDynPlayChipUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
end

function UINWarChessSellList:InitWarChessStoreRoomSell(teamDic)
  local curChipItem, curTeamData
  self.teamNodeItemPool:HideAll()
  self.teamNum = 0
  local buyPrice
  for k, teamData in pairs(teamDic) do
    if teamData ~= nil then
      local teamIdx = teamData:GetWCTeamIndex()
      local chipList = teamData:GetWCTeamChipList()
      if 0 < #chipList then
        local teamNodeItem = self.teamNodeItemPool:GetOne()
        teamNodeItem:InitTeamNodeItem(chipList, teamData, self.storeRoomRoot.CoinIconId, self._OnClickChipItemFunc)
        local dynPlayer = teamData:GetTeamDynPlayer()
        self.teamNodeItemDic[dynPlayer] = teamNodeItem
        if curChipItem == nil then
          curChipItem = teamNodeItem:GetChipItemByIndex(1)
          curTeamData = teamData
        end
        self.teamNum = self.teamNum + 1
      end
    end
  end
  if self.teamNum <= 0 then
    self:SetSellListEmptyUI(true)
  else
    self:SetSellListEmptyUI(false)
    self.curChipItem = curChipItem
    self.curTeamData = curTeamData
    if curChipItem ~= nil then
      self.storeRoomRoot:RefreshSelectItemDetailSoldOut(curChipItem.chipData)
    end
  end
end

function UINWarChessSellList:OnDynPlayChipUpdate(chipList, dynPlayer)
  local teamNodeItem = self.teamNodeItemDic[dynPlayer]
  if teamNodeItem == nil then
    return
  end
  if 0 < #chipList then
    local teamData = teamNodeItem:GetTeamData()
    teamNodeItem:InitTeamNodeItem(chipList, teamData, self.storeRoomRoot.CoinIconId, self._OnClickChipItemFunc)
  else
    teamNodeItem:Hide()
    self.teamNum = self.teamNum - 1
    if 0 >= self.teamNum then
      self:SetSellListEmptyUI(true)
    end
  end
end

function UINWarChessSellList:GetCurChipItem()
  return self.curChipItem
end

function UINWarChessSellList:GetCurTeamData()
  return self.curTeamData
end

function UINWarChessSellList:_OnClickChipItem(chipItem, teamData)
  self.curChipItem = chipItem
  self.curTeamData = teamData
  local chipData = chipItem.chipData
  self.storeRoomRoot:RefreshSelectItemDetailSoldOut(teamData, chipData)
end

function UINWarChessSellList:SetSellListEmptyUI(active)
  for k, v in ipairs(self.ui.emptys) do
    v:SetActive(active)
  end
end

function UINWarChessSellList:OnDelete()
  base.OnDelete(self)
  self.teamNodeItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
end

return UINWarChessSellList
