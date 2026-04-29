_class("UIN22EntrustLevelController", UIController)
UIN22EntrustLevelController = UIN22EntrustLevelController

function UIN22EntrustLevelController:_CampaignSwitchState_Shot()
  local screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN22EntrustStageController, UIStateType.UIMain, {cache_rt, false}, self._campaign._id)
  end)
end

function UIN22EntrustLevelController:_SetCommonTopButton()
  local desc = StringTable.Get("str_n22_entrust_event_exits_pop_title")
  local exitTitle = StringTable.Get("str_n22_entrust_event_exits_leave")
  
  local function exitCallback()
    self:_PlayExitAnim()
  end
  
  local confirmTitle = StringTable.Get("str_n22_entrust_event_exits_goon")
  local confirmCallback
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:ShowDialog("UIN22EntrustMsgPopController", "", desc, exitTitle, exitCallback, confirmTitle, confirmCallback)
  end, nil, nil, false)
  obj:HideHomeBtn()
end

function UIN22EntrustLevelController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N22
  self._componentId = ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  if not self._campaign:CheckComponentOpen(self._componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId)
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  self._component = self._campaign:GetComponent(self._componentId)
end

function UIN22EntrustLevelController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self._levelId = uiParams[1] or 0
  self._nodeInfo = {}
  self._showEnterAnim = uiParams[2] or false
  self:_PlayEnterAnim()
  self:_SetDebug()
end

function UIN22EntrustLevelController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIN22EntrustLevelController:_Init()
  self:_SetCommonTopButton()
end

function UIN22EntrustLevelController:_Refresh()
  self:_SetTreasureBox()
  local tb_node = UIN22EntrustHelper.CalcNodeInfo(self._showEnterAnim, self._component, self._levelId)
  local tb_line = UIN22EntrustHelper.CalcLineInfo(self._showEnterAnim, self._component, self._levelId, tb_node)
  self:_SetMapNode(tb_node)
  self:_SetMapLine(tb_line)
  local tb_player = UIN22EntrustHelper.CalcPlayerInfo(false, self._showEnterAnim, tb_node[self._startNode])
  self:_SetMapPlayer(self._startNode, tb_player)
  self._showEnterAnim = false
end

function UIN22EntrustLevelController:_PlayEnterAnim(showAnim)
  local tb = {
    [1] = "uieff_UIN22EntrustLevelController_in_01",
    [2] = "uieff_UIN22EntrustLevelController_in_02",
    [3] = "uieff_UIN22EntrustLevelController_in_03",
    [4] = "uieff_UIN22EntrustLevelController_in_04",
    [5] = "uieff_UIN22EntrustLevelController_in_05",
    [6] = "uieff_UIN22EntrustLevelController_in_06"
  }
  local index = UIN22EntrustHelper.GetLevelIndex(self._component, self._levelId) or 0
  local animName = tb[index]
  if self._showEnterAnim and animName then
    UIWidgetHelper.PlayAnimation(self, "root", animName, 733, function()
      self:_Init()
      self:_Refresh()
    end)
  else
    self:_Init()
    self:_Refresh()
  end
end

function UIN22EntrustLevelController:_PlayExitAnim(isDebug)
  local tb = {
    [1] = "uieff_UIN22EntrustLevelController_out_01",
    [2] = "uieff_UIN22EntrustLevelController_out_02",
    [3] = "uieff_UIN22EntrustLevelController_out_03",
    [4] = "uieff_UIN22EntrustLevelController_out_04",
    [5] = "uieff_UIN22EntrustLevelController_out_05",
    [6] = "uieff_UIN22EntrustLevelController_out_06"
  }
  local index = UIN22EntrustHelper.GetLevelIndex(self._component, self._levelId) or 0
  local animName = tb[index]
  if animName then
    local obj = self:GetUIComponent("Transform", "Center")
    local parent = self:GetUIComponent("Transform", "bg_ori")
    obj.parent = parent
    UIWidgetHelper.PlayAnimation(self, "Center", "UIN22EntrustLevelController_Center_out", 167)
    UIWidgetHelper.PlayAnimation(self, "root", animName, 700, function()
      if not isDebug then
        self:_CampaignSwitchState_Shot()
      end
    end)
  else
    self:_CampaignSwitchState_Shot()
  end
end

function UIN22EntrustLevelController:_SetTreasureBox()
  local txt = self._component:GetTreasureBoxText(self._levelId)
  UIWidgetHelper.SetLocalizationText(self, "_txtTreasureBox", txt)
end

