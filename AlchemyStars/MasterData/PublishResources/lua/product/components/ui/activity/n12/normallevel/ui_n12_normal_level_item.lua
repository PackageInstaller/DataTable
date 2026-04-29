_class("UIN12NormalLevelItem", UICustomWidget)
UIN12NormalLevelItem = UIN12NormalLevelItem

function UIN12NormalLevelItem:Constructor()
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12NormalLevelItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12NormalLevelItem:_GetComponent()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._gainType = self:GetUIComponent("Image", "GainType")
  self._animation = self.view.gameObject:GetComponent("Animation")
end

function UIN12NormalLevelItem:SetData(id, index)
  local missionAffixCfg = Cfg.cfg_component_mission_affix[id]
  if not missionAffixCfg then
    Log.error("cfg_component_mission_affix does not exist." .. id)
    return
  end
  local affixCfg = Cfg.cfg_affix[missionAffixCfg.AffixID]
  if not affixCfg then
    Log.error("cfg_affix does not exist." .. missionAffixCfg.AffixID)
    return
  end
  N12ToolFunctions.SetAffixText(self._text, affixCfg)
  self._gainType.sprite = self._atlas:GetSprite(GainTypeSprite[missionAffixCfg.GainType])
  self:_PlayAnimation(index)
end

function UIN12NormalLevelItem:_PlayAnimation(index)
  if self._animationTask then
    GameGlobal.TaskManager():KillTask(self._animationTask)
    self._animationTask = nil
  end
  self._animationTask = self:StartTask(function(TT)
    YIELD(TT, index * 33)
    self._animation:Stop()
    self._animation:Play("uieff_N12_Normal_Item_In")
  end)
end
