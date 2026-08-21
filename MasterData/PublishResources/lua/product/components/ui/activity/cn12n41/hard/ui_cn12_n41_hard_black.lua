_class("UICN12N41HardBlack", Object)
UICN12N41HardBlack = UICN12N41HardBlack

function UICN12N41HardBlack:Constructor(uiView)
  self._uiView = uiView
end

function UICN12N41HardBlack:SetData(campaign, component)
  self._campaign = campaign
  self._blackHardComponent = component
  self._blackHardCompInfo = component:GetComponentInfo()
  self._countdownTimer = {}
  self:_InitLevelData()
end

function UICN12N41HardBlack:Destroy()
  for _, countdownTimer in pairs(self._countdownTimer) do
    countdownTimer = UIActivityHelper.CancelTimerEvent(countdownTimer)
  end
end

function UICN12N41HardBlack:SetActive(status, playAnim)
  UIWidgetHelper.ClearWidgets(self._uiView, "_nodes_Black")
  self._uiView:GetGameObject("_bg_Black"):SetActive(status)
  self._uiView:GetGameObject("_nodes_Black"):SetActive(status)
  if status then
  end
end

function UICN12N41HardBlack:_InitLevelData()
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

function UICN12N41HardBlack:_Refresh(playAnim)
  local nodes = UIWidgetHelper.SpawnObjects(self._uiView, "_nodes_Black", "UICN12N41HardBlackNode", #self._levelDatas)
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

function UICN12N41HardBlack:OnNodeClick(data)
  GameGlobal.UIStateManager():ShowDialog("UIActivityDiffLevelDetail", data, self._blackHardComponent)
end

function UICN12N41HardBlack:ClickNodeByID(id)
  for _, data in ipairs(self._levelDatas) do
    if data:GetMissionId() == id then
      self:OnNodeClick(data)
      return true
    end
  end
  Log.error("[UICN12N41HardBlack] 找不到目标id:", id)
  return false
end
