local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessStrategyCtrl = class("WarChessStrategyCtrl", base)

function WarChessStrategyCtrl:ctor(wcCtrl)
  self.__wcStrageCfg = nil
  self.__wcStrageExpItemId = nil
  self.__wcStrageExp = nil
  self.__wcStrageLevel = 0
  self.__curLevelFullExp = 0
  self.__curLevelExp = 0
  self.__refreshWCStrategyLevelAndExp = BindCallback(self, self.RefreshWCStrategyLevelAndExp)
  MsgCenter:AddListener(eMsgEventId.WC_ItemNumChange, self.__refreshWCStrategyLevelAndExp)
end

function WarChessStrategyCtrl:InitWCStrategyCtrl()
  local isInSeason = WarChessSeasonManager:GetIsInWCSeason()
  if isInSeason then
    local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
    local envCfg = wcsCtrl:GetWCEnvCfg()
    if envCfg == nil then
      return
    end
    local strategy_id = envCfg.strategy_id
    if strategy_id == 0 then
      return
    end
    self.__wcStrageCfg = ConfigData.warchess_strategy[strategy_id]
    self.__wcStrageExpItemId = self.__wcStrageCfg.expItemId
    local num = self.wcCtrl.backPackCtrl:GetWCItemNum(self.__wcStrageExpItemId)
    self:RefreshWCStrategyLevelAndExp(self.__wcStrageExpItemId, num, num)
  end
end

function WarChessStrategyCtrl:RefreshWCStrategyLevelAndExp(itemId, num, addNum)
  if itemId ~= self.__wcStrageExpItemId then
    return
  end
  if num == self.__wcStrageExp then
    return
  end
  self.__wcStrageExp = num
  local curlevel = 0
  local fullExp = 0
  local levelFullExp = 0
  local lastLevelFullExp = 0
  for level, cfg in ipairs(self.__wcStrageCfg) do
    levelFullExp = cfg.expSum - fullExp
    fullExp = cfg.expSum
    if self.__wcStrageExp >= cfg.expSum then
      curlevel = level
    else
      break
    end
    lastLevelFullExp = fullExp
  end
  self.__wcStrageLevel = curlevel
  self.__curLevelFullExp = levelFullExp
  self.__curLevelExp = self.__wcStrageExp - lastLevelFullExp
  MsgCenter:Broadcast(eMsgEventId.WC_StrategyExpChange)
end

function WarChessStrategyCtrl:GetWCIsHaveStrategy()
  return self.__wcStrageCfg ~= nil
end

function WarChessStrategyCtrl:GetWCStrategyExpNum()
  return self.__wcStrageExp
end

function WarChessStrategyCtrl:GetWCStrategyLevel()
  return self.__wcStrageLevel
end

function WarChessStrategyCtrl:GetWCStrategyExp()
  return self.__curLevelExp, self.__curLevelFullExp
end

function WarChessStrategyCtrl:Delete()
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemNumChange, self.__refreshWCStrategyLevelAndExp)
end

return WarChessStrategyCtrl
