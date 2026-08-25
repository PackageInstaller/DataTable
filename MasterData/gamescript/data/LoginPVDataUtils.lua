local LoginPVDataUtils = {}
local PlayerDataUtils = require("GameScript.Data.PlayerDataUtils")
local DivPackageType = CS.ResourceManager.DivPackageType
local PkgDivType = CS.FrameWork.Z1Const.GetPackageDivType()
local AUTO_PV_PLAY_COUNT_LIMIT = 1

function LoginPVDataUtils.GetBeforeLoginAvgId()
  local avgId = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.BeforeLoginAvgId)
  if avgId then
    return avgId
  end
  local isPlayedPv = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.PreviewVideo)
  if not isPlayedPv then
    local beforeCfg = DT.GetOriginalConstant("BeforLoginPV1")
    return beforeCfg and beforeCfg[2]
  end
end

function LoginPVDataUtils.GetDefaultLoginPVInfo()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "LoginPV1"
end

function LoginPVDataUtils.GetManualLoginPVInfo()
  local video = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.ManualPvVideo)
  local music = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.ManualPvMusic)
  local caption = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.ManualPvCaption)
  if not video or "" == video then
    return
  end
  return {
    video = video,
    music = music,
    caption = caption
  }
end

function LoginPVDataUtils.GetAutoLoginPVInfo()
  local uidSuffix = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount)
  if uidSuffix then
    uidSuffix = tostring(uidSuffix)
  else
    uidSuffix = ""
  end
  local kVideo = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvVideo .. uidSuffix or cd.LocalSaveKeyCommon.PvVideo
  local kMusic = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvMusic .. uidSuffix or cd.LocalSaveKeyCommon.PvMusic
  local kCaption = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvCaption .. uidSuffix or cd.LocalSaveKeyCommon.PvCaption
  local kCount = "" ~= uidSuffix and cd.LocalSaveKeyCommon.AutoPvPlayCount .. uidSuffix or cd.LocalSaveKeyCommon.AutoPvPlayCount
  local video = MobileFileDataManager.Instance:GetCommFileValue(kVideo)
  local music = MobileFileDataManager.Instance:GetCommFileValue(kMusic)
  local caption = MobileFileDataManager.Instance:GetCommFileValue(kCaption)
  local playCount = MobileFileDataManager.Instance:GetCommFileValue(kCount)
  if not video or "" == video then
    return nil
  end
  return {
    video = video,
    music = music,
    caption = caption,
    playCount = playCount or 1
  }
end

function LoginPVDataUtils.SetManualLoginPV(video, music, caption)
  if not video or "" == video then
    return
  end
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvVideo, video)
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvMusic, music)
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvCaption, caption)
  MobileFileDataManager.Instance:OnSaveCommInfo()
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.LoginPVManualChanged)
end

function LoginPVDataUtils.ClearManualLoginPV()
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvVideo, nil)
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvMusic, nil)
  MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvCaption, nil)
  MobileFileDataManager.Instance:OnSaveCommInfo()
  EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.LoginPVManualChanged)
end

