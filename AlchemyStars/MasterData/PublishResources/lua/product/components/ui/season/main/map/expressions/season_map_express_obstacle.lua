_class("SeasonMapExpressObstacle", SeasonMapExpressBase)
SeasonMapExpressObstacle = SeasonMapExpressObstacle

function SeasonMapExpressObstacle:Constructor(cfg, eventPoint)
  self._content = self._cfg.Obstacle
end

function SeasonMapExpressObstacle:Update(deltaTime)
end

function SeasonMapExpressObstacle:OnPlay()
  self._eventPoint:OpenObstacle(self._content)
  self:Next()
end