function UIN22EntrustLevelController:_SetMapNode(tb_node)
  local tb = self._component:GetAllOpenEvents(self._levelId)
  local count = table.count(tb)
  local objs = UIWidgetHelper.SpawnObjects(self, "Nodes", "UIN22EntrustLevelNode", count)
  for i, v in ipairs(objs) do
    local nodeId = tb[i]
    v:SetData(self._campaign, self._component, self._levelId, nodeId, function(nodeId)
      local tb_player = UIN22EntrustHelper.CalcPlayerInfo(true)
      self:_SetMapPlayer(nodeId, tb_player)
    end, function(isExit)
      if not isExit then
        self:_Refresh()
      else
        self:_ShowExitMsg()
      end
    end)
    local nodeInfo = tb_node[nodeId]
    if nodeInfo.isPlay then
      v:PlayAnim(i, "uieff_UIN22EntrustLevel_Node_in", nodeInfo.delay, nodeInfo.time)
    end
  end
  if count == 0 then
    Log.exception("UIN22EntrustLevelController:_SetMapNode() count == 0")
    return
  end
  self._startNode = tb and tb[1]
  local x = self._component:GetPlayerPos()
  if x ~= 0 then
    self._startNode = x
  end
end

function UIN22EntrustLevelController:_SetMapLine(tb_line)
  local tb = tb_line
  local count = table.count(tb)
  local objs = UIWidgetHelper.SpawnObjects(self, "Lines", "UIN22EntrustLevelLine", count)
  for i, v in ipairs(objs) do
    local lineInfo = tb[i]
    v:SetPos(lineInfo.from, lineInfo.to)
    if lineInfo.isPlay then
      v:PlayAnim(i, nil, lineInfo.delay, lineInfo.time)
    end
    v:SetDebugText(lineInfo.id)
  end
end

function UIN22EntrustLevelController:_SetMapPlayer(nodeId, tb_player)
  local obj = UIWidgetHelper.SpawnObject(self, "Player", "UIN22EntrustLevelPlayer")
  obj:SetData(self._component, nodeId)
  self._component:SetPlayerPos(nodeId)
  if tb_player.isPlay then
    obj:PlayAnim(tb_player.anim, tb_player.delay, tb_player.time)
  end
end

function UIN22EntrustLevelController:_ShowExitMsg()
  local rate = self._component:GetExplorNum(self._levelId)
  local over = 100 <= rate
  local strTitle = StringTable.Get("str_n22_entrust_event_exits_title")
  local str1 = StringTable.Get("str_n22_entrust_event_exits_rate_leave", "100%%")
  local str2 = StringTable.Get("str_n22_entrust_event_exits_rate_leave_or_goon", rate .. "%%")
  local desc = over and str1 or str2
  local exitTitle = StringTable.Get("str_n22_entrust_event_exits_leave")
  
  local function exitCallback()
    self:_PlayExitAnim()
  end
  
  local confirmTitle = over and "" or StringTable.Get("str_n22_entrust_event_exits_goon")
  
  local function confirmCallback()
    self:_Refresh()
  end
  
  GameGlobal.UIStateManager():ShowDialog("UIN22EntrustMsgPopController", strTitle, desc, exitTitle, exitCallback, confirmTitle, confirmCallback)
end

function UIN22EntrustLevelController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN22EntrustLevelController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN22EntrustLevelController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN22EntrustLevelController:EnterAnimDebugBtnOnClick(go)
  self._showEnterAnim = true
  UIWidgetHelper.SpawnObjects(self, "Nodes", "UIN22EntrustLevelNode", 0)
  UIWidgetHelper.SpawnObjects(self, "Lines", "UIN22EntrustLevelLine", 0)
  local obj = UIWidgetHelper.SpawnObject(self, "Player", "UIN22EntrustLevelPlayer")
  obj:SetShow(false)
  self:_PlayEnterAnim()
end

function UIN22EntrustLevelController:NewNodeDebugBtnOnClick(go)
  local tb = self._component:GetAllOpenEvents(self._levelId)
  local tb_del = {
    tb[#tb]
  }
  self:_Debug_ClearAnimationKey_Node(tb_del)
  self:_Refresh()
end

function UIN22EntrustLevelController:ExitAnimDebugBtnOnClick(go)
  self:_PlayExitAnim(true)
end

function UIN22EntrustLevelController:_Debug_ClearAnimationKey_Node(tb)
  for _, v in ipairs(tb) do
    local key = self._component:GetEntrustEventNewKey(v)
    LocalDB.SetInt(key, 0)
  end
end

function UIN22EntrustLevelController:_SetDebug()
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
end
