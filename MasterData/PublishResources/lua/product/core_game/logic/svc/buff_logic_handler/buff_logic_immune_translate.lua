BuffImmuneTranslateType = {
  "ImmuneHitBack",
  "ImmunePullAround",
  "ImmuneTransportConveyor",
  "ImmuneTransportEddy"
}
_class("BuffLogicImmuneTranslate", BuffLogicBase)
BuffLogicImmuneTranslate = BuffLogicImmuneTranslate

function BuffLogicImmuneTranslate:Constructor(buffInstance, logicParam)
  self._translateTypeList = logicParam.translateType
end

function BuffLogicImmuneTranslate:DoLogic()
  local e = self._buffInstance:Entity()
  local cBuff = e:BuffComponent()
  if self._translateTypeList then
    for _, idx in ipairs(self._translateTypeList) do
      cBuff:SetBuffValue(BuffImmuneTranslateType[idx], true)
    end
  end
end

_class("BuffLogicResetImmuneTranslate", BuffLogicBase)
BuffLogicResetImmuneTranslate = BuffLogicResetImmuneTranslate

function BuffLogicResetImmuneTranslate:Constructor(buffInstance, logicParam)
  self._translateTypeList = logicParam.translateType
end

function BuffLogicResetImmuneTranslate:DoLogic()
  local e = self._buffInstance:Entity()
  local cBuff = e:BuffComponent()
  if self._translateTypeList then
    for _, idx in ipairs(self._translateTypeList) do
      cBuff:SetBuffValue(BuffImmuneTranslateType[idx], nil)
    end
  end
end
