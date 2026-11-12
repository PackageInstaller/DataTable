local MonsterSkillHintIndicator = class("MonsterSkillHintIndicator", BaseCtrl)
MonsterSkillHintIndicator._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"}
}
MonsterSkillHintIndicator._mapEventConfig = {}

function MonsterSkillHintIndicator:Awake()
  self.animtor = self.gameObject:GetComponent("Animator")
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self.nEntityId = nil
end

function MonsterSkillHintIndicator:FadeIn()
end

function MonsterSkillHintIndicator:FadeOut()
end

function MonsterSkillHintIndicator:OnEnable()
end

function MonsterSkillHintIndicator:OnDisable()
  self:UnBindEvent()
end

function MonsterSkillHintIndicator:OnDestroy()
end

function MonsterSkillHintIndicator:OnRelease()
end

function MonsterSkillHintIndicator:SetTarget(nEntityId, _, bHold, fRecycleCallback)
  if self.nEntityId ~= nil then
    printError("重复绑定")
    return
  end
  self.fRecycleCallback = fRecycleCallback
  self.nEntityId = nEntityId
  self.bHold = bHold
  EventManager.AddEntityEvent("AttackHintCancel", self.nEntityId, self, self.OnEvent_SkillCancel)
  EventManager.AddEntityEvent("AttackHint", self.nEntityId, self, self.OnEvent_SkillHint)
  EventManager.AddEntityEvent("AttackHintEnd", self.nEntityId, self, self.OnEvent_SkillEnd)
  EventManager.AddEntityEvent("AttackHintShow", self.nEntityId, self, self.OnEvent_HintShow)
  EventManager.AddEntityEvent("AttackHintHide", self.nEntityId, self, self.OnEvent_HintHide)
  NovaAPI.SetSkillIndicatorTarget(nEntityId, self.gameObject, Vector3.zero)
  self.gameObject:SetActive(self.bHold)
  if self.bHold then
    self.animtor:Play("TemplateMonster_in")
  end
  NovaAPI.SetComponentEnable(self._mapNode.imgIcon, false)
end

function MonsterSkillHintIndicator:UnBindEvent()
  if self.nEntityId == nil then
    return
  end
  if self.endTimer ~= nil then
    self.endTimer:Cancel()
  end
  EventManager.RemoveEntityEvent("AttackHintCancel", self.nEntityId, self, self.OnEvent_SkillCancel)
  EventManager.RemoveEntityEvent("AttackHint", self.nEntityId, self, self.OnEvent_SkillHint)
  EventManager.RemoveEntityEvent("AttackHintEnd", self.nEntityId, self, self.OnEvent_SkillEnd)
  EventManager.RemoveEntityEvent("AttackHintShow", self.nEntityId, self, self.OnEvent_HintShow)
  EventManager.RemoveEntityEvent("AttackHintHide", self.nEntityId, self, self.OnEvent_HintHide)
  if self.fRecycleCallback ~= nil then
    self.fRecycleCallback(self.nEntityId, self, self.bHold)
    self.fRecycleCallback = nil
  end
  self.nEntityId = nil
end

function MonsterSkillHintIndicator:OnEvent_SkillHint()
  if self.endTimer ~= nil then
    printError("已在技能结束处理中")
    return
  end
  self.gameObject:SetActive(true)
  NovaAPI.SetComponentEnable(self._mapNode.imgIcon, true)
  if self.bHold then
    self.animtor:Play("TemplateMonster_loop")
  else
    self.animtor:Play("TemplateMonster_Hint")
  end
end

function MonsterSkillHintIndicator:OnEvent_SkillEnd()
  if self.endTimer ~= nil then
    printError("已在技能结束处理中")
    return
  end
  self.animtor:Play("TemplateMonster_out")
  
  local function EndCallBack()
    if self.bHold then
      self.animtor:Play("TemplateMonster_in")
      NovaAPI.SetComponentEnable(self._mapNode.imgIcon, false)
    else
      self.gameObject:SetActive(false)
    end
    self.endTimer = nil
  end
  
  self.endTimer = self:AddTimer(1, 0.2, EndCallBack, true, true, nil, true)
end

function MonsterSkillHintIndicator:OnEvent_SkillCancel()
  if self.endTimer ~= nil then
    self.endTimer:Cancel()
  end
  if self.bHold then
    self.animtor:Play("TemplateMonster_in")
    NovaAPI.SetComponentEnable(self._mapNode.imgIcon, false)
  else
    self.gameObject:SetActive(false)
  end
  self.endTimer = nil
end

function MonsterSkillHintIndicator:OnEvent_HintShow()
  local indicatorBase = self.gameObject:GetComponent(typeof(CS.IndicatorBase))
  indicatorBase:SetLogicHide(false)
end

function MonsterSkillHintIndicator:OnEvent_HintHide()
  local indicatorBase = self.gameObject:GetComponent(typeof(CS.IndicatorBase))
  indicatorBase:SetLogicHide(true)
end

function MonsterSkillHintIndicator:MonsterDied()
  self:UnBindEvent()
end

return MonsterSkillHintIndicator
