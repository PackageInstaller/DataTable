require("skill_phase_param_base")
_class("SkillPhaseZhongxuSummonTrapOrAttachFlagParam", SkillPhaseParamBase)
SkillPhaseZhongxuSummonTrapOrAttachFlagParam = SkillPhaseZhongxuSummonTrapOrAttachFlagParam

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:Constructor(t)
  local trapParamArray = string.split(t.checkTrapIDList, ",")
  self._checkTrapIDList = {}
  if trapParamArray then
    for k, idStr in ipairs(trapParamArray) do
      local trapID = tonumber(idStr)
      table.insert(self._checkTrapIDList, trapID)
    end
  end
  self._singleGridMonsterEffectDelay = t.singleGridMonsterEffectDelay
  self._singleGridMonsterEffectID = t.singleGridMonsterEffectID
  self._singleGridMonsterEffectLoopAnim = t.singleGridMonsterEffectLoopAnim
  self._singleGridMonsterEffectLoopAnimDelay = t.singleGridMonsterEffectLoopAnimDelay
  self._multiGridMonsterEffectDelay = t.multiGridMonsterEffectDelay
  self._multiGridMonsterEffectID = t.multiGridMonsterEffectID
  self._multiGridMonsterEffectLoopAnim = t.multiGridMonsterEffectLoopAnim
  self._multiGridMonsterEffectLoopAnimDelay = t.multiGridMonsterEffectLoopAnimDelay
  self._multiGridMonsterFlagEffectID = t.multiGridMonsterFlagEffectID
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetCacheTable()
  local t = {}
  if self._checkTrapIDList then
    for index, trapID in ipairs(self._checkTrapIDList) do
      local cfgTrap = Cfg.cfg_trap[trapID]
      if cfgTrap then
        for i, resPath in ipairs(cfgTrap.ResPath) do
          table.insert(t, {resPath, 1})
        end
      end
    end
  end
  if self._singleGridMonsterEffectID then
    local cfgfx = Cfg.cfg_effect[self._singleGridMonsterEffectID]
    if cfgfx then
      table.insert(t, {
        cfgfx.ResPath,
        1
      })
    end
  end
  if self._multiGridMonsterEffectID then
    local cfgfx = Cfg.cfg_effect[self._multiGridMonsterEffectID]
    if cfgfx then
      table.insert(t, {
        cfgfx.ResPath,
        1
      })
    end
  end
  if self._multiGridMonsterFlagEffectID then
    local cfgfx = Cfg.cfg_effect[self._multiGridMonsterFlagEffectID]
    if cfgfx then
      table.insert(t, {
        cfgfx.ResPath,
        1
      })
    end
  end
  return t
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetPhaseType()
  return SkillViewPhaseType.ZhongxuSummonTrapOrAttachFlag
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetCheckTrapIDList()
  return self._checkTrapIDList
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetSingeGridMonsterEffectDelay()
  return self._singleGridMonsterEffectDelay
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetSingeGridMonsterEffectID()
  return self._singleGridMonsterEffectID
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetSingeGridMonsterEffectLoopAnim()
  return self._singleGridMonsterEffectLoopAnim
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetSingeGridMonsterEffectLoopAnimDelay()
  return self._singleGridMonsterEffectLoopAnimDelay
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetMultiGridMonsterEffectDelay()
  return self._multiGridMonsterEffectDelay
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetMultiGridMonsterEffectID()
  return self._multiGridMonsterEffectID
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetMultiGridMonsterEffectLoopAnim()
  return self._multiGridMonsterEffectLoopAnim
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetMultiGridMonsterEffectLoopAnimDelay()
  return self._multiGridMonsterEffectLoopAnimDelay
end

function SkillPhaseZhongxuSummonTrapOrAttachFlagParam:GetMultiGridMonsterFlagEffectID()
  return self._multiGridMonsterFlagEffectID
end
