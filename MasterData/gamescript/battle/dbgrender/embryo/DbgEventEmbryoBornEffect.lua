local UIAnimationController = CS.Z1Client.UIAnimationController
local BloodEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodEffectPath
local BloodCardEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodCardEffectPath
local BloodLineEffectPath = BattleCommonRes.ScoolResources[CommonDefine.AwakerSchool.Caro].BloodLineEffectPath
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local PSystemPlaybackSpdCtrl = CS.PSystemPlaybackSpdCtrl
local DbgEventEmbryoBornEffect, Super = System.NewClass("DbgEventEmbryoBornEffect", DbgEventEffectBase)

function DbgEventEmbryoBornEffect:ctor(uiBinder, battlePanel)
  self.battlePanel = battlePanel
  Super.ctor(self, uiBinder)
end

function DbgEventEmbryoBornEffect:StartEffect(data)
  Super.StartEffect(self, data)
  self.isFree = false
  local cardsUid = self.paramsData
  for i = 1, #cardsUid do
    local cardItem = self.battlePanel:GetCardItemByUid(cardsUid[i])
    cardItem.canvasGroup.alpha = 0
    cardItem.ui.uiNode:SetActive(false)
    cardItem.inAnimation = true
  end
  Awaiter.Dispatch("DbgEventEmbryoBornEffect", 2, false)
end

function DbgEventEmbryoBornEffect:IsFree()
  return self.isFree
end

function DbgEventEmbryoBornEffect:GetResources()
  return {
    BloodEffectPath,
    BloodCardEffectPath,
    BloodLineEffectPath
  }
end

function DbgEventEmbryoBornEffect:Clear()
  self:ReturnGameObject(BloodEffectPath, self.bloodEffect)
  if self.lineEffects then
    for i = 1, #self.lineEffects do
      self:ReturnGameObject(BloodCardEffectPath, self.lineEffects[i].cardEffGo)
      self:ReturnGameObject(BloodLineEffectPath, self.lineEffects[i].lineEffGo)
      self.lineEffects[i]:Clear()
    end
  end
  self.embryoBornEffectAnimController = nil
  self.battlePanel = nil
  self.bloodEffect = nil
  self.lineEffects = nil
  self.isFree = nil
  Super.Clear(self)
end

function DbgEventEmbryoBornEffect:OnResourcesReady()
  self:CreateEffects()
  self:StartPlayBlood()
end

function DbgEventEmbryoBornEffect:CreateEffects()
  if not self.bloodEffect then
    self.bloodEffect = self:FetchGameObject(BloodEffectPath)
  end
  local cardsUid = self.paramsData
  self.lineEffects = self.lineEffects or {}
  while #self.lineEffects < #cardsUid do
    local lineEffGo = self:FetchGameObject(BloodLineEffectPath)
    local cardEffGo = self:FetchGameObject(BloodCardEffectPath)
    local bloodLine = DbgEventEmbryoBornBloodLine(self.binder, self.battlePanel, lineEffGo, cardEffGo)
    table.insert(self.lineEffects, bloodLine)
  end
  local parentTf = self.battlePanel.ui.uiNode.transform
  self.bloodEffect.transform:SetParent(parentTf, false)
  self.bloodEffect.transform:SetAsFirstSibling()
  self.embryoBornEffectAnimController = self.bloodEffect:GetComponent(typeof(UIAnimationController))
  for i = 1, #self.lineEffects do
    self.lineEffects[i]:PrepareBloodLineEffect(cardsUid[i])
  end
end

function DbgEventEmbryoBornEffect:StartPlayBlood()
  local animClip = self.embryoBornEffectAnimController:GetClip("UI_Vx_Battle_XueRou_01").clip
  self.embryoBornEffectAnimController:RemoveAnimationEvent(animClip)
  CS.AMTimeline.AMTimelineUtils.AddAnimationEvent(animClip, 21 / animClip.frameRate, "OnBloodLineStart", "SendLuaEvent")
  local clipsToPlay = ""
  local gameSpeed = BattleEmbryoMgrClient.GetPlaybackSpeed()
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Vx_Battle_XueRou_01")
  self.embryoBornEffectAnimController:RegisterAniamtionEventHander(self.OnCSAnimEvent, self)
  self.embryoBornEffectAnimController:StopPlayableGraph()
  self.embryoBornEffectAnimController:PlayMultiState(clipsToPlay, function()
  end, gameSpeed)
  PSystemPlaybackSpdCtrl.SetPSSpeed(self.bloodEffect, gameSpeed)
  if self.bloodEffect then
    self.bloodEffect:SetActive(true)
  end
  AudioManager.Instance:PostSoundEvent("Play_SFX_Realm_B_Embryo_Gen")
end

function DbgEventEmbryoBornEffect:StartBloodLines()
  local cardsUid = self.paramsData
  if not self.lineEffects or not cardsUid then
    return
  end
  self.finishBloodLineMotionNum = 0
  for i = 1, #self.lineEffects do
    if cardsUid[i] then
      self.lineEffects[i]:StartBloodLineEffect(function()
        self.finishBloodLineMotionNum = self.finishBloodLineMotionNum + 1
        if self.finishBloodLineMotionNum >= #cardsUid then
          if self.bloodEffect then
            self.bloodEffect:SetActive(false)
          end
          self.isFree = true
          for j = 1, #cardsUid do
            local cardItem = self.battlePanel:GetCardItemByUid(cardsUid[j])
            if cardItem then
              cardItem.inAnimation = false
              cardItem.initPos = cardItem.rootRectTransform.anchoredPosition
              cardItem.initIndex = cardItem.rootRectTransform:GetSiblingIndex()
            end
          end
        end
      end)
    end
  end
end

function DbgEventEmbryoBornEffect:OnCSAnimEvent(eventName)
  if "OnBloodLineStart" ~= eventName then
    return
  end
  self:StartBloodLines()
end

return DbgEventEmbryoBornEffect
