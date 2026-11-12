local SoldierQuestCtrl = class("SoldierQuestCtrl", BaseCtrl)
SoldierQuestCtrl._mapNodeConfig = {
  animator = {sNodeName = "WindowRoot", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btn_close = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_QuestPanelTitle"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab1"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab2"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  btn_GetAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetReward"
  },
  txt_GetAllReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Quest_GetAllReward"
  },
  btn_GetAllReward_None = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetReward_None"
  },
  txt_GetAllReward_None = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Quest_GetAllReward"
  }
}
SoldierQuestCtrl._mapEventConfig = {}
SoldierQuestCtrl._mapRedDotConfig = {}

function SoldierQuestCtrl:Awake()
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self.nTabIndex = 1
  self.tbQuestGroup = {}
  self.tbAllQuestData = PlayerData.SoldierData:GetAllQuestData()
  self.nSelectedGroupId = 0
  self.tbQuestList = {}
end

function SoldierQuestCtrl:OnEnable()
  self:InitQuestGroup()
  self:InitTab()
  self:CheckTabPriority()
  self:SelectTab(self.nTabIndex, true)
end

function SoldierQuestCtrl:OnDisable()
end

function SoldierQuestCtrl:OnDestroy()
  if self.tbItemCtrl ~= nil then
    for _, ctrl in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
end

function SoldierQuestCtrl:CheckTabPriority()
  local bIsLockRight = PlayerData.SoldierData:IsGroupLock(self.tbQuestGroup[2])
  if bIsLockRight then
    self.nTabIndex = 1
    return
  end
  local bHasRedDotLeft = RedDotManager.GetValid(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[1])
  local bHasRedDotRight = RedDotManager.GetValid(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[2])
  if bHasRedDotLeft then
    self.nTabIndex = 1
    return
  elseif bHasRedDotRight then
    self.nTabIndex = 2
    return
  end
  local tbQuestData = PlayerData.SoldierData:GetQuestDataByGroupId(self.tbQuestGroup[1])
  self.tbQuestList = {}
  for _, questData in pairs(tbQuestData) do
    table.insert(self.tbQuestList, questData)
  end
  local nCompleteCount = 0
  for _, questData in ipairs(self.tbQuestList) do
    if questData.nStatus == AllEnum.ActQuestStatus.Received then
      nCompleteCount = nCompleteCount + 1
    end
  end
  if nCompleteCount == #self.tbQuestList then
    self.nTabIndex = 2
    return
  end
end

function SoldierQuestCtrl:InitQuestGroup()
  local function func_ForEach_QuestGroup(mapLineData)
    if mapLineData.ActivityId == self.nActId then
      table.insert(self.tbQuestGroup, mapLineData.Id)
    end
  end
  
  ForEachTableLine(DataTable.SoldierQuestGroup, func_ForEach_QuestGroup)
  table.sort(self.tbQuestGroup, function(a, b)
    return a < b
  end)
end

function SoldierQuestCtrl:InitTab()
  if #self.tbQuestGroup < 2 then
    return
  end
  local txtLeft1 = self._mapNode.btnLeft.transform:Find("AnimRoot/imgOff/txtLeft"):GetComponent("TMP_Text")
  local txtLeft2 = self._mapNode.btnLeft.transform:Find("AnimRoot/imgOn/txtLeft"):GetComponent("TMP_Text")
  local groupConfig1 = ConfigTable.GetData("SoldierQuestGroup", self.tbQuestGroup[1])
  local groupConfig2 = ConfigTable.GetData("SoldierQuestGroup", self.tbQuestGroup[2])
  NovaAPI.SetTMPText(txtLeft1, groupConfig1.Des)
  NovaAPI.SetTMPText(txtLeft2, groupConfig1.Des)
  local txtRight1 = self._mapNode.btnRight.transform:Find("AnimRoot/imgOn/txtRight"):GetComponent("TMP_Text")
  local txtRight2 = self._mapNode.btnRight.transform:Find("AnimRoot/imgOff/txtRight"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtRight1, groupConfig2.Des)
  NovaAPI.SetTMPText(txtRight2, groupConfig2.Des)
  self:RefreshRedDot()
  local bIsLockLeft = PlayerData.SoldierData:IsGroupLock(self.tbQuestGroup[1])
  local bIsLockRight = PlayerData.SoldierData:IsGroupLock(self.tbQuestGroup[2])
  self._mapNode.btnRight.transform:Find("AnimRoot/imgOff/imgLock").gameObject:SetActive(bIsLockRight)
