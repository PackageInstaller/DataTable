_class("BuffLogicSetHPShieldType", BuffLogicBase)
BuffLogicSetHPShieldType = BuffLogicSetHPShieldType
local HPShieldType = {Normal = 1, Lava = 2}
_enum("HPShieldType", HPShieldType)

function BuffLogicSetHPShieldType:Constructor(buffInstance, logicParam)
  self._hpShieldType = logicParam.type or HPShieldType.Normal
end

function BuffLogicSetHPShieldType:DoLogic(notify)
  local hpCmpt = self._entity:BuffComponent()
  if hpCmpt then
    hpCmpt:SetBuffValue("HPShieldType", self._hpShieldType)
  end
end
