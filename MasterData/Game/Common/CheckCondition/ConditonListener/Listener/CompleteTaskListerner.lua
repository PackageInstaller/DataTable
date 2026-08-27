local CompleteTaskListerner = class("CompleteTaskListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.CompleteTask

function CompleteTaskListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__OnOutCondititonChange)
end

function CompleteTaskListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function CompleteTaskListerner:AddNewCondition(conditonDataDic)
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

function CompleteTaskListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function CompleteTaskListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnOutCondititonChange)
end

return CompleteTaskListerner
