_class("BuffViewLockChainSkill", BuffViewBase)
BuffViewLockChainSkill = BuffViewLockChainSkill

function BuffViewLockChainSkill:PlayView(TT)
  if not self._entity:HasPetPstID() then
    return
  end
  local petPstID = self._entity:PetPstID():GetPstID()
  local buffConfig = self._viewInstance:BuffConfigData()
  local viewParam = buffConfig:GetViewParams() or {}
  local index = viewParam.ActiveSkillChainEnergyViewIndex
  if not index then
    return
  end
  GameGlobal:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyChange, {
    petPstID = petPstID,
    index = index,
    on = true
  })
end

_class("BuffViewUnlockChainSkill", BuffViewBase)
BuffViewUnlockChainSkill = BuffViewUnlockChainSkill

function BuffViewUnlockChainSkill:PlayView(TT)
  if not self._entity:HasPetPstID() then
    return
  end
  local petPstID = self._entity:PetPstID():GetPstID()
  if self._buffResult.unlockList then
    for i, index in ipairs(self._buffResult.unlockList) do
      GameGlobal:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyChange, {
        petPstID = petPstID,
        index = index,
        on = false,
        all = self._buffResult.isAll
      })
    end
  else
    GameGlobal:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyChange, {
      petPstID = petPstID,
      index = self._buffResult.index,
      on = false,
      all = self._buffResult.isAll
    })
  end
  if self._buffResult.addBuffResult then
    local playBuffSvc = self._world:GetService("PlayBuff")
    local arr = self._buffResult.addBuffResult:GetBuffArray()
    for i, v in ipairs(arr) do
      local eid, seq = v[1], v[2]
      local entity = self._world:GetEntityByID(eid)
      if entity then
        local inst = entity:BuffView():GetBuffViewInstance(seq)
        if inst then
          playBuffSvc:PlayAddBuff(TT, inst)
        end
      end
    end
  end
end