end

function SoldierQuestCtrl:SelectTab(nTabIndex, bForce)
  if self.nTabIndex == nTabIndex and not bForce then
    return
  end
  self.nTabIndex = nTabIndex
  local imgOn1 = self._mapNode.btnLeft.transform:Find("AnimRoot/imgOn")
  local imgOff1 = self._mapNode.btnLeft.transform:Find("AnimRoot/imgOff")
  local imgOn2 = self._mapNode.btnRight.transform:Find("AnimRoot/imgOn")
  local imgOff2 = self._mapNode.btnRight.transform:Find("AnimRoot/imgOff")
  imgOn1.gameObject:SetActive(self.nTabIndex == 1)
  imgOff1.gameObject:SetActive(self.nTabIndex ~= 1)
  imgOn2.gameObject:SetActive(self.nTabIndex == 2)
  imgOff2.gameObject:SetActive(self.nTabIndex ~= 2)
  self.nSelectedGroupId = self.tbQuestGroup[self.nTabIndex]
  local tbQuestData = PlayerData.SoldierData:GetQuestDataByGroupId(self.nSelectedGroupId)
  if tbQuestData == nil then
    local actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Soldier)
    actData:RefreshAllQuestData(function()
      self:SelectTab(self.nTabIndex, true)
    end)
    return
  end
  self.tbQuestList = {}
  for _, questData in pairs(tbQuestData) do
    table.insert(self.tbQuestList, questData)
  end
  table.sort(self.tbQuestList, function(a, b)
    if a.nStatus ~= b.nStatus then
      return a.nStatus < b.nStatus
    end
    return a.nId < b.nId
  end)
  self.tbItemCtrl = {}
  self._mapNode.sv:Init(#self.tbQuestList, self, self.OnRefreshQuestGrid)
  local bHasComplete = false
  for _, questData in pairs(self.tbQuestList) do
    if questData.nStatus == AllEnum.ActQuestStatus.Complete then
      bHasComplete = true
      break
    end
  end
  self._mapNode.btn_GetAllReward.gameObject:SetActive(bHasComplete)
  self._mapNode.btn_GetAllReward_None.gameObject:SetActive(not bHasComplete)
  PlayerData.SoldierData:SetViewedGroupId(self.nSelectedGroupId)
  self:RefreshRedDot()
end

function SoldierQuestCtrl:RefreshRedDot()
  local redDotLeft = self._mapNode.btnLeft.transform:Find("AnimRoot/redDotLeft")
  local redDotRight = self._mapNode.btnRight.transform:Find("AnimRoot/redDotRight")
  RedDotManager.RegisterNode(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[1], redDotLeft.gameObject)
  RedDotManager.RegisterNode(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[2], redDotRight.gameObject)
  local redDotLeftNew = self._mapNode.btnLeft.transform:Find("AnimRoot/redDotLeftNew")
  local redDotRightNew = self._mapNode.btnRight.transform:Find("AnimRoot/redDotRightNew")
  local bHasRedDotLeft = RedDotManager.GetValid(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[1])
  local bHasRedDotRight = RedDotManager.GetValid(RedDotDefine.Solider_Quest_Group, self.tbQuestGroup[2])
  local bHasNewQuestLeft = RedDotManager.GetValid(RedDotDefine.Solider_Quest_New_Group, self.tbQuestGroup[1])
  local bHasNewQuestRight = RedDotManager.GetValid(RedDotDefine.Solider_Quest_New_Group, self.tbQuestGroup[2])
  if bHasNewQuestLeft and not bHasRedDotLeft then
    redDotLeftNew.gameObject:SetActive(true)
  else
    redDotLeftNew.gameObject:SetActive(false)
  end
  if bHasNewQuestRight and not bHasRedDotRight then
    redDotRightNew.gameObject:SetActive(true)
  else
    redDotRightNew.gameObject:SetActive(false)
  end
end

function SoldierQuestCtrl:OnRefreshQuestGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local questData = self.tbQuestList[nIndex]
  local questConfig = ConfigTable.GetData("SoldierQuest", questData.nId)
  if questConfig == nil then
    return
  end
  for i = 1, 2 do
    local index = i
    local btnItem = goGrid.transform:Find("DetailRoot/AnimRoot/btn_item" .. index):GetComponent("UIButton")
    local item = btnItem.transform:Find("AnimRoot/item")
    local instanceId = btnItem:GetInstanceID()
    if self.tbItemCtrl[instanceId] == nil then
      self.tbItemCtrl[instanceId] = self:BindCtrlByNode(item.gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
    end
    local itemId = questConfig["Reward" .. index]
    local itemCount = questConfig["RewardQty" .. index]
    if 0 < itemId then
      btnItem.gameObject:SetActive(true)
    else
      btnItem.gameObject:SetActive(false)
    end
    self.tbItemCtrl[instanceId]:SetItem(itemId, nil, itemCount, false, questData.nstatus == AllEnum.ActQuestStatus.Received, false, false)
    btnItem.onClick:RemoveAllListeners()
    btnItem.onClick:AddListener(function()
      UTILS.ClickItemGridWithTips(itemId, btnItem.transform, true, true, false)
    end)
  end
  local txt_target = goGrid.transform:Find("DetailRoot/AnimRoot/txt_target"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target, questConfig.Desc)
  local barFill = goGrid.transform:Find("DetailRoot/AnimRoot/imgBarBg/imgMainBarFill"):GetComponent("Image")
  NovaAPI.SetImageFillAmount(barFill, questData.Progress[1].Cur / questData.Progress[1].Max)
  local txt_com = goGrid.transform:Find("DetailRoot/AnimRoot/txt_com"):GetComponent("TMP_Text")
  local img_Received = goGrid.transform:Find("DetailRoot/AnimRoot/img_Received")
  img_Received.gameObject:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Received)
  if questData.nStatus == AllEnum.ActQuestStatus.UnComplete then
    NovaAPI.SetImageFillAmount(barFill, questData.Progress[1].Cur / questData.Progress[1].Max)
    NovaAPI.SetTMPText(txt_com, string.format("%d/%d", questData.Progress[1].Cur, questData.Progress[1].Max))
  else
    NovaAPI.SetImageFillAmount(barFill, 1)
    NovaAPI.SetTMPText(txt_com, ConfigTable.GetUIText("Soldier_Quest_Complete"))
  end
  local btn_JumpTo = goGrid.transform:Find("DetailRoot/AnimRoot/btn_JumpTo"):GetComponent("UIButton")
  local txt_JumpTo = btn_JumpTo.transform:Find("AnimRoot/txtBtn"):GetComponent("TMP_Text")
  local btn_GetReward = goGrid.transform:Find("DetailRoot/AnimRoot/btn_GetReward"):GetComponent("UIButton")
  local txt_GetReward = btn_GetReward.transform:Find("AnimRoot/txtBtn"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_JumpTo, ConfigTable.GetUIText("Soldier_Quest_JumpTo"))
  NovaAPI.SetTMPText(txt_GetReward, ConfigTable.GetUIText("Soldier_Quest_Receive"))
  btn_JumpTo.gameObject:SetActive(questData.nStatus == AllEnum.ActQuestStatus.UnComplete)
  btn_JumpTo.onClick:RemoveAllListeners()
  btn_JumpTo.onClick:AddListener(function()
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierLevelSelectPanel)
    self:OnBtnClick_Close()
  end)
  btn_GetReward.gameObject:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Complete)
  btn_GetReward.onClick:RemoveAllListeners()
  btn_GetReward.onClick:AddListener(function()
    PlayerData.SoldierData:ReceiveQuestReward(self.nSelectedGroupId, questData.nId, function()
      self:SelectTab(self.nTabIndex, true)
    end)
  end)
end

function SoldierQuestCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierQuestPanel)
  end, true, true, true)
end

function SoldierQuestCtrl:OnBtnClick_GetReward()
  PlayerData.SoldierData:ReceiveQuestReward(self.nSelectedGroupId, 0, function()
    self:SelectTab(self.nTabIndex, true)
  end)
end

function SoldierQuestCtrl:OnBtnClick_GetReward_None()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Quest_ReceiveNone"))
end

function SoldierQuestCtrl:OnBtnClick_Tab1()
  if PlayerData.SoldierData:IsGroupLock(self.tbQuestGroup[1]) then
    return
  end
  self:SelectTab(1)
end

function SoldierQuestCtrl:OnBtnClick_Tab2()
  if PlayerData.SoldierData:IsGroupLock(self.tbQuestGroup[2]) then
    return
  end
  self:SelectTab(2)
end

return SoldierQuestCtrl
