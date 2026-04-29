require("skill_phase_param_base")
_class("SkillPhaseParamMultiGridEffect", SkillPhaseParamBase)
SkillPhaseParamMultiGridEffect = SkillPhaseParamMultiGridEffect

function SkillPhaseParamMultiGridEffect:Constructor(t)
  self._gridEff = t.gridEff
  self._hitAnim = t.hit.anim
  self._hitEff = t.hit.eff
  self._interval = t.interval
  self._random = t.random
  self._expectionGrid = {}
  if t.expectionGrid then
    for i, v in ipairs(t.expectionGrid) do
      local pos = Vector2(v[1], v[2])
      table.insert(self._expectionGrid, pos)
    end
  end
end

function SkillPhaseParamMultiGridEffect:GetCacheTable()
  local t = {}
  if self._gridEff and self._gridEff > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEff].ResPath,
      1
    }
  end
  if self._hitEff and 0 < self._hitEff then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEff].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseParamMultiGridEffect:GetPhaseType()
  return SkillViewPhaseType.MultiGridEffect
end

function SkillPhaseParamMultiGridEffect:GetGridEff()
  return self._gridEff
end

function SkillPhaseParamMultiGridEffect:GetHitAnim()
  return self._hitAnim
end

function SkillPhaseParamMultiGridEffect:GetHitEff()
  return self._hitEff
end

function SkillPhaseParamMultiGridEffect:GetInterval()
  return self._interval
end

function SkillPhaseParamMultiGridEffect:GetRandom()
  return self._random
end

function SkillPhaseParamMultiGridEffect:GetExpectionGrid()
  return self._expectionGrid
end
