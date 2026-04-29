_class("SeasonMapExpressLockInput", SeasonMapExpressBase)
SeasonMapExpressLockInput = SeasonMapExpressLockInput

function SeasonMapExpressLockInput:Constructor(cfg, eventPoint)
  self._content = self._cfg.LockInput
end

function SeasonMapExpressLockInput:Update(deltaTime)
end

function SeasonMapExpressLockInput:OnPlay()
  if self._content ~= nil then
    local seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
    if self._content == true then
      seasonManager:Lock("LockInput")
    elseif self._content == false then
      seasonManager:UnLock("LockInput")
    end
    self:Next()
  end
end
