_class("TrapRoundInfoRenderComponent", Object)
TrapRoundInfoRenderComponent = TrapRoundInfoRenderComponent

function TrapRoundInfoRenderComponent:Constructor()
  self._roundInfoEntityID = 0
  self._offset = Vector3(0, 0, 0)
  self._headShowType = 1
  self._effect_id = nil
  self._lastEffectId = nil
  self._isShow = false
  self._levelNum = nil
  self._childCount = 0
  self._inAnimName = nil
  self._outAnimName = nil
  self._childAnimState = {}
end

function TrapRoundInfoRenderComponent:SetParam(entityid, headshowtype, param)
  self._roundInfoEntityID = entityid
  self._offset = Vector3(param.x, param.y, param.z)
  self._headShowType = headshowtype
  self._lastEffectId = param.lastEffectId
  self._childCount = param.childCount
  self._inAnimName = param.inAnimName
  self._outAnimName = param.outAnimName
  self._levelNum = param.levelTrapNum
end

function TrapRoundInfoRenderComponent:GetCurChildAnimState(index)
  return self._childAnimState[index]
end

function TrapRoundInfoRenderComponent:SetCurChildAnimState(index, state)
  self._childAnimState[index] = state
end

function TrapRoundInfoRenderComponent:GetChildCount()
  return self._childCount
end

function TrapRoundInfoRenderComponent:GetInAnimName()
  return self._inAnimName
end

function TrapRoundInfoRenderComponent:GetOutAnimName()
  return self._outAnimName
end

function TrapRoundInfoRenderComponent:GetRoundEffectList()
  return self._roundEffectList
end

function TrapRoundInfoRenderComponent:GetHeadShowType()
  return self._headShowType
end

function TrapRoundInfoRenderComponent:GetLastEffectId()
  return self._lastEffectId
end

function TrapRoundInfoRenderComponent:GetOffset()
  return self._offset
end

function TrapRoundInfoRenderComponent:SetRoundInfoEntityID(id)
  self._roundInfoEntityID = id
end

function TrapRoundInfoRenderComponent:GetRoundInfoEntityID()
  return self._roundInfoEntityID
end

function TrapRoundInfoRenderComponent:GetLevelTrapNum()
  return self._levelNum
end

function TrapRoundInfoRenderComponent:GetEffectID()
  return self._effect_id
end

function TrapRoundInfoRenderComponent:SetEffectID(effectId)
  self._effect_id = effectId
end

function TrapRoundInfoRenderComponent:GetIsShow()
  return self._isShow
end

function TrapRoundInfoRenderComponent:SetIsShow(isShow)
  self._isShow = isShow
end

function Entity:TrapRoundInfoRender()
  return self:GetComponent(self.WEComponentsEnum.TrapRoundInfoRender)
end

function Entity:HasTrapRoundInfoRender()
  return self:HasComponent(self.WEComponentsEnum.TrapRoundInfoRender)
end

function Entity:AddTrapRoundInfoRender()
  local index = self.WEComponentsEnum.TrapRoundInfoRender
  local component = TrapRoundInfoRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTrapRoundInfoRender(entityID, headshowtype, param)
  local roundinfo = self:TrapRoundInfoRender()
  if roundinfo == nil then
    roundinfo = TrapRoundInfoRenderComponent:New()
  end
  roundinfo:SetParam(entityID, headshowtype, param)
  self:ReplaceComponent(self.WEComponentsEnum.TrapRoundInfoRender, roundinfo)
end

function Entity:RemoveTrapRoundInfoRender()
  if self:HasTrapRoundInfoRender() then
    self:RemoveComponent(self.WEComponentsEnum.TrapRoundInfoRender)
  end
end
