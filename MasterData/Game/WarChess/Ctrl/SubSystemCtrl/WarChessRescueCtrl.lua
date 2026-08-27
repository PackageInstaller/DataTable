local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessRescueCtrl = class("WarChessRescueCtrl", base)
local cs_MessageCommon = CS.MessageCommon
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function WarChessRescueCtrl:ctor(wcCtrl)
  self.__rescueSystemData = nil
  self.__identify = nil
  self.__curTeamData = nil
  self.__couldReplaceHeroIdList = nil
  self.__couldReplaceHeroDataDic = nil
end

function WarChessRescueCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.rescue
end

function WarChessRescueCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.rescueSystemData == nil then
    error("not have data")
    return
  end
  self.__rescueSystemData = systemState.rescueSystemData
  self.__identify = identify
  self.__curTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(identify.tid)
  local careerDic = {
    [self.__rescueSystemData.career] = true
  }
  self:__GenCouldReplaceHeroIdList(careerDic)
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSupportRoom, function(win)
    if win == nil then
      return
    end
    local dynPlayer = self.__curTeamData:GetTeamDynPlayer()
    local supportHeroMixedList = self:GetWCCouldReplaceHeroDataDic()
    
    local function cancleFunc()
      self:CancelReplaceWCTeamHero()
    end
    
    local function confirmFunc(enterIdList, quitHeroIdList)
      self:ConfirmReplaceWCTeamHero(enterIdList, quitHeroIdList)
    end
    
    win:InitEpSurpportRoomForWC(dynPlayer, supportHeroMixedList, cancleFunc, confirmFunc)
  end)
end

function WarChessRescueCtrl:GetWCCouldReplaceHeroDataDic()
  return self.__couldReplaceHeroDataDic
end

function WarChessRescueCtrl:__GenCouldReplaceHeroIdList(careerDic)
  careerDic = careerDic or {}
  local couldRescueHeroIdList = {}
  local couldRescueHeroDataDic = {}
  local curInUseHeroDic = {}
  for teamIndex, teamData in pairs(self.wcCtrl.teamCtrl:GetWCTeams()) do
    local wcDynPlayer = teamData:GetTeamDynPlayer()
    for heroId, dynHeroData in pairs(wcDynPlayer.heroDic) do
      curInUseHeroDic[heroId] = true
    end
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local career = heroData.career
    if careerDic[career] ~= nil then
      local usedDynHeroData = self.wcCtrl.teamCtrl:GetHeroDynDataById(heroId)
      if usedDynHeroData ~= nil then
        if curInUseHeroDic[heroId] ~= nil then
        elseif usedDynHeroData.hpPer <= 0 then
        else
          table.insert(couldRescueHeroIdList, heroId)
          couldRescueHeroDataDic[heroId] = usedDynHeroData
          usedDynHeroData.onBench = false
        end
      else
        table.insert(couldRescueHeroIdList, heroId)
        couldRescueHeroDataDic[heroId] = heroData
      end
    end
  end
  self.__couldReplaceHeroIdList = couldRescueHeroIdList
  self.__couldReplaceHeroDataDic = couldRescueHeroDataDic
end

function WarChessRescueCtrl:ConfirmReplaceWCTeamHero(enterIdList, quitHeroIdList)
  local newHeroDic = {}
  local heroDic = self.__curTeamData:GetWCTeamOrderDic()
  local removeDic = {}
  for _, heroId in pairs(quitHeroIdList) do
    removeDic[heroId] = true
  end
  local normalNum = ConfigData.formation_rule[0].stage_num
  local benchNum = ConfigData.formation_rule[0].bench_num
  local enterIndex = 1
  for heroIndex = 1, normalNum + benchNum do
    local curHeroId = heroDic[heroIndex]
    if curHeroId == nil then
      newHeroDic[heroIndex] = enterIdList[enterIndex]
      enterIndex = enterIndex + 1
    elseif removeDic[curHeroId] then
      newHeroDic[heroIndex] = enterIdList[enterIndex]
      enterIndex = enterIndex + 1
    else
      newHeroDic[heroIndex] = curHeroId
    end
  end
  for heroIndex, heroId in pairs(newHeroDic) do
    local usedDynHeroData = self.wcCtrl.teamCtrl:GetHeroDynDataById(heroId)
    if usedDynHeroData ~= nil and 0 >= usedDynHeroData.hpPer then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8721))
      return
    end
  end
  local identify = self.__identify
  local heroes = newHeroDic
  local fromFormationIdx = self.__curTeamData:GetWCTeamIndex()
  local powerNum = 0
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Event_FreshFormation(identify, heroes, fromFormationIdx, powerNum, false, function()
    if isGameDev then
      print("换人结束")
    end
  end)
end

function WarChessRescueCtrl:CancelReplaceWCTeamHero()
  local identify = self.__identify
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Event_FreshFormation(identify, table.emptytable, 0, 0, true, function()
    if isGameDev then
      print("换人结束")
    end
  end)
end

function WarChessRescueCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  UIManager:DeleteWindow(UIWindowTypeID.EpSupportRoom)
  self:Exit()
end

function WarChessRescueCtrl:Exit()
  self.__rescueSystemData = nil
  self.__identify = nil
  self.__couldReplaceHeroIdList = nil
  self.__couldReplaceHeroDataDic = nil
end

function WarChessRescueCtrl:Delete()
end

return WarChessRescueCtrl
