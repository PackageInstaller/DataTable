_class("SeasonMapCondition", Object)
SeasonMapCondition = SeasonMapCondition

function SeasonMapCondition:Constructor(module, id, progress)
  self._module = module
  self._id = id
  self._progress = progress
end

function SeasonMapCondition:OnCheck(map)
  return self._module:CheckUISatisfy(self._id, self._progress, map)
end
