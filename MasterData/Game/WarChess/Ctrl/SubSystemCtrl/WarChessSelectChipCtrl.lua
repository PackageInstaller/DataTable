local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessSelectChipCtrl = class("WarChessSelectChipCtrl", base)
local ChipData = require("Game.PlayerData.Item.ChipData")

function WarChessSelectChipCtrl:ctor(wcCtrl)
  self.__selectTeamForAlgSystemData = nil
  self.__identify = nil
  self.__WCSSSelectChipSelectAlg = BindCallback(self, self.WCSSSelectChipSelectAlg)
end

function WarChessSelectChipCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.selectAlg
end

function WarChessSelectChipCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.selectTeamForAlgSystemData == nil then
    error("not have data")
    return
  end
  self.__selectTeamForAlgSystemData = systemState.selectTeamForAlgSystemData
  self.__identify = identify
  local chipList = {}
  for _, v in ipairs(self.__selectTeamForAlgSystemData.algList) do
    local chipData = ChipData.NewChipForServer(v)
    table.insert(chipList, chipData)
  end
  local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
    wcChipWindow:InitWCSelectChip(chipList, teamDataDic, self.__WCSSSelectChipSelectAlg)
  end)
end

function WarChessSelectChipCtrl:WCSSSelectChipSelectAlg(index, teamData)
  local tid = teamData:GetWCTeamId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_SelectTeamForAlgSystem_Select(self.__identify, tid, index - 1, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local remainAlgList = args[0]
    if 0 < #remainAlgList then
      local chipList = {}
      for _, v in ipairs(remainAlgList) do
        local chipData = ChipData.NewChipForServer(v)
        table.insert(chipList, chipData)
      end
      local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
      UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
        wcChipWindow:InitWCSelectChip(chipList, teamDataDic, self.__WCSSSelectChipSelectAlg)
      end)
    else
      self:WCSSQuitSelect()
    end
  end)
end

function WarChessSelectChipCtrl:WCSSQuitSelect()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_SelectTeamForAlgSystem_Quit(self.__identify, function()
    self:CloseWCSubSystem()
  end)
end

function WarChessSelectChipCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessSelectChip)
  self.__selectTeamForAlgSystemData = nil
  self.__identify = nil
end

function WarChessSelectChipCtrl:Delete()
end

return WarChessSelectChipCtrl
