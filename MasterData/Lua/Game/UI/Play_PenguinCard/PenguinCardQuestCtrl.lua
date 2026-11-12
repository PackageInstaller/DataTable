local PenguinCardQuestCtrl = class("PenguinCardQuestCtrl", BaseCtrl)
PenguinCardQuestCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Title_Quest"
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
    sLanguageId = "PenguinCard_Btn_GetAllReward"
  },
  Group_loop_sv = {
    sNodeName = "sv_group",
    sComponentName = "LoopScrollView"
  },
  Quest_loop_sv = {
    sNodeName = "sv_quest",
    sComponentName = "LoopScrollView"
  },
  trGroupSv = {sNodeName = "sv_group", sComponentName = "Transform"},
  title_process = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_CurProcess"
  },
  txt_GroupProcess = {sComponentName = "TMP_Text"},
  imgGroupProcessBarFill = {
    sComponentName = "RectTransform"
  },
  animator = {sNodeName = "Quest", sComponentName = "Animator"}
}
PenguinCardQuestCtrl._mapEventConfig = {PenguinCardRefreshQuest = "Refresh"}
PenguinCardQuestCtrl._mapRedDotConfig = {}

function PenguinCardQuestCtrl:Awake()
  self.tbQuestGridCtrl = {}
  local param = self:GetPanelParam()
  local actId
  if type(param) == "table" then
    actId = param[1]
  end
  if actId ~= nil then
    self:InitData(actId)
    self:Refresh()
  end
end

function PenguinCardQuestCtrl:OnEnable()
  self._mapNode.blur:SetActive(true)
  self:PlayAnim_In()
end

function PenguinCardQuestCtrl:OnDisable()
  if self.tbQuestGridCtrl ~= nil then
    for _, ctrl in pairs(self.tbQuestGridCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbQuestGridCtrl = {}
end

function PenguinCardQuestCtrl:OnDestroy()
end

function PenguinCardQuestCtrl:PlayAnim_In()
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function PenguinCardQuestCtrl:InitData(nActId)
  self.nActId = nActId
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.tbGroup = self.actData:GetQuestGroup()
  self.nSelectIndex = 1
  for i, v in ipairs(self.tbGroup) do
    local bRed = RedDotManager.GetValid(RedDotDefine.Activity_PenguinCard_QuestGroup, {v})
    if bRed then
      self.nSelectIndex = i
      break
    end
  end
  self.nSelecedGroupId = self.tbGroup[self.nSelectIndex]
end

function PenguinCardQuestCtrl:Refresh()
  self._mapNode.Group_loop_sv:Init(#self.tbGroup, self, self.OnRefreshGroupGrid, self.OnClickGroupGrid)
  self:RefreshQuestList(self.nSelecedGroupId)
end

function PenguinCardQuestCtrl:RefreshQuestList(nGroupId)
  local tbQuest = self.actData:GetQuestbyGroupId(nGroupId)
  self.questList = {}
  for _, v in pairs(tbQuest) do
    local mapData = self.actData:GetQuestData(v)
    table.insert(self.questList, mapData)
  end
  
  local function sortFunc(a, b)
    if a.nStatus ~= b.nStatus then
      return a.nStatus < b.nStatus
    end
    return a.nId < b.nId
  end
  
  table.sort(self.questList, sortFunc)
  local nFinishCount = self.actData:GetGroupQuestReceiveCount(nGroupId)
  local nQuestCount = #self.questList
  self._mapNode.Quest_loop_sv:SetAnim(0.08)
  self._mapNode.Quest_loop_sv:Init(nQuestCount, self, self.OnRefreshQuestGrid)
  NovaAPI.SetTMPText(self._mapNode.txt_GroupProcess, string.format("%d/%d", nFinishCount, nQuestCount))
  self._mapNode.imgGroupProcessBarFill.sizeDelta = Vector2(nFinishCount / nQuestCount * 642.67, 28)
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

function PenguinCardQuestCtrl:OnRefreshGroupGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nGroupId = self.tbGroup[nIndex]
  local txtName = goGrid.transform:Find("btnGrid/AnimRoot/txt_Name"):GetComponent("TMP_Text")
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardQuestGroup", nGroupId)
  if mapCfg then
    NovaAPI.SetTMPText(txtName, mapCfg.GroupName)
  end
  local nFinishCount = self.actData:GetGroupQuestReceiveCount(nGroupId)
  local tbQuest = self.actData:GetQuestbyGroupId(nGroupId)
  local nAllCount = #tbQuest
  local txtCount = goGrid.transform:Find("btnGrid/AnimRoot/txt_Process"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtCount, string.format("%d/%d", nFinishCount, nAllCount))
  local goSelected = goGrid.transform:Find("btnGrid/AnimRoot/img_selected")
  goSelected.gameObject:SetActive(nGroupId == self.nSelecedGroupId)
  local reddot = goGrid.transform:Find("btnGrid/AnimRoot/reddot")
  RedDotManager.RegisterNode(RedDotDefine.Activity_PenguinCard_QuestGroup, {nGroupId}, reddot, nil, nil, true)
end

function PenguinCardQuestCtrl:OnClickGroupGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nSelectIndex == nIndex then
    return
  end
  if self.nSelectIndex then
    local goSelect = self._mapNode.trGroupSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      local oldGoSelected = goSelect:Find("btnGrid/AnimRoot/img_selected")
      oldGoSelected.gameObject:SetActive(false)
    end
  end
  self.nSelectIndex = nIndex
  self.nSelecedGroupId = self.tbGroup[self.nSelectIndex]
  local goSelected = goGrid.transform:Find("btnGrid/AnimRoot/img_selected")
  goSelected.gameObject:SetActive(true)
  self:RefreshQuestList(self.nSelecedGroupId)
end

function PenguinCardQuestCtrl:OnRefreshQuestGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbQuestGridCtrl[nInstanceId] then
    self.tbQuestGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Play_PenguinCard.PenguinCardQuestCellCtrl")
  end
  self.tbQuestGridCtrl[nInstanceId]:Refresh(self.nActId, self.questList[nIndex])
end

function PenguinCardQuestCtrl:OnBtnClick_GetAllReward()
  local function callback()
    self:Refresh()
  end
  
  self.actData:SendActivityPenguinCardQuestReceiveReq(0, self.nSelecedGroupId, callback)
end

function PenguinCardQuestCtrl:OnBtnClick_GetAllReward_None()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PenguinCard_Quest_ReceiveNone"))
end

function PenguinCardQuestCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.PenguinCardQuest)
  end, true, true, true)
end

return PenguinCardQuestCtrl
