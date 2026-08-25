local UIAnimationController = CS.Z1Client.UIAnimationController
local RelicBattleSceneItemComponent, Super = System.NewComponent("RelicBattleSceneItemComponent")

function RelicBattleSceneItemComponent:ctor(res, relic, relicTipPos, index)
  Super.ctor(self)
  self.res = res
  self.ui = UIBaseResource(res)
  self.relicTipPos = relicTipPos
  self.relic = relic
  self.index = index
  if relic then
    self.relic.tid = relic.tid or relic.relicTid
    self.relic.relicTid = self.relic.tid
    self.relicConfig = DT.RelicConfig[self.relic.tid]
  end
  self._isInBattle = bg.IsInBattle()
end

function RelicBattleSceneItemComponent:OnBind(binder)
  self.binder = binder
  self.animCtrl = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if not self.relic or not self.relic.tid then
    self:SetEmptyState()
    return
  end
  local relicConfig = self.relicConfig or DT.RelicConfig[self.relic.tid]
  binder:SetImage(self.ui.Image_Icon, relicConfig.Icon)
  binder:SetImage(self.ui.Image_Icon_Grey, relicConfig.Icon)
  self.binder:BindToVisible(self.ui.Image_Purify, function()
    do return RelicCfgUtils.GetRelicBgImage end
    return RelicCfgUtils.GetRelicBgImage, self.relic.tid
  end)
  self.binder:BindToImage(self.ui.Image_Purify, function()
    do return RelicCfgUtils.GetRelicBgImage end
    return RelicCfgUtils.GetRelicBgImage, self.relic.tid
  end)
  binder:SetActive(self.ui.Btn_Click, true)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OpenRelicDetailPanel))
  self:_BindLightState()
  self:_BindGreyState()
  self:BindRelicEvents()
end

function RelicBattleSceneItemComponent:BindRelicEvents()
  self.binder:BindEvent(EventMgr.Instance.OnRelicAdd, System.fn(self, self.OnRelicAdd))
  self.binder:BindEvent(EventMgr.Instance.OnRelicEffect, System.fn(self, self.OnRelicEffect))
end

function RelicBattleSceneItemComponent:_BindLightState()
  local layerStateId = self.relicConfig.LayerStateId
  if self._isInBattle and layerStateId then
    local state = self:GetBattleState(layerStateId)
    if not state then
      self.binder:SetText(self.ui.Text_Count, "")
      self.binder:SetActive(self.ui.Text_Count, false)
      self.binder:SetActive(self.ui.Image_Di, false)
      self.binder:SetActive(self.ui.Image_Effect, false)
      self.binder:BindTimer(0.1, 0, nil, System.fn(self, self._BindLightState))
      return
    end
  end
  self.binder:SetActive(self.ui.Text_Count, true)
  self.binder:BindToText(self.ui.Text_Count, function()
    if not layerStateId then
      return ""
    end
    local layer = self:GetStateLayer(layerStateId)
    if layer and layer > 0 then
      return layer
    end
    return ""
  end)
  self.binder:BindToVisible(self.ui.Image_Di, function()
    if not layerStateId then
      return false
    end
    return self:GetStateLayer(layerStateId) > 0
  end)
  self.binder:BindToVisible(self.ui.Image_Effect, function()
    if self:GetIsGrey() then
      return false
    end
    if not layerStateId then
      return false
    end
    do return self.GetIsLight end
    return self.GetIsLight, self
  end)
end

function RelicBattleSceneItemComponent:_BindGreyState()
  local GreyCond = self.relicConfig.GreyCond
  local stateId = self.relicConfig.State1 and self.relicConfig.State1[1]
  if self._isInBattle and stateId and GreyCond then
    local state = self:GetBattleState(stateId)
    if not state then
      self:_SetGreyState(false)
      self.binder:BindTimer(0.1, 0, nil, System.fn(self, self._BindGreyState))
      return
    end
  end
  self.binder:BindToRaw(function(_, isGrey)
    self:_SetGreyState(isGrey)
  end, function()
    do return self.GetIsGrey end
    return self.GetIsGrey, self
  end)
end

function RelicBattleSceneItemComponent:_SetGreyState(isGrey)
  self.ui.Image_Black_Mask:SetActive(isGrey)
  self.ui.Image_Icon:SetActive(not isGrey)
  self.ui.Image_Icon_Grey:SetActive(isGrey)
