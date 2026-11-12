local GuideGroup_10 = class("GuideGroup_10")
local mapEventConfig = {
  OnEvent_PanelOnEnableById = "OnEvent_PanelOnEnableById",
  Positioning_Char_Grid = "OnEvent_PositioningCharGrid",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}
local groupId = 10
local totalStep = 5
local current = 1

function GuideGroup_10:Init(parent, runStep)
  self:BindEvent()
  self.tabChar = {}
  self.parent = parent
  current = 1
  local funName = "Step_" .. current
  local func = handler(self, self[funName])
  func()
end

function GuideGroup_10:BindEvent()
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

function GuideGroup_10:UnBindEvent()
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

function GuideGroup_10:SendGuideStep(step)
  self.parent:SendGuideStep(groupId, step)
end

function GuideGroup_10:Clear()
  self.runGuide = false
  self:UnBindEvent()
  self.parent = nil
  self.tabChar = nil
end

function GuideGroup_10:Step_1()
  current = 1
  self.parent:ActiveHide(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    local tbOption = {
      AllEnum.ChooseOption.Char_Element,
      AllEnum.ChooseOption.Char_Rarity,
      AllEnum.ChooseOption.Char_PowerStyle,
      AllEnum.ChooseOption.Char_AffiliatedForces,
      AllEnum.ChooseOption.Char_TacticalStyle
    }
    PlayerData.Filter:Reset(tbOption)
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    EventManager.Hit(EventId.FilterConfirm)
    self:Step_2()
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_10:Step_2()
  self.msg = {
    BindIcon = "CharacterListPanel/----SafeAreaRoot----/goList/sv/Viewport/Content/0/btnGrid",
    Deviation = {0, 0},
    Desc = "Guide_10_1",
    DescDeviation = {300, -400},
    HandDeviation = {0, -260},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  self.charId = 112
  current = 2
  EventManager.Hit("Guide_PositionCharPos", self.charId)
end

function GuideGroup_10:Step_3()
  self.msg = {
    BindIcon = "CharacterInfoPanel/----SafeAreaRoot----/---Right---/btnDevelopment",
    Deviation = {0, 2},
    Desc = "Guide_10_2",
    DescDeviation = {-730, 0},
    HandDeviation = {0, -120},
    Type = GameEnum.guidetype.ForcedClick
  }
  self.parent:ActiveHide(true)
  current = 3
  self.openPanelId = PanelId.CharBgPanel
  self.waitAnimTime = 0.24
end

function GuideGroup_10:Step_4()
  current = 4
  self.nEntryId = 100201
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nEntryId)
end

function GuideGroup_10:Step_5()
  self.msg = {
    BindIcon = "CharDevelopmentPanel/----SafeAreaRoot----/---Upgrade---/NotMax/rtMat",
    Size = {800, 440},
    Deviation = {0, -56},
    Desc = "Guide_10_3",
    DescDeviation = {-1000, -140},
    Type = GameEnum.guidetype.Introductory,
    isShowHand = true,
    HandDeviation = {-450, 0},
    HandRotation = -90
  }
  self.parent:ActiveHide(true)
  current = 5
  self.parent:PlayTypeMask(self.msg)
end

function GuideGroup_10:OnEvent_PanelOnEnableById(_panelId)
  if self.openPanelId and self.openPanelId == _panelId and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.5))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

function GuideGroup_10:OnEvent_PositioningCharGrid(charId, gridName)
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    if current == 2 then
      self.msg.BindIcon = "CharacterListPanel/----SafeAreaRoot----/goList/sv/Viewport/Content/" .. gridName .. "/btnGrid"
      local tmpIndex = (gridName + 1) % 6
      if tmpIndex == 5 then
        self.msg.DescDeviation = {
          0,
          self.msg.DescDeviation[2]
        }
      elseif tmpIndex == 0 then
        self.msg.DescDeviation = {
          -300,
          self.msg.DescDeviation[2]
        }
      end
      local charCount = PlayerData.Char:GetAllCharCount()
      if 6 < charCount then
        local totalLine = math.ceil(charCount / 6)
        local curLine = math.ceil((gridName + 1) / 6)
        if totalLine == curLine then
          self.msg.DescDeviation = {
            self.msg.DescDeviation[1],
            -self.msg.DescDeviation[2]
          }
          self.msg.HandDeviation = {0, 260}
          self.msg.HandRotation = 180
        end
      end
      self.parent:PlayTypeMask(self.msg)
    end
  end
  
  cs_coroutine.start(wait)
end

function GuideGroup_10:OnEvent_ClosePanel(nPanelId)
  if type(nPanelId) == "number" and nPanelId == PanelId.DictionaryEntry and current == 4 then
    self:Step_5()
  end
end

function GuideGroup_10:FinishCurrentStep()
  self.msg = nil
  self.openPanelId = nil
  self.waitAinEnd = nil
  self.runGuide = false
  self.waitAnimTime = 0
  if current == 2 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "0"})
    table.insert(tab, {
      "normal_tutorial_id",
      "1"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  elseif current == 5 then
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {"action", "1"})
    table.insert(tab, {
      "normal_tutorial_id",
      "1"
    })
    NovaAPI.UserEventUpload("normal_tutorial", tab)
  end
  if current == totalStep then
    self:SendGuideStep(-1)
    self.parent:ClearCurGuide(true)
    return
  elseif current < totalStep then
    self:SendGuideStep(current)
  end
  local funName = "Step_" .. current + 1
  local func = handler(self, self[funName])
  func()
  if self.openPanelId == nil and self.waitAnimTime ~= 0 then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self.waitAnimTime + 0.2))
      
      self.parent:PlayTypeMask(self.msg)
    end
    
    cs_coroutine.start(wait)
  end
end

return GuideGroup_10
