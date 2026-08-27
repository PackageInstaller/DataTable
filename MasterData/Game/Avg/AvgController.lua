local AvgController = class("AvgController", ControllerBase)
local base = ControllerBase
local util = require("XLua.Common.xlua_util")
local AvgResUtil = require("Game.Avg.AvgResUtil")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local CS_LanguageGlobal = CS.LanguageGlobal
local TAStrTag = "<TA>"
local CommanderNameStrTag = "<cmdr>"

function AvgController:OnInit()
  self.avgWaitingList = {}
  self.autoPlayMode = false
  self.actDelayRatio = 1
  self.speedupMode = false
  self.__onAvgComplete = BindCallback(self, self.OnAvgComplete)
  self._resLoader = CS.ResLoader.Create()
end

function AvgController:StartAvg(chapterName, avgId, completeFunc, shieldControlSwitch, isGuideAvg, ignoreTimeScale)
  if string.IsNullOrEmpty(chapterName) and avgId == nil then
    error("Avg chapterName IsNullOrEmpty:" .. tostring(chapterName) .. " " .. tostring(avgId))
    return
  end
  if avgId ~= nil and string.IsNullOrEmpty(chapterName) then
    local avgCfg = ConfigData.story_avg[avgId]
    if avgCfg == nil then
      error("avg story cfg is null,id:" .. tostring(avgId))
      return
    end
    chapterName = avgCfg.script_id
  end
  local wating = {
    chapterName = chapterName,
    completeFunc = completeFunc,
    avgId = avgId,
    shieldControlSwitch = shieldControlSwitch or false,
    isGuideAvg = isGuideAvg or false,
    ignoreTimeScale = ignoreTimeScale or false
  }
  table.insert(self.avgWaitingList, wating)
  if self.__playCoroutine == nil then
    self.__playCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.PlayCoroutineFunc)))
  end
  MsgCenter:Broadcast(eMsgEventId.AVGPlayStart)
end

function AvgController:PlayCoroutineFunc()
  while #self.avgWaitingList > 0 do
    while UIManager:GetWindow(UIWindowTypeID.CommonReward) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.CommonReward) do
      coroutine.yield(nil)
    end
    local waiting = table.remove(self.avgWaitingList, 1)
    self.avgCachePlayParam = waiting
    if not waiting.isGuideAvg then
      while GuideManager.inGuide do
        coroutine.yield(nil)
      end
    end
    self:ShowAvg(waiting.chapterName, waiting.completeFunc, waiting.shieldControlSwitch, waiting.ignoreTimeScale)
    while self.avgIsPlaying and (UIManager:GetWindow(UIWindowTypeID.Avg) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.Avg)) do
      coroutine.yield(nil)
    end
    while UIManager:GetWindow(UIWindowTypeID.CommonReward) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.CommonReward) do
      coroutine.yield(nil)
    end
    if not waiting.isGuideAvg then
      while GuideManager.inGuide do
        coroutine.yield(nil)
      end
    end
  end
  self.__playCoroutine = nil
  self:Delete()
  MsgCenter:Broadcast(eMsgEventId.AVGCtrlPlayEnd)
end

function AvgController:ShowAvg(chapterName, completeFunc, shieldControlSwitch, ignoreTimeScale)
  if self.avgIsPlaying then
    if self.avgCachePlayParam ~= nil then
      error(string.format("正在进行缓存播放模式,不可以直接播放avg(%s),请先结束缓存播放模式(delete controller)", chapterName))
      if completeFunc ~= nil then
        completeFunc()
      end
      return
    end
    self:ClearCurAvg()
  end
  if string.IsNullOrEmpty(chapterName) then
    error("Avg chapterName IsNullOrEmpty")
    if completeFunc ~= nil then
      completeFunc()
    end
    return
  end
  AudioManager:RecordCurBgm()
  AudioManager:RemoveAllVoice(true)
  AudioManager:PauseSource(eAudioSourceType.LoopSource, true)
  self.completeFunc = completeFunc
  self.__originTimeScale = Time.unity_time.timeScale
  self._hasError = nil
  if not self:LoadAvgCfg(chapterName) then
    return
  end
  self.__ignoreTimeScale = ignoreTimeScale or false
  self.__shieldControlSwitch = shieldControlSwitch or false
  self.chapterName = chapterName
  self:_VerifyCustomSkip()
  self:ChangeSpeed()
  self.recordDataList = {}
  self.avgIsPlaying = true
  self._reqCompleteAllAvg = false
  self:_ClearInitCo()
  self._initCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._InitCo)))
end

