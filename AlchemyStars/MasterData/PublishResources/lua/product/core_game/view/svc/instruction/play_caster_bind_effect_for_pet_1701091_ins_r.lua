require("base_ins_r")
_class("PlayCasterBindEffectForPet1701091Instruction", BaseInstruction)
PlayCasterBindEffectForPet1701091Instruction = PlayCasterBindEffectForPet1701091Instruction

function PlayCasterBindEffectForPet1701091Instruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._scale = tonumber(paramList.scale) or 1
  local randomRotate = paramList.randomRotate
  if randomRotate then
    self._randomRotate = tonumber(randomRotate)
  else
    self._randomRotate = nil
  end
  self._forcePlayOnSkillHolder = tonumber(paramList.forcePlayOnSkillHolder) == 1
  self._scaleByBuffValueKey = paramList.scaleByBuffValueKey
  self._scaleByBuffValueParam = tonumber(paramList.scaleByBuffValueParam)
end

function PlayCasterBindEffectForPet1701091Instruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() and not self._forcePlayOnSkillHolder then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local effect = world:GetService("Effect"):CreateEffect(self._effectID, e)
  if self._scaleByBuffValueKey then
    local bvcmpt = casterEntity:BuffView()
    if bvcmpt then
      local buffValue = bvcmpt:GetBuffValue(self._scaleByBuffValueKey)
      self._scale = self._scale + self._scaleByBuffValueParam * buffValue
    end
  end
  if effect and self._scale ~= 1 then
    YIELD(TT)
    if self._randomRotate then
      local randomDir = Vector2(math.random(0, self._randomRotate), math.random(0, self._randomRotate))
      effect:SetDirection(randomDir)
    end
    local trajectoryObject = effect:View():GetGameObject()
    local transWork = trajectoryObject.transform
    local scaleData = Vector3.New(self._scale, self._scale, self._scale)
    local sequence = transWork:DOScale(scaleData, 0)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer then
    local resultArray
    resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, 1)
    local backFarPos
    if resultArray == nil or 0 >= table.count(resultArray) then
    else
      local gridList = {}
      local specialScopeResultList = {}
      for _, result in pairs(resultArray) do
        local scopeResult = result:GetSkillEffectScopeResult()
        if scopeResult then
          local array = scopeResult:GetAttackRange()
          if array and 0 < #array then
            backFarPos = array[1]
            break
          end
        end
      end
    end
    local casterPos = casterEntity:GetGridPosition()
    local backFarVec = backFarPos - casterPos
    local casterDir = casterEntity:GetDirection()
    local casterRenderDirV2 = Vector2(casterDir.x, casterDir.z)
    local backDirVec = casterRenderDirV2 * -1
    local backDis = Vector2.Dot(backFarVec, backDirVec.normalized)
    local off = backDis * backDirVec.normalized
    local effectCtrl = effect:EffectController()
    if effectCtrl ~= nil then
      local renderOffSet = Vector3(off.x, 0, off.y)
      effectCtrl:SetPosOffSet(renderOffSet)
    end
  end
end

function PlayCasterBindEffectForPet1701091Instruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
