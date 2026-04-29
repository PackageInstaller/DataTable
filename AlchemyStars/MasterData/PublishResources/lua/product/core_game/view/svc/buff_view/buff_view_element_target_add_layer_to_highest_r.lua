_class("BuffViewElementTargetAddLayerToHighest", BuffViewBase)
BuffViewElementTargetAddLayerToHighest = BuffViewElementTargetAddLayerToHighest

function BuffViewElementTargetAddLayerToHighest:PlayView(TT)
  local result = self:GetBuffResult()
  local BuffResultAddLayerList = result:GetBuffResultAddLayerList()
  for _, result in ipairs(BuffResultAddLayerList) do
    local result = result
    local curMarkLayer = result:GetLayer()
    local buffSeq = result:GetBuffSeq()
    local entityID = result:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    if entity then
      local buffView = entity:BuffView()
      local viewInstance = buffView:GetBuffViewInstance(buffSeq)
      if viewInstance then
        viewInstance:SetLayerCount(TT, curMarkLayer)
      end
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
