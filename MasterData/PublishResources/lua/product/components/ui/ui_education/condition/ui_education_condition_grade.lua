require("ui_education_condition")
_class("UIEducationConditionGrade", UIEducationCondition)
UIEducationConditionGrade = UIEducationConditionGrade

function UIEducationConditionGrade:Constructor(count, level)
  self._type = ConditionType.CT_PetGradeY
  self._quantity = count
  self._gradeCount = count
  self._gradeLevel = level
end

function UIEducationConditionGrade:GetGradeLevel()
  return self._gradeLevel
end

function UIEducationConditionGrade:Test()
  self._completed = 0
  local petModule = GameGlobal.GetModule(PetModule)
  local allPets = petModule:GetPets()
  for k, v in pairs(allPets) do
    if v:GetPetGrade() >= self._gradeLevel then
      self._completed = self._completed + 1
    end
  end
  self._completed = math.min(self._completed, self._quantity)
end
