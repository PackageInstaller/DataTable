_class("HomelandFishingStatusFishing", HomelandFishingStatus)
HomelandFishingStatusFishing = HomelandFishingStatusFishing

function HomelandFishingStatusFishing:Constructor()
  self._guideModule = GameGlobal.GetModule(GuideModule)
end

function HomelandFishingStatusFishing:OnEnter(param)
  self._floatPosition = param
  self._biteTime = HomelandFishingConst.GetFishBiteTime()
  if self._guideModule:IsGuideProcessKey("guide_fishing") then
    self._biteTime = 5
  end
  self._biteTimeLength = self._biteTime
  if self._collectCallback == nil then
    self._collectCallback = GameHelper:GetInstance():CreateCallback(self.FishingCollect, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingCollect, self._collectCallback)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, false)
end

function HomelandFishingStatusFishing:OnExit()
  if self._collectCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingCollect, self._collectCallback)
    self._collectCallback = nil
  end
end

function HomelandFishingStatusFishing:FishingStatus()
  return FishgingStatus.Fishing
end

function HomelandFishingStatusFishing:OnUpdate(deltaTime)
  if self:GetStatusLength() < self._biteTime then
    return
  end
  if self:IsMatchFishing() then
    self:EnterFishMatch()
  elseif self:IsRiverFishing() then
    self:EnterBiteStatus()
  else
    local fishs = HomelandWishingConst.GetRaiseFishList()
    if fishs == nil or table.count(fishs) <= 0 then
      return
    end
    local t = {}
    for k, v in pairs(fishs) do
      t[#t + 1] = v
    end
    local index = math.random(1, #t)
    HomelandFishingConst.SetBitFishId(t[index].ID)
    HomelandFishingConst.SettWishingFishInfo(t[index])
    self:SwitchStatus(FishgingStatus.Bite, self._floatPosition)
  end
end

function HomelandFishingStatusFishing:OnDestroy()
  if self._collectCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingCollect, self._collectCallback)
    self._collectCallback = nil
  end
end

function HomelandFishingStatusFishing:FishingCollect()
  GameGlobal.TaskManager():StartTask(self.FishingCollectCoro, self)
end

function HomelandFishingStatusFishing:FishingCollectCoro(TT)
  self:LockStatus()
  self:LockUI("HomelandFishingStatusThrow_FishingCollectCoro")
  local anim = HomelandFishingConst.GetAnimationCfg(FishgingAnimation.FishCancel)
  self:PlayAnimation(anim.name)
  self:PlayFishRodAnimation(anim.rodname)
  YIELD(TT, anim.length)
  self:SetFishRodStatus(false)
  self:SwitchStatus(FishgingStatus.Throw)
  self:UnLockUI("HomelandFishingStatusThrow_FishingCollectCoro")
  self:UnLockStatus()
end

function HomelandFishingStatusFishing:EnterBiteStatus()
  GameGlobal.TaskManager():StartTask(self.EneterBiteStatusCoro, self)
end

function HomelandFishingStatusFishing:EneterBiteStatusCoro(TT)
  self:LockUI("HomelandFishingStatusFishing_EneterBiteStatusCoro")
  self:LockStatus()
  local fishingPositionId, positionType = self._homelandFishing:GetFishingPosition(self._floatPosition)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local type = FishingEntryType.FET_Normal
  if positionType == FishingPositionType.Normal then
    type = FishingEntryType.FET_Normal
  elseif positionType == FishingPositionType.WishingCoin then
    type = FishingEntryType.FET_SpecialWishingCoin
  elseif positionType == FishingPositionType.RareFishing then
    type = FishingEntryType.FET_RarePosition
  elseif positionType == FishingPositionType.PetFishing then
    type = FishingEntryType.FET_RarePosition
  end
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local followList = homelandClient:PetManager():GetFollowPets()
  local followPetIDs = {}
  for k, pet in pairs(followList) do
    table.insert(followPetIDs, pet:TemplateID())
  end
  local result = homelandModule:ApplyFishBiteHook(TT, type, fishingPositionId, followPetIDs)
  if result:GetSucc() then
    HomelandFishingConst.SetBitFishId(homelandModule:GetCurrentBiteFishID())
    self:SwitchStatus(FishgingStatus.Bite, self._floatPosition)
  else
    Log.error("钓鱼失败 reason code : ", result:GetResult())
    self._biteTime = self._biteTime + self._biteTimeLength
  end
  self:UnLockUI("HomelandFishingStatusFishing_EneterBiteStatusCoro")
  self:UnLockStatus()
end

function HomelandFishingStatusFishing:EnterFishMatch()
  GameGlobal.TaskManager():StartTask(self._EnterFishMatch, self)
end

function HomelandFishingStatusFishing:_EnterFishMatch(TT)
  self:LockUI("HomelandFishingStatusFishing_EneterBiteStatusCoro")
  self:LockStatus()
  local homeLandModule = GameGlobal.GetModule(HomelandModule)
  local result = homeLandModule:ApplyFishBiteHook(TT, FishingEntryType.FET_FishingPetChallenge, 0, {})
  if result:GetSucc() then
    HomelandFishingConst.SetBitFishId(homeLandModule:GetCurrentBiteFishID())
    self:SwitchStatus(FishgingStatus.Bite, 0)
  else
    Log.error("钓鱼失败 reason code : ", result:GetResult())
    self._biteTime = self._biteTime + self._biteTimeLength
  end
  self:UnLockUI("HomelandFishingStatusFishing_EneterBiteStatusCoro")
  self:UnLockStatus()
end
