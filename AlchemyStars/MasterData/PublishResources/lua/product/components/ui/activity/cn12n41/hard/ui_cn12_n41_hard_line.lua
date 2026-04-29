_class("UICN12N41HardLine", Object)
UICN12N41HardLine = UICN12N41HardLine

function UICN12N41HardLine:Constructor(uiView)
  self._uiView = uiView
end

function UICN12N41HardLine:Destroy()
  for _, countdownTimer in pairs(self._countdownTimer) do
    countdownTimer = UIActivityHelper.CancelTimerEvent(countdownTimer)
  end
end

function UICN12N41HardLine:SetData(campaign, component)
  self._campaign = campaign
  self._line_component = component
  self._countdownTimer = {}
end

function UICN12N41HardLine:SetActive(status, playAnim)
  UIWidgetHelper.ClearWidgets(self._uiView, "_nodes_Line")
  self._uiView:GetGameObject("_bg_Line"):SetActive(status)
  self._uiView:GetGameObject("_nodes_Line"):SetActive(status)
  if status then
  end
end

function UICN12N41HardLine:_Refresh(playAnim)
  local cfgs = UIActivityHardLineHelper.GetLineMissionCfgs(self._line_component)
  local passInfo = self._line_component:GetComponentInfo().m_pass_mission_info
  local nodes = UIWidgetHelper.SpawnObjects(self._uiView, "_nodes_Line", "UICN12N41HardLineNode", #cfgs)
  local index = 1
  for _, cfg in pairs(cfgs) do
    local uiNode = nodes[index]
    index = index + 1
    uiNode:SetData(cfg, passInfo, function(stageId, isStory)
      self:_OnNodeClick(stageId, isStory)
    end)
    uiNode.view:GetGameObject():SetActive(false)
  end
  for i = #nodes, 1, -1 do
    local node = nodes[i]
    self._countdownTimer[i] = GameGlobal.Timer():AddEvent(66 * (#nodes - i), function()
      node.view:GetGameObject():SetActive(true)
      node:PlayAnime_In()
    end)
  end
end

function UICN12N41HardLine:_OnNodeClick(stageId, isStory)
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._line_component, stageId, function()
      self:SwitchState(UIStateType.UICN12N41HardController)
    end)
  else
    UIActivityLineMissionHelper.EnterStage_Battle(self._campaign, self._line_component, stageId, true, true)
  end
end
