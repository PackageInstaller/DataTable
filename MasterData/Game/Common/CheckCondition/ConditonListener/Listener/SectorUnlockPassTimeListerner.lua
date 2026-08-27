local SectorUnlockPassTimeListerner = class("SectorUnlockPassTimeListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.SectorStagePassTm

function SectorUnlockPassTimeListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.SectorStateUpdate, self.__OnOutCondititonChange)
end

function SectorUnlockPassTimeListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function SectorUnlockPassTimeListerner:AddNewCondition(conditonDataDic)
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local unlock = self.__checker.Checker.ParamsCheck(paramGoup)
      if unlock then
        local sectorId = paramGoup[2]
        local passTime = paramGoup[3]
        local ok, outRange = PlayerDataCenter.sectorStage:CheckStagePassTmInRange(sectorId, passTime)
        if ok and outRange then
          self.removeConditonFunc(checkerTypeId, listenerId, index)
        end
      end
    end
  end
end

function SectorUnlockPassTimeListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function SectorUnlockPassTimeListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.SectorStateUpdate, self.__OnOutCondititonChange)
end

return SectorUnlockPassTimeListerner
