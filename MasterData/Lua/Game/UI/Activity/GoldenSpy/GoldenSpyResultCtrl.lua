local GoldenSpyResultCtrl = class("GoldenSpyResultCtrl", BaseCtrl)
GoldenSpyResultCtrl._mapNodeConfig = {
  txt_title = {nCount = 2, sComponentName = "TMP_Text"},
  txt_titleShadow = {nCount = 2, sComponentName = "TMP_Text"},
  btn_finish1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Finish"
  },
  txt_finish1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_Finish"
  },
  btn_finish2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Finish"
  },
  txt_finish2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_LevelFinish"
  },
  GoNextRoot = {},
  txtTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_Tip"
  },
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_Tip"
  },
  btn_goNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoNext"
  },
  txt_goNext = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_GoNext"
  },
  txt_ttTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_TotalTargetTitle"
  },
  txt_ttValue = {sComponentName = "TMP_Text"},
  img_finish = {},
  FinishRoot = {},
  btn_goNext2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoNext2"
  },
  txt_goNext2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Result_GoNext2"
  }
}
GoldenSpyResultCtrl._mapEventConfig = {}
GoldenSpyResultCtrl._mapRedDotConfig = {}

function GoldenSpyResultCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.data = tbParam[1]
    self.nActId = tbParam[2]
  end
  self.bResult = self.data.bResult
  self.nLevelId = self.data.nLevelId
  self.nCurFloorId = self.data.nCurFloorId
  self.nFloor = self.data.nFloor
  self.nTotalFloor = self.data.nTotalFloor
  self.nCurScore = self.data.nCurScore
  self.finishCallback = self.data.finishCallback
  self.goNextCallback = self.data.goNextCallback
  self.bSuccess = self.data.bSuccess
  self.goNextLevelCallback = self.data.goNextLevelCallback
  self.levelCfg = ConfigTable.GetData("GoldenSpyLevel", self.nLevelId)
  self.floorCfg = ConfigTable.GetData("GoldenSpyFloor", self.nCurFloorId)
  self._mapNode.GoNextRoot:SetActive(not self.bResult)
  self:SetFinishActive(self.bResult)
  self:SetContent()
  if self.bSuccess then
    for i, v in ipairs(self._mapNode.txt_title) do
      NovaAPI.SetTMPText(v, ConfigTable.GetUIText("GoldenSpy_Result_Title"))
    end
    for i, v in ipairs(self._mapNode.txt_titleShadow) do
      NovaAPI.SetTMPText(v, ConfigTable.GetUIText("GoldenSpy_Result_Title"))
    end
  else
    for i, v in ipairs(self._mapNode.txt_title) do
      NovaAPI.SetTMPText(v, ConfigTable.GetUIText("GoldenSpy_Result_Failure"))
    end
    for i, v in ipairs(self._mapNode.txt_titleShadow) do
      NovaAPI.SetTMPText(v, ConfigTable.GetUIText("GoldenSpy_Result_Failure"))
    end
  end
end

function GoldenSpyResultCtrl:OnEnable()
end

function GoldenSpyResultCtrl:OnDisable()
end

function GoldenSpyResultCtrl:OnDestroy()
end

function GoldenSpyResultCtrl:SetContent()
  self:SetGoNextTarget()
  self:SetFinishTarget()
end

function GoldenSpyResultCtrl:SetGoNextTarget()
  NovaAPI.SetTMPText(self._mapNode.txt_ttValue, tostring(self.levelCfg.Score))
  self._mapNode.img_finish:SetActive(self.nCurScore >= self.levelCfg.Score)
  local goNext = self._mapNode.GoNextRoot
  local target1 = goNext.transform:Find("AnimRoot/target1")
  local txt_target1 = target1.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value1 = target1.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target1, ConfigTable.GetUIText("GoldenSpy_Result_GoNextTarget1"))
  NovaAPI.SetTMPText(txt_value1, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue2"), self.floorCfg.GoalScore))
  local target2 = goNext.transform:Find("AnimRoot/target2")
  local txt_target2 = target2.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value2 = target2.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target2, ConfigTable.GetUIText("GoldenSpy_Result_GoNextTarget2"))
  NovaAPI.SetTMPText(txt_value2, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue2"), self.nCurScore))
end

function GoldenSpyResultCtrl:SetFinishTarget()
  local finish = self._mapNode.FinishRoot
  local target1 = finish.transform:Find("AnimRoot/target1")
  local txt_target1 = target1.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value1 = target1.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target1, ConfigTable.GetUIText("GoldenSpy_Result_FinishTarget1"))
  NovaAPI.SetTMPText(txt_value1, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue1"), self.nTotalFloor))
  local target2 = finish.transform:Find("AnimRoot/target2")
  local txt_target2 = target2.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value2 = target2.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target2, ConfigTable.GetUIText("GoldenSpy_Result_FinishTarget2"))
  NovaAPI.SetTMPText(txt_value2, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue1"), self.nFloor))
  local target3 = finish.transform:Find("AnimRoot/target3")
  local txt_target3 = target3.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value3 = target3.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target3, ConfigTable.GetUIText("GoldenSpy_Result_FinishTarget3"))
  NovaAPI.SetTMPText(txt_value3, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue2"), self.levelCfg.Score))
  local target4 = finish.transform:Find("AnimRoot/target4")
  local txt_target4 = target4.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_value4 = target4.transform:Find("txt_value"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_target4, ConfigTable.GetUIText("GoldenSpy_Result_FinishTarget4"))
  NovaAPI.SetTMPText(txt_value4, orderedFormat(ConfigTable.GetUIText("GoldenSpy_Result_TargetValue2"), self.nCurScore))
end

function GoldenSpyResultCtrl:SetFinishActive(bActive)
  if bActive then
    local function callback(msgData, nextGroupId, nextLevelId)
      self._mapNode.FinishRoot:SetActive(true)
      
      local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(msgData)
      UTILS.OpenReceiveByChangeInfo(msgData)
      self.nextGroupId = nextGroupId
      self.nextLevelId = nextLevelId
      local bCurLevelPass = false
      local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
      local levelData = actData:GetLevelDataById(self.nLevelId)
      if levelData ~= nil then
        bCurLevelPass = levelData.nMaxScore >= self.levelCfg.Score
      end
      if self.bSuccess and self.nextGroupId ~= nil and self.nextLevelId ~= nil and bCurLevelPass then
        self._mapNode.btn_goNext2.gameObject:SetActive(true)
      else
        self._mapNode.btn_goNext2.gameObject:SetActive(false)
      end
    end
    
    if self.finishCallback ~= nil then
      self.finishCallback(callback)
    end
  else
    self._mapNode.FinishRoot:SetActive(false)
  end
end

function GoldenSpyResultCtrl:OnBtnClick_Finish()
  if self.bResult then
    EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  else
    self.bResult = true
    self._mapNode.GoNextRoot:SetActive(not self.bResult)
    self:SetFinishActive(self.bResult)
  end
end

function GoldenSpyResultCtrl:OnBtnClick_GoNext()
  EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  if self.goNextCallback ~= nil then
    self.goNextCallback()
  end
end

function GoldenSpyResultCtrl:OnBtnClick_GoNext2()
  EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
  if self.goNextLevelCallback ~= nil then
    self.goNextLevelCallback(self.nextGroupId, self.nextLevelId)
  end
end

return GoldenSpyResultCtrl
