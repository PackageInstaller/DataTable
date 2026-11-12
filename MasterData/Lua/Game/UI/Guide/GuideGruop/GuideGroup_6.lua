local GuideGroup_6 = class("GuideGroup_6")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Guide_SelectGuideGroupGrid = "OnEvent_SelectGuideGroupGrid",
  Guide_CloseGuideQuestReward = "OnEvent_Guide_CloseGuideQuestReward"
}
local groupId = 6
local totalStep = 5
local current = 1

function GuideGroup_6:Init(parent, runStep)
  self:BindEvent()
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_6:BindEvent()
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

function GuideGroup_6:UnBindEvent()
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

function GuideGroup_6:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_6:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
end

function GuideGroup_6:Step_1()
  self.msg = {
    BindIcon = "MainViewPanel/----SafeAreaRoot----/HideRoot/--TopRight--/trBtnList/btnTask",
    Size = {120, 120},
    Deviation = {0, 0},
    Desc = "Guide_6_1",
    DescDeviation = {-500, -280},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 1
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_6:Step_2()
  EventManager.Hit("Guide_SelectQuestPage", AllEnum.QuestPanelTab.GuideQuest)
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtLevel",
    Size = {340, 350},
    Deviation = {30, 0},
    Desc = "Guide_6_2",
    DescDeviation = {750, 100},
    HandDeviation = {0, 180},
    HandRotation = 180,
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 2
  self.openPanelId = PanelId.Quest
  self.waitAnimTime = 0.3
end

function GuideGroup_6:Step_3()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtGuideQuest/questList",
    Deviation = {0, 0},
    Desc = "Guide_6_3",
    DescDeviation = {-930, -420},
    Type = GameEnum.guidetype.Introductory
  }
  self.parent:ActiveHide(true)
  current = 3
  self.waitAnimTime = 0.1
end

function GuideGroup_6:Step_4()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/rtGuideQuest/questList/guideQuestLSV/Viewport/Content/0/btnGrid/AnimRoot/btnReceive",
    Deviation = {0, 0},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 4
  self.waitAnimTime = 0.2
end

function GuideGroup_6:Step_5()
  self.msg = {
    BindIcon = "QuestPanel/----SafeAreaRoot----/TopBarPanel/Area/goBack/btnHome",
    Deviation = {0, 0},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 5
  self.waitAnimTime = 0.2
end

function GuideGroup_6:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId then
    if self.waitAnimTime == nil or self.waitAnimTime == 0 then
      if current == 17 then
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.2))
          
          self.parent:PlayTypeMask(self.msg)
        end
        
        cs_coroutine.start(wait)
      end
    elseif self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    end
  end
end

function GuideGroup_6:OnEvent_SelectGuideGroupGrid(nQuestId, nIndex)
  if self.nQuestId == nQuestId then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      if current == 4 then
        self.msg.BindIcon = "QuestPanel/----SafeAreaRoot----/rtGuideQuest/questList/guideQuestLSV/Viewport/Content/" .. nIndex .. "/btnGrid/AnimRoot/btnReceive"
        self.parent:PlayTypeMask(self.msg)
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_6:OnEvent_Guide_CloseGuideQuestReward()
  if current == 4 then
    self:Step_5()
    if self.waitAnimTime ~= 0 then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime))
        
        self.parent:PlayTypeMask(self.msg)
      end
      
      cs_coroutine.start(wait)
    end
  end
end

function GuideGroup_6:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 1 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "newbie_tutorial_id",
      "22"
    })
    NovaAPI.UserEventUpload("newbie_tutorial", tab)
  end
  if current == 1 then
    self:SendGuideStep(-1)
  end
  if current == totalStep then
    self.parent:ClearCurGuide(true)
    return
  end
  if current == 3 then
    self.nQuestId = PlayerData.Quest:GetTourGuideQuestRewardId()
    if self.nQuestId ~= 0 then
      EventManager.Hit("Guide_SelectTourGuideQuest", self.nQuestId)
      self:Step_4()
    else
      self:Step_5()
    end
  elseif current ~= 4 then
    local funName = "Step_" .. current + 1
    local func = handler(self, self[funName])
    func()
  end
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_6
