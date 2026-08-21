_class("LogicAutoBeadComponent", Object)
LogicAutoBeadComponent = LogicAutoBeadComponent

function LogicAutoBeadComponent:Constructor()
  self._attachTeamEntityID = 0
  self._autoBeadList = {}
  self._autoBeadPoint = 0
  self._autoBeadPointEachPower = 0
  self._autoBeadInnerDataList = {}
end

function LogicAutoBeadComponent:SetAttachTeamEntityID(entityID)
  self._attachTeamEntityID = entityID
end

function LogicAutoBeadComponent:GetAttachTeamEntityID()
  return self._attachTeamEntityID
end

function LogicAutoBeadComponent:SetAutoBeadList(autoBeadList)
  self._autoBeadList = autoBeadList
end

function LogicAutoBeadComponent:GetAutoBeadList()
  return self._autoBeadList
end

function LogicAutoBeadComponent:SetAutoBeadInnerDataList(dataList)
  self._autoBeadInnerDataList = dataList
end

function LogicAutoBeadComponent:GetAutoBeadInnerDataList()
  return self._autoBeadInnerDataList
end

function LogicAutoBeadComponent:GetAutoBeadInnerDataByID(autoBeadID)
  if self._autoBeadInnerDataList then
    for index, data in ipairs(self._autoBeadInnerDataList) do
      if data:GetAutoBeadID() == autoBeadID then
        return data
      end
    end
  end
end

function LogicAutoBeadComponent:GetAutoBeadPower()
  if self._autoBeadPointEachPower <= 0 then
    return 0, self._autoBeadPoint
  end
  local power = math.floor(self._autoBeadPoint / self._autoBeadPointEachPower)
  local restPoint = self._autoBeadPoint - power * self._autoBeadPointEachPower
  return power, restPoint
end

function LogicAutoBeadComponent:SetAutoBeadPoint(point)
  self._autoBeadPoint = point
end

function LogicAutoBeadComponent:GetAutoBeadPoint()
  return self._autoBeadPoint
end

function LogicAutoBeadComponent:SetAutoBeadPointEachPower(point)
  self._autoBeadPointEachPower = point
end

function LogicAutoBeadComponent:GetAutoBeadPointEachPower()
  return self._autoBeadPointEachPower
end

function LogicAutoBeadComponent:GetAutoBeadInnerDataListByTag(tagList)
  if not tagList then
    return self._autoBeadInnerDataList
  end
  if type(tagList) ~= "table" then
    tagList = {tagList}
  end
  local filterArray = {}
  for index, value in ipairs(self._autoBeadInnerDataList) do
    local data = value
    local autoBeadTagList = data:GetAutoBeadTag()
    local bTagMatch = false
    for index, tag in ipairs(tagList) do
      if table.icontains(autoBeadTagList, tag) then
        bTagMatch = true
        break
      end
    end
    if bTagMatch then
      table.insert(filterArray, data)
    end
  end
  return filterArray
end

function LogicAutoBeadComponent:SetExtraRateByTag(tagList, rate)
  local filterArray = self:GetAutoBeadInnerDataListByTag(tagList)
  for index, value in ipairs(filterArray) do
    local data = value
    data:SetAutoBeadExtraRate(rate)
  end
end

function LogicAutoBeadComponent:AddAttrByTag(tagList, attrKey, addVal)
  local filterArray = self:GetAutoBeadInnerDataListByTag(tagList)
  for index, value in ipairs(filterArray) do
    local data = value
    data:AddAutoBeadAttr(attrKey, addVal)
  end
end

function LogicAutoBeadComponent:WEC_PostInitialize(owner)
end

function LogicAutoBeadComponent:WEC_PostRemoved()
end

_class("AutoBeadInnerData", Object)
AutoBeadInnerData = AutoBeadInnerData

function AutoBeadInnerData:Constructor()
  self.ID = 0
  self.AutoBeadAttrMap = {}
  self.SkillID = 0
  self.BuffID = {}
  self.BuffTargetType = 0
  self.BuffTargetParam = {}
  self.Tag = {}
  self.ExtraRate = 0
end

function AutoBeadInnerData:InitByDataAndCfg(data, cfg)
  self.ID = data.bead_id
  self.AutoBeadAttrMap = table.clone(data.att_info)
  if cfg then
    self.Tag = cfg.Tag
    self.SkillID = cfg.SkillID
    self.BuffID = cfg.BuffID
    if type(self.BuffID) ~= "table" then
      self.BuffID = {
        self.BuffID
      }
    end
    self.BuffTargetType = cfg.BuffTargetType or BuffTargetType.Team
    self.BuffTargetParam = cfg.BuffTargetParam or {}
  end
end

function AutoBeadInnerData:IsEmptySlot()
  return self:GetAutoBeadID() == 0
end

function AutoBeadInnerData:GetAutoBeadID()
  return self.ID
end

function AutoBeadInnerData:GetAutoBeadTag()
  return self.Tag
end

function AutoBeadInnerData:GetAutoBeadSkillID()
  return self.SkillID
end

function AutoBeadInnerData:GetAutoBeadBuff()
  return self.BuffID, self.BuffTargetType, self.BuffTargetParam
end

function AutoBeadInnerData:GetAutoBeadAttr(key)
  local attr = self.AutoBeadAttrMap[key] or 0
  return attr
end

function AutoBeadInnerData:SetAutoBeadAttr(key, setVal)
  local attr = self.AutoBeadAttrMap[key]
  if attr then
    self.AutoBeadAttrMap[key] = setVal
  end
end

function AutoBeadInnerData:AddAutoBeadAttr(key, addVal)
  local attr = self.AutoBeadAttrMap[key]
  if attr then
    local curAttr = attr + addVal
    self.AutoBeadAttrMap[key] = curAttr
  end
end

function AutoBeadInnerData:GetAutoBeadExtraRate()
  return self.ExtraRate
end

function AutoBeadInnerData:SetAutoBeadExtraRate(extraRate)
  self.ExtraRate = extraRate
end

function Entity:LogicAutoBead()
  return self:GetComponent(self.WEComponentsEnum.LogicAutoBead)
end

function Entity:HasLogicAutoBead()
  return self:HasComponent(self.WEComponentsEnum.LogicAutoBead)
end

function Entity:AddLogicAutoBead()
  local index = self.WEComponentsEnum.LogicAutoBead
  local component = LogicAutoBeadComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicAutoBead(autoBeadList)
  local index = self.WEComponentsEnum.LogicAutoBead
  local component = LogicAutoBeadComponent:New()
  component:SetAutoBeadList(autoBeadList)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicAutoBead()
  if self:HasLogicAutoBead() then
    self:RemoveComponent(self.WEComponentsEnum.LogicAutoBead)
  end
end
