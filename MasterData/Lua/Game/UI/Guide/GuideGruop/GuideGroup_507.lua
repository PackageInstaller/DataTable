local GuideGroup_507 = class("GuideGroup_507")
local mapEventConfig = {
  Guide_ExperienceLevelChange = "OnEvent_ExperienceLevelChange",
  Guide_ExperienceLevelUp_CostNotEnough = "OnEvent_ExperienceLevelUpCostNotEnough"
}
local groupId = 507
local totalStep = 13
local current = 1

function GuideGroup_507:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_507:BindEvent()
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

function GuideGroup_507:UnBindEvent()
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

function GuideGroup_507:SendGuideStep(step)
  local seasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  self.parent:SendGuideStep(groupId, step, AllEnum.GuideType.Soldier, seasonId)
end

function GuideGroup_507:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_507:Step_1()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ShopContainer/btnShop",
    Deviation = {-92, 0},
    Desc = "Guide_507_1",
    DescDeviation = {-792, 50},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_2()
  local index = self:GetShopIndex()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/Container/rtCardGrid/SoldierCharCardShopItem" .. index,
    Deviation = {0, 0},
    Desc = "Guide_507_2",
    DescDeviation = {0, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_3()
  local index = self:GetShopIndex()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/Container/rtCardGrid/SoldierCharCardShopItem" .. index .. "/btnItem/AnimRoot/Container/Cost",
    Deviation = {-32, 20},
    Desc = "Guide_507_3",
    DescDeviation = {0, -150},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_4()
  local index = self:GetShopIndex()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/Container/rtCardGrid/SoldierCharCardShopItem" .. index,
    Deviation = {0, 0},
    Desc = "Guide_507_4",
    DescDeviation = {0, -300},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 4
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_5()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/btnLayot/btnRefreshShop",
    Deviation = {-120, 0},
    Desc = "Guide_507_5",
    DescDeviation = {-400, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_6()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/SoldierShopComponent/goProbabilityBar",
    Size = {550, 60},
    Deviation = {230, 0},
    Desc = "Guide_507_6",
    DescDeviation = {250, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 6
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_7()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ExperienceContainer/btnExperience",
    Deviation = {0, 0},
    Desc = "Guide_507_7",
    DescDeviation = {600, 220},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 7
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_8()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ExperienceContainer/btnExperience",
    Deviation = {0, 0},
    Desc = "Guide_507_8",
    DescDeviation = {600, 220},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 8
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_9()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ExperienceContainer/btnExperience",
    Deviation = {0, 0},
    Desc = "Guide_507_9",
    DescDeviation = {600, 220},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 9
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_10()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/MiddleContainer/TextAddCharCount",
    Size = {300, 100},
    Deviation = {-50, 0},
    Desc = "Guide_507_10",
    DescDeviation = {0, -200},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 10
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_11()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/ShopContainer/btnShop",
    Deviation = {-92, 0},
    Desc = "Guide_507_11",
    DescDeviation = {-700, 150},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 11
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_12()
  self.msg = {
    BindIcon = "SoldierSandtablePanel/----SafeAreaRoot----/DownContainer/btn_coinTips",
    Deviation = {0, 0},
    Desc = "Guide_507_12",
    DescDeviation = {-700, 150},
    HandDeviation = {0, 120},
    HandRotation = 180,
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 12
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_507:Step_13()
  self.msg = {
    BindIcon = "SoldierGoldTipsPanel/----SafeAreaRoot----/Scroll View",
    Deviation = {0, 0},
    Desc = "Guide_507_13",
    DescDeviation = {850, -50},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 13
  self.waitAnimTime = 0.3
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
    self.parent:PlayTypeMask(self.msg)
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_507:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 6 then
    EventManager.Hit("Guide_CloseSoldierShop")
  end
  if current == 9 then
    return
  end
  if current < totalStep then
    self:SendGuideStep(current)
  elseif current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_507:GetShopIndex()
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  local shopList = levelData:GetShopData()
  local index = 1
  local tmpPrice = 0
  for i, v in pairs(shopList.tbGoods) do
    if tmpPrice < v.Price then
      tmpPrice = v.Price
      index = i
    end
  end
  return index
end

function GuideGroup_507:OnEvent_ExperienceLevelChange(isChange)
  if current == 9 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
      
      if isChange then
        self:Step_10()
      else
        self:Step_9()
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_507:OnEvent_ExperienceLevelUpCostNotEnough()
  if current == 9 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      
      self:Step_11()
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_507
