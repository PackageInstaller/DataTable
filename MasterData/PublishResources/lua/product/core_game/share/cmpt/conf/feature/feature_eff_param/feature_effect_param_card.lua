_class("FeatureEffectParamCard", FeatureEffectParamBase)
FeatureEffectParamCard = FeatureEffectParamCard

function FeatureEffectParamCard:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamCard:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillDic then
    self._skillDic = t.SkillDic
  end
  if t.CardMax then
    self._cardMax = t.CardMax
  end
  if t.InitCardNum then
    self._initCardNum = t.InitCardNum
  end
  if t.InitCardList then
    self._initCardList = t.InitCardList
  end
  if t.DrawCardFixedList then
    self._drawCardFixedList = t.DrawCardFixedList
  end
  if t.DefaultWeightNum then
    self._defaultWeightNum = t.DefaultWeightNum
  end
  if t.WeightIncreaseNum then
    self._weightIncreaseNum = t.WeightIncreaseNum
  end
  if t.UiType then
    self._uiType = t.UiType
  end
end

function FeatureEffectParamCard:GetFeatureType()
  return FeatureType.Card
end

function FeatureEffectParamCard:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamCard:CloneSelf()
  local param = FeatureEffectParamCard:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamCard:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamCard:GetCardSkillDic()
  return self._skillDic
end

function FeatureEffectParamCard:GetCardMax()
  return self._cardMax
end

function FeatureEffectParamCard:GetInitCardNum()
  return self._initCardNum
end

function FeatureEffectParamCard:GetInitCardList()
  return self._initCardList
end

function FeatureEffectParamCard:GetDrawCardFixedList()
  return self._drawCardFixedList
end

function FeatureEffectParamCard:GetFixedDrawCard(times)
  local card
  if self._drawCardFixedList then
    card = self._drawCardFixedList[times]
  end
  return card
end

function FeatureEffectParamCard:GetDefaultWeightNum()
  return self._defaultWeightNum or 5
end

function FeatureEffectParamCard:GetWeightIncreaseNum()
  return self._weightIncreaseNum or 1
end

function FeatureEffectParamCard:GetUiType()
  return self._uiType or FeatureCardUiType.Default
end
