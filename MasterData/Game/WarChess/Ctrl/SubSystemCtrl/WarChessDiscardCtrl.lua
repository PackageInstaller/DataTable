local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessDiscardCtrl = class("WarChessDiscardCtrl", base)

function WarChessDiscardCtrl:ctor(wcCtrl)
  self.__algDiscardSystemData = nil
  self.__identify = nil
end

function WarChessDiscardCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.discard
end

function WarChessDiscardCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.algDiscardSystemData == nil then
    error("not have data")
    return
  end
  self.__algDiscardSystemData = systemState.algDiscardSystemData
  self.__identify = identify
  local resultTeam = self:GetWCNextDiscardChipTeam()
  self._curDiscardTeam = resultTeam
  self:__EnterWCDiscard()
end

function WarChessDiscardCtrl:__EnterWCDiscard()
  if self._curDiscardTeam == nil then
    self._curDiscardTeam = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(self.__identify.tid)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessChipDiscard, function(win)
    if win == nil then
      return
    end
    win:InitWCChipDiscard(self, self._curDiscardTeam)
  end)
end

function WarChessDiscardCtrl:GetWCNextDiscardChipTeam()
  local resultTeam
  local teamDic = self.wcCtrl.teamCtrl:GetWCTeams()
  for index, teamData in pairs(teamDic) do
    local dynPlayer = teamData:GetTeamDynPlayer()
    if dynPlayer:IsChipOverLimitNum() then
      resultTeam = teamData
      break
    end
  end
  return resultTeam
end

function WarChessDiscardCtrl:GetWCCapacityUpGradeCost(teamData)
  local dynPlayer = teamData:GetTeamDynPlayer()
  local shopId = WarChessManager:GetWCLevelShopId()
  return dynPlayer:GetChipUpgradeLimitPrice(shopId)
end

function WarChessDiscardCtrl:GetWCChipDiscardPrice(chipData)
  local shopId = WarChessManager:GetWCLevelShopId()
  local shopCfg = ConfigData.warchess_shop_coin[shopId]
  local chipLevel = chipData:GetCount()
  local price = shopCfg.function_price[chipLevel]
  local disCardPrice = math.ceil(price * shopCfg.discard_scale / 1000)
  return disCardPrice, shopCfg.item1
end

function WarChessDiscardCtrl:WCDiscardChip(algId, callback)
  if self._curDiscardTeam == nil then
    return
  end
  local identify = self.__identify
  local tid = self._curDiscardTeam:GetWCTeamId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_AlgDiscardSystem_Select(identify, tid, algId, callback)
end

function WarChessDiscardCtrl:ExitWCDiscard(callback)
  if self._curDiscardTeam ~= nil and self._curDiscardTeam:GetTeamDynPlayer():IsChipOverLimitNum() then
    return
  end
  local nextDiscardTeam = self:GetWCNextDiscardChipTeam()
  if nextDiscardTeam ~= nil then
    self._curDiscardTeam = nextDiscardTeam
    self:__EnterWCDiscard()
    return
  end
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_AlgDiscardSystem_Quit(self.__identify, function()
    if callback ~= nil then
      callback()
    end
  end)
  self.__algDiscardSystemData = nil
  self.__identify = nil
  self._curDiscardTeam = nil
end

function WarChessDiscardCtrl:AddWCChipCapacity(callback)
  if self._curDiscardTeam == nil then
    return
  end
  local costId, costNum = self:GetWCCapacityUpGradeCost(self._curDiscardTeam)
  local curNum = self.wcCtrl.backPackCtrl:GetWCItemNum(costId)
  if costNum > curNum then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8512))
    return
  end
  local tid = self._curDiscardTeam:GetWCTeamId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_AlgDiscardSystem_PurchaseAlgLimit(self.__identify, tid, function()
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8532))
    if callback ~= nil then
      callback()
    end
  end)
end

function WarChessDiscardCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessChipDiscard)
  self.__algDiscardSystemData = nil
  self.__identify = nil
  self._curDiscardTeam = nil
end

function WarChessDiscardCtrl:Delete()
end

return WarChessDiscardCtrl
