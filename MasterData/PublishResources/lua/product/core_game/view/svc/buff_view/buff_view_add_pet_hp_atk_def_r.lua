_class("BuffViewAddPetHpAtkDef", BuffViewBase)
BuffViewAddPetHpAtkDef = BuffViewAddPetHpAtkDef

function BuffViewAddPetHpAtkDef:PlayView(TT)
  local result = self:GetBuffResult()
  local pstId = self._entity:PetPstID():GetPstID()
  local hpAdded = result:GetAddHP()
  local atkAdded = result:GetAddAtk()
  local defAdded = result:GetAddDef()
  local damageInfo = result:GetDamageInfo()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangePetAtkDefHp, pstId, atkAdded, defAdded, hpAdded)
  local playDamageSvc = self._world:GetService("PlayDamage")
  playDamageSvc:UpdateTargetHPBar(TT, self._entity, damageInfo)
  local buffViewInstance = self:BuffViewInstance()
  local buffConfigData = buffViewInstance:BuffConfigData()
  local viewParams = buffConfigData:GetViewParams()
  local isPassiveSkill = viewParams.passiveSkill == 1
  if isPassiveSkill then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, pstId, true)
  else
    local entity = self._entity
    local materialAnimationComponent = entity:MaterialAnimationComponent()
    if materialAnimationComponent then
      if 0 < atkAdded then
        materialAnimationComponent:PlayAtkup()
      end
      if 0 < defAdded then
        materialAnimationComponent:PlayDefup()
      end
    end
  end
end
