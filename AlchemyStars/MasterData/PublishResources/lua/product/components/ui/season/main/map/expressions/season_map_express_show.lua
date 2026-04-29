_class("SeasonMapExpressShow", SeasonMapExpressBase)
SeasonMapExpressShow = SeasonMapExpressShow

function SeasonMapExpressShow:Constructor(cfg, eventPoint)
  self._content = self._cfg.Show
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._seasonMapManger = self._seasonManager:SeasonMapManager()
end

function SeasonMapExpressShow:Update(deltaTime)
end

function SeasonMapExpressShow:OnPlay()
  if self._content ~= nil then
    local eventPoint
    local id = self._content.id
    local show = self._content.show
    local timingType = self._content.type
    if id then
      eventPoint = self._seasonMapManger:GetEventPoint(id)
    else
      eventPoint = self._eventPoint
    end
    if eventPoint and (not timingType or timingType == SeasonExpressTiming.Play) then
      eventPoint:ExpressShow(show)
      if eventPoint:IsLevel() and eventPoint:GroupID() > 0 then
        local cfgs = Cfg.cfg_season_mission({
          GroupID = eventPoint:GroupID()
        })
        if cfgs then
          for _, cfg in pairs(cfgs) do
            if cfg.ID ~= eventPoint:GetID() then
              local otherEventPoint = self._seasonMapManger:GetEventPoint(cfg.ID)
              if otherEventPoint then
                otherEventPoint:ExpressShow(show)
              end
            end
          end
        end
      end
    end
    self:Next()
  end
end
