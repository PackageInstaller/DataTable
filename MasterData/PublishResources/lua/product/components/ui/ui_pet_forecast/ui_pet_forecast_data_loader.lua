_class("UIPetForecastDataLoader", Object)
UIPetForecastDataLoader = UIPetForecastDataLoader

function UIPetForecastDataLoader:SetData(params)
end

function UIPetForecastDataLoader:LoadData(TT, res)
  local signInModule = GameGlobal.GetModule(SignInModule)
  local data = signInModule:GetPredictionData()
  local ret, replyEvent = signInModule:PredictionReq(TT)
  if PetForecastData.CheckCode(ret:GetResult(), false) then
    data:Init(replyEvent.info)
    return data
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, -1)
    res:SetSucc(false)
    Log.warn("### PredictionReq failed.")
  end
end
