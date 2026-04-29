_class("SeasonMapExpressReward", SeasonMapExpressBase)
SeasonMapExpressReward = SeasonMapExpressReward

function SeasonMapExpressReward:Constructor(cfg, eventPoint)
  self._content = self._cfg.Reward
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._rewards = {}
  self._delayShow = false
  self._time = 0
  self._autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
end

function SeasonMapExpressReward:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and self._delayShow then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._delayShow = false
      self._seasonManager:UnLock("reward")
      UISeasonHelper.ShowUIGetRewards(self._rewards)
    end
  end
end

function SeasonMapExpressReward:Dispose()
  self.super.Dispose(self)
  self._autoBinder:UnBindAllEvents()
end

function SeasonMapExpressReward:OnPlay()
  table.clear(self._rewards)
  for _, value in pairs(self._content) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = value[1]
    roleAsset.count = value[2]
    table.insert(self._rewards, roleAsset)
  end
  self._time = 0
  local controller = GameGlobal.UIStateManager():GetController(UISeasonHelper.CurSeasonSceneUI())
  if controller then
    local playing, time = controller:IsPlayAnimation()
    if playing then
      self._time = time * 1000
    end
  end
  self._autoBinder:BindEvent(GameEventType.OnUIGetItemCloseInQuest, self, self._OnCallBack)
  self._delayShow = self._time > 0
  self._state = SeasonExpressState.Playing
  if self._delayShow then
    self._seasonManager:Lock("reward")
  else
    UISeasonHelper.ShowUIGetRewards(self._rewards)
  end
end

function SeasonMapExpressReward:_OnCallBack()
  self._autoBinder:UnBindAllEvents()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.SeasonRewardShowEnd)
  self:Next()
end
