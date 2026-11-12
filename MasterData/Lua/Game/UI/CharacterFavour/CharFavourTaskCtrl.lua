local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharFavourTaskCtrl = class("CharFavourTaskCtrl", BaseCtrl)
local FavourTaskState = {
  Complete = 1,
  NotComplete = 2,
  Received = 3
}
CharFavourTaskCtrl._mapNodeConfig = {
  anit_window_01 = {
    sNodeName = "t_window_01",
    sComponentName = "Animator"
  },
  got_fullscreen_blur_black = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  loopTaskList = {
    sNodeName = "TaskList",
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickGetReward"
  },
  btnReceived = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCantReward"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Affinity_Task_Receive"
  },
  txtBtnReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "Affinity_Task_Receive"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Affinity_Task_Title"
  },
  imgCharIcon = {sComponentName = "Image"}
}
CharFavourTaskCtrl._mapEventConfig = {
  [EventId.AffinityQuestReceived] = "OnEvent_AffinityQuestReceived"
}

function CharFavourTaskCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.curCharId = tbParam[1]
end

function CharFavourTaskCtrl:OnEnable()
  self._mapNode.anit_window_01:Play("t_window_04_t_in")
  self._mapNode.got_fullscreen_blur_black:SetActive(true)
  local nCharSkinId = PlayerData.Char:GetCharUsedSkinId(self.curCharId)
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
  if mapCharSkin ~= nil then
    self:SetPngSprite(self._mapNode.imgCharIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
  end
  self:OnRefreshTaskList()
end

function CharFavourTaskCtrl:OnRefreshTaskList()
  self.bHasCompleteTask = false
  self.TaskData = {}
  local affinityData = PlayerData.Char:GetCharAffinityData(self.curCharId)
  for k, v in pairs(affinityData.Quest.List) do
    local questData = PlayerData.Quest:GetAffinityQuestData(v.Id)
    local state = questData ~= nil and questData.nStatus or v.Status
    if state == 0 then
      state = FavourTaskState.NotComplete
    elseif state == 1 then
      state = FavourTaskState.Complete
      self.bHasCompleteTask = true
    else
      state = FavourTaskState.Received
    end
    local progressData = {}
    if state ~= FavourTaskState.Received then
      progressData.Cur = questData ~= nil and questData.nCurProgress or v.Progress[1].Cur
      progressData.Max = questData ~= nil and questData.nGoal or v.Progress[1].Max
    else
      progressData.Cur = 1
      progressData.Max = 1
    end
    local data = {
      taskData = ConfigTable.GetData("AffinityQuest", v.Id),
      progress = progressData,
      taskState = state
    }
    table.insert(self.TaskData, data)
  end
  self._mapNode.btnReceived.gameObject:SetActive(not self.bHasCompleteTask)
  self._mapNode.btnReceive.gameObject:SetActive(self.bHasCompleteTask)
  table.sort(self.TaskData, function(a, b)
    if a.taskState ~= b.taskState then
      return a.taskState < b.taskState
    else
      return a.taskData.SortId < b.taskData.SortId
    end
  end)
  self._mapNode.loopTaskList:SetAnim(0.07)
  self._mapNode.loopTaskList:Init(#self.TaskData, self, self.OnRefreshTaskGrid)
end

function CharFavourTaskCtrl:OnRefreshTaskGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local goGridTrans = goGrid.transform:Find("AnimRoot/Root")
  local txtRewardCount = goGridTrans:Find("txtHeartCount"):GetComponent("TMP_Text")
  local goReceived = goGrid.transform:Find("AnimRoot/imgReceived")
  local txtReceived = goReceived:Find("txtReceived"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtReceived, ConfigTable.GetUIText("CharPlot_Task_Received"))
  local imgReceiveMask = goGrid.transform:Find("AnimRoot/imgReceiveMask")
  local txtTaskDescReceived = goGridTrans:Find("txtTaskDescReceived"):GetComponent("TMP_Text")
  local txtTaskDesc = goGridTrans:Find("txtTaskDesc"):GetComponent("TMP_Text")
  local sldTask = goGridTrans:Find("sldTask"):GetComponent("Slider")
  local txtTaskProgress = goGridTrans:Find("sldTask/txtTaskProgress"):GetComponent("TMP_Text")
  local imgTaskState1 = goGridTrans:Find("imgTaskState1")
  local imgTaskState2 = goGridTrans:Find("imgTaskState2")
  local imgTaskState3 = goGridTrans:Find("imgTaskState3")
  local data = self.TaskData[index]
  imgTaskState1.gameObject:SetActive(data.taskState == FavourTaskState.NotComplete)
  imgTaskState2.gameObject:SetActive(data.taskState == FavourTaskState.Complete)
  imgTaskState3.gameObject:SetActive(data.taskState == FavourTaskState.Received)
  NovaAPI.SetSliderValue(sldTask, data.taskState == FavourTaskState.NotComplete and data.progress.Cur / data.progress.Max or 1)
  local progressTxt = data.progress.Cur .. "/" .. data.progress.Max
  NovaAPI.SetTMPText(txtTaskProgress, data.taskState == FavourTaskState.NotComplete and progressTxt or ConfigTable.GetUIText("Quest_Complete"))
  NovaAPI.SetTMPText(txtRewardCount, data.taskData.AffinityExp)
  NovaAPI.SetTMPText(txtTaskDescReceived, UTILS.ParseParamDesc(data.taskData.Desc, data.taskData))
  NovaAPI.SetTMPText(txtTaskDesc, UTILS.ParseParamDesc(data.taskData.Desc, data.taskData))
  txtTaskDesc.gameObject:SetActive(data.taskState ~= FavourTaskState.Received)
  txtTaskDescReceived.gameObject:SetActive(data.taskState == FavourTaskState.Received)
  goReceived.gameObject:SetActive(data.taskState == FavourTaskState.Received)
  imgReceiveMask.gameObject:SetActive(data.taskState == FavourTaskState.Received)
end

function CharFavourTaskCtrl:OnBtn_ClickCantReward()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Affinity_Reward_Tips"))
end

function CharFavourTaskCtrl:OnBtn_ClickGetReward()
  local data = {}
  for k, v in ipairs(self.TaskData) do
    if v.taskState == FavourTaskState.Complete then
      table.insert(data, v.taskData.Id)
    end
  end
  PlayerData.Quest:ReceiveAffinityReward(data, self.curCharId)
end

function CharFavourTaskCtrl:OnBtn_ClickClose()
  self._mapNode.anit_window_01:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen_blur_black:SetActive(false)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function CharFavourTaskCtrl:OnCloseAnimFinish()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharFavourTask)
end

function CharFavourTaskCtrl:OnEvent_AffinityQuestReceived()
  self:OnRefreshTaskList()
end

return CharFavourTaskCtrl
