local GuideGroup_509 = class("GuideGroup_509")
local mapEventConfig = {}
local groupId = 509
local totalStep = 2
local current = 1

function GuideGroup_509:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_509:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function GuideGroup_509:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function GuideGroup_509:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_509:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_509:Step_1()
  local index = self:GetShopIndex()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/Container/rtCardGrid/SoldierCharCardShopItem" .. index,
    Deviation = {0, 0},
    Desc = "Guide_509_1",
    DescDeviation = {300, -400},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_509:Step_2()
  current = 2
  local nEntryId = 400904
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nEntryId)
  self.parent:FinishCurrentStep()
end

function GuideGroup_509:GetShopIndex()
  local tmpId = 1
  if PlayerData.SoldierData.tbGuideData[509] ~= nil then
    tmpId = PlayerData.SoldierData:GetGuideData(509)
  end
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local shopList = levelData:GetShopData()
  local index = 1
  for i, v in pairs(shopList.tbGoods) do
    if tmpId == v.Id then
      index = i
    end
  end
  return index
end

function GuideGroup_509:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

return GuideGroup_509
