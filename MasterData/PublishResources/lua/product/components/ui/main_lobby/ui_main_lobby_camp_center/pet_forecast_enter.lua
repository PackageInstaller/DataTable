_class("PetForecastEnter", Object)
PetForecastEnter = PetForecastEnter

function PetForecastEnter:Constructor(cfg)
  self._cfg = cfg
end

function PetForecastEnter:GetCfgID()
  return self._cfg.ID
end

function PetForecastEnter:LoadData(TT)
  local mSignIn = GameGlobal.GetModule(SignInModule)
  self.data = mSignIn:GetPredictionData()
  local res, replyEvent = mSignIn:PredictionReq(TT)
  if PetForecastData.CheckCode(res:GetResult(), false) then
    Log.debug("###[PetForecastEnter] load info succ")
    self.data:Init(replyEvent.info)
  else
    Log.debug("###[PetForecastEnter] load info fail,result=", res:GetResult())
    self.data.id = 0
  end
end

function PetForecastEnter:CheckOpen()
  return self.data and self.data.id > 0
end

function PetForecastEnter:CheckNew()
  local val = false
  if self.data and self.data.id > 0 then
    local id = self.data.id
    local key
    if self.data.cfg.cg then
      key = UIPetForecastEnter.GetLocalDBKey(id)
    else
      key = UIPetForecastEnterNew.GetLocalDBKey(id)
    end
    val = not LocalDB.HasKey(key)
  end
  return val and 1 or 0
end

function PetForecastEnter:CheckRed()
  local red = false
  if self.data and self.data.pieces then
    for i, p in ipairs(self.data.pieces) do
      if p.state == PredictionStatus.PRES_UnAccept then
        red = true
        break
      end
    end
  end
  return red and 1 or 0
end
