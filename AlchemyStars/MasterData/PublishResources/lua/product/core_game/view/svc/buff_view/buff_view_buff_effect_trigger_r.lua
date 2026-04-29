_class("BuffViewBuffEffectTrigger", BuffViewBase)
BuffViewBuffEffectTrigger = BuffViewBuffEffectTrigger

function BuffViewBuffEffectTrigger:Constructor()
end

function BuffViewBuffEffectTrigger:PlayView(TT)
  local result = self._buffResult
  if result:GetSuccess() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTNotifyTriggerBuff:New(self._entity))
  end
  local count = result:GetBuffCount()
  count = count or 0
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), count)
end
