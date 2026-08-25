local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local TaskServerIndex = CommonDefine.TaskServerIndex
local TaskPage = CommonDefine.TaskPage
local typeof = _ENV.typeof
local TaskMainPanel, Super = System.NewClass("TaskMainPanel", UIBasePanel)
TaskMainPanel.uiResCls = UI_Task_Panel_Main_NewResource

function TaskMainPanel:ctor()
  Super.ctor(self)
  self.page = Vue.ref()
end

function TaskMainPanel:OnBind(binder)
  self:Init(binder)
  binder:BindEvent(EventMgr.Instance.TaskSwitchPage, function(tabIndex)
    binder:SetZ1Toggle(self.ui["Btn_Task" .. tabIndex], true)
  end)
  binder:BindEvent(EventMgr.Instance.TaskShowAnim, function(animName, callBack)
    self.uiAnimController:PlayMultiState(animName, callBack)
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "Main_Title_3"
  end)
  self.closeBtnGO = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    if not self.clickClose then
      self:OnClose()
    end
  end))
  self:OnBindToggle(binder)
end

function TaskMainPanel:Init(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.toggleInfoMap = {
    [TaskPage.Career] = {
      panelInstance = nil,
      toggleObj = self.ui.Btn_Task1,
      toggleUI = self.ui.UI_Task_Popup_Career,
      serverIdx = TaskServerIndex.Career,
      nameKey = "Task_Tab_Career",
      enterAnimClip = "UI_Task_Popup_Career_New_Open",
      closeAnimClip = "UI_Task_Popup_Career_New_Close",
      enterAnimCallback = nil,
      closeAnimCallback = nil
    },
    [TaskPage.PlayerLevel] = {
      panelInstance = nil,
      toggleObj = self.ui.Btn_Task2,
      toggleUI = self.ui.UI_Task_Popup_PlayerLevel,
      serverIdx = TaskServerIndex.PlayerLevel,
      nameKey = "PlayerLevelTaskLabel",
      enterAnimClip = "UI_Task_Popup_Challenge_Open",
      closeAnimClip = "UI_Task_Popup_Challenge_Close",
      enterAnimCallback = nil,
      closeAnimCallback = nil
    },
    [TaskPage.School] = {
      panelInstance = nil,
      toggleObj = self.ui.Btn_Task3,
      toggleUI = self.ui.UI_Task_Popup_School,
      serverIdx = TaskServerIndex.School,
      nameKey = "SchoolTaskLabel",
      enterAnimClip = "UI_Task_Popup_Career_New_Open",
      closeAnimClip = "UI_Task_Popup_Career_New_Close",
      enterAnimCallback = nil,
      closeAnimCallback = nil
    },
    [TaskPage.Achievement] = {
      panelInstance = nil,
      toggleObj = self.ui.Btn_Task4,
      toggleUI = self.ui.UI_Task_Popup_Challenge,
      serverIdx = TaskServerIndex.Achivement,
      nameKey = "Task_AchievementLabel",
      enterAnimClip = nil,
      closeAnimClip = nil,
      enterAnimCallback = function()
        self.ui.UI_Task_Popup_Challenge:SetActive(true)
      end,
      closeAnimCallback = function()
        self.ui.UI_Task_Popup_Challenge:SetActive(false)
      end
    }
  }
end

function TaskMainPanel:OnBindToggle(binder)
  local readyOpenIndex = 0
  for tabIndex = 1, 4 do
    local toggleBtn = self.toggleInfoMap[tabIndex].toggleObj
    local onToggle = System.bind(self.OnToggle, self, tabIndex)
    local toggleUI = self.toggleInfoMap[tabIndex].toggleUI
    binder:BindToZ1Toggle(toggleBtn, nil, onToggle)
    binder:BindComponent(RedDotComponent(UI_Common_Item_Toggle_3Resource(toggleBtn).Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
      do return RedPointDataUtils.IsShowTaskRedPoint end
      return RedPointDataUtils.IsShowTaskRedPoint, self.toggleInfoMap[tabIndex].serverIdx, tabIndex
    end))
    binder:BindToTextColorOld(UI_Common_Item_Toggle_3Resource(toggleBtn).Text_C_Name, function()
      if self.page.value == tabIndex then
        return "#FFFFFF"
      end
      return "#8D979A"
    end)
    binder:BindToVisible(toggleUI, function()
      return self.page.value == tabIndex
    end)
    binder:BindToVisible(toggleUI, function()
      return self.page.value == tabIndex
    end)
    binder:BindToVisible(UI_Common_Item_Toggle_3Resource(toggleBtn).Group_Selected, function()
      return self.page.value == tabIndex
    end)
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, self.toggleInfoMap[tabIndex].serverIdx)
    binder:BindToVisible(UI_Common_Item_Toggle_3Resource(toggleBtn).uiNode, function()
      return unlocked
    end)
    if unlocked and 0 == readyOpenIndex then
      readyOpenIndex = tabIndex
    end
  end
  local toggleBtn = self.toggleInfoMap[readyOpenIndex].toggleObj or self.ui.Btn_Task1
  binder:SetZ1Toggle(toggleBtn, false)
  binder:SetZ1Toggle(toggleBtn, true)
  self.page.value = readyOpenIndex
