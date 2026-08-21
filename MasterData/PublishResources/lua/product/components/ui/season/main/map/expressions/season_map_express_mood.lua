_class("SeasonMapExpressMood", SeasonMapExpressBase)
SeasonMapExpressMood = SeasonMapExpressMood

function SeasonMapExpressMood:Constructor(cfg, eventPoint)
  self._content = self._cfg.Mood
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
end

function SeasonMapExpressMood:Update(deltaTime)
end

function SeasonMapExpressMood:OnPlay()
  if self._content then
    local signType = self._content.type
    if signType == SeasonExpressTiming.Play then
      local seasonUI = self._seasonManager:SeasonUIManager():UI()
      local show = self._content.show
      if show then
        seasonUI:AddMood(self._eventPoint, self)
      else
        seasonUI:RemoveMood(self._eventPoint)
      end
    end
    self:Next()
  end
end
