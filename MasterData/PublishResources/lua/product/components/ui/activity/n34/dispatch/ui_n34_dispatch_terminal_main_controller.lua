local UIN34DispatchType = {OpenDialogue = 1}
_enum("UIN34DispatchType", UIN34DispatchType)
_class("UIN34DispatchTerminalMainControlller", UIController)
UIN34DispatchTerminalMainControlller = UIN34DispatchTerminalMainControlller

function UIN34DispatchTerminalMainControlller:Constructor()
  self._inDialogue = false
end

function UIN34DispatchTerminalMainControlller:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N34)
  self._dispatchComponent = self._localProcess:GetComponent(ECampaignN34ComponentID.ECAMPAIGN_N34_DISPATCH)
  self._dispatchComponentInfo = self._dispatchComponent:GetComponentInfo()
  self._openType = uiParams[1]
  if self._openType == UIN34DispatchType.OpenDialogue then
    self._odArchId = uiParams[2]
  end
end

function UIN34DispatchTerminalMainControlller:OnShow(uiParams)
  self:InitWidget()
  if self._openType == UIN34DispatchType.OpenDialogue then
    self:BtnChangeColor(false)
    self.changeLog = true
    self:AutoOpenDialogue(self._odArchId)
  else
    self:StartTask(function(TT)
      self:Lock("UIN34DispatchTerminalMainControlller_Open")
      self:LoadMainContent()
      local Pools = self.mainContent:GetAllSpawnList()
      for i = 1, #Pools do
        local item = Pools[i]
        item:PlayAnimIn(i)
      end
      YIELD(TT, 400)
      self:UnLock("UIN34DispatchTerminalMainControlller_Open")
    end)
  end
end

function UIN34DispatchTerminalMainControlller:InitWidget()
  self.mainContent = self:GetUIComponent("UISelectObjectPath", "MainContent")
  self.logContent = self:GetUIComponent("UISelectObjectPath", "LogContent")
  self.dialogueLoader = self:GetUIComponent("UISelectObjectPath", "Dialogue")
  self.dialogueObj = self:GetGameObject("Dialogue")
  self.main = self:GetGameObject("Main")
  self.logAndDialogue = self:GetGameObject("LogAndDialogue")
  self.log = self:GetGameObject("Log")
  self.returnBtn = self:GetUIComponent("RectTransform", "ReturnBtn")
  self._logTitle = self:GetUIComponent("UILocalizationText", "LogTitle")
  self._toLogBtn = self:GetUIComponent("Image", "ToLogBtn")
  self._dialogueTitle = self:GetUIComponent("UILocalizationText", "DialogueTitle")
  self._toDialogueBtn = self:GetUIComponent("Image", "ToDialogueBtn")
  self.toastObj = self:GetGameObject("Toast")
  self.toast = self:GetUIComponent("RectTransform", "Toast")
  self.toastBGObj = self:GetGameObject("ToastBG")
  self.awardsContent = self:GetUIComponent("UISelectObjectPath", "LoadAwards")
  self.tipsObj = self:GetGameObject("tips")
  self._atlas = self:GetAsset("UIN34Dispatch.spriteatlas", LoadType.SpriteAtlas)
  self._switchAnim = self:GetUIComponent("Animation", "SwitchAnim")
  self._changeAnim = self:GetUIComponent("Animation", "ChangeAnim")
  self._mainAnim = self:GetUIComponent("Animation", "MainAnim")
end

