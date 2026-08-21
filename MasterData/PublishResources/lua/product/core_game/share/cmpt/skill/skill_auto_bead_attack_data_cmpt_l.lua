_class("SkillAutoBeadAttackDataComponent", Object)
SkillAutoBeadAttackDataComponent = SkillAutoBeadAttackDataComponent

function SkillAutoBeadAttackDataComponent:Constructor()
  self._autoBeadSkillData = {}
  self._currentAutoBeadID = 0
end

function SkillAutoBeadAttackDataComponent:ClearAutoBeadAttackData()
  self._autoBeadSkillData = {}
  self:ClearCurrentAutoBeadID()
end

function SkillAutoBeadAttackDataComponent:ClearCurrentAutoBeadID()
  self._currentAutoBeadID = 0
end

function SkillAutoBeadAttackDataComponent:SetCurrentAutoBeadID(autoBeadID)
  self._currentAutoBeadID = autoBeadID
end

function SkillAutoBeadAttackDataComponent:GetCurrentAutoBeadID()
  return self._currentAutoBeadID
end

function SkillAutoBeadAttackDataComponent:GetAutoBeadAttackDataList()
  return self._autoBeadSkillData
end

function SkillAutoBeadAttackDataComponent:GetAutoBeadAttackData(skillIndex)
  return self._autoBeadSkillData[skillIndex]
end

function SkillAutoBeadAttackDataComponent:AddAutoBeadAttackData(autoBeadID, skillID, skillIndex, skillTurnIndex, skillBeadIndex, skillExtraIndex, skillRepeatIndex)
  local attackData = SkillAutoBeadAttackData:New(autoBeadID, skillID, skillIndex, skillTurnIndex, skillBeadIndex, skillExtraIndex, skillRepeatIndex)
  table.insert(self._autoBeadSkillData, attackData)
end

function Entity:SkillAutoBeadAttackData()
  if EDITOR and CHECK_RENDER_ACCESS_LOGIC then
    local debugInfo = debug.getinfo(2, "S")
    local filePath = debugInfo.short_src
    local renderIndex = string.find(filePath, "_r.lua")
    if renderIndex ~= nil then
      Log.exception("render file :", filePath, " call SkillAutoBeadAttackData() ", Log.traceback())
      return nil
    end
  end
  return self:GetComponent(self.WEComponentsEnum.SkillAutoBeadAttackData)
end

function Entity:HasSkillAutoBeadAttackData()
  return self:HasComponent(self.WEComponentsEnum.SkillAutoBeadAttackData)
end

function Entity:AddSkillAutoBeadAttackData()
  local index = self.WEComponentsEnum.SkillAutoBeadAttackData
  local component = SkillAutoBeadAttackDataComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveSkillAutoBeadAttackData()
  if self:HasSkillAutoBeadAttackData() then
    self:RemoveComponent(self.WEComponentsEnum.SkillAutoBeadAttackData)
  end
end
