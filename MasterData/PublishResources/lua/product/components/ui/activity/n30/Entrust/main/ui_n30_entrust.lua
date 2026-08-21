_class("UIN30Entrust", UIController)
UIN30Entrust = UIN30Entrust

function UIN30Entrust:Constructor()
  self._cdEnd = {tick = 0, period = 30000}
end

function UIN30Entrust:RefreshClientData()
  if self.m_client_data == nil or self.m_client_data._className ~= "N30EntrustData" then
    self.m_client_data = N30EntrustData:New(self)
  end
  self.m_client_data:RefreshClientData()
end

function UIN30Entrust:LoadDataOnEnter(TT, res, uiParams)
  EntrustComponent:HookClientData(109301805, UIN30Entrust.RefreshClientData)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N30, ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    self:StartTask(function(TT)
      YIELD(TT)
      self:OnActivityCloseEvent(self._campaign._id)
    end)
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._entrustComponent = self._localProcess:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST)
  self._entrustData = self._entrustComponent:GetClientData()
  self._isReturn = uiParams[1]
end

function UIN30Entrust:OnShow(uiParams)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._txtEndDuration = self:GetUIComponent("UILocalizationText", "txtEndDuration")
  self._uiLines = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._uiNodes = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:InitCommonTopButton()
  self:EnterFullScreenBg(false)
  self:CreateNodes()
  self:CreateLines()
  self:FlushNodes()
  self:FlushEndDuration()
  if self._entrustData:ViewPlot() then
    self:InAnimation()
  else
    self:PlayPlot(true)
  end
end

function UIN30Entrust:OnHide()
end

function UIN30Entrust:OnUpdate(deltaTimeMS)
  self._cdEnd.tick = self._cdEnd.tick + deltaTimeMS
  if self._cdEnd.tick >= self._cdEnd.period then
    self._cdEnd.tick = 0
    self:FlushEndDuration()
    self:FlushNodeStatus()
  end
end

function UIN30Entrust:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(false, UIStateType.UIActivityN30MainController, UIStateType.UIMain, nil, self._campaign._id)
  end
end

function UIN30Entrust:BtnIntroOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN30EntrustIntro")
end

function UIN30Entrust:BtnPlotOnClick(go)
  self:PlayPlot(false)
end

function UIN30Entrust:PlayPlot(inAnimation)
  self._animation.gameObject:SetActive(false)
  self:ShowDialog("UIStoryController", 50500001, function()
    self._entrustData:ViewPlot(true)
    self._animation.gameObject:SetActive(true)
    if inAnimation then
      self:InAnimation()
    end
  end)
end

function UIN30Entrust:BtnAnywhereOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN30Entrust:NodeOnClick(uiNode, go)
  local node = uiNode:GetNodeData()
  if node:IsLocked() then
    ToastManager.ShowToast(StringTable.Get("str_n30_entrust_locked_prev_popup"))
  elseif node:IsTimeLocked() then
    ToastManager.ShowToast(StringTable.Get("str_n30_entrust_locked_time_popup"))
  else
    self._entrustData:ViewNode(node:ID())
    uiNode:FlushStatus()
    self:ShowDialog("UIN30EntrustStage", node)
  end
end

function UIN30Entrust:InitCommonTopButton()
  local function fnHelp()
    self:ShowDialog("UIIntroLoader", "UIN30EntrustIntro")
  end
  
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local lockName = "UIN30Entrust:EntrustMain_out"
    self:StartTask(function(TT)
      self:Lock(lockName)
      self._animation:Play("uieff_N30_EntrustMain_quit")
      YIELD(TT, 333)
      self:UnLock(lockName)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN30MainController, UIStateType.UIMain, nil, self._campaign._id)
    end)
  end, fnHelp, function()
    self:SwitchState(UIStateType.UIMain)
  end, false, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN30Entrust:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._btnAnywhere.gameObject:SetActive(isEnter)
end

function UIN30Entrust:ResetCellSize(go, cellSize)
  if go == nil then
    return
  end
  local rt = go.transform
  rt.pivot = Vector2.one * 0.5
  rt.localScale = Vector3.one
  rt.anchorMin = Vector2.one * 0.5
  rt.anchorMax = Vector2.one * 0.5
  rt.sizeDelta = cellSize
  rt.anchoredPosition = Vector2.zero
