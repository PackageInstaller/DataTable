_class("TalentComponent", Object)
TalentComponent = TalentComponent

function TalentComponent:Constructor()
  self._talentDataList = {}
  self._unlockRelicIDList = {}
  self._isChosenOpeningRelic = false
end

function TalentComponent:AddTalentData(talentType, param)
  if not self._talentDataList[talentType] then
    self._talentDataList[talentType] = {}
  end
  table.insert(self._talentDataList[talentType], param)
end

function TalentComponent:HasTalentData(talentType)
  return self._talentDataList[talentType] ~= nil
end

function TalentComponent:GetTalentDataList(talentType)
  return self._talentDataList[talentType]
end

function TalentComponent:SetUnlockRelicIDList(relicIDList)
  self._unlockRelicIDList = relicIDList
end

function TalentComponent:GetUnlockRelicIDList()
  return self._unlockRelicIDList
end

function TalentComponent:SetIsChosenOpeningRelic(isChosen)
  self._isChosenOpeningRelic = isChosen
end

function TalentComponent:IsChosenOpeningRelic()
  return self._isChosenOpeningRelic
end

function Entity:Talent()
  return self:GetComponent(self.WEComponentsEnum.Talent)
end

function Entity:HasTalent()
  return self:HasComponent(self.WEComponentsEnum.Talent)
end

function Entity:AddTalent()
  local index = self.WEComponentsEnum.Talent
  local component = TalentComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTalent()
  local index = self.WEComponentsEnum.Talent
  local component = TalentComponent:New()
  self:ReplaceComponent(index, component)
end
