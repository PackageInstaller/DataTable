_class("SeasonMapExpressTransmit", SeasonMapExpressBase)
SeasonMapExpressTransmit = SeasonMapExpressTransmit

function SeasonMapExpressTransmit:Constructor(cfg, eventPoint)
  self._content = self._cfg.Transmit
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
end

function SeasonMapExpressTransmit:Update(deltaTime)
end

function SeasonMapExpressTransmit:OnPlay()
  if self._content then
    local position = Vector3(self._content.position[1], self._content.position[2], self._content.position[3])
    local direction
    if self._content.direction then
      direction = Vector3(self._content.direction[1], self._content.direction[2], self._content.direction[3])
    end
    self._seasonManager:SeasonPlayerManager():GetPlayer():Transmit(position, direction)
    self:Next()
  end
end
