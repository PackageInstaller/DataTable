local TrialInfoCtrl = class("TrialInfoCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
TrialInfoCtrl._mapNodeConfig = {
  Challenge = {},
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_QuestList"
  },
  rtList = {sComponentName = "Transform"},
  goQuest = {},
  aniQuest = {sNodeName = "goQuest", sComponentName = "Animator"}
}
TrialInfoCtrl._mapEventConfig = {
  OpenTrialInfo = "OnEvent_OpenUI",
  TrialLevelEnd = "OnEvent_CloseUI",
  InputEnable = "OnEvent_InputEnable",
  TrialBattleEnd = "OnEvent_BattleEnd",
  TaskLevel_InitTask = "RefreshQuest",
  TaskLevel_UpdateTaskTargetProcess = "UpdateTarget"
}

function TrialInfoCtrl:Awake()
  self.nCurQuest = nil
  self.nNextQuest = nil
  self.tbTargetCount = {}
  self.tbTargetProcess = {}
end

function TrialInfoCtrl:OnEnable()
  self._mapNode.Challenge.gameObject:SetActive(false)
  self.bBattleEnd = false
end

function TrialInfoCtrl:OnDisable()
end

function TrialInfoCtrl:OnDestroy()
end

function TrialInfoCtrl:RefreshQuest(nQuestId)
  local mapQuest = ConfigTable.GetData("LevelQuest", nQuestId)
  if not mapQuest then
    return
  end
  local tbTarget = mapQuest.LevelQuestTargetIds
  if not self.tbTargetCount[nQuestId] then
    self.tbTargetCount[nQuestId] = {
      nCur = 0,
      nMax = #tbTarget
    }
  end
  if not self.tbTargetProcess[nQuestId] then
    self.tbTargetProcess[nQuestId] = {}
    for _, v in ipairs(tbTarget) do
      self.tbTargetProcess[nQuestId][v] = {nCur = 0, nMax = 0}
    end
  end
  if self.nCurQuest then
    if self.nCurQuest ~= nQuestId then
      self.nNextQuest = nQuestId
    end
    return
  else
    self.nCurQuest = nQuestId
  end
  self.tbTagetNode = {}
  delChildren(self._mapNode.rtList)
  for _, v in ipairs(tbTarget) do
    local mapTarget = ConfigTable.GetData("LevelQuestTarget", v)
    if mapTarget then
      local goItemObj = instantiate(self._mapNode.goQuest, self._mapNode.rtList)
      goItemObj:SetActive(true)
      self.tbTagetNode[v] = {}
      self.tbTagetNode[v].imgOff = goItemObj.transform:Find("goReach/imgOff").gameObject
      self.tbTagetNode[v].imgOn = goItemObj.transform:Find("goReach/imgOn").gameObject
      self.tbTagetNode[v].txtDesc = goItemObj.transform:Find("txtDesc"):GetComponent("TMP_Text")
      self.tbTagetNode[v].ani = goItemObj.transform:GetComponent("Animator")
      self.tbTagetNode[v].sPrefix = UTILS.ParseLevelQuestTargetDesc(mapTarget.QuestDes, mapTarget)
      local sSuffix = ""
      if 0 < self.tbTargetProcess[nQuestId][v].nCur then
        sSuffix = "<color=#2be1f1>(" .. self.tbTargetProcess[nQuestId][v].nCur .. "/" .. self.tbTargetProcess[nQuestId][v].nMax .. ")</color>"
      else
        sSuffix = UTILS.GetLevelQuestTargetProcess(mapTarget)
      end
      local bComplete = false
      if 0 < self.tbTargetProcess[nQuestId][v].nCur then
        bComplete = self.tbTargetProcess[nQuestId][v].nCur >= self.tbTargetProcess[nQuestId][v].nMax
      end
      self.tbTagetNode[v].imgOff:SetActive(not bComplete)
      self.tbTagetNode[v].imgOn:SetActive(bComplete)
      NovaAPI.SetTMPText(self.tbTagetNode[v].txtDesc, self.tbTagetNode[v].sPrefix .. sSuffix)
    end
  end
end

function TrialInfoCtrl:UpdateTarget(nQuestId, nTargetId, nCur, nMax)
  nCur = nCur:AsInt()
  nMax = nMax:AsInt()
  local bComplete = nCur >= nMax
  self.tbTargetProcess[nQuestId][nTargetId].nCur = nCur
  self.tbTargetProcess[nQuestId][nTargetId].nMax = nMax
  if bComplete then
    self.tbTargetCount[nQuestId].nCur = self.tbTargetCount[nQuestId].nCur + 1
  end
  if nQuestId ~= self.nCurQuest then
    return
  end
  if self.tbTargetCount[nQuestId].nCur == self.tbTargetCount[nQuestId].nMax then
    self:SetTimer()
  end
  if not self.tbTagetNode[nTargetId] then
    return
  end
  self.tbTagetNode[nTargetId].imgOff:SetActive(not bComplete)
  self.tbTagetNode[nTargetId].imgOn:SetActive(bComplete)
  local sSuffix = "<color=#2be1f1>(" .. nCur .. "/" .. nMax .. ")</color>"
  NovaAPI.SetTMPText(self.tbTagetNode[nTargetId].txtDesc, self.tbTagetNode[nTargetId].sPrefix .. sSuffix)
  if bComplete then
    self.tbTagetNode[nTargetId].ani:Play("TrialInfo_Quest_on")
    WwiseAudioMgr:PostEvent("ui_tip_complete")
  end
end

function TrialInfoCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniQuest, {
    "TrialInfo_Quest_on"
  })
  
  local function countdown()
    self.nCurQuest = nil
    if self.nNextQuest then
      self:RefreshQuest(self.nNextQuest)
    end
  end
  
  self.timer = self:AddTimer(1, nAnimTime + 0.5, countdown, true, true, false)
end

function TrialInfoCtrl:ClearTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  self.timer = nil
end

function TrialInfoCtrl:OnEvent_OpenUI(nQuestId)
  self._mapNode.Challenge.gameObject:SetActive(true)
  if nQuestId then
    self:RefreshQuest(nQuestId)
  end
end

function TrialInfoCtrl:OnEvent_CloseUI()
end

function TrialInfoCtrl:OnEvent_InputEnable(bEnable)
  if self.bBattleEnd == true then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
end

function TrialInfoCtrl:OnEvent_BattleEnd()
  self.bBattleEnd = true
end

return TrialInfoCtrl
