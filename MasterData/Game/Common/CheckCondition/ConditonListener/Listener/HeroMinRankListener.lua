local HeroMinRankListener = class("HeroMinRankListener")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.MinHeroStar

function HeroMinRankListener:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__OnOutCondititonChangeCallback = BindCallback(self, self.__OnOutCondititonChange)
  self.__HeroUpdateCallback = BindCallback(self, self.__HeroUpdate)
  MsgCenter:AddListener(eMsgEventId.OnHeroRankChange, self.__OnOutCondititonChangeCallback)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroUpdateCallback)
end

function HeroMinRankListener:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function HeroMinRankListener:AddNewCondition(conditonDataDic)
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

function HeroMinRankListener:__OnOutCondititonChange()
  if self.onConditonChangeCallback ~= nil then
    self.onConditonChangeCallback(checkerTypeId)
  end
end

function HeroMinRankListener:__HeroUpdate(heroUpdate, newHero)
  if newHero then
    self:__OnOutCondititonChange()
  end
end

function HeroMinRankListener:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroRankChange, self.__OnOutCondititonChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroUpdateCallback)
end

return HeroMinRankListener
