local CompleteStageListerner = class("CompleteStageListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.CompleteStage

function CompleteStageListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__OnOutCondititonChange)
end

function CompleteStageListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function CompleteStageListerner:AddNewCondition(conditonDataDic)
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

function CompleteStageListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function CompleteStageListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__OnOutCondititonChange)
end

return CompleteStageListerner
