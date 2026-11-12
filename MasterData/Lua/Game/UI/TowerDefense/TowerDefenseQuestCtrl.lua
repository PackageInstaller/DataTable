local TowerDefenseQuestCtrl = class("TowerDefenseQuestCtrl", BaseCtrl)
local barMinX = -622
local barMaxX = 0
TowerDefenseQuestCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_QuestPanelTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnAllClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btn_GetReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetAllReward"
  },
  btn_GetReward_None = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetAllReward_None"
  },
  txt_getAllReward = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Quest_GetAllReward"
  },
  Group_loop_sv = {
    sNodeName = "sv_group",
    sComponentName = "LoopScrollView"
  },
  Quest_loop_sv = {
    sNodeName = "sv_quest",
    sComponentName = "LoopScrollView"
  },
  title_process = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_QuestPanel_CurProcess"
  },
  txt_GroupProcess = {sComponentName = "TMP_Text"},
  imgGroupProcessBarFill = {
    sComponentName = "RectTransform"
  },
  animator = {sNodeName = "Quest", sComponentName = "Animator"}
}
TowerDefenseQuestCtrl._mapEventConfig = {
  TowerDefenseQuestReceived = "OnEvent_QuestUpdate"
}
TowerDefenseQuestCtrl._mapRedDotConfig = {}

function TowerDefenseQuestCtrl:Awake()
  self.tbQuestGridCtrl = {}
  local param = self:GetPanelParam()
  local actId
  if type(param) == "table" then
    actId = param[1]
  end
  if actId ~= nil then
    self:SetData(actId, false)
  end
end

function TowerDefenseQuestCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:PlayAnim_In()
end

