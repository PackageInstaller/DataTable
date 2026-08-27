local FairyCultivateMainUIData = class("FairyCultivateMainUIData")
local FairyHelper = require("Game.Fairy.FairyHelper")

function FairyCultivateMainUIData:ctor()
  self.noFilterFairyList = {}
  self.fairyDataList = {}
end

function FairyCultivateMainUIData.CreateNewFairyCultivateMainUIData(fairyDataDic)
  local cultivateUIData = FairyCultivateMainUIData.New()
  cultivateUIData:InitFairyCultivateMainUIData(fairyDataDic)
  return cultivateUIData
end

function FairyCultivateMainUIData:InitFairyCultivateMainUIData(fairyDataDic)
  self.fairyDataDic = fairyDataDic
  self.__dirty = true
end

function FairyCultivateMainUIData:UpdateFairyCultivateMainUIData(fairyDataDic)
  self:InitFairyCultivateMainUIData(fairyDataDic)
end

function FairyCultivateMainUIData:SetSiftFunc(siftFunc)
  self.siftFunc = siftFunc
  self.__dirty = true
end

function FairyCultivateMainUIData:SetRefreshFunc(refreshFunc)
  self.refreshFunc = refreshFunc
end

function FairyCultivateMainUIData:RejectFairyDic(deleteFairyDic, needRefresh)
  self.deleteFairyDic = deleteFairyDic or {}
  if self.refreshFunc and needRefresh then
    self:GenFairyList()
    self.refreshFunc()
    return
  end
  self.__dirty = true
end

function FairyCultivateMainUIData:GenFairyList()
  table.clearmap(self.noFilterFairyList)
  table.clearmap(self.fairyDataList)
  self.deleteFairyDic = self.deleteFairyDic or {}
  for id, value in pairs(self.fairyDataDic) do
    if not self.deleteFairyDic[id] then
      table.insert(self.noFilterFairyList, value)
      if self.siftFunc == nil or self.siftFunc(value, self.sortKindData) then
        table.insert(self.fairyDataList, value)
      end
    end
  end
  self:SetSortRule()
end

function FairyCultivateMainUIData:FilterFairyDic(sortKindData)
  self.sortKindData = sortKindData
  self:RejectFairyDic(self.deleteFairyDic, false)
end

function FairyCultivateMainUIData:SetFairySortRuleFunc(func)
  self.fairySortRuleFunc = func
end

function FairyCultivateMainUIData:SetSortRule()
  if self.fairySortRuleFunc then
    table.sort(self.fairyDataList, self.fairySortRuleFunc)
  else
    FairyHelper.FairyCommonSort(self.fairyDataList)
  end
end

function FairyCultivateMainUIData:GetSortKindData()
  return self.sortKindData
end

function FairyCultivateMainUIData:GetFairyDataUIList()
  if self.__dirty == true then
    self:GenFairyList()
    self.__dirty = false
  end
  return self.fairyDataList
end

function FairyCultivateMainUIData:GetRealFairyDataList()
  if self.__dirty == true then
    self:GenFairyList()
    self.__dirty = false
  end
  return self.noFilterFairyList
end

return FairyCultivateMainUIData
