require("ui_education_condition")
_class("UIEducationConditionElementLevel", UIEducationCondition)
UIEducationConditionElementLevel = UIEducationConditionElementLevel

function UIEducationConditionElementLevel:Constructor(count, elementType, limitGrade)
  self._type = ConditionType.CT_PetYElementZLevel
  self._quantity = count
  self._elementType = elementType
  self._limitGrade = limitGrade
  self._limitLevel = 0
  self._limitStar = 0
end

function UIEducationConditionElementLevel:GetElementType()
  return self._elementType
end

function UIEducationConditionElementLevel:GetLimitGrade()
  return self._limitGrade
end

function UIEducationConditionElementLevel:Test()
  self._completed = 0
  local petModule = GameGlobal.GetModule(PetModule)
  local allPets = petModule:GetPets()
  for k, v in pairs(allPets) do
    local isMet = true
    isMet = isMet and (v:GetPetFirstElement() == self._elementType or 0 == self._elementType)
    isMet = isMet and (v:GetPetGrade() >= self._limitGrade or 0 == self._limitGrade)
    isMet = isMet and (v:GetPetLevel() >= self._limitLevel or 0 == self._limitLevel)
    isMet = isMet and (v:GetPetStar() >= self._limitStar or 0 == self._limitStar)
    if isMet then
      self._completed = self._completed + 1
    end
  end
  self._completed = math.min(self._completed, self._quantity)
end
