require("buff_logic_base")
_class("BuffLogicButterflyPollen", BuffLogicBase)
BuffLogicButterflyPollen = BuffLogicButterflyPollen

function BuffLogicButterflyPollen:Constructor(buffInstance, logicParam)
  self._layerType = tonumber(logicParam.layerType)
  self._damagePercent = logicParam.damagePercent
  self._monsterDamageIncreaseMinValue = logicParam.monsterDamageIncreaseMinValue or 0
  self._monsterDamageIncreaseOneLayerValue = logicParam.monsterDamageIncreaseOneLayerValue or 0
  self._petDamageIncreaseMinValue = logicParam.petDamageIncreaseMinValue or 0
  self._petDamageIncreaseOneLayerValue = logicParam.petDamageIncreaseOneLayerValue or 0
  self._monsterAddHPMulValue = logicParam.monsterAddHPMulValue or 0
  self._monsterAddHPValue = logicParam.monsterAddHPValue or 0
end

function BuffLogicButterflyPollen:DoLogic(notify)
  local e = self._entity
  local layer = self._buffLogicService:GetBuffLayer(e, self._layerType)
  if layer <= 0 then
    return
  end
  local result = BuffResultButterflyPollen:New()
  if e:HasMonsterID() then
    if 0 < self._monsterDamageIncreaseMinValue or 0 < self._monsterDamageIncreaseOneLayerValue then
      local svc = self._world:GetService("BuffLogic")
      local changeVal = self._monsterDamageIncreaseMinValue + self._monsterDamageIncreaseOneLayerValue * layer
      local seq = self:GetBuffSeq()
      self._buffLogicService:RemoveSkillIncrease(e, seq, ModifySkillIncreaseParamType.MonsterDamage)
      self._buffLogicService:ChangeSkillIncrease(e, seq, ModifySkillIncreaseParamType.MonsterDamage, changeVal)
    end
    if 0 < self._monsterAddHPMulValue or 0 < self._monsterAddHPValue then
      local cAttr = e:Attributes()
      local maxHP = cAttr:CalcMaxHp()
      local rate = cAttr:GetAttribute("AddBloodRate") or 0
      local val = math.floor((maxHP * self._monsterAddHPMulValue + self._monsterAddHPValue) * (1 + rate))
      if 0 <= val then
        self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
        local logger = self._world:GetMatchLogger()
        logger:AddBloodLog(self._entity:GetID(), {
          key = "ButterflyPollen",
          desc = "BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate] 回血比例[mulValue] 回血加值[addValue]",
          attacker = self._entity:GetID(),
          defender = self._entity:GetID(),
          blood = val,
          rate = rate,
          mulValue = self._mulValue,
          addValue = self._addValue
        })
        self._world:GetMatchLogger():EndBuff(self._entity:GetID())
        local calcDamage = self._world:GetService("CalcDamage")
        local damageInfo = DamageInfo:New(val, DamageType.Recover)
        damageInfo:SetHPShield(e:BuffComponent():GetBuffValue("HPShield"))
        calcDamage:AddTargetHP(e:GetID(), damageInfo)
        result:SetRecoveryDamageInfo(damageInfo)
      end
    end
  elseif e:HasTeam() then
    local attrCmpt = e:Attributes()
    local maxHp = attrCmpt:CalcMaxHp()
    if maxHp <= 0 then
      return
    end
    local casterEntity = self:GetCasterEntity()
    if casterEntity:EntityType() == nil then
      casterEntity = e
    end
    local blsvc = self._world:GetService("BuffLogic")
    Log.debug("Buff AddPoison, beforeCalcDmg,entityID: ", e:GetID())
    local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, {
      percent = self._damagePercent,
      layer = layer,
      formulaID = 15
    })
    if damageInfo:GetDamageType() == DamageType.Real then
      damageInfo:SetDamageType(DamageType.Poison)
    end
    result:SetPoisonDamageInfo(damageInfo)
    if 0 < self._petDamageIncreaseMinValue or 0 < self._petDamageIncreaseOneLayerValue then
      local changeVal = self._petDamageIncreaseMinValue + self._petDamageIncreaseOneLayerValue * layer
      local seq = self:GetBuffSeq()
      local cTeam = e:Team()
      for _, pet in ipairs(cTeam:GetTeamPetEntities()) do
        self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.NormalSkill)
        self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ChainSkill)
        self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ActiveSkill)
        self._buffLogicService:ChangeSkillIncrease(pet, seq, ModifySkillIncreaseParamType.NormalSkill, changeVal)
        self._buffLogicService:ChangeSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ChainSkill, changeVal)
        self._buffLogicService:ChangeSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ActiveSkill, changeVal)
      end
    end
  end
  return result
end

_class("BuffLogicRevertButterflyPollen", BuffLogicBase)
BuffLogicRevertButterflyPollen = BuffLogicRevertButterflyPollen

function BuffLogicRevertButterflyPollen:DoLogic(notify)
  local e = self._entity
  local seq = self:GetBuffSeq()
  if e:HasMonsterID() then
    self._buffLogicService:RemoveSkillIncrease(e, seq, ModifySkillIncreaseParamType.MonsterDamage)
  elseif e:HasTeam() then
    local cTeam = e:Team()
    for _, pet in ipairs(cTeam:GetTeamPetEntities()) do
      self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.NormalSkill)
      self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ChainSkill)
      self._buffLogicService:RemoveSkillIncrease(pet, seq, ModifySkillIncreaseParamType.ActiveSkill)
    end
  end
  return true
end
