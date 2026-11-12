local HintIndicators = class("HintIndicators", BaseCtrl)
HintIndicators._mapNodeConfig = {
  canvas_group = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  IndictorArea = {sComponentName = "Transform"},
  TemplateBossIndicator = {},
  TemplateMonsterIndictor = {}
}
HintIndicators._mapEventConfig = {
  MonsterActive = "OnEvent_MonsterActive",
  InputEnable = "OnEvent_InputEnable"
}

function HintIndicators:Awake()
  self.tbAllIndicators = {}
  self.mapActiveIndicator = {}
  self.tbPoolBossIndicator = {}
  self.tbPoolMonsterIndicator = {}
end

function HintIndicators:FadeIn()
end

function HintIndicators:FadeOut()
end

function HintIndicators:OnEnable()
end

function HintIndicators:OnDisable()
  self:ClearAllCtrl()
end

function HintIndicators:OnDestroy()
end

function HintIndicators:OnRelease()
end

function HintIndicators:GetIndicator(bHold)
  if not bHold then
    if #self.tbPoolMonsterIndicator > 0 then
      local mapCtrl = table.remove(self.tbPoolMonsterIndicator)
      return mapCtrl
    else
      local goIndicator = instantiate(self._mapNode.TemplateMonsterIndictor, self._mapNode.IndictorArea)
      local rtIndicator = goIndicator:GetComponent("RectTransform")
      rtIndicator.localScale = Vector3.one
      rtIndicator.localPosition = Vector3.zero
      local mapCtrl = self:BindCtrlByNode(goIndicator, "Game.UI.Battle.SkillHintIndicator.MonsterSkillHintIndicator")
      table.insert(self.tbAllIndicators, mapCtrl)
      return mapCtrl
    end
  elseif 0 < #self.tbPoolBossIndicator then
    local mapCtrl = table.remove(self.tbPoolBossIndicator)
    return mapCtrl
  else
    local goIndicator = instantiate(self._mapNode.TemplateBossIndicator, self._mapNode.IndictorArea)
    local rtIndicator = goIndicator:GetComponent("RectTransform")
    rtIndicator.localScale = Vector3.one
    rtIndicator.localPosition = Vector3.zero
    local mapCtrl = self:BindCtrlByNode(goIndicator, "Game.UI.Battle.SkillHintIndicator.BossSkillHintIndicator")
    table.insert(self.tbAllIndicators, mapCtrl)
    return mapCtrl
  end
end

function HintIndicators:OnEvent_MonsterSpawn(nEntityId, nDataId)
  local mapMonster = ConfigTable.GetData("Monster", nDataId)
  if mapMonster == nil then
    printError("Monster Data Missing:" .. nDataId)
    return
  end
  local mapMonsterSkin = ConfigTable.GetData("MonsterSkin", mapMonster.FAId)
  if mapMonsterSkin == nil then
    printError("MonsterSkin Data Missing:" .. mapMonster.FAId)
    return
  end
  if mapMonster.AttackHintType ~= nil and mapMonster.AttackHintType ~= GameEnum.AttackHintType.Null then
    if self.mapActiveIndicator[nEntityId] ~= nil then
      printError("重复EntityId绑定指示器：" .. nEntityId)
      return
    end
    local mapCtrl = self:GetIndicator(mapMonster.AttackHintType == GameEnum.AttackHintType.Always)
    
    local function RecycleCallback(nCtrlEntityId, goCtrl, bHold)
      if not bHold then
        table.insert(self.tbPoolMonsterIndicator, goCtrl)
      else
        table.insert(self.tbPoolBossIndicator, goCtrl)
      end
      goCtrl.gameObject:SetActive(false)
      if self.mapActiveIndicator[nCtrlEntityId] ~= nil then
        self.mapActiveIndicator[nCtrlEntityId] = nil
      end
    end
    
    mapCtrl:SetTarget(nEntityId, mapMonster.FAId, mapMonster.AttackHintType == GameEnum.AttackHintType.Always, RecycleCallback)
    self.mapActiveIndicator[nEntityId] = mapCtrl
  end
end

function HintIndicators:OnEvent_MonsterDied(nEntityId)
  if self.mapActiveIndicator[nEntityId] ~= nil then
    self.mapActiveIndicator[nEntityId]:UnBindEvent()
  end
end

function HintIndicators:OnEvent_MonsterActive(nEntityId, dataID, bShow)
  if bShow then
    self:OnEvent_MonsterSpawn(nEntityId, dataID)
  else
    self:OnEvent_MonsterDied(nEntityId)
  end
end

function HintIndicators:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
end

function HintIndicators:ClearAllCtrl()
  for _, mapCtrl in ipairs(self.mapActiveIndicator) do
    mapCtrl:UnBindEvent()
  end
  for _, mapCtrl in pairs(self.tbAllIndicators) do
    local go = mapCtrl.gameObject
    self:UnbindCtrlByNode(mapCtrl)
    destroy(go)
  end
  self.tbAllIndicators = {}
  self.mapActiveIndicator = {}
  self.tbPoolBossIndicator = {}
end

return HintIndicators
