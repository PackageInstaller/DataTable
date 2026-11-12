local FRIndicators = class("FRIndicators", BaseCtrl)
FRIndicators._mapNodeConfig = {
  canvasGroup = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  IndictorArea = {sComponentName = "Transform"},
  TemplateBoxIndicator = {},
  TemplateTeleportIndicator = {},
  TemplateBossIndicator = {},
  TemplateNPCIndicator = {}
}
FRIndicators._mapEventConfig = {
  SetIndicator = "OnEvent_SetIndicator",
  FRRoomEnd = "OnEvent_LevelEnd",
  SetIndicatorEnemy = "OnEvent_SetIndicatorEnemy",
  LevelStateChanged = "OnEvent_LevelStateChanged",
  InputEnable = "OnEvent_InputEnable"
}

function FRIndicators:Awake()
  self.tbIndicators = {}
  self.tbEnemyIndicators = {}
end

function FRIndicators:FadeIn()
end

function FRIndicators:FadeOut()
end

function FRIndicators:OnEnable()
end

function FRIndicators:OnDisable()
end

function FRIndicators:OnDestroy()
end

function FRIndicators:OnRelease()
end

function FRIndicators:OnEvent_SetIndicator(nType, rtTransform, v3Offset, sIconPath)
  if #self.tbIndicators > 10 then
    printError("箱子传送门指示器数量上限")
    return
  end
  if nType == 1 then
    local go = instantiate(self._mapNode.TemplateBoxIndicator, self._mapNode.IndictorArea)
    local comp = go:GetComponent(typeof(CS.FRIndicator))
    go:SetActive(true)
    if comp ~= nil then
      comp:SetFollowTarget(rtTransform, v3Offset)
    end
    table.insert(self.tbIndicators, go)
  elseif nType == 2 then
    local go = instantiate(self._mapNode.TemplateTeleportIndicator, self._mapNode.IndictorArea)
    local comp = go:GetComponent(typeof(CS.FRIndicator))
    go:SetActive(true)
    if comp ~= nil then
      comp:SetFollowTarget(rtTransform, v3Offset)
    end
    table.insert(self.tbIndicators, go)
  elseif nType == 3 and sIconPath ~= nil and sIconPath ~= "" then
    local go = instantiate(self._mapNode.TemplateNPCIndicator, self._mapNode.IndictorArea)
    local comp = go:GetComponent(typeof(CS.FRIndicator))
    go:SetActive(true)
    if comp ~= nil then
      comp:SetFollowTarget(rtTransform, v3Offset)
    end
    local img = go.transform:Find("Icon")
    self:SetAtlasSprite(img:GetComponent("Image"), "15_battle", sIconPath)
    table.insert(self.tbIndicators, go)
  end
end

function FRIndicators:OnEvent_SetIndicatorEnemy(nEntityId, v3Offset)
  if #self.tbEnemyIndicators > 10 then
    printError("敌人指示器数量上限")
    return
  end
  local go = instantiate(self._mapNode.TemplateBossIndicator, self._mapNode.IndictorArea)
  go:SetActive(true)
  CS.AdventureModuleHelper.SetBossIndicatorTarget(nEntityId, go, v3Offset)
  table.insert(self.tbEnemyIndicators, go)
end

function FRIndicators:OnEvent_LevelStateChanged()
  for _, goIndicators in pairs(self.tbEnemyIndicators) do
    destroy(goIndicators)
  end
  self.tbEnemyIndicators = {}
end

function FRIndicators:OnEvent_LevelEnd()
  for _, goIndicators in pairs(self.tbIndicators) do
    destroy(goIndicators)
  end
  for _, goIndicators in pairs(self.tbEnemyIndicators) do
    destroy(goIndicators)
  end
  self.tbIndicators = {}
end

function FRIndicators:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, bEnable == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, bEnable == true)
end

return FRIndicators
