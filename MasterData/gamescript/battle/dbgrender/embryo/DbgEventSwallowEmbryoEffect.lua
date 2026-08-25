local UIAnimationController = CS.Z1Client.UIAnimationController
local BloodSwallowEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodSwallowEffectPath
local BloodCardEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodCardEffectPath
local BloodLineEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodLineEffectPath
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local PSystemPlaybackSpdCtrl = CS.PSystemPlaybackSpdCtrl
local DbgEventSwallowEmbryoEffect, Super = System.NewClass("DbgEventSwallowEmbryoEffect", DbgEventEffectBase)

function DbgEventSwallowEmbryoEffect:ctor(uiBinder, battlePanel)
  self.battlePanel = battlePanel
  Super.ctor(self, uiBinder)
end

function DbgEventSwallowEmbryoEffect:StartEffect(data)
  if self.isRunning then
    for i = 1, #data do
      self:AppendEffect(data[i])
    end
    return
  end
  Super.StartEffect(self, data)
  local cardsUid = self.paramsData
  for i = 1, #cardsUid do
    local cardItem = self.battlePanel:GetCardItemByUid(cardsUid[i])
    self:PrepareCardItem(cardItem)
  end
  self.isFree = true
  self.swallowEffectPlayed = false
  self.isRunning = true
  if bg.battleRender then
    bg.battleRender.embryoMgr:StartSwallowEmbryo()
  end
end

function DbgEventSwallowEmbryoEffect:AppendEffect(cardUid)
  table.insert(self.paramsData, cardUid)
  local cardItem = self.battlePanel:GetCardItemByUid(cardUid)
  self:PrepareCardItem(cardItem)
  if self:IsResourcesReady() then
    self:CreateLineEffects()
    local index = #self.paramsData
    self.lineEffects[index]:PrepareBloodLineEffect(self.paramsData[index])
    self:PlaySwallowBloodLine(self.lineEffects[index])
  end
end

function DbgEventSwallowEmbryoEffect:PrepareCardItem(cardItem)
  cardItem.canvasGroup.alpha = 1
  cardItem.ui.uiNode:SetActive(true)
  cardItem.inAnimation = true
end

function DbgEventSwallowEmbryoEffect:IsFree()
  return self.isFree
end

function DbgEventSwallowEmbryoEffect:GetResources()
  return {
    BloodSwallowEffectPath,
    BloodCardEffectPath,
    BloodLineEffectPath
  }
end

function DbgEventSwallowEmbryoEffect:Clear()
  self:StopNotFreeTimer()
  self:ReturnGameObject(BloodSwallowEffectPath, self.bloodSwallowEffect)
  if self.lineEffects then
    for i = 1, #self.lineEffects do
      self:ReturnGameObject(BloodCardEffectPath, self.lineEffects[i].cardEffGo)
      self:ReturnGameObject(BloodLineEffectPath, self.lineEffects[i].lineEffGo)
      self.lineEffects[i]:Clear()
    end
  end
  self.bloodEffectAnimController = nil
  self.battlePanel = nil
  self.bloodSwallowEffect = nil
  self.lineEffects = nil
  self.swallowEffectPlayed = nil
  self.isFree = nil
  Super.Clear(self)
end

function DbgEventSwallowEmbryoEffect:OnResourcesReady()
  self:CreateEffects()
  self:StartPlaySwallowBloodLines()
end

function DbgEventSwallowEmbryoEffect:CreateEffects()
  if not self.bloodSwallowEffect then
    self.bloodSwallowEffect = self:FetchGameObject(BloodSwallowEffectPath)
  end
  self:CreateLineEffects()
  local cardsUid = self.paramsData
  local parentTf = self.battlePanel.ui.uiNode.transform
  self.bloodSwallowEffect.transform:SetParent(parentTf, false)
  self.bloodSwallowEffect.transform:SetAsFirstSibling()
  self.bloodEffectAnimController = self.bloodSwallowEffect:GetComponent(typeof(UIAnimationController))
  for i = 1, #self.lineEffects do
    self.lineEffects[i]:PrepareBloodLineEffect(cardsUid[i])
  end
  self.bloodSwallowEffect:SetActive(false)
end

function DbgEventSwallowEmbryoEffect:CreateLineEffects()
  local cardsUid = self.paramsData
  self.lineEffects = self.lineEffects or {}
  while #self.lineEffects < #cardsUid do
    local lineEffGo = self:FetchGameObject(BloodLineEffectPath)
    local cardEffGo = self:FetchGameObject(BloodCardEffectPath)
    local bloodLine = DbgEventSwallowEmbryoBloodLine(self.binder, self.battlePanel, lineEffGo, cardEffGo)
    table.insert(self.lineEffects, bloodLine)
  end
end

function DbgEventSwallowEmbryoEffect:StopNotFreeTimer()
  if self.notFreeTimer then
    TimerManager.Instance:StopTimer(self.notFreeTimer)
    self.notFreeTimer = nil
  end
end

function DbgEventSwallowEmbryoEffect:StopLinesTimer()
  if self.lineEffects then
    for i = 1, #self.lineEffects do
      self.lineEffects[i]:StopCardFadeTimer()
    end
  end
end

function DbgEventSwallowEmbryoEffect:StartPlaySwallowBloodLines()
  self:StopNotFreeTimer()
  self.notFreeTimer = TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
    self.isFree = false
  end)
  local cardsUid = self.paramsData
  for i = 1, #self.lineEffects do
    if cardsUid[i] then
      self:PlaySwallowBloodLine(self.lineEffects[i])
    end
  end
end

function DbgEventSwallowEmbryoEffect:PlaySwallowBloodLine(eff)
  eff:SetSwallowEffectStartFunc(function()
  end)
  eff:SetCardItemDisappearFunc(function()
  end)
  eff:StartBloodLineEffect()
  bg.battleRender:PerformWithDelay(0.75, function()
    self:StartSwallowBlood()
  end, self)
end

function DbgEventSwallowEmbryoEffect:StartSwallowBlood()
  if self.swallowEffectPlayed then
    return
  end
  self:StopNotFreeTimer()
  self.swallowEffectPlayed = true
  self.bloodSwallowEffect:SetActive(true)
  local clipsToPlay = ""
  local gameSpeed = BattleEmbryoMgrClient.GetPlaybackSpeed()
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Vx_Battle_XueRou_03")
  PSystemPlaybackSpdCtrl.SetPSSpeed(self.bloodSwallowEffect, gameSpeed)
  self.bloodEffectAnimController:PlayMultiState(clipsToPlay, function()
    self:StopLinesTimer()
    self:StopNotFreeTimer()
    local cardsUid = self.paramsData
    self.isFree = true
    self.isRunning = false
    if self.bloodSwallowEffect then
      self.bloodSwallowEffect:SetActive(false)
    end
    if not cardsUid then
      if bg.battleRender then
        bg.battleRender.embryoMgr:CompleteSwallowEmbryo()
      end
      return
    end
    for j = 1, #cardsUid do
      local cardItem = self.battlePanel:GetCardItemByUid(cardsUid[j])
      if cardItem then
        cardItem.inAnimation = false
      end
    end
    if bg.battleRender then
      bg.battleRender.embryoMgr:CompleteSwallowEmbryo()
    end
  end, gameSpeed)
end

return DbgEventSwallowEmbryoEffect
