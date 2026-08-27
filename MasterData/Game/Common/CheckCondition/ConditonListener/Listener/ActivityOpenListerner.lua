local ActivityOpenListerner = class("ActivityOpenListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.ActivityOpen

function ActivityOpenListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChangeCallback = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__OnOutCondititonChangeCallback)
end

function ActivityOpenListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function ActivityOpenListerner:AddNewCondition(conditonDataDic)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local activityFrameId = paramGoup[2]
      local activityData = activityFrameCtrl:GetActivityFrameData(activityFrameId)
      if activityData == nil or activityData:GetIsActivityFinished() then
        self.removeConditonFunc(checkerTypeId, listenerId, index)
      end
    end
  end
end

function ActivityOpenListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function ActivityOpenListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__OnOutCondititonChangeCallback)
end

return ActivityOpenListerner
