local MiningGameQuestCtrl = class("MiningGameQuestCtrl", BaseCtrl)
local barMinX = -622
local barMaxX = 0
MiningGameQuestCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MiningGame_QuestPanelTitle"
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
    sLanguageId = "MiningGame_Quest_GetAllReward"
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
    sLanguageId = "MiningGame_QuestPanel_CurProcess"
  },
  txt_GroupProcess = {sComponentName = "TMP_Text"},
  imgGroupProcessBarFill = {
    sComponentName = "RectTransform"
  },
  animator = {sNodeName = "Quest", sComponentName = "Animator"}
}
MiningGameQuestCtrl._mapEventConfig = {
  MiningQuestUpdate = "OnEvent_QuestUpdate"
}
MiningGameQuestCtrl._mapRedDotConfig = {}

function MiningGameQuestCtrl:Awake()
  self.tbQuestGridCtrl = {}
  local param = self:GetPanelParam()
  local actId
  if type(param) == "table" then
    actId = param[1]
  end
  self:SetData(actId)
end

function MiningGameQuestCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:PlayAnim_In()
end

function MiningGameQuestCtrl:OnDisable()
  if self.tbQuestGridCtrl ~= nil then
    for _, ctrl in pairs(self.tbQuestGridCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbQuestGridCtrl = {}
end

function MiningGameQuestCtrl:OnDestroy()
end

function MiningGameQuestCtrl:PlayAnim_In()
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function MiningGameQuestCtrl:SetData(nActId)
  self.nActId = nActId
  self.MiningGameData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.nSelectedGroupId = 0
  self.tbGroup = self.MiningGameData:GetAllGroupId()
  table.sort(self.tbGroup, function(a, b)
    return a < b
  end)
  local nSelectIndex = 1
  for i, v in ipairs(self.tbGroup) do
    local bRed = RedDotManager.GetValid(RedDotDefine.Activity_Mining_QuestGroup, {v})
    if bRed then
      nSelectIndex = i
      break
    end
  end
  self.nSelectedGroupId = self.tbGroup[nSelectIndex]
  self._mapNode.Group_loop_sv:Init(#self.tbGroup, self, self.OnRefreshGroupGrid)
  self:UpdateQuestList(self.nSelectedGroupId)
end

function MiningGameQuestCtrl:UpdateQuestList(nGroupId)
  self.questList = self.MiningGameData:GetQuestbyGroupId(nGroupId)
  if self.questList == nil then
    return
  end
  
  local function sortFunc(a, b)
    if a.nStatus ~= b.nStatus then
      return a.nStatus < b.nStatus
    end
    return a.nId < b.nId
  end
  
  table.sort(self.questList, sortFunc)
  local nFinishCount = self.MiningGameData:GetGroupQuestReceiveCount(nGroupId)
  self._mapNode.Quest_loop_sv:Init(#self.questList, self, self.OnRefreshQuestGrid)
  NovaAPI.SetTMPText(self._mapNode.txt_GroupProcess, string.format("%d/%d", nFinishCount, #self.questList))
  self._mapNode.imgGroupProcessBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (nFinishCount / #self.questList), self._mapNode.imgGroupProcessBarFill.anchoredPosition.y)
  local bHasFinish = false
  for _, questData in ipairs(self.questList) do
    if questData.nStatus == AllEnum.ActQuestStatus.Complete then
      bHasFinish = true
      break
    end
  end
  self._mapNode.btn_GetReward.gameObject:SetActive(bHasFinish)
  self._mapNode.btn_GetReward_None.gameObject:SetActive(not bHasFinish)
end

function MiningGameQuestCtrl:OnRefreshGroupGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local txtName = goGrid.transform:Find("btnGrid/AnimRoot/txt_Name")
  local config = ConfigTable.GetData("MiningQuestGroup", self.tbGroup[nIndex])
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(txtName:GetComponent("TMP_Text"), config.GroupName)
  local nFinishCount = self.MiningGameData:GetGroupQuestReceiveCount(self.tbGroup[nIndex])
  local nAllCount = 0
  for _, value in pairs(self.MiningGameData:GetQuestbyGroupId(self.tbGroup[nIndex])) do
    nAllCount = nAllCount + 1
  end
  local txtCount = goGrid.transform:Find("btnGrid/AnimRoot/txt_Process")
  NovaAPI.SetTMPText(txtCount:GetComponent("TMP_Text"), string.format("%d/%d", nFinishCount, nAllCount))
  local goSelected = goGrid.transform:Find("btnGrid/AnimRoot/img_selected")
  goSelected.gameObject:SetActive(self.tbGroup[nIndex] == self.nSelectedGroupId)
  if self.tbGroup[nIndex] == self.nSelectedGroupId then
    self.selectedGrid = goGrid
  end
  local reddot = goGrid.transform:Find("btnGrid/AnimRoot/reddot")
  RedDotManager.RegisterNode(RedDotDefine.Activity_Mining_QuestGroup, {
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
    self.nSelectedGroupId = nGroupId
    self.selectedGrid = goGrid
    goSelected.gameObject:SetActive(true)
    self:UpdateQuestList(self.nSelectedGroupId)
  end)
end

function MiningGameQuestCtrl:OnRefreshQuestGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbQuestGridCtrl[nInstanceId] then
    self.tbQuestGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.Mining.MiningQuestCellCtrl")
  end
  self.tbQuestGridCtrl[nInstanceId]:SetData(self.nActId, self.questList[nIndex])
end

function MiningGameQuestCtrl:OnBtnClick_GetAllReward()
  self.MiningGameData:SendQuestReceive(0, self.nSelectedGroupId)
end

function MiningGameQuestCtrl:OnBtnClick_GetAllReward_None()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDefense_Quest_ReceiveNone"))
end

function MiningGameQuestCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  end, true, true, true)
end

function MiningGameQuestCtrl:OnEvent_QuestUpdate()
  self._mapNode.Group_loop_sv:Init(#self.tbGroup, self, self.OnRefreshGroupGrid)
  self:UpdateQuestList(self.nSelectedGroupId)
end

return MiningGameQuestCtrl
