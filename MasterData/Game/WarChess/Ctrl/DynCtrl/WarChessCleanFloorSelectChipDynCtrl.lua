local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessCleanFloorSelectChipDynCtrl = class("WarChessCleanFloorSelectChipDynCtrl", base)
local ChipData = require("Game.PlayerData.Item.ChipData")

function WarChessCleanFloorSelectChipDynCtrl:ctor(wcCtrl)
  self.__boxSystemData = nil
  self.__identify = nil
  self.__treasureChipDataList = nil
  self.__WCSSTreasureChipSelectAlg = BindCallback(self, self.WCSSTreasureChipSelectAlg)
  self.__WCSSTreasureRefreshChip = BindCallback(self, self.WCSSTreasureRefreshChip)
  self.__WCSSTreasureChipExitWithOutPic = BindCallback(self, self.WCSSTreasureChipExitWithOutPick)
end

function WarChessCleanFloorSelectChipDynCtrl:OpenCleanFloorRewardSelect(boxSystemData, closeCallback)
  self.__boxSystemData = boxSystemData
  self.__closeCallback = closeCallback
  self:__DealTreasureData(self.__boxSystemData.algList)
  local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
  for _, teamData in pairs(teamDataDic) do
    local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
    self.__identify = {wid = wid, tid = tid}
    break
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
    wcChipWindow:InitWCSelectChip(self.__treasureChipDataList, teamDataDic, self.__WCSSTreasureChipSelectAlg)
    wcChipWindow:InitWCSelectChipRefresh(self.__WCSSTreasureRefreshChip, self.__boxSystemData.refreshTime)
    wcChipWindow:InitWCSelectChipSkip(self.__WCSSTreasureChipExitWithOutPic)
  end)
end

function WarChessCleanFloorSelectChipDynCtrl:__DealTreasureData(algList)
  self.__treasureChipDataList = {}
  if algList ~= nil then
    for index, algId in ipairs(algList) do
      local data = ChipData.NewChipForServer(algId)
      table.insert(self.__treasureChipDataList, data)
    end
  end
end

function WarChessCleanFloorSelectChipDynCtrl:WCSSTreasureChipSelectAlg(index, teamData)
  local tid = teamData:GetWCTeamId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_OverReward_SelectAlg(self.__identify, index - 1, tid, function()
    self:CloseWCDynCtrl()
  end)
end

function WarChessCleanFloorSelectChipDynCtrl:WCSSTreasureRefreshChip()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_OverReward_RefreshAlg(self.__identify, function(args)
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

function WarChessCleanFloorSelectChipDynCtrl:WCSSTreasureChipExitWithOutPick(callback)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_OverReward_DropAlg(self.__identify, function()
    if callback ~= nil then
      callback()
    end
    self:CloseWCDynCtrl()
  end)
end

function WarChessCleanFloorSelectChipDynCtrl:CloseWCDynCtrl()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessSelectChip)
  UIUtil.CloseOneCover("UISelectChip")
  self.__treasureChipDataList = nil
  self.__boxSystemData = nil
  self.__identify = nil
  if self.__closeCallback ~= nil then
    self.__closeCallback()
  end
end

function WarChessCleanFloorSelectChipDynCtrl:Delete()
end

return WarChessCleanFloorSelectChipDynCtrl
