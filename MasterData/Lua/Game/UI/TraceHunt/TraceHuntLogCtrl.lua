local TraceHuntLogCtrl = class("TraceHuntLogCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local WwiseManger = CS.WwiseAudioManager.Instance
local TypeToAni = {
  [1] = 1,
  [2] = 5,
  [3] = 2,
  [4] = 2,
  [5] = 3,
  [6] = 3,
  [7] = 1,
  [8] = 1,
  [9] = 4
}
TraceHuntLogCtrl._mapNodeConfig = {
  txtLog = {sComponentName = "TMP_Text"},
  goLogParam = {nCount = 2},
  txtLogParam = {nCount = 2, sComponentName = "TMP_Text"}
}
TraceHuntLogCtrl._mapEventConfig = {}

function TraceHuntLogCtrl:Refresh(mapLog)
  local mapCfg = ConfigTable.GetData("TraceHuntLogEntryTemplate", mapLog.nId)
  if not mapCfg then
    return
  end
  self.nType = mapCfg.Type
  self.nAniIndex = TypeToAni[mapCfg.Template]
  NovaAPI.SetTMPText(self._mapNode.txtLog, mapCfg.Desc)
  if next(mapLog.tbArgs) ~= nil then
    local nCount = #mapLog.tbArgs
    for i = 1, 2 do
      self._mapNode.goLogParam[i]:SetActive(i <= nCount)
    end
    if mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayer then
      local nMaxHuntProgress = ConfigTable.GetConfigNumber("TraceHuntMaxHuntProgress")
      local sP = string.format("%.1f", tonumber(mapLog.tbArgs[2]) / nMaxHuntProgress * 100)
      NovaAPI.SetTMPText(self._mapNode.txtLogParam[1], orderedFormat(ConfigTable.GetUIText("TraceHunt_Log_Percent"), sP))
    elseif mapCfg.Type == GameEnum.TraceHuntLogType.HuntNPC then
      local nMaxHuntProgress = ConfigTable.GetConfigNumber("TraceHuntMaxHuntProgress")
      local sP = string.format("%.1f", tonumber(mapLog.tbArgs[1]) / nMaxHuntProgress * 100)
      NovaAPI.SetTMPText(self._mapNode.txtLogParam[1], orderedFormat(ConfigTable.GetUIText("TraceHunt_Log_Percent"), sP))
    elseif mapCfg.Type == GameEnum.TraceHuntLogType.Tracing then
      local nMaxTraceProgress = ConfigTable.GetConfigNumber("TraceHuntMaxTraceProgress")
      local sP = string.format("%.1f", tonumber(mapLog.tbArgs[1]) / nMaxTraceProgress * 100)
      NovaAPI.SetTMPText(self._mapNode.txtLogParam[1], orderedFormat(ConfigTable.GetUIText("TraceHunt_Log_Percent"), sP))
      if nCount == 3 then
        local icon = self._mapNode.goLogParam[2].gameObject.transform:Find("icon2"):GetComponent("Image")
        self:SetSprite_Coin(icon, tonumber(mapLog.tbArgs[2]))
        NovaAPI.SetTMPText(self._mapNode.txtLogParam[2], orderedFormat(ConfigTable.GetUIText("TraceHunt_Log_Count"), mapLog.tbArgs[3]))
      end
      self.gameObject.transform:Find("SearchRoot").gameObject:SetActive(false)
      local txtTracing = self.gameObject.transform:Find("SearchRoot/txtTracing"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtTracing, ConfigTable.GetUIText("TraceHunt_Log_Tracing"))
    elseif mapCfg.Type == GameEnum.TraceHuntLogType.Settlement then
      NovaAPI.SetTMPText(self._mapNode.txtLogParam[1], orderedFormat(ConfigTable.GetUIText("TraceHunt_Log_Count"), mapLog.tbArgs[1]))
    end
  end
  local nBossId = PlayerData.TraceHunt:GetBossId()
  local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", nBossId)
  if not mapBossCfg then
    return
  end
  local mData = ConfigTable.GetData("Monster", mapBossCfg.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  if mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayer then
    NovaAPI.SetTMPText(self._mapNode.txtLog, orderedFormat(mapCfg.Desc, mapLog.tbArgs[1]))
  elseif mapCfg.Type == GameEnum.TraceHuntLogType.HuntPlayerFatal then
    NovaAPI.SetTMPText(self._mapNode.txtLog, orderedFormat(mapCfg.Desc, mapLog.tbArgs[1], mManual.Name))
  elseif mapCfg.Type == GameEnum.TraceHuntLogType.HuntNPCFatal or mapCfg.Type == GameEnum.TraceHuntLogType.HuntInterrupt then
    NovaAPI.SetTMPText(self._mapNode.txtLog, orderedFormat(mapCfg.Desc, mManual.Name))
  end
end

function TraceHuntLogCtrl:ForceRebuild()
  local rt = self.gameObject.transform:GetComponent("RectTransform")
  LayoutRebuilder.ForceRebuildLayoutImmediate(rt)
  return rt.rect.height
end

function TraceHuntLogCtrl:CheckLogPlaying()
  local bPlayed = self.animator:GetCurrentAnimatorStateInfo(0):IsName("TraceHuntLogTemplate" .. self.nAniIndex)
  return bPlayed
end

function TraceHuntLogCtrl:PlayLogAni(bSkip, nWaitTime)
  if self.nType == GameEnum.TraceHuntLogType.Tracing then
    self:PlayLogAni_Trace(bSkip, nWaitTime)
  else
    self:PlayLogAni_Other(bSkip)
  end
end

function TraceHuntLogCtrl:PlayLogAni_Trace(bSkip, nWaitTime)
  if bSkip then
    self.animator:Play("TraceHuntLogTemplate" .. self.nAniIndex .. "_1", 0, 0)
    WwiseManger:PostEvent("mode_gongdou_findone")
    if self.timer then
      self.timer:Cancel()
      self.timer = nil
    end
  else
    self.animator:Play("TraceHuntLogTemplate" .. self.nAniIndex, 0, 0)
    self.gameObject.transform:Find("SearchRoot").gameObject:SetActive(true)
    nWaitTime = nWaitTime or 0.5
    self.timer = self:AddTimer(1, nWaitTime, function()
      self.animator:SetTrigger("tOut")
      WwiseManger:PostEvent("mode_gongdou_findone")
    end, true, true, true, nil)
  end
end

function TraceHuntLogCtrl:PlayLogAni_Other(bSkip)
  if bSkip then
    return
  end
  self.animator:Play("TraceHuntLogTemplate" .. self.nAniIndex, 0, 0)
  if self.nType == GameEnum.TraceHuntLogType.TraceStart or self.nType == GameEnum.TraceHuntLogType.HuntStart then
    WwiseManger:PostEvent("mode_gongdou_findstart")
  elseif self.nType == GameEnum.TraceHuntLogType.TraceEnd or self.nType == GameEnum.TraceHuntLogType.HuntEnd then
    WwiseManger:PostEvent("mode_gongdou_findover")
  else
    WwiseManger:PostEvent("mode_gongdou_findone")
  end
end

function TraceHuntLogCtrl:Awake()
  self.nAniIndex = 1
  self.animator = self.gameObject:GetComponent("Animator")
end

return TraceHuntLogCtrl
