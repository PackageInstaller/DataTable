require("ui_controller")
_class("UISmokingTestDashboard", UIController)
UISmokingTestDashboard = UISmokingTestDashboard

function UISmokingTestDashboard:OnShow()
  self._StoryTestBtn = self:GetUIComponent("Button", "StoryTest")
  self._StoryChapterTestBtn = self:GetUIComponent("Button", "StoryChapterTest")
  self._ExtraTestBtn = self:GetUIComponent("Button", "ExtraTest")
  self._MazeTestBtn = self:GetUIComponent("Button", "MazeTest")
  self._ResDungeonTestBtn = self:GetUIComponent("Button", "ResDungeonTest")
  self._GoldbergEveBtn = self:GetUIComponent("Button", "GoldbergEveTest")
  self._SafetyLockBtn = self:GetUIComponent("Button", "SafetyLock")
  self._HardResetBtn = self:GetUIComponent("Button", "HardReset")
  self._HaltBtn = self:GetUIComponent("Button", "Halt")
  self._StatusLog = self:GetUIComponent("UILocalizationText", "StatusLog")
  self._InputChapter = self:GetUIComponent("InputField", "InputChapter")
  self._activityTestBtn = self:GetUIComponent("Button", "ActivityTest")
  self._advancedMode = false
end

function UISmokingTestDashboard:OnUpdate(dt)
  self:_EntrancesBtnStatusUpdate(dt)
  self:_AdvancedBtnStatusUpdate(dt)
  local testRobot = GameGlobal.GetModule(TestRobotModule)
  self._StatusLog:SetText(testRobot.__statusStr)
end

function UISmokingTestDashboard:_EntrancesBtnStatusUpdate(dt)
  local testRobot = GameGlobal.GetModule(TestRobotModule)
  local entranceEnable = not testRobot.m_bEnableRobot
  self._StoryTestBtn.interactable = entranceEnable
  self._StoryChapterTestBtn.interactable = entranceEnable
  self._ExtraTestBtn.interactable = entranceEnable
  self._MazeTestBtn.interactable = entranceEnable
  self._ResDungeonTestBtn.interactable = entranceEnable
  self._GoldbergEveBtn.interactable = entranceEnable
end

function UISmokingTestDashboard:_AdvancedBtnStatusUpdate(dt)
  self._HardResetBtn.interactable = self._advancedMode
  self._HaltBtn.interactable = self._advancedMode
end

function UISmokingTestDashboard:BlackBGOnClick()
  self:CloseDialog()
end

function UISmokingTestDashboard:StoryTestOnClick()
  if not self._StoryTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:StoryChapterTestOnClick()
  if not self._StoryChapterTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:ExtraTestOnClick()
  if not self._ExtraTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:MazeTestOnClick()
  if not self._MazeTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:TowerTestOnClick()
  if not self._StoryTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:ResDungeonTestOnClick()
  if not self._ResDungeonTestBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:GoldbergEveTestOnClick()
  if not self._GoldbergEveBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:SafetyLockOnClick()
  self._advancedMode = not self._advancedMode
end

function UISmokingTestDashboard:HardResetOnClick()
  if not self._HardResetBtn.interactable then
    return
  end
end

function UISmokingTestDashboard:HaltOnClick()
  if not self._HaltBtn.interactable then
    return
  end
  GameGlobal.GetModule(TestRobotModule).m_bEnableRobot = false
end

function UISmokingTestDashboard:ActivityTestOnClick()
  if not self._activityTestBtn.interactable then
    return
  end
end