function TowerDefenseQuestCtrl:OnDisable()
  if self.tbQuestGridCtrl ~= nil then
    for _, ctrl in pairs(self.tbQuestGridCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbQuestGridCtrl = {}
end

function TowerDefenseQuestCtrl:OnDestroy()
end

function TowerDefenseQuestCtrl:PlayAnim_In()
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function TowerDefenseQuestCtrl:SetData(nActId, bIsSubPanel)
  self.bIsSubPanel = bIsSubPanel
  self.nActId = nActId
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.nSelecedGroupId = 0
  self.tbGroup = {}
  self.tbGroupConfig = {}
  
  local function foreachQuestGroup(data)
    if data.ActivityId == self.nActId then
      table.insert(self.tbGroup, data.Id)
      self.tbGroupConfig[data.Id] = data
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseQuestGroup, foreachQuestGroup)
  table.sort(self.tbGroup, function(a, b)
    return a < b
  end)
  local nSelectIndex = 1
  for i, v in ipairs(self.tbGroup) do
    local bRed = RedDotManager.GetValid(RedDotDefine.Activity_TowerDefense_QuestGroup, {v})
    if bRed then
      nSelectIndex = i
      break
    end
  end
  self.nSelecedGroupId = self.tbGroup[nSelectIndex]
  self._mapNode.Group_loop_sv:Init(#self.tbGroup, self, self.OnRefreshGroupGrid)
  self:UpdateQuestList(self.nSelecedGroupId)
end

function TowerDefenseQuestCtrl:UpdateQuestList(nGroupId)
  local tbQuest = self.TowerDefenseData:GetQuestbyGroupId(nGroupId)
  self.questList = {}
  for _, value in pairs(tbQuest) do
    table.insert(self.questList, value)
  end
  
  local function sortFunc(a, b)
    if a.nState ~= b.nState then
      return a.nState < b.nState
    end
    return a.nId < b.nId
  end
  
  table.sort(self.questList, sortFunc)
  local nFinishCount = self.TowerDefenseData:GetGroupQuestReceiveCount(nGroupId)
  self._mapNode.Quest_loop_sv:Init(#self.questList, self, self.OnRefreshQuestGrid)
  NovaAPI.SetTMPText(self._mapNode.txt_GroupProcess, string.format("%d/%d", nFinishCount, #self.questList))
  self._mapNode.imgGroupProcessBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (nFinishCount / #self.questList), self._mapNode.imgGroupProcessBarFill.anchoredPosition.y)
  local bHasFinish = false
  for _, questData in ipairs(self.questList) do
    if questData.nState == AllEnum.ActQuestStatus.Complete then
      bHasFinish = true
      break
    end
  end
  self._mapNode.btn_GetReward.gameObject:SetActive(bHasFinish)
  self._mapNode.btn_GetReward_None.gameObject:SetActive(not bHasFinish)
end

function TowerDefenseQuestCtrl:OnRefreshGroupGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local txtName = goGrid.transform:Find("btnGrid/AnimRoot/txt_Name")
  NovaAPI.SetTMPText(txtName:GetComponent("TMP_Text"), self.tbGroupConfig[self.tbGroup[nIndex]].GroupName)
  local nFinishCount = self.TowerDefenseData:GetGroupQuestReceiveCount(self.tbGroup[nIndex])
  local nAllCount = 0
  for _, value in pairs(self.TowerDefenseData:GetQuestbyGroupId(self.tbGroup[nIndex])) do
    nAllCount = nAllCount + 1
  end
  local txtCount = goGrid.transform:Find("btnGrid/AnimRoot/txt_Process")
  NovaAPI.SetTMPText(txtCount:GetComponent("TMP_Text"), string.format("%d/%d", nFinishCount, nAllCount))
  local goSelected = goGrid.transform:Find("btnGrid/AnimRoot/img_selected")
  goSelected.gameObject:SetActive(self.tbGroup[nIndex] == self.nSelecedGroupId)
  if self.tbGroup[nIndex] == self.nSelecedGroupId then
    self.selectedGrid = goGrid
  end
  local reddot = goGrid.transform:Find("btnGrid/AnimRoot/reddot")
  RedDotManager.RegisterNode(RedDotDefine.Activity_TowerDefense_QuestGroup, {
    self.tbGroup[nIndex]
  }, reddot, nil, nil, true)
  local go_Button = goGrid.transform:Find("btnGrid")
  local btn_Select = go_Button:GetComponent("UIButton")
  btn_Select.onClick:RemoveAllListeners()
  local nGroupId = self.tbGroup[nIndex]
  btn_Select.onClick:AddListener(function()
    if self.selectedGrid ~= nil then
      local oldGoSelected = self.selectedGrid.transform:Find("btnGrid/AnimRoot/img_selected")
      oldGoSelected.gameObject:SetActive(false)
    end
    self.nSelecedGroupId = nGroupId
    self.selectedGrid = goGrid
    goSelected.gameObject:SetActive(true)
    self:UpdateQuestList(self.nSelecedGroupId)
  end)
end

function TowerDefenseQuestCtrl:OnRefreshQuestGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbQuestGridCtrl[nInstanceId] then
    self.tbQuestGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TowerDefense.TowerDefenseQuestCellCtrl")
  end
  self.tbQuestGridCtrl[nInstanceId]:SetData(self.nActId, self.questList[nIndex])
end

function TowerDefenseQuestCtrl:OnBtnClick_GetAllReward()
  if not self.TowerDefenseData:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_End_Notice"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    })
    return
  end
  self.TowerDefenseData:RequestReceiveQuest(self.nSelecedGroupId, 0)
end

function TowerDefenseQuestCtrl:OnBtnClick_GetAllReward_None()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDefense_Quest_ReceiveNone"))
end

function TowerDefenseQuestCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    if self.bIsSubPanel then
      EventManager.Hit("CloseTowerDefenseQuestPanel")
    else
      EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseQuest)
    end
  end, true, true, true)
end

function TowerDefenseQuestCtrl:OnEvent_QuestUpdate()
  self._mapNode.Group_loop_sv:Init(#self.tbGroup, self, self.OnRefreshGroupGrid)
  self:UpdateQuestList(self.nSelecedGroupId)
end

return TowerDefenseQuestCtrl
