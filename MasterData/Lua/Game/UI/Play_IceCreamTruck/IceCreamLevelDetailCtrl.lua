local IceCreamLevelDetailCtrl = class("IceCreamLevelDetailCtrl", BaseCtrl)
IceCreamLevelDetailCtrl._mapNodeConfig = {
  btn_ClosePanel = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClosePanel"
  },
  btn_tag = {
    nCount = 2,
    sNodeName = "btn_tag",
    sComponentName = "UIButton",
    callback = "OnBtn_SwitchTag"
  },
  txt_UnSelect = {sComponentName = "TMP_Text"},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_LevelName = {sComponentName = "TMP_Text"},
  txt_detailDesc = {sComponentName = "TMP_Text"},
  obj_MaxScore = {},
  txt_ScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_MaxScore"
  },
  txt_MaxScore = {sComponentName = "TMP_Text"},
  obj_Target = {},
  txt_TitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_LevelTarget"
  },
  obj_Task = {nCount = 2, sNodeName = "obj_Task"},
  txtTask = {nCount = 2, sComponentName = "TMP_Text"},
  txt_Reward = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_LevelAward"
  },
  item = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btn_item = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  LevelState = {},
  btn_Go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Open"
  },
  btn_Next = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  txtBtnNext = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_NextIsland"
  },
  levelLockRoot = {},
  UnlockTime = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_LevelLockPreTip"
  }
}
IceCreamLevelDetailCtrl._mapEventConfig = {}

function IceCreamLevelDetailCtrl:Awake()
end

function IceCreamLevelDetailCtrl:FadeIn()
end

function IceCreamLevelDetailCtrl:FadeOut()
end

function IceCreamLevelDetailCtrl:OnEnable()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function IceCreamLevelDetailCtrl:Open(nActId, nIndex)
  self.gameObject:SetActive(true)
  self.LevelType = nIndex
  self.nActId = nActId
  self.IceCreamActData = PlayerData.Activity:GetActivityDataById(nActId)
  if self.IceCreamActData == nil then
    printError("没有冰淇淋活动数据")
    self.gameObject:SetActive(false)
    return
  end
  self:InitPanel()
end

function IceCreamLevelDetailCtrl:InitPanel()
  self.tbLevels = self.IceCreamActData:GetLevelsByType(self.LevelType)
  if not self.tbLevels then
    printError("没有对应的关卡类型")
    return
  end
  for i = 1, 2 do
    local levelId = self.tbLevels[i]
    if levelId ~= nil then
      self._mapNode.btn_tag[i].gameObject:SetActive(true)
      self:RegisterNewRedNode(self._mapNode.btn_tag[i].gameObject.transform, self.nActId, self.LevelType, levelId)
    else
      self._mapNode.btn_tag[i].gameObject:SetActive(false)
    end
  end
  self:SetCurTag()
  self:RefreshPanel()
end

function IceCreamLevelDetailCtrl:SetCurTag()
  if self.tbLevels ~= nil and #self.tbLevels == 2 then
    local bCompleteLevel_1 = self.IceCreamActData:GetLevelData(self.tbLevels[1]).bFirstComplete
    local bCompleteLevel_2 = self.IceCreamActData:GetLevelData(self.tbLevels[2]).bFirstComplete
    if bCompleteLevel_1 ~= bCompleteLevel_2 then
      self.nCurTag = 2
    elseif bCompleteLevel_1 == bCompleteLevel_2 and bCompleteLevel_2 then
      self.nCurTag = 2
    else
      self.nCurTag = 1
    end
  else
    self.nCurTag = 1
  end
end

function IceCreamLevelDetailCtrl:RefreshPanel()
  self.curLevelId = self.tbLevels[self.nCurTag]
  self.CurrentMapData = self.IceCreamActData:GetLevelMapData(self.curLevelId)
  self:RefreshTagState()
  self:RefreshData()
  self:RefreshReward()
  self:RefreshButton()
  self:RefreshLevelRedDot(self.nCurTag)
end

function IceCreamLevelDetailCtrl:RefreshReward()
  self.tbReward = {}
  for i = 1, 4 do
    local nRewardId = self.CurrentMapData["FirstCompleteReward" .. i .. "Tid"]
    local nRewardQty = self.CurrentMapData["FirstCompleteReward" .. i .. "Qty"]
    if nRewardId ~= nil and 0 < nRewardId and nRewardQty ~= nil and 0 < nRewardQty then
      table.insert(self.tbReward, {nRewardId, nRewardQty})
      self._mapNode.btn_item[i].gameObject:SetActive(true)
    else
      self._mapNode.btn_item[i].gameObject:SetActive(false)
    end
  end
  local bIsComplete = self.IceCreamActData:GetLevelData(self.curLevelId).bFirstComplete
  for k, v in pairs(self.tbReward) do
    self._mapNode.item[k]:SetItem(v[1], nil, v[2], nil, bIsComplete)
  end
end

