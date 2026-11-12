local BossSkillHintIndicator = class("BossSkillHintIndicator", BaseCtrl)
BossSkillHintIndicator._mapNodeConfig = {
  ImageIcon = {sComponentName = "Image"},
  ImageBossIconBtn = {
    sNodeName = "ImageBossIcon",
    sComponentName = "Button"
  },
  ImageBossWarn = {},
  ImageArrow = {sComponentName = "Button"}
}
BossSkillHintIndicator._mapEventConfig = {}

function BossSkillHintIndicator:Awake()
  self.animtor = self.gameObject:GetComponent("Animator")
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self.nEntityId = nil
end

function BossSkillHintIndicator:FadeIn()
end

function BossSkillHintIndicator:FadeOut()
end

function BossSkillHintIndicator:OnEnable()
end

function BossSkillHintIndicator:OnDisable()
  self:UnBindEvent()
end

function BossSkillHintIndicator:OnDestroy()
end

function BossSkillHintIndicator:OnRelease()
end

function BossSkillHintIndicator:SetTarget(nEntityId, nBossSkinId, bHold, fRecycleCallback)
  if self.nEntityId ~= nil then
    printError("重复绑定")
    return
  end
  self.fRecycleCallback = fRecycleCallback
  self.nEntityId = nEntityId
  self.bHold = bHold
  local mapMonsterSkin = ConfigTable.GetData("MonsterSkin", nBossSkinId)
  local previewMonster
  if mapMonsterSkin.MonsterManual ~= "" then
    previewMonster = ConfigTable.GetData("MonsterManual", mapMonsterSkin.MonsterManual)
  end
  if self.bHold and previewMonster ~= nil and (previewMonster.Icon ~= nil or previewMonster.Icon ~= "") then
    self:SetPngSprite(self._mapNode.ImageIcon, previewMonster.Icon)
  else
  end
  EventManager.AddEntityEvent("AttackHintCancel", self.nEntityId, self, self.OnEvent_SkillCancel)
  EventManager.AddEntityEvent("AttackHint", self.nEntityId, self, self.OnEvent_SkillHint)
  EventManager.AddEntityEvent("AttackHintEnd", self.nEntityId, self, self.OnEvent_SkillEnd)
  EventManager.AddEntityEvent("AttackHintShow", self.nEntityId, self, self.OnEvent_HintShow)
  EventManager.AddEntityEvent("AttackHintHide", self.nEntityId, self, self.OnEvent_HintHide)
  self._mapNode.ImageBossWarn:SetActive(false)
  self.gameObject:SetActive(self.bHold)
  self.animtor:Play("TemplateBoss_in")
  NovaAPI.SetSkillIndicatorTarget(nEntityId, self.gameObject, Vector3.zero)
end

function BossSkillHintIndicator:UnBindEvent()
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

function BossSkillHintIndicator:OnEvent_SkillHint()
  if self.endTimer ~= nil then
    printError("已在技能结束处理中")
    return
  end
  self.gameObject:SetActive(true)
  self._mapNode.ImageBossWarn:SetActive(true)
  self.animtor:Play("TemplateBoss_Hint")
end

function BossSkillHintIndicator:OnEvent_SkillEnd()
  if self.endTimer ~= nil then
    printError("已在技能结束处理中")
    return
  end
  self.animtor:Play("TemplateBoss_out_2")
  
  local function EndCallBack()
    self.animtor:Play("TemplateBoss_in_loop")
    self._mapNode.ImageBossWarn:SetActive(false)
    self.endTimer = nil
  end
  
  self.endTimer = self:AddTimer(1, 0.5, EndCallBack, true, true, nil, true)
end

function BossSkillHintIndicator:OnEvent_SkillCancel()
  if self.endTimer ~= nil then
    self.endTimer:Cancel()
  end
  if self.bHold then
    self.animtor:Play("TemplateBoss_in_loop")
  else
    self.gameObject:SetActive(false)
  end
  self._mapNode.ImageBossWarn:SetActive(false)
  self.endTimer = nil
end

function BossSkillHintIndicator:OnEvent_HintShow()
  local indicatorBase = self.gameObject:GetComponent(typeof(CS.IndicatorBase))
  indicatorBase:SetLogicHide(false)
end

function BossSkillHintIndicator:OnEvent_HintHide()
  local indicatorBase = self.gameObject:GetComponent(typeof(CS.IndicatorBase))
  indicatorBase:SetLogicHide(true)
end

function BossSkillHintIndicator:MonsterDied()
  self:UnBindEvent()
end

return BossSkillHintIndicator