end

function UIN30Entrust:CreateNodes()
  self._dataNodes = self._entrustData:GetAllEntrust()
  local count = #self._dataNodes
  self._widgetNodes = self._uiNodes:SpawnObjects("UIN30EntrustMainNode", count)
  for k, v in pairs(self._dataNodes) do
    local pos = Vector2.zero
    if v.PointPos ~= nil and #v.PointPos >= 2 then
      pos.x = v.PointPos[1]
      pos.y = v.PointPos[2]
    end
    local ui = self._widgetNodes[k]
    self:ResetCellSize(ui:GetGameObject(), Vector2(478, 479))
    ui:GetGameObject().transform.anchoredPosition = pos
  end
end

function UIN30Entrust:CreateLines()
  local count = #self._dataNodes - 1
  self._widgetLines = self._uiLines:SpawnObjects("UIN30EntrustMainLine", count)
  for k, v in pairs(self._widgetLines) do
    local preNode = self._widgetNodes[k]
    local nxtNode = self._widgetNodes[k + 1]
    local go = v:GetGameObject()
    self:ResetCellSize(go, Vector2(250, 51))
    go.transform.pivot = Vector2(0, 0.5)
    v:SetPos(preNode, nxtNode)
  end
end

function UIN30Entrust:FlushNodes()
  for k, v in pairs(self._dataNodes) do
    local ui = self._widgetNodes[k]
    ui:SetData(self._entrustData:GetNodeData(v.ID))
    ui:FlushStatus()
  end
end

function UIN30Entrust:FlushNodeStatus()
  for k, v in pairs(self._dataNodes) do
    local ui = self._widgetNodes[k]
    ui:FlushStatus()
  end
end

function UIN30Entrust:GetFormatTimerStr(deltaTime, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107",
    clrFormat = "<color=#%s>%s</color>"
  }
  if txtColor == nil then
    txtColor = "FFFFFF"
  end
  local day = 0
  local hour = 0
  local min = 0
  local second = 0
  if 0 <= deltaTime then
    day, hour, min, second = UIActivityHelper.Time2Str(deltaTime)
  end
  local timeStr
  if 0 < day and 0 < hour then
    timeStr = tostring(day) .. StringTable.Get(id.day)
    timeStr = timeStr .. tostring(hour) .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = tostring(day) .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = tostring(hour) .. StringTable.Get(id.hour)
    timeStr = timeStr .. tostring(min) .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = tostring(hour) .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = tostring(min) .. StringTable.Get(id.min)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return string.format(id.clrFormat, txtColor, timeStr)
end

function UIN30Entrust:FlushEndDuration()
  local endTime = self._entrustComponent:GetComponentInfo().m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local deltaTime = math.max(endTime - curTime, 0)
  local timerStr = self:GetFormatTimerStr(deltaTime)
  local txtValue = StringTable.Get("str_n30_entrust_end_title", timerStr)
  self._txtEndDuration:SetText(txtValue)
end

function UIN30Entrust:InAnimation()
  local lockName = "UIN30Entrust:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    if self._isReturn then
      self._animation:Play("uieff_N30_EntrustMain_in")
    else
      self._animation:Play("uieff_N30_EntrustMain")
    end
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
  local lockName = "UIN30Entrust:InAnimation - 2"
  self:StartTask(function(TT)
    self:Lock(lockName)
    for k, v in pairs(self._widgetNodes) do
      v:ShowNormalDoing(false)
      if k % 2 == 1 then
        v:PlayAnimation("uieff_N30_EntrustMainNode_up")
      else
        v:PlayAnimation("uieff_N30_EntrustMainNode_down")
      end
    end
    YIELD(TT, 800)
    for k, v in pairs(self._widgetNodes) do
      v:ShowNormalDoing(true)
      v:PlayAnimation("uieff_N30_EntrustMainNode")
    end
    self:UnLock(lockName)
  end)
end

function UIN30Entrust:OutAnimation()
  self._animation:Play("uieff_N30_EntrustMain_out")
end

_class("UIN30EntrustMainNode", UICustomWidget)
UIN30EntrustMainNode = UIN30EntrustMainNode

