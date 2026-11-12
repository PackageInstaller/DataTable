local PenguinCardSelectCtrl = class("PenguinCardSelectCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txtQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Quest"
  },
  reddotQuest = {},
  sv = {sComponentName = "ScrollRect"},
  sc = {
    sNodeName = "sv",
    sComponentName = "UIScrollToClick"
  },
  LevelContent = {sComponentName = "Transform"},
  goHardLevel = {},
  goNormalLevel = {},
  goEndlessLevel = {}
}
PenguinCardSelectCtrl._mapEventConfig = {
  PenguinCard_ClickLevel = "OnEvent_Click",
  PenguinCard_EnterLevel = "OnEvent_Enter",
  ActivityPenguinCardSkipLevel = "OnEvent_Skip"
}

function PenguinCardSelectCtrl:Refresh()
  self.goFirstLock = nil
  self.tbLevel = self.actData:GetLevelList()
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  self.tbGridCtrl = {}
  delChildren(self._mapNode.LevelContent)
  for k, nLevelId in ipairs(self.tbLevel) do
    local mapCfg = ConfigTable.GetData("ActivityPenguinCardLevel", nLevelId)
    if mapCfg then
      if mapCfg.Type == GameEnum.ActivityPenguinCardLevelType.Endless then
        self:RefreshEndless(k, nLevelId)
      elseif mapCfg.ScoreLevel then
        self:RefreshHard(k, nLevelId)
      else
        self:RefreshNormal(k, nLevelId)
      end
    end
  end
  EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PenguinCard_304")
  self:AutoMoveScroll()
end

function PenguinCardSelectCtrl:AutoMoveScroll()
  local bGuided = PlayerData.Guide:CheckGuideFinishById(305)
  local bEndless = self.actData:CheckEndlessLevelUnlock()
  if not bGuided and bEndless then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      NovaAPI.SetHorizontalNormalizedPosition(self._mapNode.sv, 1)
      self:AddTimer(1, 1, function()
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PenguinCard_305")
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, 1)
    end
    
    cs_coroutine.start(wait)
    return
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._panel.nPos then
      NovaAPI.SetHorizontalNormalizedPosition(self._mapNode.sv, self._panel.nPos)
    elseif self.goFirstLock ~= nil then
      self._mapNode.sc:ScrollToClick(self.goFirstLock, 0.01)
      self.goFirstLock = nil
    else
      NovaAPI.SetHorizontalNormalizedPosition(self._mapNode.sv, 1)
    end
  end
  
  cs_coroutine.start(wait)
end

function PenguinCardSelectCtrl:RefreshHard(nIndex, nLevelId)
  local goObj = instantiate(self._mapNode.goHardLevel, self._mapNode.LevelContent)
  local ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.Play_PenguinCard.PenguinCardLevelGridCtrl")
  self.tbGridCtrl[nIndex] = ctrlObj
  goObj:SetActive(true)
  ctrlObj:RefreshHard(self.actData, nLevelId)
  local bLock = ctrlObj:GetLock()
  if bLock and not self.goFirstLock then
    self.goFirstLock = goObj
  end
end

function PenguinCardSelectCtrl:RefreshEndless(nIndex, nLevelId)
  local goObj = instantiate(self._mapNode.goEndlessLevel, self._mapNode.LevelContent)
  local ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.Play_PenguinCard.PenguinCardLevelGridCtrl")
  self.tbGridCtrl[nIndex] = ctrlObj
  goObj:SetActive(true)
  ctrlObj:RefreshEndless(self.actData, nLevelId)
  local bLock = ctrlObj:GetLock()
  if bLock and not self.goFirstLock then
    self.goFirstLock = goObj
  end
end

function PenguinCardSelectCtrl:RefreshNormal(nIndex, nLevelId)
  local goObj = instantiate(self._mapNode.goNormalLevel, self._mapNode.LevelContent)
  local ctrlObj = self:BindCtrlByNode(goObj, "Game.UI.Play_PenguinCard.PenguinCardLevelGridCtrl")
  self.tbGridCtrl[nIndex] = ctrlObj
  goObj:SetActive(true)
  ctrlObj:RefreshNormal(self.actData, nIndex, nLevelId)
  local bLock = ctrlObj:GetLock()
  if bLock and not self.goFirstLock then
    self.goFirstLock = goObj
  end
end

function PenguinCardSelectCtrl:RegisterRedDot()
  self._mapNode.reddotQuest:SetActive(false)
  local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
  if mapActivityData == nil then
    return
  end
  local nGroupId = mapActivityData.MidGroupId
  if 0 < nGroupId then
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
          nGroupId,
          actData.ActivityId,
          mapActivityData.MiniGameRedDot
        }, self._mapNode.reddotQuest)
      end
    end
  else
    RedDotManager.RegisterNode(RedDotDefine.Activity_PenguinCard_AllQuest, nil, self._mapNode.reddotQuest)
  end
end

function PenguinCardSelectCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.tbGridCtrl = {}
end

function PenguinCardSelectCtrl:OnEnable()
  self:Refresh()
  self:RegisterRedDot()
end

function PenguinCardSelectCtrl:OnDisable()
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  self.tbGridCtrl = {}
  self._panel.nPos = NovaAPI.GetHorizontalNormalizedPosition(self._mapNode.sv)
  self.actData:SkipLevelRedDot()
end

function PenguinCardSelectCtrl:OnDestroy()
end

function PenguinCardSelectCtrl:OnBtnClick_Quest()
  local mapActivityData = ConfigTable.GetData("Activity", self.nActId)
  if mapActivityData == nil then
    return
  end
  local nGroupId = mapActivityData.MidGroupId
  if 0 < nGroupId then
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        EventManager.Hit(EventId.OpenPanel, actData.PanelId, actData.ActivityId, 5)
      end
    end
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.PenguinCardQuest, self.nActId)
  end
end

function PenguinCardSelectCtrl:OnEvent_Click(go)
  self._mapNode.sc:ScrollToClick(go)
end

function PenguinCardSelectCtrl:OnEvent_Enter(callback)
  local ani = self.gameObject:GetComponent("Animator")
  ani:Play("PenguinCardSelect_out")
  WwiseManger:PostEvent("Mode_Card_level")
  self:AddTimer(1, 0.5, callback, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function PenguinCardSelectCtrl:OnEvent_Skip()
  self:Refresh()
end

return PenguinCardSelectCtrl
