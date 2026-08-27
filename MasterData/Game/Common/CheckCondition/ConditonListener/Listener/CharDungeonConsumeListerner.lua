local CharDungeonConsumeListerner = class("CharDungeonConsumeListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.CharDungeonConsume

function CharDungeonConsumeListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChange = BindCallback(self, self.__OnOutCondititonChange)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__OnOutCondititonChange)
end

function CharDungeonConsumeListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function CharDungeonConsumeListerner:AddNewCondition(conditonDataDic)
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

function CharDungeonConsumeListerner:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function CharDungeonConsumeListerner:Delete()
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__OnOutCondititonChange)
end

return CharDungeonConsumeListerner