function AvgController:_InitCo()
  UIManager:ShowWindowAsync(UIWindowTypeID.Avg, function(win)
    if win then
      win:Hide()
    end
  end)
  UIUtil.AddOneCover("AvgUI")
  coroutine.yield(nil)
  local loadedResTab = {}
  local firstActCfg = self:GetAvgNextActCfg(1)
  local dialogPath = AvgResUtil.GetAvgDialogRes(firstActCfg.contentStyle)
  if dialogPath ~= nil then
    local wait = self._resLoader:LoadABAssetAsyncAwait(dialogPath)
    coroutine.yield(wait)
    loadedResTab.dialogPrefab = wait.Result
  end
  while UIManager:GetWindow(UIWindowTypeID.Avg) == nil do
    coroutine.yield(nil)
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.Avg)
  self.avgWindow = window
  window:InitAvgSystem(self, loadedResTab)
  window:SetTopControlActive(not self.__shieldControlSwitch)
  self:PlayAvgAct(1)
  UIUtil.CloseOneCover("AvgUI")
  self._initCo = nil
end

function AvgController:_ClearInitCo()
  if self._initCo ~= nil then
    GR.StopCoroutine(self._initCo)
    self._initCo = nil
  end
end

function AvgController:PlayAvgAct(actId)
  local nextActCfg = self.avgCfg[actId]
  if nextActCfg == nil then
    warn("没有该 actId : " .. tostring(actId))
    return
  end
  self.curActId = actId
  self.avgActComplete = false
  self.avgWindow:PlayAvgAct(nextActCfg)
  self:RecordAct(nextActCfg, actId)
end

function AvgController:PlayNextAvgAct()
  if self.curActId == nil then
    return
  end
  local nextActCfg = self.avgCfg[self.curActId]
  if nextActCfg.isEnd then
    return
  end
  local nextActId
  if nextActCfg.nextId == nil then
    nextActId = self.curActId + 1
  else
    nextActId = nextActCfg.nextId
  end
  if self.avgCfg[nextActId] == nil then
    return
  end
  local nextActCfg = self.avgCfg[nextActId]
  if nextActCfg == nil then
    warn("没有该 actId : " .. tostring(nextActId))
    return
  end
  if nextActCfg.branch ~= nil and nextActCfg.branch.disableSelected ~= nil then
    local canNotSelectNum = 0
    for index, branchCfg in ipairs(nextActCfg.branch) do
      if branchCfg.jumpAct ~= nil and self:GetIsBranchSelected(nextActId, index) then
        canNotSelectNum = canNotSelectNum + 1
      end
    end
    if canNotSelectNum >= #nextActCfg.branch then
      self:PlayAvgAct(nextActCfg.branch.finalAct)
      return
    end
  end
  self:PlayAvgAct(nextActId)
end

function AvgController:ClickContinueAvg()
  if self.autoPlayMode then
    self:ClearDelayPlatNextTimer()
  end
  if self:AvgIsEnd(self.curActId) then
    self:CompleteAllAvg()
    return
  end
  self:PlayNextAvgAct()
end

function AvgController:OnAvgActComplete(selectBranchIndex, jumpAct, jumpChapter, contentLen)
  self.avgActComplete = true
  self.avgWindow:StopAvgVoice()
  local avgIsEnd = self:AvgIsEnd(self.curActId)
  if avgIsEnd and not self.autoPlayMode then
    return false
  end
  if jumpAct ~= nil then
    if self.avgCfg[jumpAct] == nil then
      self:AvgLogError("没有该分支,id = " .. tostring(jumpAct))
      return
    end
    self:RecordSelectedBranch(selectBranchIndex)
    self:PlayAvgAct(jumpAct)
    return true
  elseif not string.IsNullOrEmpty(jumpChapter) then
    self:JumpChapter(jumpChapter)
    return true
  else
    if not self.autoPlayMode then
      return false
    end
    local ratio = self.actDelayRatio == 1 and ConfigData.buildinConfig.AvgActDelayFactor1 or ConfigData.buildinConfig.AvgActDelayFactor2
    local duration = ConfigData.buildinConfig.AvgActDelayBase + contentLen * ratio
    self.__delayPlatNextTimerId = TimerManager:StartTimer(duration, function()
      self.__delayPlatNextTimerId = nil
      if self.avgCfg == nil then
        return
      end
      if avgIsEnd then
        self:CompleteAllAvg()
      else
        self:PlayNextAvgAct()
      end
    end, nil, true, false, self:AvgIgnoreTimeScale())
    return true
  end
end

function AvgController:AvgIsEnd(actId)
  local nextActCfg = self:GetAvgNextActCfg(actId)
  if nextActCfg.isEnd then
    return true
  end
  if nextActCfg.nextId ~= nil then
    return false
  end
  if self.avgCfg[actId + 1] == nil then
    return true
  end
  return false
