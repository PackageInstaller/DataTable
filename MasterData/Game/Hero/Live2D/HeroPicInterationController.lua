local HeroInterationBaseController = require("Game.Hero.Live2D.HeroInterationBaseController")
local HeroPicInterationController = class("HeroPicInterationController", HeroInterationBaseController)
local base = HeroInterationBaseController
local CS_EventTriggerListener = CS.EventTriggerListener

function HeroPicInterationController:ctor()
end

function HeroPicInterationController:InitPicInteration(go, aniPlayFunc, lastCvId, heroId, skinId)
  self._picImage = go.transform:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
  self._shortInterival = ConfigData.buildinConfig.HomeOnHookVoiceTime
  self._aniPlayFunc = aniPlayFunc
  self._lastPlayedCVId = lastCvId or 0
  self.heroId = heroId
  self.skinId = skinId
  self._openRayCast = true
  self._isCVOver = true
  self.timerId = TimerManager:StartTimer(1, self.__TimeCallback, self)
  self:ResetInterationWaitTime()
  if IsNull(self._picImage) then
    return
  end
  CS_EventTriggerListener.Get(self._picImage.gameObject):onUp("+", BindCallback(self, self.__OnInPutUp))
  self._oriRaycastTarget = self._picImage.raycastTarget
  if not self._oriRaycastTarget then
    self._picImage.raycastTarget = true
  end
end

function HeroPicInterationController:__TimeCallback()
  if PlayerDataCenter.timestamp < self._nextPlayTime then
    return
  end
  if not self:CheckGlobalPlayTimeInterval(self.heroId, false) then
    return
  end
  local cvId = self:GetCvId(self.heroId, eVoicePointType.WaitInHome, self._lastPlayedCVId)
  self:__RecordAndPlayCv(cvId)
end

function HeroPicInterationController:GetCvId(heroId, VoicePointType, lastPlayedCVId)
  if VoicePointType == eVoicePointType.PicClick then
    return ConfigData:GetVoicePointRandom(eVoicePointType.PicClick, self._lastPlayedCVId, heroId)
  end
  local waitCvid = ConfigData:GetVoicePointRandom(VoicePointType, lastPlayedCVId, heroId)
  if heroId ~= 0 then
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    if self.friendShipCvids == nil then
      self.friendShipCvids = ConfigData:GetUnLockFriendShipCvIds(heroId, heroData)
    end
  end
  local friendShipCvids = self.friendShipCvids
  if friendShipCvids ~= nil and 0 < table.length(friendShipCvids) then
    local index = math.random(#friendShipCvids)
    local friendShipCvid = friendShipCvids[index]
    return math.random(2) == 1 and waitCvid or friendShipCvid
  else
    return waitCvid
  end
  return
end

function HeroPicInterationController:__RecordAndPlayCv(cvId)
  self._lastPlayedCVId = cvId
  local lastCvInfo = PlayerDataCenter.cacheSaveData:GetLastHeroInterationCVInfo()
  lastCvInfo.lastVoiceHeroId = self.heroId
  lastCvInfo.lastVoiceTIme = CS.UnityEngine.Time.time
  PlayerDataCenter.cacheSaveData:SetLastHeroInterationCVInfo(lastCvInfo)
  if self._aniPlayFunc ~= nil then
    self._isCVOver = false
    self._aniPlayFunc(cvId)
  end
end

function HeroPicInterationController:__OnInPutUp()
  if not self._openRayCast or not self._isCVOver then
    return
  end
  local cvId = self:GetCvId(self.heroId, eVoicePointType.PicClick, self._lastPlayedCVId)
  self:__RecordAndPlayCv(cvId)
end

function HeroPicInterationController:__GetCvidByLoginType(loginType)
  local skinId = self.skinId
  if skinId == 0 then
    skinId = ConfigData.hero_data[self.heroId].default_skin
  end
  local skinConfig = ConfigData.skin[skinId]
  local cvid
  if skinConfig ~= nil and type(skinConfig.login_type_cvid) == "table" then
    local cvidList = skinConfig.login_type_cvid[loginType]
    math.randomseed(os.time())
    if 0 < #cvidList then
      cvid = cvidList[math.random(#cvidList)]
    end
  end
  if cvid == nil then
    cvid = loginType
  end
  return cvid
end

function HeroPicInterationController:PlayHeroEnterHomeAnimation(loginType)
  if not self._isCVOver then
    return
  end
  if not self:CheckGlobalPlayTimeInterval(self.heroId, false) then
    return
  end
  local isEndBattle = PlayerDataCenter.cacheSaveData:GetIsEndBattleForHeroInteration()
  if isEndBattle then
    self:PlayLoginAnimation(loginType)
    return
  end
  local cvId = self:GetCvId(self.heroId, eVoicePointType.EnterHome, self._lastPlayedCVId)
  self:__RecordAndPlayCv(cvId)
end

function HeroPicInterationController:PlayLoginAnimation(loginType)
  if not self._isCVOver then
    return 0
  end
  local cvid = self:__GetCvidByLoginType(loginType)
  self:__RecordAndPlayCv(cvid)
  return 0
end

function HeroPicInterationController:SetInterationOpenRayCast(flag)
  self._openRayCast = flag
end

function HeroPicInterationController:SetInterationCVOver(flag)
  self._isCVOver = flag
  self:ResetInterationWaitTime()
end

function HeroPicInterationController:SetInterationOpenWait(flag)
  if flag and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, self.__TimeCallback, self)
    self:ResetInterationWaitTime()
  elseif not flag and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function HeroPicInterationController:ResetInterationWaitTime()
  self._nextPlayTime = PlayerDataCenter.timestamp + self._shortInterival
end

function HeroPicInterationController:Delete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if not IsNull(self._picImage) then
    CS_EventTriggerListener.Get(self._picImage.gameObject):onUp("-", BindCallback(self, self.__OnInPutUp))
    self._picImage.raycastTarget = self._oriRaycastTarget
  end
  self.friendShipCvIds = nil
  base.Delete(self)
end

return HeroPicInterationController
