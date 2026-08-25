local SteamAchievementAPI = CS.SteamAchievementAPI
local UnityTime = CS.UnityEngine.Time
local SteamArchievesMgr = System.NewClass("SteamArchievesMgr", Manager, IUpdater)

function SteamArchievesMgr:Awake()
  self._isSteam = CS.FrameWork.Z1Const.IsSteam()
  self._isReqSteamArchieves = false
  self._nextTime2ReqSteamAchievements = 0
  self._gameArchievesList = {}
  self._gameArchievesMap = {}
  self._gameArchievesIndex = 1
  self._uploadArchsNumPerTimes = 50
end

function SteamArchievesMgr:Update()
  if not self._isSteam or nil == SteamAchievementAPI or nil == SteamAchievementAPI.Instance or nil == SteamAchievementAPI.Instance.Init then
    return
  end
  if not SdkMgr.Instance:HasInitSuccess() then
    return
  end
  self:_WaitingSteamInitialized()
  self:_UploadGameAchievements2Steam()
end

function SteamArchievesMgr:OnGameArchieveCompepete(pchName)
  if not self._isSteam then
    return
  end
  if string.isempty(pchName) then
    return
  end
  if self._gameArchievesMap[pchName] then
    return
  end
  self._gameArchievesMap[pchName] = true
  table.insert(self._gameArchievesList, pchName)
end

function SteamArchievesMgr:_WaitingSteamInitialized()
  if self._isReqSteamArchieves then
    return
  end
  if 0 ~= self._nextTime2ReqSteamAchievements and UnityTime.realtimeSinceStartup - self._nextTime2ReqSteamAchievements < 3 then
    return
  end
  self._isReqSteamArchieves = true
  SteamAchievementAPI.Instance:Init()
  SteamAchievementAPI.Instance:RequestCurrentAchievements(System.fn(self, self._OnSteamAchievementsBack))
end

function SteamArchievesMgr:_OnSteamAchievementsBack()
  if not SteamAchievementAPI.IsReady then
    self._isReqSteamArchieves = false
    self._nextTime2ReqSteamAchievements = UnityTime.realtimeSinceStartup
  end
end

function SteamArchievesMgr:_UploadGameAchievements2Steam()
  if not self._isSteam or not SteamAchievementAPI.IsReady then
    return
  end
  if self._gameArchievesIndex > #self._gameArchievesList then
    return
  end
  local uploadNum = self._uploadArchsNumPerTimes
  local needRestory = false
  while uploadNum > 0 do
    local pchName = self._gameArchievesList[self._gameArchievesIndex]
    self._gameArchievesIndex = self._gameArchievesIndex + 1
    if not SteamAchievementAPI.Instance:IsAchievementUnlock(pchName) then
      SteamAchievementAPI.Instance:UnlockAchievement(pchName)
      uploadNum = uploadNum - 1
      needRestory = true
    end
    if self._gameArchievesIndex > #self._gameArchievesList then
      break
    end
  end
  if needRestory then
    SteamAchievementAPI.Instance:StoreAchievements()
  end
end

return SteamArchievesMgr