end

function AvgController:LoadAvgCfg(storyName)
  local nameList = string.split(storyName, ".")
  local lastName = nameList[#nameList]
  local cfgPath = "AvgConfig." .. storyName .. ".AvgCfg_" .. lastName
  local ok, err = pcall(function()
    self.avgCfg = require(cfgPath)
    self.avgCfgPath = cfgPath
    return true
  end)
  if not ok then
    error("Can't get AvgCfg, path = " .. cfgPath .. ",\n" .. err)
    self:CompleteAllAvg(true)
    return
  end
  local lang = CS_LanguageGlobal.GetLanguageStr()
  local langPath = "AvgConfig." .. storyName .. ".AvgLang_" .. lastName .. "_" .. lang
  local ok, err = pcall(function()
    self.avgLangCfg = require(langPath)
    self.avgLangPath = langPath
    return true
  end)
  if not ok then
    error("Can't get AvgLanguage, path = " .. langPath .. ",\n" .. err)
    self:CompleteAllAvg(true)
    return
  end
  return true
end

function AvgController:UnloadAvgCfg()
  self.avgCfg = nil
  if self.avgCfgPath ~= nil then
    package.loaded[self.avgCfgPath] = nil
    self.avgCfgPath = nil
  end
  self.avgLangCfg = nil
  if self.avgLangPath ~= nil then
    package.loaded[self.avgLangPath] = nil
    self.avgLangPath = nil
  end
  collectgarbage()
end

local function getSheFunc(self, id, content)
  if PlayerDataCenter.inforData ~= nil and PlayerDataCenter.inforData:GetSex() then
    local sheContent = self.avgLangCfg[-id]
    content = string.IsNullOrEmpty(sheContent) and content or sheContent
  end
  return content
end

local function getTaDiffFunc(self, id, content)
  if string.find(content, TAStrTag) then
    local isGirl = PlayerDataCenter.inforData ~= nil and PlayerDataCenter.inforData:GetSex()
    local taStr = isGirl and ConfigData:GetTipContent(12101) or ConfigData:GetTipContent(12100)
    content = string.gsub(content, TAStrTag, taStr)
  end
  return content
end

local function getTaAndSheFunc(self, id, content)
  content = getSheFunc(self, id, content)
  content = getTaDiffFunc(self, id, content)
  return content
end

local GetLanguageContentFunc = {
  [eLanguageType.ZH_CN] = getTaAndSheFunc,
  [eLanguageType.ZH_TW] = getTaAndSheFunc,
  [eLanguageType.EN_US] = getTaAndSheFunc,
  [eLanguageType.JA_JP] = getSheFunc,
  [eLanguageType.KO_KR] = getSheFunc
}

function AvgController:GetAvgLanguage(id)
  local content = self.avgLangCfg[id]
  if string.IsNullOrEmpty(content) then
    warn("Avg language is nil, contentId = " .. tostring(id))
    return ""
  end
  local languageInt = CS_LanguageGlobal.GetLanguageInt()
  local getLangContentFunc = GetLanguageContentFunc[languageInt]
  if getLangContentFunc == nil then
    error("Cant get getLangContentFunc")
  else
    content = getLangContentFunc(self, id, content)
  end
  if string.find(content, CommanderNameStrTag) and PlayerDataCenter.playerName ~= nil then
    content = string.gsub(content, CommanderNameStrTag, PlayerDataCenter.playerName)
  end
  return content
end

function AvgController:SwitchAvgAutoPlay()
  local delayRatio = self.actDelayRatio
  local autoPlayMode = self.autoPlayMode
  if autoPlayMode then
    if delayRatio == 1 then
      delayRatio = 2
    else
      autoPlayMode = false
      delayRatio = 1
    end
  else
    autoPlayMode = true
    delayRatio = 1
  end
  return self:SetAvgAutoPlayMode(autoPlayMode, delayRatio)
end

function AvgController:SetStartAutoPlayAvg()
  self:SetAvgAutoPlayMode(true, 2)
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow ~= nil then
    avgWindow:RefreshAutoPlay(true, 2)
  end
end

function AvgController:SetAvgAutoPlayMode(autoPlayMode, delayRatio)
  self.autoPlayMode = autoPlayMode
  if self.autoPlayMode then
    if self.avgActComplete then
      self:ClearDelayPlatNextTimer()
      self:PlayNextAvgAct()
    else
      local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
      if avgWindow ~= nil then
        avgWindow:TryAvgContinuePlay()
      end
    end
  else
    self:ClearDelayPlatNextTimer()
  end
  self.actDelayRatio = delayRatio or 1
  return self.autoPlayMode, self.actDelayRatio
end

function AvgController:CloseAvgAutoPlayMode()
  return self:SetAvgAutoPlayMode(false, 1)
end

function AvgController:GetAvgAutoPlayMode()
  return self.autoPlayMode, self.actDelayRatio
end

function AvgController:SwitchAvgSpeedup()
  self.speedupMode = not self.speedupMode
  self:ChangeSpeed()
  return self.speedupMode
end

function AvgController:GetAvgSpeedupMode()
  return self.speedupMode
end

function AvgController:ChangeSpeed()
  if self:AvgIgnoreTimeScale() then
    return
  end
  Time.unity_time.timeScale = self.speedupMode and ConfigData.game_config.AvgSpeedupTimescale or 1
end

function AvgController:ClearDelayPlatNextTimer()
  TimerManager:StopTimer(self.__delayPlatNextTimerId)
  self.__delayPlatNextTimerId = nil
end

function AvgController:RecordAct(nextActCfg, actId)
  if nextActCfg.content == nil and nextActCfg.branch == nil then
    return
  end
  local recordData = {actId = actId, selectedActBranchIdx = nil}
  table.insert(self.recordDataList, recordData)
end

function AvgController:RecordSelectedBranch(selectedActBranch)
  local recordData = self.recordDataList[#self.recordDataList]
  if recordData == nil then
    warn("Current recordData is nil.")
    return
  end
  recordData.selectedActBranchIdx = selectedActBranch
end

function AvgController:GetAvgRecordData()
  local list = {}
  for k, v in ipairs(self.recordDataList) do
    list[k] = v
  end
  return list
end

function AvgController:GetIsBranchSelected(actId, branchActId)
  for index, recordData in ipairs(self.recordDataList) do
    if recordData.actId == actId and recordData.selectedActBranchIdx == branchActId then
      return true
    end
  end
  return false
end

function AvgController:GetAvgNextActCfg(actId)
  local nextActCfg = self.avgCfg[actId]
  if nextActCfg == nil then
    self:AvgLogError("Can't get nextActCfg, actId = " .. tostring(actId))
    return table.emptytable
  end
  return nextActCfg
end

function AvgController:GetCurActId()
  return self.curActId
end

function AvgController:GetCurChapterName()
  return self.chapterName
end

function AvgController:JumpChapter(chapterName)
  self:ClearCurAvg()
  self:ShowAvg(chapterName, self.completeFunc, self.__shieldControlSwitch, self.__ignoreTimeScale)
end

function AvgController:AvgIgnoreTimeScale()
  return self.__ignoreTimeScale
end

function AvgController:SkipAvg()
  PlayerClickCollectManager:BtnClickNumCollect(1021)
  local skip2EndActId = self.avgCfg[1].skip2EndActId
  if skip2EndActId ~= nil and self.avgCfg[skip2EndActId] ~= nil and self.avgCfg[skip2EndActId].isEnd == true and self.curActId ~= skip2EndActId then
    self:ClearDelayPlatNextTimer()
    self.avgWindow:EndAllAvgTween()
    self:PlayAvgAct(skip2EndActId)
    return
  end
  self:CompleteAllAvg(nil, true)
end

function AvgController:CompleteAllAvg(hasError, isSkip)
  self._hasError = hasError
  if self._reqCompleteAllAvg then
    return
  end
  self._reqCompleteAllAvg = true
  if self.avgCachePlayParam ~= nil and self.avgCachePlayParam.avgId ~= nil then
    local storyCfg = ConfigData.story_avg[self.avgCachePlayParam.avgId]
    if storyCfg ~= nil and storyCfg.no_send then
    elseif not ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(self.avgCachePlayParam.avgId) then
      ControllerManager:GetController(ControllerTypeId.AvgPlay):RecordAvgPlayed(self.avgCachePlayParam.avgId)
      self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
      self:CalAvgTransDic(self.avgCachePlayParam.avgId)
      local op = isSkip and 1 or 0
      NetworkManager:GetNetwork(NetworkTypeID.Avg):CS_AVG_Complete(self.avgCachePlayParam.avgId, op, self.__onAvgComplete)
      return
    end
  end
  self:OnAvgComplete(nil)
end

function AvgController:__CallAvgCompleteFunc()
  local completeFunc = self.completeFunc
  self.completeFunc = nil
  if completeFunc ~= nil then
    completeFunc()
  end
end

function AvgController:CalAvgTransDic(avgId)
  local storyCfg = ConfigData.story_avg[avgId]
  local rewardIds = {}
  local rewardNums = {}
  local rewardDic = {}
  for index, id in pairs(storyCfg.rewardIds) do
    rewardDic[id] = (rewardDic[id] or 0) + storyCfg.rewardNums[index]
  end
  for index, id in pairs(storyCfg.activityRewardIds) do
    rewardDic[id] = (rewardDic[id] or 0) + storyCfg.activityRewardNums[index]
  end
  for id, num in pairs(rewardDic) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(rewardIds, rewardNums)
  self.crTransDic = crTransDic
end

function AvgController:OnAvgComplete(objList)
  local hasReward = false
  if objList ~= nil and objList.Count > 1 and self.avgCachePlayParam ~= nil then
    local ok = objList[0]
    local rewardDic = objList[1]
    if ok and 0 < table.count(rewardDic) then
      hasReward = true
      local rewardIds = {}
      local rewardNums = {}
      for id, num in pairs(rewardDic) do
        table.insert(rewardIds, id)
        table.insert(rewardNums, num)
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          self:__CallAvgCompleteFunc()
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRItemTransDic(self.crTransDic):SetCRShowOverFunc(function()
          self:__CallAvgCompleteFunc()
        end)
        window:AddAndTryShowReward(CRData)
      end)
    end
  end
  self:ClearCurAvg()
  self.avgIsPlaying = false
  Time.unity_time.timeScale = self.__originTimeScale
  AudioManager:RemoveBgmSourceFader()
  AudioManager:ResumeLastBgm()
  AudioManager:RemoveAllVoice(true)
  AudioManager:PauseSource(eAudioSourceType.LoopSource, false)
  if self.avgCachePlayParam == nil then
    self:Delete()
  end
  if not hasReward then
    self:__CallAvgCompleteFunc()
  end
end

function AvgController:ClearCurAvg()
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow ~= nil then
    avgWindow:CloseUIAVGSystem()
  end
  self:ClearDelayPlatNextTimer()
  self:UnloadAvgCfg()
end

function AvgController:RecordAvgAudioSheet(sheetName)
  if sheetName == eAuCueSheet.UI then
    return
  end
  if self._waitRemoveSheet == nil then
    self._waitRemoveSheet = {}
  end
  self._waitRemoveSheet[sheetName] = true
end

function AvgController:IsAvgPlaying()
  return self.avgIsPlaying
end

function AvgController:AvgLogError(msg)
  msg = msg .. string.format([[

 Avg chapterName:%s, actId:%s]], self.chapterName, self.curActId)
  error(msg)
  if not isGameDev then
    self:CompleteAllAvg(true)
  end
end

function AvgController:_RemoveCueSheet()
  if self._waitRemoveSheet == nil then
    return
  end
  for sheetName, v in pairs(self._waitRemoveSheet) do
    AudioManager:RemoveCueSheet(sheetName)
  end
  self._waitRemoveSheet = nil
end

function AvgController:_VerifyCustomSkip()
  if self.avgCfg[1] == nil then
    error(string.format("[Avg] act 1 is null, chapterName:%s", self.chapterName))
    return
  end
  local skipTextId = self.avgCfg[1].SkipScenario
  local storyAvgId = self.avgCfg[1].storyAvgId
  if skipTextId == nil then
    return
  end
  if self.avgCachePlayParam ~= nil and self.avgCachePlayParam.avgId ~= nil then
    return
  end
  local storyCfg = ConfigData.story_avg[storyAvgId]
  if storyCfg == nil then
    warn(string.format("[Avg] Cant get storyCfg, storyAvgId:%s, chapterName:%s", storyAvgId, self.chapterName))
    return
  end
  if storyCfg.script_id ~= self.chapterName then
    warn(string.format("[Avg] storyAvgId error, storyAvgId:%s, chapterName:%s, storyCfg.script_id:", storyAvgId, self.chapterName, storyCfg.script_id))
    return
  end
end

function AvgController:TryGetAvgCustomSkip()
  local skipTextId = self.avgCfg[1].SkipScenario
  local storyAvgId
  if self.avgCachePlayParam ~= nil and self.avgCachePlayParam.avgId ~= nil then
    storyAvgId = self.avgCachePlayParam.avgId
  else
    storyAvgId = self.avgCfg[1].storyAvgId
  end
  return skipTextId, storyAvgId
end

function AvgController:OnDelete()
  self:_ClearInitCo()
  self:ClearCurAvg()
  if self.__playCoroutine ~= nil then
    GR.StopCoroutine(self.__playCoroutine)
    self.__playCoroutine = nil
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self:_RemoveCueSheet()
  base.OnDelete(self)
end

return AvgController