function LoginPVDataUtils.SetAutoLoginPV(video, music, caption, syncManualWhenEmpty)
  if not video or "" == video then
    return
  end
  local uidSuffix = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount)
  if uidSuffix then
    uidSuffix = tostring(uidSuffix)
  else
    uidSuffix = ""
  end
  local kVideo = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvVideo .. uidSuffix or cd.LocalSaveKeyCommon.PvVideo
  local kMusic = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvMusic .. uidSuffix or cd.LocalSaveKeyCommon.PvMusic
  local kCaption = "" ~= uidSuffix and cd.LocalSaveKeyCommon.PvCaption .. uidSuffix or cd.LocalSaveKeyCommon.PvCaption
  local kCount = "" ~= uidSuffix and cd.LocalSaveKeyCommon.AutoPvPlayCount .. uidSuffix or cd.LocalSaveKeyCommon.AutoPvPlayCount
  local oldVideo = MobileFileDataManager.Instance:GetCommFileValue(kVideo)
  local oldCount = MobileFileDataManager.Instance:GetCommFileValue(kCount, 1)
  MobileFileDataManager.Instance:SetCommFileValue(kVideo, video)
  MobileFileDataManager.Instance:SetCommFileValue(kMusic, music)
  MobileFileDataManager.Instance:SetCommFileValue(kCaption, caption)
  local newPlayCount
  if oldVideo ~= video then
    newPlayCount = 1
    MobileFileDataManager.Instance:SetCommFileValue(kCount, newPlayCount)
  else
    newPlayCount = oldCount or 1
    MobileFileDataManager.Instance:SetCommFileValue(kCount, newPlayCount)
  end
  if "" ~= uidSuffix then
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.AutoPvPlayCount, newPlayCount)
  end
  if syncManualWhenEmpty then
    local manualInfo = LoginPVDataUtils.GetManualLoginPVInfo()
    if not manualInfo then
      MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvVideo, video)
      MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvMusic, music)
      MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.ManualPvCaption, caption)
    end
  end
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function LoginPVDataUtils.InitLoginPVInfo()
  local resultInfo, resultSource
  local judgeAuto = false
  local judgeManual = false
  local judgeDefault = false
  local defaultMissing = false
  local autoInfo = LoginPVDataUtils.GetAutoLoginPVInfo()
  local manualInfo = LoginPVDataUtils.GetManualLoginPVInfo()
  judgeAuto = (autoInfo and autoInfo.playCount or 99999) <= AUTO_PV_PLAY_COUNT_LIMIT or autoInfo and not manualInfo
  if judgeAuto then
    resultInfo = autoInfo
    resultSource = "auto"
  elseif manualInfo then
    judgeManual = true
    resultInfo = manualInfo
    resultSource = "manual"
  else
    local default = LoginPVDataUtils.GetDefaultLoginPVInfo()
    defaultMissing = nil == default
    judgeDefault = not defaultMissing
    if defaultMissing then
      resultInfo = nil
      resultSource = "default"
    else
      resultInfo = {
        video = default[2],
        music = default[3],
        caption = default[4]
      }
      resultSource = "default"
    end
  end
  print("[LoginPVDataUtils.GetLoginPVInfo]", [[

lastLoginAccount=]], MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount), [[

judgeAuto=]], judgeAuto, [[

judgeManual=]], judgeManual, [[

judgeDefault=]], judgeDefault, [[

defaultMissing=]], defaultMissing, [[

resultSource=]], resultSource, [[

resultInfo=]], resultInfo and table.tostring(resultInfo) or "nil", debug.traceback())
  return resultInfo, resultSource
end

function LoginPVDataUtils.GetLoginPVInfo()
  if not LoginPVDataUtils.loginPVInfo then
    LoginPVDataUtils.loginPVInfo, LoginPVDataUtils.loginPVSource = LoginPVDataUtils.InitLoginPVInfo()
  end
  return LoginPVDataUtils.loginPVInfo, LoginPVDataUtils.loginPVSource
end

function LoginPVDataUtils.TryClearAutoLoginPVAfterPlayed(playedVideo)
  if not playedVideo then
    return
  end
  local _, source = LoginPVDataUtils.GetLoginPVInfo()
  if "auto" ~= source then
    return
  end
  local autoInfo = LoginPVDataUtils.GetAutoLoginPVInfo()
  if not autoInfo or autoInfo.video ~= playedVideo then
    return
  end
  local curCount = autoInfo.playCount or 1
  local nowUid = tostring(PlayerDataUtils.GetPlayerUid() or "")
  local uidSuffix = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastLoginAccount)
  if nowUid ~= uidSuffix then
    return
  end
  local kCount = "" ~= uidSuffix and cd.LocalSaveKeyCommon.AutoPvPlayCount .. uidSuffix or cd.LocalSaveKeyCommon.AutoPvPlayCount
  local nextCount = curCount + 1
  MobileFileDataManager.Instance:SetCommFileValue(kCount, nextCount)
  if "" ~= uidSuffix then
    MobileFileDataManager.Instance:SetCommFileValue(cd.LocalSaveKeyCommon.AutoPvPlayCount, nextCount)
  end
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function LoginPVDataUtils.GetLoginMusic()
  local dlGroupName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
  if DivPackageType.InGameDownLoad ~= PkgDivType or GroupDownloadMgr.Instance:IsGroupDownload(dlGroupName) then
    local pvInfo = LoginPVDataUtils.GetLoginPVInfo()
    if pvInfo and pvInfo.music then
      return pvInfo.music
    end
  end
  local default = LoginPVDataUtils.GetDefaultLoginPVInfo()
  return default and default[3]
end

function LoginPVDataUtils.GetLoginVideo()
  local dlGroupName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
  if DivPackageType.InGameDownLoad ~= PkgDivType or GroupDownloadMgr.Instance:IsGroupDownload(dlGroupName) then
    local pvInfo = LoginPVDataUtils.GetLoginPVInfo()
    if pvInfo and pvInfo.video then
      return pvInfo.video
    end
  end
  local default = LoginPVDataUtils.GetDefaultLoginPVInfo()
  return default and default[2]
end

function LoginPVDataUtils.GetLogoVideo()
  local lastPassedStageId = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.LastPassedStageId, 0)
  for i = 20, 1, -1 do
    local cfg = DT.GetOriginalConstant("Logo" .. i)
    if cfg and lastPassedStageId >= cfg[1] then
      local _, logoVideo, logoAlphaVideo = table.unpack(cfg)
      return logoVideo, logoAlphaVideo
    end
  end
end

return LoginPVDataUtils
