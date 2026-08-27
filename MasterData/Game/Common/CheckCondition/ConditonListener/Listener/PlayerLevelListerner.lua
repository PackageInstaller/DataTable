local PlayerLevelListerner = class("PlayerLevelListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.PlayerLevel

function PlayerLevelListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__OnOutCondititonChange)
  self.__minPlayerLevel = math.maxinteger
end

function PlayerLevelListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function PlayerLevelListerner:AddNewCondition(conditonDataDic)
  self.__minPlayerLevel = math.maxinteger
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local unlock = self.__checker.Checker.ParamsCheck(paramGoup)
      if unlock then
        self.removeConditonFunc(checkerTypeId, listenerId, index)
      else
        self.__minPlayerLevel = math.min(self.__minPlayerLevel, paramGoup[1])
      end
    end
  end
end

function PlayerLevelListerner:__OnOutCondititonChange()
  if PlayerDataCenter.playerLevel >= self.__minPlayerLevel then
    self.__minPlayerLevel = math.maxinteger
    if self.onConditonChangeCallback ~= nil then
      self.onConditonChangeCallback(checkerTypeId)
    end
  end
end

function PlayerLevelListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__OnOutCondititonChange)
end

return PlayerLevelListerner
