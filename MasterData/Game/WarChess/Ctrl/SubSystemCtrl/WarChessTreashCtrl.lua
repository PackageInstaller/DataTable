local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessTreashCtrl = class("WarChessTreashCtrl", base)
local ChipData = require("Game.PlayerData.Item.ChipData")
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")

function WarChessTreashCtrl:ctor(wcCtrl)
  self.__boxSystemData = nil
  self.__identify = nil
  self.__treasureChipDataList = nil
  self.__WCSSTreasureChipSelectAlg = BindCallback(self, self.WCSSTreasureChipSelectAlg)
  self.__WCSSTreasureRefreshChip = BindCallback(self, self.WCSSTreasureRefreshChip)
  self.__WCSSTreasureChipExitWithOutPic = BindCallback(self, self.WCSSTreasureChipExitWithOutPick)
end

function WarChessTreashCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.treash
end

function WarChessTreashCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.boxSystemData == nil then
    error("not have data")
    return
  end
  self.__boxSystemData = systemState.boxSystemData
  self.__identify = identify
  self.__curTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(identify.tid)
  self:__DealTreasureData(self.__boxSystemData.algList)
  local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
    wcChipWindow:InitWCSelectChip(self.__treasureChipDataList, teamDataDic, self.__WCSSTreasureChipSelectAlg)
    wcChipWindow:InitWCSelectChipRefresh(self.__WCSSTreasureRefreshChip, self.__boxSystemData.refreshTime)
    wcChipWindow:InitWCSelectChipSkip(self.__WCSSTreasureChipExitWithOutPic)
  end)
end

function WarChessTreashCtrl:__DealTreasureData(algList)
  self.__treasureChipDataList = {}
  if algList ~= nil then
    for index, algId in ipairs(algList) do
      local data = ChipData.NewChipForServer(algId)
      table.insert(self.__treasureChipDataList, data)
    end
  end
end

function WarChessTreashCtrl:WCSSTreasureChipSelectAlg(index, teamData)
  local tid = teamData:GetWCTeamId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BoxSystem_SelectAlg(self.__identify, index - 1, tid, function()
    self:_WCSTTryShowBuff()
    UIManager:DeleteWindow(UIWindowTypeID.WarChessSelectChip)
  end)
end

function WarChessTreashCtrl:WCSSTreasureRefreshChip()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BoxSystem_RefreshAlg(self.__identify, function(args)
    if args.Count <= 0 then
      return
    end
    local msg = args[0]
    local algList = msg.algList
    local refeshTime = msg.refeshTime
    self:__DealTreasureData(algList)
    local wcChipWindow = UIManager:GetWindow(UIWindowTypeID.WarChessSelectChip)
    if wcChipWindow ~= nil then
      local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
      wcChipWindow:InitWCSelectChip(self.__treasureChipDataList, teamDataDic, self.__WCSSTreasureChipSelectAlg)
      wcChipWindow:UpdateWCSelectChipRefreshInfo()
      wcChipWindow:UpdateWCSelectChipSkipInfo()
    end
  end)
end

function WarChessTreashCtrl:WCSSTreasureChipExitWithOutPick(callback)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BoxSystem_DropAlg(self.__identify, function()
    if callback ~= nil then
      callback()
    end
    self:_WCSTTryShowBuff()
  end)
end

function WarChessTreashCtrl:_WCSTTryShowBuff()
  if #self.__boxSystemData.propChips <= 0 then
    return
  end
  local buffList = {}
  for k, id in pairs(self.__boxSystemData.propChips) do
    local wcsBuffData = WarChessBuffData.CrearteBuffById(id)
    table.insert(buffList, wcsBuffData)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitWCBuffDesc(buffList, nil, 3)
  end)
end

function WarChessTreashCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  if isSwitchClose then
    UIManager:DeleteWindow(UIWindowTypeID.WarChessSelectChip)
  end
  self.__treasureChipDataList = nil
  self.__boxSystemData = nil
  self.__identify = nil
end

function WarChessTreashCtrl:Delete()
end

return WarChessTreashCtrl