function IceCreamLevelDetailCtrl:RefreshButton()
  local bIsPreLock = false
  local bIsUnlockIsland = false
  if self.IceCreamActData:CheckLevelLockByPrev(self.curLevelId) then
    bIsPreLock = true
  end
  if self.tbLevels[2] ~= nil and self.IceCreamActData:GetLevelData(self.tbLevels[2]).bFirstComplete and not self.IceCreamActData:GetNextIslandIsLock(self.LevelType) then
    bIsUnlockIsland = true
  end
  self._mapNode.LevelState:SetActive(not bIsPreLock)
  self._mapNode.levelLockRoot:SetActive(bIsPreLock)
  self._mapNode.btn_Next.gameObject:SetActive(bIsUnlockIsland)
end

function IceCreamLevelDetailCtrl:RefreshTagState()
  if not self.nCurTag then
    self.nCurTag = 1
  end
  for key, tag in ipairs(self._mapNode.btn_tag) do
    local obj_Select = tag.gameObject.transform:Find("AnimRoot/obj_Select")
    local obj_UnSelect = tag.gameObject.transform:Find("AnimRoot/obj_UnSelect")
    obj_Select.gameObject:SetActive(key == self.nCurTag)
    obj_UnSelect.gameObject:SetActive(key ~= self.nCurTag)
  end
end

function IceCreamLevelDetailCtrl:RefreshData()
  if self.CurrentMapData then
    NovaAPI.SetTMPText(self._mapNode.txt_LevelName, self.CurrentMapData.Name)
    NovaAPI.SetTMPText(self._mapNode.txt_detailDesc, self.CurrentMapData.Des)
    if self.CurrentMapData.PassScoreDes == "" then
      self._mapNode.obj_Task[1]:SetActive(false)
    else
      self._mapNode.obj_Task[1]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTask[1], self.CurrentMapData.PassScoreDes)
    end
    if self.CurrentMapData.OrderNumDes == "" then
      self._mapNode.obj_Task[2]:SetActive(false)
    else
      self._mapNode.obj_Task[2]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTask[2], self.CurrentMapData.OrderNumDes)
    end
  end
  local bIsInfinite = self.LevelType == GameEnum.ActivityIceCreamLevelType.Infinite
  self._mapNode.obj_MaxScore:SetActive(bIsInfinite)
  if bIsInfinite then
    local MaxScore = self.IceCreamActData:GetLevelMaxScore(self.curLevelId)
    NovaAPI.SetTMPText(self._mapNode.txt_MaxScore, MaxScore)
  end
  self._mapNode.obj_Target:SetActive(not bIsInfinite)
end

function IceCreamLevelDetailCtrl:RefreshLevelRedDot(nIndex)
  self.IceCreamActData:SetLevelNew(self.LevelType, self.tbLevels[nIndex])
  self.IceCreamActData:RefreshLevelRedDot()
end

function IceCreamLevelDetailCtrl:OnDisable()
  self:UnRegisterNewRedNode()
end

function IceCreamLevelDetailCtrl:OnDestroy()
end

function IceCreamLevelDetailCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nRewardId
  if self.tbReward ~= nil and self.tbReward[nIndex] ~= nil then
    nRewardId = self.tbReward[nIndex][1]
  end
  if nRewardId ~= nil then
    UTILS.ClickItemGridWithTips(nRewardId, btn.transform, true, true, false)
  end
end

function IceCreamLevelDetailCtrl:OnBtn_SwitchTag(btn, nIndex)
  if nIndex == self.nCurTag then
    return
  end
  self.nCurTag = nIndex
  self:RefreshLevelRedDot(nIndex)
  self:RefreshPanel()
end

function IceCreamLevelDetailCtrl:OnBtn_ClosePanel()
  self.gameObject:SetActive(false)
  EventManager.Hit("Event_CloseLevelDetail", self.LevelType)
end

function IceCreamLevelDetailCtrl:OnBtnClick_Next()
  self.gameObject:SetActive(false)
  EventManager.Hit("Event_ChangeNextDetail", self.LevelType, self.LevelType + 1)
end

function IceCreamLevelDetailCtrl:OnBtnClick_Go()
  self.gameObject:SetActive(false)
  EventManager.Hit(EventId.OpenPanel, PanelId.IceCreamTruckGamePanel, self.nActId, self.curLevelId)
end

function IceCreamLevelDetailCtrl:RegisterNewRedNode(trTag, nActId, nIndex, nLevel)
  local objRed = trTag:Find("AnimRoot/redH")
  RedDotManager.RegisterNode(RedDotDefine.Activity_IceCreamTruck_NewLevel, {
    nActId,
    nIndex,
    nLevel
  }, objRed)
end

function IceCreamLevelDetailCtrl:UnRegisterNewRedNode()
  for i = 1, 2 do
    local objRed = self._mapNode.btn_tag[i] and self._mapNode.btn_tag[i].gameObject.transform:Find("AnimRoot/redH")
    if objRed then
      RedDotManager.UnRegisterNode(RedDotDefine.Activity_IceCreamTruck_NewLevel, {
        nActId,
        nIndex,
        nLevel
      }, objRed)
    end
  end
end

return IceCreamLevelDetailCtrl