function UIN34DispatchTerminalMainControlller:LoadMainContent()
  local componentID = self._dispatchComponent:GetComponentCfgId()
  local ArchCfg = Cfg.cfg_component_dispatch_arch({ComponentID = componentID})
  local dispatchInfo = self._dispatchComponentInfo.dispatch_infos
  local LastDispatchEnd = false
  if #dispatchInfo == 0 or dispatchInfo[#dispatchInfo].status == N34TerminalItemStatus.End then
    LastDispatchEnd = true
  end
  local unlock
  self._mainItems = self.mainContent:SpawnObjects("UIN34DispatchTerminalMainItem", #ArchCfg)
  for i, v in pairs(self._mainItems) do
    if i == #dispatchInfo + 1 and LastDispatchEnd then
      unlock = true
    else
      unlock = false
    end
    v:SetData(dispatchInfo[i], i, ArchCfg[i].DispatchLogName, function(id, transform)
      self:OnAwardClick(id, transform)
    end, function(item)
      self:OnItemSelect(item)
    end, unlock)
    if i == 1 then
      self:OnItemSelect(self._mainItems[i])
    end
  end
end

function UIN34DispatchTerminalMainControlller:OnAwardClick(id, transform)
  local ArchCfg = Cfg.cfg_component_dispatch_arch[id]
  if not ArchCfg then
    return
  end
  local Award = ArchCfg.Rewards
  self.toastBGObj:SetActive(true)
  self.toastObj:SetActive(true)
  self.toast.position = transform
  self.toast.anchoredPosition = Vector2(self.toast.anchoredPosition.x + 273, self.toast.anchoredPosition.y - 163)
  self._mainItems = self.awardsContent:SpawnObjects("UIN34DispatchAwardItem", #Award)
  for i, v in ipairs(self._mainItems) do
    v:SetData(Award[i])
  end
end

function UIN34DispatchTerminalMainControlller:OnItemSelect(item)
  local ID = item:GetDispatchID()
  local status = item:GetStatus()
  if self._lastID == ID then
    return
  end
  self._lastID = ID
  self._status = status
  if self.selectItem then
    self.selectItem:SetSelected(false)
  end
  self.selectItem = item
  self.selectItem:SetSelected(true)
end

function UIN34DispatchTerminalMainControlller:CheckLog(cfg, BuildingId)
  local log = {}
  local dispatchInfo = self._dispatchComponentInfo.dispatch_infos
  local Info = dispatchInfo[BuildingId]
  if not Info then
    return log
  end
  local DispatchTime = Cfg.cfg_component_dispatch_arch[BuildingId].DispatchTime
  local startTime = Info.end_time - DispatchTime
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime()
  curTime = curTime / 1000
  for i, v in ipairs(cfg) do
    if curTime > startTime + v.DispatchTime then
      table.insert(log, cfg[i])
    end
  end
  return log
end

function UIN34DispatchTerminalMainControlller:ShowLog()
  local SelectBuildingID = self._lastID
  if not SelectBuildingID and self._odArchId then
    SelectBuildingID = self._odArchId
  end
  local cfg = Cfg.cfg_mission_dispatch_log({BuildingId = SelectBuildingID})
  local LogData = self:CheckLog(cfg, SelectBuildingID)
  self.main:SetActive(false)
  self.logAndDialogue:SetActive(true)
  self.logContent:ClearWidgets()
  self.logContent:SpawnObjects("UIN34DispatchTerminalLogItem", #LogData)
  self.logItems = self.logContent:GetAllSpawnList()
  for i, v in ipairs(self.logItems) do
    v:SetData(LogData[i])
  end
  if self._status == N34TerminalItemStatus.Going then
    self.tipsObj:SetActive(true)
    return
  end
end

function UIN34DispatchTerminalMainControlller:BtnChange(ChangeLog)
  self:StartTask(function(TT)
    self:Lock("UIN34DispatchTerminalMainControlller_Change")
    if ChangeLog then
      self:BtnChangeColor(true)
      self:ToLogBtn()
    else
      if self._status ~= N34TerminalItemStatus.End then
        self:ShowDialog("UIN34DispatchTerminalToast", self._status)
        return
      end
      self:BtnChangeColor(false)
      self:ToDialogueBtn()
    end
    YIELD(TT, 400)
    self:UnLock("UIN34DispatchTerminalMainControlller_Change")
  end)
end

function UIN34DispatchTerminalMainControlller:BtnChangeColor(ChangeLog)
  local SelectColor = Color(0.21568627450980393, 0.16470588235294117, 0.12156862745098039, 1.0)
  local UnSelectColor = Color(0.4666666666666667, 0.6549019607843137, 0.7372549019607844, 1.0)
  local SelectImageLog = self._atlas:GetSprite("n34_pqtc_btn03")
  local UnSelectImageLog = self._atlas:GetSprite("n34_pqtc_btn05")
  local SelectImageDialogue = self._atlas:GetSprite("n34_pqtc_btn06")
  local UnSelectImageDialogue = self._atlas:GetSprite("n34_pqtc_btn04")
  if ChangeLog then
    self._logTitle.color = SelectColor
    self._dialogueTitle.color = UnSelectColor
    self._toLogBtn.sprite = SelectImageLog
    self._toDialogueBtn.sprite = UnSelectImageDialogue
  else
    self._logTitle.color = UnSelectColor
    self._dialogueTitle.color = SelectColor
    self._toLogBtn.sprite = UnSelectImageLog
    self._toDialogueBtn.sprite = SelectImageDialogue
  end
end

function UIN34DispatchTerminalMainControlller:OpenBtnOnClick(go)
  if self._inDialogue then
    return
  end
  if self._status == N34TerminalItemStatus.NotStart or self._status == N34TerminalItemStatus.Unlock then
    self:ShowDialog("UIN34DispatchTerminalToast", self._status)
    return
  elseif self._status == N34TerminalItemStatus.Going then
    self:BtnChange(true)
    self._switchAnim:Play("uieff_UIN34DispatchTerminalMainControlller_switchLog")
    local Pools = self.mainContent:GetAllSpawnList()
    for i = 1, #Pools do
      local item = Pools[i]
      item:SetCanvasGroup()
    end
  elseif self._status == N34TerminalItemStatus.End then
    local SelectBuildingID = self._lastID
    if not SelectBuildingID then
      return
    end
    self:BtnChange(false)
    self._switchAnim:Play("uieff_UIN34DispatchTerminalMainControlller_switchLog1")
    local Pools = self.mainContent:GetAllSpawnList()
    for i = 1, #Pools do
      local item = Pools[i]
      item:SetCanvasGroup()
    end
    self.changeLog = true
  end
end

function UIN34DispatchTerminalMainControlller:ReturnBtnOnClick(go)
  if self._inDialogue then
    return
  end
  self:InitWidget()
  self:LoadMainContent()
  self:StartTask(function(TT)
    self:Lock("UIN34DispatchTerminalMainControlller_Return")
    self._switchAnim:Play("uieff_UIN34DispatchTerminalMainControlller_switchMain")
    YIELD(TT, 100)
    local Pools = self.mainContent:GetAllSpawnList()
    for i = 1, #Pools do
      local item = Pools[i]
      item:PlayAnimIn(i)
    end
    YIELD(TT, 300)
    self:UnLock("UIN34DispatchTerminalMainControlller_Return")
  end)
end

function UIN34DispatchTerminalMainControlller:ToLogBtn(go)
  if self._inDialogue then
    return
  end
  self.log:SetActive(true)
  self:ShowLog()
  self.dialogueObj:SetActive(false)
end

function UIN34DispatchTerminalMainControlller:ToDialogueBtn()
  if self._inDialogue then
    return
  end
  local SelectBuildingID = self._lastID
  if self._status ~= N34TerminalItemStatus.End then
    self:ShowDialog("UIN34DispatchTerminalToast", self._status)
    return
  end
  self:AutoOpenDialogue(SelectBuildingID)
end

function UIN34DispatchTerminalMainControlller:BGOnClick(go)
  if self._inDialogue then
    return
  end
  self:StartTask(function(TT)
    self:Lock("UIN34DispatchTerminalMainControlller_Close")
    YIELD(TT, 200)
    self._mainAnim:Play("uieff_UIN34DispatchTerminalMainControlller_out")
    YIELD(TT, 250)
    self:UnLock("UIN34DispatchTerminalMainControlller_Close")
    self:CloseDialog()
  end)
end

function UIN34DispatchTerminalMainControlller:ChangeBtnOnClick(go)
  if self._inDialogue then
    return
  end
  if not self.changeLog and self._status ~= N34TerminalItemStatus.End then
    self:ShowDialog("UIN34DispatchTerminalToast", self._status)
    return
  end
  if not self.changeLog then
    self._changeAnim:Play("uieff_UIN34DispatchTerminalMainControlller_switchLog_01")
  else
    self._changeAnim:Play("uieff_UIN34DispatchTerminalMainControlller_switchLog_02")
  end
  self:BtnChange(self.changeLog)
  if not self.changeLog then
    self.changeLog = true
  else
    self.changeLog = false
  end
end

function UIN34DispatchTerminalMainControlller:AutoOpenDialogue(archId)
  self.main:SetActive(false)
  self.logAndDialogue:SetActive(true)
  self.log:SetActive(false)
  self.dialogueObj:SetActive(true)
  self.dialogue = self.dialogueLoader:SpawnObject("UIN34DispatchDialogue")
  self.dialogue:Chat(archId, function(inDialogue)
    self._inDialogue = inDialogue
    self:OnInDialogueChanged()
  end)
end

function UIN34DispatchTerminalMainControlller:OnInDialogueChanged()
  self.returnBtn.gameObject:SetActive(not self._inDialogue)
end

function UIN34DispatchTerminalMainControlller:ToastBGOnClick(go)
  self.toastBGObj:SetActive(false)
  self.toastObj:SetActive(false)
end