end

function TaskMainPanel:OnToggle(tabIndex, isOn)
  if not isOn then
    return
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, self.toggleInfoMap[tabIndex].serverIdx)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Task, self.toggleInfoMap[tabIndex].serverIdx)
    return
  end
  self:SwitchPage(tabIndex)
end

function TaskMainPanel:CreateSubPanel(tabIndex)
  local subPanel
  if 1 == tabIndex then
    subPanel = self.binder:BindComponent(TaskParentChildPage(self.ui.UI_Task_Popup_Career, self.toggleInfoMap[tabIndex].serverIdx))
  elseif 2 == tabIndex then
    subPanel = self.binder:BindComponent(TaskChallengePage(self.ui.UI_Task_Popup_PlayerLevel, self.toggleInfoMap[tabIndex].serverIdx))
  elseif 3 == tabIndex then
    subPanel = self.binder:BindComponent(TaskParentChildPage(self.ui.UI_Task_Popup_School, self.toggleInfoMap[tabIndex].serverIdx))
  end
  return subPanel
end

function TaskMainPanel:SwitchPage(tabIndex)
  if not self.toggleInfoMap[tabIndex].panelInstance then
    self.toggleInfoMap[tabIndex].panelInstance = self:CreateSubPanel(tabIndex)
  end
  self.binder:BindToVisible(self.ui.Text_Label, function()
    return false
  end)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Task, RedPointDataUtils.RedAttrType.IsNew, self.toggleInfoMap[tabIndex].serverIdx)
  self:PlaySwitchPageAnim(tabIndex)
  self.page.value = tabIndex
end

function TaskMainPanel:PlaySwitchPageAnim(tabIndex)
  local clipsToPlay = ""
  local oldPage = self.page.value
  local newPage = tabIndex
  if not oldPage then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Task_Panel_Main_New_Open")
  else
    if oldPage and self.toggleInfoMap[oldPage].closeAnimClip then
      clipsToPlay = AddClipToPlay(clipsToPlay, self.toggleInfoMap[oldPage].closeAnimClip)
    end
    if newPage and self.toggleInfoMap[newPage].enterAnimClip then
      clipsToPlay = AddClipToPlay(clipsToPlay, self.toggleInfoMap[newPage].enterAnimClip)
    end
  end
  self.uiAnimController:PlayMultiState(clipsToPlay, function()
    if oldPage and self.toggleInfoMap[oldPage].closeAnimCallback then
      self.toggleInfoMap[oldPage].closeAnimCallback()
    end
    if newPage and self.toggleInfoMap[newPage].enterAnimCallback then
      self.toggleInfoMap[newPage].enterAnimCallback()
    end
  end)
  local panel = self.toggleInfoMap[newPage].panelInstance
  if panel.OnOpen then
    panel:OnOpen()
  end
end

function TaskMainPanel:PlayCloseAnim()
  local clipsToPlay = ""
  local aniQuit = self.toggleInfoMap[self.page.value].closeAnimClip
  if aniQuit then
    clipsToPlay = AddClipToPlay(clipsToPlay, aniQuit)
  end
  self.closeBtnGO:PlayCloseAnim()
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Task_Panel_Main_New_Close")
  EventMgr.Instance.OpenAnimMask:Dispatch()
  self.uiAnimController:StopPlayableGraph()
  self.uiAnimController:PlayMultiState(clipsToPlay, function()
    self:Close()
    EventMgr.Instance.CloseAnimMask:Dispatch()
  end)
end

function TaskMainPanel:OnClose()
  UIManager.Instance:ReShowBehindPanel(self)
  self.clickClose = true
  self:PlayCloseAnim()
end

return TaskMainPanel