end

function RelicBattleSceneItemComponent:OnRelicAdd(tid)
  local match = self.relic and tid == self.relic.tid
  if match then
    self:ShowTriggerEffect()
  end
end

function RelicBattleSceneItemComponent:OnRelicEffect(tid)
  local match = self.relic and tid == self.relic.tid
  if match then
    self:ShowTriggerEffect()
  end
end

function RelicBattleSceneItemComponent:GetStateLayer(stateId)
  if not stateId then
    return 0
  end
  if self._isInBattle then
    local state = self:GetBattleState(stateId)
    return state and state.layer or 0
  else
    return StateDataUtils.GetLayer(stateId) or 0
  end
end

function RelicBattleSceneItemComponent:GetBattleState(stateId)
  if not self._isInBattle or not bg.battleDataCenter then
    return nil
  end
  do return bg.battleDataCenter.GetPlayerStateById, bg.battleDataCenter end
  return bg.battleDataCenter.GetPlayerStateById, bg.battleDataCenter, stateId
end

function RelicBattleSceneItemComponent:SetEmptyState()
  self.ui.Image_Icon:SetActive(false)
  self.ui.Image_Icon_Grey:SetActive(false)
  self.ui.Image_Black_Mask:SetActive(false)
  self.ui.Text_Count:SetActive(false)
  self.ui.Image_Di:SetActive(false)
  self.ui.Image_Effect:SetActive(false)
  self.ui.Image_Purify:SetActive(false)
  self.ui.Btn_Click:SetActive(false)
end

function RelicBattleSceneItemComponent:GetIsGrey()
  if not (self.relicConfig and self.relic) or not self.relic.tid then
    return false
  end
  local GreyCond = self.relicConfig.GreyCond
  local stateId = self.relicConfig.State1 and self.relicConfig.State1[1]
  if GreyCond and stateId then
    local layer = self:GetStateLayer(stateId)
    if layer == GreyCond then
      return true
    end
  end
  return false
end

function RelicBattleSceneItemComponent:GetIsLight(lightState)
  local LightCond = self.relicConfig.LightCond
  if not LightCond then
    return false
  end
  local layerStateId = self.relicConfig.LayerStateId
  if not layerStateId then
    return false
  end
  local lightLayer = self:GetStateLayer(layerStateId) or 0
  if lightLayer <= 0 then
    return false
  end
  if type(LightCond) == "table" then
    for _, layer in ipairs(LightCond) do
      if layer == lightLayer then
        return true
      end
    end
  end
  return false
end

function RelicBattleSceneItemComponent:OpenRelicDetailPanel()
  print("--------------RelicBattleSceneItemComponent:OpenRelicDetailPanel ==== ", self.relic.tid)
  self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, {
    value = self.relic
  }, {
    stageId = DataCenter.playerData.DRole.level,
    isGrey = self:GetIsGrey()
  })
end

function RelicBattleSceneItemComponent:SetItemPosition(parentTransform)
  self.ui.uiNode.transform.pivot = parentTransform.pivot
  self.ui.uiNode.transform.position = parentTransform.position
end

function RelicBattleSceneItemComponent:ShowTriggerEffect()
  if not self.relic or not self.relic.tid then
    return
  end
  if self._isInTriggerEffect then
    return
  end
  self._isInTriggerEffect = true
  self.binder:SetActive(self.ui.Light_Effect, true)
  local particle = self.ui.Light_Effect:GetComponent(typeof(CS.UnityEngine.ParticleSystem))
  particle:Play()
  self.binder:BindTimer(0.8, 0, nil, function()
    self.binder:SetActive(self.ui.Light_Effect, false)
    self._isInTriggerEffect = false
  end)
  if not IsNil(self.animCtrl) then
    self.animCtrl:StopPlayableGraph()
    self.animCtrl:PlayState("Item_Battle_Dbg_Relic_Open")
  end
end

function RelicBattleSceneItemComponent:OnUnbind()
  if not IsNil(self.animCtrl) then
    self.animCtrl:StopPlayableGraph()
    self.animCtrl = nil
  end
  Super.OnUnbind(self)
end

return RelicBattleSceneItemComponent
