return function(self, params, default)
  if not params.src then
    return
  end
  local sprite = self:getSprite(params.src)
  if not sprite then
    self:printf("<img> - create sprite failde")
    return
  end
  if params.scale then
    sprite:setScale(params.scale)
  end
  if params.rotate then
    sprite:setRotation(params.rotate)
  end
  if params.visible ~= nil then
    sprite:setVisible(params.visible)
  end
  return {sprite}
end
