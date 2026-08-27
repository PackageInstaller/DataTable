local CompleteAvgListerner = class("CompleteAvgListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.CompleteAvg

function CompleteAvgListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.AVGLogicPlayed, self.__OnOutCondititonChange)
end

function CompleteAvgListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function CompleteAvgListerner:AddNewCondition(conditonDataDic)
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local unlock = self.__checker.Checker.ParamsCheck(paramGoup)
      if unlock then
        self.removeConditonFunc(checkerTypeId, listenerId, index)
      end
    end
  end
end

function CompleteAvgListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function CompleteAvgListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.AVGLogicPlayed, self.__OnOutCondititonChange)
end

return CompleteAvgListerner
