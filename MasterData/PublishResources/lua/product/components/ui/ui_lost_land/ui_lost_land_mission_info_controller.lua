_class("UILostLandMissionInfoController", UIController)
UILostLandMissionInfoController = UILostLandMissionInfoController

function UILostLandMissionInfoController:OnShow(uiParams)
  self._missionid = uiParams[1]
  self._uiModule = GameGlobal.GetUIModule(LostAreaModule)
  self:GetComponents()
  self:GetAwardInfo()
  self:OnValue()
end

function UILostLandMissionInfoController:GetComponents()
  self._recommendPools = self:GetUIComponent("UISelectObjectPath", "recommendPools")
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  local itemTips = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._selectInfo = itemTips:SpawnObject("UISelectInfo")
end

function UILostLandMissionInfoController:OnValue()
  self:GetFilterData()
  self:SetAwardPool()
end

function UILostLandMissionInfoController:SetAwardPool()
  self._count = self._uiModule:GetPetAwardCount()
  self._awardPool:SpawnObjects("UILostLandMissionInfoItem", self._count)
  self:SetAwardData()
end

function UILostLandMissionInfoController:SetAwardData()
  local pools = self._awardPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    if i <= self._count then
      item:Active(true)
      item:SetData(i, self._petAwardCount, function(id, pos)
        self:ItemInfo(id, pos)
      end)
    else
      item:Active(false)
    end
  end
end

function UILostLandMissionInfoController:ItemInfo(id, pos)
  self._selectInfo:SetData(id, pos)
end

function UILostLandMissionInfoController:closeBtnOnClick(go)
  self:CloseDialog()
end

function UILostLandMissionInfoController:GetFilterData()
  local recommendList = self._uiModule:GetRecommendConditionList()
  self._recommendPools:SpawnObjects("UILostLandFilterItem", #recommendList)
  local pools = self._recommendPools:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(recommendList[i])
  end
end

function UILostLandMissionInfoController:GetAwardInfo()
  local stageData = self._uiModule:GetMissionDataByMissionID(self._missionid)
  self._petAwardCount = stageData:GetPetAward()
end
