require("skill_phase_param_base")
_class("SkillPhaseAbsorbPieceParam", SkillPhaseParamBase)
SkillPhaseAbsorbPieceParam = SkillPhaseAbsorbPieceParam
local AbsorbPiecePlayType = {Normal = 1}
_enum("AbsorbPiecePlayType", AbsorbPiecePlayType)

function SkillPhaseAbsorbPieceParam:Constructor(t)
  self._scopeDelay = t.scopeDelay
  self._changeDelay = t.changeDelay
  self._displayDelay = t.displayDelay
  self._gridEffectID = t.gridEffectID
  self._gridPlayType = t.gridPlayType
end

function SkillPhaseAbsorbPieceParam:GetCacheTable()
  local t
  if self._gridEffectID ~= 0 then
    t = {
      {
        Cfg.cfg_effect[self._gridEffectID].ResPath,
        1
      }
    }
  end
  return t
end

function SkillPhaseAbsorbPieceParam:GetPhaseType()
  return SkillViewPhaseType.AbsorbPieceAnimation
end

function SkillPhaseAbsorbPieceParam:GetScopeDelay()
  return self._scopeDelay
end

function SkillPhaseAbsorbPieceParam:GetGridPlayType()
  return self._gridPlayType
end

function SkillPhaseAbsorbPieceParam:GetChangeDelay()
  return self._changeDelay
end

function SkillPhaseAbsorbPieceParam:GetDisPlayDelay()
  return self._displayDelay
end

function SkillPhaseAbsorbPieceParam:GetGridEffectID()
  return self._gridEffectID
end
