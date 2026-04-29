_class("UIN48HardBlack", Object)
UIN48HardBlack = UIN48HardBlack

function UIN48HardBlack:Constructor(uiView)
  self._uiView = uiView
end

function UIN48HardBlack:SetData(campaign, component)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = component:GetComponentInfo()
  self._countdownTimer = {}
  self:_InitLevelData()
end

function UIN48HardBlack:Destroy()
  for _, countdownTimer in pairs(self._countdownTimer) do
    countdownTimer = UIActivityHelper.CancelTimerEvent(countdownTimer)
  end
end

function UIN48HardBlack:SetActive(status, playAnim)
  UIWidgetHelper.ClearWidgets(self._uiView, "_nodes_Black")
  self._uiView:GetGameObject("_nodes_Black"):SetActive(status)
  if status then
  end
end

function UIN48HardBlack:_InitLevelData()
  if not self._levelDatas then
    self._levelDatas = {}
    local componentCfgId = self._blackHardComponent:GetComponentCfgId()
    local cfgs = Cfg.cfg_difficulty_parent_mission({ComponentID = componentCfgId})
    if cfgs ~= nil then
      for k, cfg in pairs(cfgs) do
        local data = UIActivityDiffLevelData:New()
        data:InitParentLevel(self._blackHardComponent, self._blackHardCompInfo, cfg)
        self._levelDatas[#self._levelDatas + 1] = data
      end
    end
  else
    for i = 1, #self._levelDatas do
      self._levelDatas[i]:RefreshParentLevel(self._blackHardComponent, self._blackHardCompInfo)
    end
  end
end

function UIN48HardBlack:_Refresh(playAnim)
  local nodes = UIWidgetHelper.SpawnObjects(self._uiView, "_nodes_Black", "UIN48HardBlackNode", #self._levelDatas)
  self.nodes = nodes
  for i = 1, #nodes do
    local uiNode = nodes[i]
    uiNode:SetData(self._levelDatas[i], function(data)
      self:OnNodeClick(data)
    end)
    uiNode.view:GetGameObject():SetActive(false)
  end
  for j, node in pairs(nodes) do
    self._countdownTimer[j] = GameGlobal.Timer():AddEvent(33 * (j - 1), function()
      node.view:GetGameObject():SetActive(true)
      node:PlayAnime_In()
    end)
  end
end

function UIN48HardBlack:_HideAnim(playAnim)
  if not self.nodes then
    return
  end
  for i = #self.nodes, 1, -1 do
    local node = self.nodes[i]
    node:PlayAnime_Out()
  end
end

function UIN48HardBlack:OnNodeClick(data)
  GameGlobal.UIStateManager():ShowDialog("UIActivityDiffLevelDetail", data, self._blackHardComponent)
end

function UIN48HardBlack:ClickNodeByID(id)
  for _, data in ipairs(self._levelDatas) do
    if data:GetMissionId() == id then
      self:OnNodeClick(data)
      return true
    end
  end
  Log.error("[UIN48HardBlack] 找不到目标id:", id)
  return false
end