function UIN30EntrustMainNode:Constructor()
  self._cfg = nil
  self._node = nil
end

function UIN30EntrustMainNode:OnShow(uiParams)
  self._uiLocked = self:GetUIComponent("RectTransform", "uiLocked")
  self._uiNormal = self:GetUIComponent("RectTransform", "uiNormal")
  self._uiFinish = self:GetUIComponent("RectTransform", "uiFinish")
  self._uiNew = self:GetUIComponent("RectTransform", "uiNew")
  self._titleNormal = self:GetUIComponent("UILocalizationText", "titleNormal")
  self._imgRemainTime = self:GetUIComponent("RectTransform", "imgRemainTime")
  self._txtRemainTime = self:GetUIComponent("UILocalizationText", "txtRemainTime")
  self._imgProgressN = self:GetUIComponent("Image", "imgProgressN")
  self._txtExplorValueN = self:GetUIComponent("UILocalizationText", "txtExplorValueN")
  self._imgProgressC = self:GetUIComponent("Image", "imgProgressC")
  self._txtExplorValueC = self:GetUIComponent("UILocalizationText", "txtExplorValueC")
  self._bgNormalSel = self:GetUIComponent("RectTransform", "bgNormalSel")
  self._imgDoing = self:GetUIComponent("RectTransform", "imgDoing")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN30EntrustMainNode:OnHide()
end

function UIN30EntrustMainNode:ButtonOnClick(go)
  self:RootUIOwner():NodeOnClick(self, go)
end

function UIN30EntrustMainNode:GetNodeData()
  return self._node
end

function UIN30EntrustMainNode:SetData(node)
  self._node = node
  local cfg = node:GetCfg()
  self._titleNormal:SetText(StringTable.Get(cfg.StrTitle))
end

function UIN30EntrustMainNode:FlushStatus()
  local showLocked = false
  local showNormal = false
  local showFinish = false
  local showNew = false
  local showRemain = false
  local remainValue = 0
  if self._node:IsLocked() then
    showLocked = true
  elseif self._node:IsNew() then
    showRemain, remainValue = self._node:IsTimeLocked()
    if showRemain then
      showLocked = true
      showRemain = true
    else
      showNormal = true
      showNew = true
    end
  elseif self._node:IsPass() then
    showFinish = true
  else
    showNormal = true
  end
  self._uiLocked.gameObject:SetActive(showLocked)
  self._uiNormal.gameObject:SetActive(showNormal)
  self._uiFinish.gameObject:SetActive(showFinish)
  self._uiNew.gameObject:SetActive(showNew)
  self._imgRemainTime.gameObject:SetActive(showRemain)
  if showRemain then
    local colorStr = "FFFFFF"
    local timerStr = self:RootUIOwner():GetFormatTimerStr(remainValue, colorStr)
    self._txtRemainTime:SetText(timerStr)
  end
  local value = self._node:GetExplor()
  self._imgProgressN.fillAmount = value
  self._imgProgressC.fillAmount = value
  local value = self._node:GetExplor() * 100
  local strExplor = string.format("%d<size=41>%%</size>", math.floor(value))
  self._txtExplorValueN:SetText(strExplor)
  self._txtExplorValueC:SetText(strExplor)
end

function UIN30EntrustMainNode:ShowNormalDoing(inShow)
  self._bgNormalSel.gameObject:SetActive(inShow)
  self._imgDoing.gameObject:SetActive(inShow)
end

function UIN30EntrustMainNode:PlayAnimation(animName)
  self._animation:Play(animName)
end

_class("UIN30EntrustMainLine", UICustomWidget)
UIN30EntrustMainLine = UIN30EntrustMainLine

function UIN30EntrustMainLine:Constructor()
  self._preNode = nil
  self._nxtNode = nil
end

function UIN30EntrustMainLine:OnShow(uiParams)
  self._rect = self:GetGameObject().transform
end

function UIN30EntrustMainLine:OnHide()
end

function UIN30EntrustMainLine:SetPos(preNode, nxtNode)
  self._preNode = preNode
  self._nxtNode = nxtNode
  local from = preNode:GetGameObject().transform.anchoredPosition
  local to = nxtNode:GetGameObject().transform.anchoredPosition
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end
