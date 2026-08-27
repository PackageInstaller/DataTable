local UIAVGSystem = class("UIAVGSystem", UIBaseWindow)
local base = UIBaseWindow
local UINAvgDialog = require("Game.Avg.UI.UINAvgDialog")
local UINAvgChapter = require("Game.Avg.UI.UINAvgChapter")
local UINAvgChoose = require("Game.Avg.UI.UINAvgChoose")
local UINAvgRecord = require("Game.Avg.UI.UINAvgRecord")
local UINAvgImgItem = require("Game.Avg.UI.UINAvgImgItem")
local UINAvgHeroPic = require("Game.Avg.UI.UINAvgHeroPic")
local UINAvgVideoNode = require("Game.Avg.UI.UINAvgVideoNode")
local UINAvgEffectNode = require("Game.Avg.UI.Effect.UINAvgEffectNode")
local UINAvgHeroCommItem = require("Game.Avg.UI.UINAvgHeroCommItem")
local AvgPostProcess = require("Game.Avg.AvgPostProcess")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgDialogPosX = require("Game.Avg.Enum.eAvgDialogPosX")
local eAvgContentType = require("Game.Avg.Enum.eAvgContentType")
local AvgSteinsGate = require("Game.Avg.SteinsGate.AvgSteinsGate")
local CS_MessageCommon = CS.MessageCommon
local CS_Object = CS.UnityEngine.Object
local CS_DoTween = CS.DG.Tweening.DOTween
local CS_Material = CS.UnityEngine.Material
local defaultScreenRatio = 1.7777777777777777
local imgMaxCount = 10
local eBgColor = {
  [1] = Color.clear,
  [2] = Color.black,
  [3] = Color.white
}
local LongPressSpeed = {
  OneHalfSpeed = 1,
  TwoSpeed = 0.5,
  FourSpeed = 0.25,
  EightSpeed = 0.125
}
local SliderInterval = 43

function UIAVGSystem:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_ShwoLogList, self, self.OnClickShwoLogList)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickSkip)
  UIUtil.AddButtonListener(self.ui.btn_AutoPlay, self, self.OnClickAutoPlay)
  UIUtil.AddButtonListener(self.ui.btn_HideUI, self, self.OnClickHideUI)
  UIUtil.AddButtonListener(self.ui.btn_ReShowUI, self, self.OnClickReShowUI)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickBackground)
  UIUtil.AddButtonListener(self.ui.btn_AvgNoun, self, self.OnClickAvgNoun)
  self:InitAvgLongPressAndDrag()
  self.ui.btn_ReShowUI.gameObject:SetActive(false)
  self.ui.imgItem:SetActive(false)
  self.ui.heroItem:SetActive(false)
  self.ui.communication:SetActive(false)
  self.ui.img_bg.color = Color.clear
  self.imgItemPool = UIItemPool.New(UINAvgImgItem, self.ui.imgItem)
  self.distantViewImgDic = {}
  self.bgImgDic = {}
  self.foregroundImgDic = {}
  self.heroPicDic = {}
  self.audioBackDic = {}
  self.imgCount = 0
  self.__onAvgImgTweenComplete = BindCallback(self, self.OnAvgImgTweenComplete)
  self._OnAvgNounClose = BindCallback(self, self.OnAvgNounClose)
  self.isend = false
end

function UIAVGSystem:InitAvgLongPressAndDrag()
  self.ui.btn_bg.onPress:AddListener(BindCallback(self, self.OnLongPressBackground))
  self.ui.btn_bg.OnFirstExcute:AddListener(BindCallback(self, self.OnFirstExcute))
  self.ui.btn_bg.OnDragEvent:AddListener(BindCallback(self, self.OnDragEvent))
  self.ui.btn_bg.onPressUp:AddListener(BindCallback(self, self.OnPressUpEvent))
  self.ui.btn_bg.responseOnceByPress = false
  self.LastIndex = 0
  self.CurIndex = 0
  self.CurChildIndex = 0
end

function UIAVGSystem:InitAvgSystem(avgCtrl, loadedResTab)
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and ControllerManager:GetController(ControllerTypeId.HomeController):IsNormalState() then
    self._needChangeHomeState = true
    homeWin:OpenOtherCoverWin()
  end
  self.avgCtrl = avgCtrl
  local autoPlay, delayRatio = self.avgCtrl:GetAvgAutoPlayMode()
  self:RefreshAutoPlay(autoPlay, delayRatio)
  self.chapterNode = UINAvgChapter.New(self)
  self.chapterNode:Init(self.ui.chapter)
  self.dialogNode = UINAvgDialog.New(self)
  if IsNull(loadedResTab.dialogPrefab) then
    self.dialogNode:Init(self.ui.dialog)
  else
    local idx = self.ui.dialog.transform:GetSiblingIndex()
    self.ui.dialog:SetActive(false)
    local go = loadedResTab.dialogPrefab:Instantiate(self.ui.dialog.transform.parent)
    go.transform:SetSiblingIndex(idx)
    self.dialogNode:Init(go)
  end
  self.chooseNode = UINAvgChoose.New(self)
  self.chooseNode:Init(self.ui.chooseNode)
  self.chooseNode:Hide()
  self.effectNode = UINAvgEffectNode.New()
  self.effectNode:Init(self.ui.effectNode)
  self.recordNode = UINAvgRecord.New(self)
  self.recordNode:Init(self.ui.recordNode)
  self.videoNode = UINAvgVideoNode.New(self)
  self.videoNode:Init(self.ui.videoNode)
  self.videoNode:Hide()
  self.avgPP = AvgPostProcess.New(self)
  self.avgPP:InitAvgPP(self.ui.ppProfile)
  self._stainGate = AvgSteinsGate.New(self)
  self:__UpdateBlackEdge()
  self._uiCamHdr = UIManager.UICamera.allowHDR
  UIManager.UICamera.allowHDR = true
end

function UIAVGSystem:__UpdateBlackEdge()
  local curRatio = UIManager.UICamera.aspect
  local needEdge = curRatio < defaultScreenRatio
  self.ui.blackEdge:SetActive(needEdge)
  if not needEdge then
    return
  end
  local height = UIManager.BackgroundStretchSize.x / defaultScreenRatio
  local extraHeight = (UIManager.BackgroundStretchSize.y - height) / 2
  local sizeDelta = self.ui.blackEdge_Top.sizeDelta
  sizeDelta.y = extraHeight
  self.ui.blackEdge_Top.sizeDelta = sizeDelta
  self.ui.blackEdge_Bottom.sizeDelta = sizeDelta
  self.dialogNode:SetAvgDialogBottom(extraHeight)
end

function UIAVGSystem:PlayAvgAct(actCfg)
  if actCfg == nil then
    self.avgCtrl:AvgLogError("Cant get actCfg")
    return
  end
  self.actCfg = actCfg
  self.chapterNode:Hide()
  self.dialogNode:Hide()
  self.chooseNode:HideAvgChoose()
  self.jumpAct = nil
  self.jumpChapter = nil
  self.skipTween = false
  self:_ChangeBgColor()
  self:PlayAvgAudio()
  self:RefreshAvgImg(actCfg.images)
  self:RefreshHeroFace(actCfg.heroFace)
  self.hasImgTween = actCfg.imgTween ~= nil and table.count(actCfg.imgTween) > 0
  self.hasContent = actCfg.content ~= nil
  self.hasBranch = actCfg.branch ~= nil and 0 < table.count(actCfg.branch)
  self.hasVideo = actCfg.vedioPath ~= nil
  self.hasPPVTween = actCfg.ppv ~= nil
  self.avgPP:ChangeAvgPP(actCfg.ppv)
  self.effectNode:PlayAvgEffect(actCfg.effect)
  self._stainGate:PlayAvgActSG(actCfg)
  self:DoCustomCode()
  self.contentLenth = 0
  self:PlayAvgOrder()
end

function UIAVGSystem:_ChangeBgColor()
  local actCfg = self.actCfg
  if actCfg.bgColor ~= nil then
    local color = eBgColor[actCfg.bgColor]
    if color == nil then
      self.avgCtrl:AvgLogError("[Avg] bgColor error, bgColor = " .. tostring(actCfg.bgColor))
      return
    end
    self.ui.img_bg.color = color
  end
end

function UIAVGSystem:PlayAvgOrder()
  if self.hasSgAnim then
    return
  end
  if self.hasPPVTween then
    self:PlayAvgVideoLoopBg()
    return
  end
  if self.hasImgTween then
    self:RefreshAvgImgTween(self.actCfg.imgTween)
    return
  end
  if self.hasContent then
    self:ShowAvgContent()
    return
  end
  if self.hasBranch then
    self.chooseNode:ShowAvgChoose(self.actCfg.branch)
    return
  end
  if self.hasVideo then
    self:PlayAvgVideo()
    return
  end
  if self:CheckActComplete() then
    return
  end
  if self.actCfg.autoContinue and not self.avgCtrl:GetAvgAutoPlayMode() then
    self.avgCtrl:ClickContinueAvg()
  end
end

function UIAVGSystem:CheckActComplete()
  if self.hasContent or self.voiceIsPlaying or self.hasVideo or self.hasBranch or self.hasPPVTween or self.hasImgTween then
    return false
  end
  return self.avgCtrl:OnAvgActComplete(self.selectBranchIndex, self.jumpAct, self.jumpChapter, self.contentLenth)
end

function UIAVGSystem:GetAvgSpeakerName(heroId)
  if heroId == -1 then
    return heroId
  end
  local heroCfg = ConfigData.avg_character[heroId]
  if heroCfg == nil then
    warn("Can't find avg_character cfg, speakerHeroId = " .. tostring(heroId))
    return
  end
  return LanguageUtil.GetLocaleText(heroCfg.name)
end

function UIAVGSystem:ShowAvgContent()
  local actCfg = self.actCfg
  local content = self.avgCtrl:GetAvgLanguage(actCfg.content)
  if actCfg.contentType == eAvgContentType.Chapter then
    self.chapterNode:ShowAvgChapter(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter)
  elseif actCfg.contentType == eAvgContentType.Narratage then
    self.dialogNode:ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, nil, true)
  elseif actCfg.contentType == eAvgContentType.NarratageWithSpeaker then
    local speakerName = self.avgCtrl:GetAvgLanguage(actCfg.speakerName)
    self.dialogNode:ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, speakerName, true)
  elseif actCfg.contentType == eAvgContentType.HeroDialog then
    local posId = actCfg.speakerHeroPosId or 2
    if eAvgImgPosType[posId] == nil then
      posId = 2
      self.avgCtrl:AvgLogError("speakerHeroPosId error, id = " .. tostring(actCfg.speakerHeroPosId))
      return
    end
    local posX = eAvgDialogPosX[posId]
    self.dialogNode:ShowAvgDialog(content, actCfg.contentShake, self.skipTween, actCfg.scrambleTypeWriter, self:GetAvgSpeakerName(actCfg.speakerHeroId), false, posX)
  elseif actCfg.contentType == eAvgContentType.Tips then
    CS_MessageCommon.ShowMessageTips(content, true, actCfg.tipsShowDuration or 0, actCfg.tipsTypeWriter)
    self:ShowTextComplete()
  else
    self.avgCtrl:AvgLogError(string.format("Avg contentType error, contentType:%s", actCfg.contentType))
    return
  end
  self:PlayAvgVoice()
end

function UIAVGSystem:TryAvgContinuePlay()
  if self._inContentSplitPuase then
    if self.actCfg.contentType == eAvgContentType.Chapter then
      self.chapterNode:TryPlayAvgContentSplitTween()
    else
      self.dialogNode:TryPlayAvgContentSplitTween()
    end
  end
end

function UIAVGSystem:AvgShowTextSplitPause(pause)
  self._inContentSplitPuase = pause
end

function UIAVGSystem:SetCurActContentSplitIdx(idx)
  self._curActContentSplitIdx = idx
end

function UIAVGSystem:GetCurActContentSplitIdx(idx)
  return self._curActContentSplitIdx
end

function UIAVGSystem:ShowTextComplete(contentLenth)
  self.hasContent = false
  self.contentLenth = contentLenth or 0
  self:PlayAvgOrder()
end

function UIAVGSystem:DoCustomCode()
  if string.IsNullOrEmpty(self.actCfg.customCode) then
    return
  end
  local code = load(self.actCfg.customCode)
  if code == nil then
    return
  end
  local status, current = xpcall(code, debug.traceback)
  if not status then
    error(current)
  end
end

function UIAVGSystem:PlayAvgVideo()
  self.videoNode:PlayAvgVideo(self.actCfg.vedioPath, self.actCfg.vedioAudio)
end

function UIAVGSystem:PlayAvgVideoComplete()
  self.hasVideo = false
  self:PlayAvgOrder()
end

function UIAVGSystem:PlayAvgVideoLoopBg()
  if self.actCfg.vedioLoopPath ~= nil then
    self.videoNode:PlayAvgVideoLoop(self.actCfg.vedioLoopPath, self.actCfg.vedioLoopFrame)
  elseif self.actCfg.vedioLoopFrame ~= nil then
    self.videoNode:SetAvgVideoLoop(self.actCfg.vedioLoopFrame)
  end
  if self.actCfg.vedioLoopStop then
    self.videoNode:StopAvgVideoLoop()
  end
end

function UIAVGSystem:PlayAvgAudio()
  if self.actCfg.audio == nil then
    return
  end
  local audioCfg = self.actCfg.audio
  if audioCfg.bgm ~= nil then
    if audioCfg.bgm.stop then
      AudioManager:StopSource(eAudioSourceType.BgmSource)
    else
      local fadeInTime, fadeOutTime
      if audioCfg.bgm.fadeIn ~= nil then
        fadeInTime = audioCfg.bgm.fadeIn * 1000
      end
      if audioCfg.bgm.fadeOut ~= nil then
        fadeOutTime = audioCfg.bgm.fadeOut * 1000
      end
      AudioManager:SetBgmSourceFadeInAndOutTime(fadeInTime, fadeOutTime)
      AudioManager:PlayAudio(audioCfg.bgm.cue, audioCfg.bgm.sheet, eAudioSourceType.BgmSource)
    end
  end
  if audioCfg.sfx ~= nil then
    local auBack = AudioManager:PlayAudio(audioCfg.sfx.cue, audioCfg.sfx.sheet, eAudioSourceType.SfxSource)
    self.avgCtrl:RecordAvgAudioSheet(audioCfg.sfx.sheet)
    if audioCfg.sfx.audioId ~= nil then
      self.audioBackDic[audioCfg.sfx.audioId] = auBack
    end
  end
  if audioCfg.stopAudioId ~= nil then
    for k, id in ipairs(audioCfg.stopAudioId) do
      local auBack = self.audioBackDic[id]
      if auBack == nil then
        warn("[avg] stopAudioId is invalid, id : " .. tostring(id))
      else
        AudioManager:StopAudioByBack(auBack)
        self.audioBackDic[id] = nil
      end
    end
  end
end

function UIAVGSystem:PlayAvgVoice()
  if self.actCfg.audio == nil then
    return
  end
  local audioCfg = self.actCfg.audio
  self.voiceIsPlaying = false
  if audioCfg.voice ~= nil then
    self.voiceIsPlaying = true
    if self.__onAudioPlayComplete == nil then
      self.__onAudioPlayComplete = BindCallback(self, self.AudioPlayComplete)
    end
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(audioCfg.voice.heroId, audioCfg.voice.voiceId, self.__onAudioPlayComplete)
  end
end

function UIAVGSystem:AudioPlayComplete()
  self.voiceIsPlaying = false
  self:CheckActComplete()
end

function UIAVGSystem:StopAvgVoice()
  if self.voiceIsPlaying then
    AudioManager:StopSource(eAudioSourceType.VoiceSource)
    self.voiceIsPlaying = false
  end
end

function UIAVGSystem:BranchChooseComplete(index, jumpAct, jumpChapter)
  self.selectBranchIndex = index
  self.jumpAct = jumpAct
  self.jumpChapter = jumpChapter
  self.hasBranch = false
  self:StopAvgVoice()
  self:PlayAvgOrder()
end

function UIAVGSystem:RefreshAvgImg(imgCfgList)
  if imgCfgList == nil then
    return
  end
  for k, v in ipairs(imgCfgList) do
    if v.delete then
      self:RecycleImgItem(v.imgId)
    end
  end
  self.imgNeedSort = {}
  for k, v in ipairs(imgCfgList) do
    if not v.delete then
      self:NewImgItem(v)
    end
  end
  self:SortAvtImgItem()
  self.ui.heroesNode.gameObject:SetActive(table.count(self.heroPicDic) > 0)
end

function UIAVGSystem:NewImgItem(imgCfg)
  local imgId = imgCfg.imgId
  local imgType = imgCfg.imgType
  local imgItem
  if imgType == eAvgImgType.Background then
    imgItem = self.bgImgDic[imgId]
    if imgItem == nil then
      imgItem = self.imgItemPool:GetOne()
      self.bgImgDic[imgId] = imgItem
    end
    imgItem:InitAvgImgItem(imgCfg, self.ui.background, self.__onAvgImgTweenComplete)
  elseif imgType == eAvgImgType.Character then
    imgItem = self.heroPicDic[imgId]
    if imgItem == nil then
      imgItem = UINAvgHeroPic.New()
      self.heroPicDic[imgId] = imgItem
    end
    imgItem:InitAvgHeroPic(imgCfg, self.ui.heroItem, self.__onAvgImgTweenComplete)
  elseif imgType == eAvgImgType.Foreground then
    imgItem = self.foregroundImgDic[imgId]
    if imgItem == nil then
      imgItem = self.imgItemPool:GetOne()
      self.foregroundImgDic[imgId] = imgItem
    end
    imgItem:InitAvgImgItem(imgCfg, self.ui.foreground, self.__onAvgImgTweenComplete)
  elseif imgType == eAvgImgType.DistantView or imgType == eAvgImgType.Movie then
    imgItem = self.distantViewImgDic[imgId]
    if imgItem == nil then
      imgItem = self.imgItemPool:GetOne()
      self.distantViewImgDic[imgId] = imgItem
    end
    imgItem:InitAvgImgItem(imgCfg, self.ui.distantView, self.__onAvgImgTweenComplete)
  else
    local imgItem = self:GetImgItem(imgId, true)
    if imgItem == nil then
      local actId = self.avgCtrl:GetCurActId()
      local chapterName = self.avgCtrl:GetCurChapterName()
      warn(string.format("Unsupported avg imgType, imgType = %s, imgId = %s, actId = %s, chapterName = %s", imgType, imgId, actId, chapterName))
      return
    elseif imgCfg.order ~= nil then
      imgType = imgItem:GetAvgImgType()
      imgItem:ChangeAvgImgOrder(imgCfg.order)
      self.imgNeedSort[imgType] = true
      return
    end
  end
  self.imgNeedSort[imgType] = true
  self.imgCount = self.imgCount + 1
  if self.imgCount > imgMaxCount then
    warn("Avg image count is beyond limit, imgCount = " .. tostring(self.imgCount))
  end
end

function UIAVGSystem:RecycleImgItem(imgId)
  local imgItem
  if self.bgImgDic[imgId] ~= nil then
    imgItem = self.bgImgDic[imgId]
    self.bgImgDic[imgId] = nil
    self.imgItemPool:HideOne(imgItem)
  elseif self.heroPicDic[imgId] ~= nil then
    imgItem = self.heroPicDic[imgId]
    self.heroPicDic[imgId] = nil
    imgItem:Delete()
  elseif self.foregroundImgDic[imgId] ~= nil then
    imgItem = self.foregroundImgDic[imgId]
    self.foregroundImgDic[imgId] = nil
    self.imgItemPool:HideOne(imgItem)
  elseif self.distantViewImgDic[imgId] ~= nil then
    imgItem = self.distantViewImgDic[imgId]
    self.distantViewImgDic[imgId] = nil
    self.imgItemPool:HideOne(imgItem)
  else
    warn("Can't find avg img to delete, imgId = " .. tostring(imgId))
    return
  end
  self.imgCount = self.imgCount - 1
end

function UIAVGSystem:GetImgItem(imgId, withoutWarn)
  local imgItem
  if self.bgImgDic[imgId] ~= nil then
    imgItem = self.bgImgDic[imgId]
  elseif self.heroPicDic[imgId] ~= nil then
    imgItem = self.heroPicDic[imgId]
  elseif self.foregroundImgDic[imgId] ~= nil then
    imgItem = self.foregroundImgDic[imgId]
  elseif self.distantViewImgDic[imgId] ~= nil then
    imgItem = self.distantViewImgDic[imgId]
  elseif not withoutWarn then
    warn("Can't find avg img item, imgId = " .. tostring(imgId))
    return
  end
  return imgItem
end

function UIAVGSystem:SortAvtImgItem()
  for imgType, v in pairs(self.imgNeedSort) do
    local targetDic
    if imgType == eAvgImgType.Background then
      targetDic = self.bgImgDic
    elseif imgType == eAvgImgType.Character then
      targetDic = self.heroPicDic
    elseif imgType == eAvgImgType.Foreground then
      targetDic = self.foregroundImgDic
    elseif imgType == eAvgImgType.DistantView or imgType == eAvgImgType.Movie then
      targetDic = self.distantViewImgDic
    end
    if targetDic ~= nil then
      local imgItemList = {}
      for k, v in pairs(targetDic) do
        table.insert(imgItemList, v)
      end
      table.sort(imgItemList, function(a, b)
        return a:GetAvgImgOrder() < b:GetAvgImgOrder()
      end)
      for k, v in ipairs(imgItemList) do
        v.transform:SetAsLastSibling()
      end
    end
  end
end

function UIAVGSystem:RefreshAvgImgTween(tweenCfgList)
  if tweenCfgList == nil then
    return
  end
  self.tweenImgItemDic = {}
  for k, tweenCfg in ipairs(tweenCfgList) do
    local imgId = tweenCfg.imgId
    local imgItem = self:GetImgItem(imgId)
    if imgItem ~= nil then
      imgItem:AddAvgImgTween(tweenCfg)
      self.tweenImgItemDic[imgId] = imgItem
    end
  end
  for k, v in pairs(self.tweenImgItemDic) do
    v:PlayAvgImgTween()
  end
end

function UIAVGSystem:OnAvgImgTweenComplete(imgId)
  self.tweenImgItemDic[imgId] = nil
  if table.count(self.tweenImgItemDic) == 0 then
    self.hasImgTween = false
    self:PlayAvgOrder()
  end
end

function UIAVGSystem:OnAvgPPVTweenComplete()
  if self.hasPPVTween then
    self.hasPPVTween = false
    self:PlayAvgOrder()
  end
end

function UIAVGSystem:GetAvgSteinsGateMobileHolder()
  return self.ui.stainsGateMobileHolder
end

function UIAVGSystem:SetWaitAvgSGAnim()
  self.hasSgAnim = true
end

function UIAVGSystem:OnAvgSGAnimComplete()
  if self.hasSgAnim then
    self.hasSgAnim = false
    self:PlayAvgOrder()
  end
end

function UIAVGSystem:SetTopControlActive(active)
  self.ui.topNode:SetActive(active)
end

function UIAVGSystem:RefreshHeroFace(faceCfg)
  if faceCfg == nil then
    return
  end
  for k, cfg in ipairs(faceCfg) do
    local imgItem = self.heroPicDic[cfg.imgId]
    if imgItem == nil then
      self.avgCtrl:AvgLogError("Cant get heroPicItem, imgId = " .. tostring(cfg.imgId))
    else
      imgItem:AvgHeroChangeFace(cfg.faceId)
    end
  end
end

function UIAVGSystem:EndAllAvgTween()
  if self.hasPPVTween then
    self.avgPP:EndAvgPPV()
  elseif self.hasImgTween then
    local list = {}
    for k, v in pairs(self.tweenImgItemDic) do
      list[k] = v
    end
    for k, v in pairs(list) do
      v:AvgImgTweenDoEnd()
    end
  elseif self.hasContent then
    if self.actCfg.contentType == eAvgContentType.Chapter then
      self.chapterNode:EndAvgContent()
    else
      self.dialogNode:EndAvgContent()
    end
  end
end

function UIAVGSystem:OnClickShwoLogList()
  self.__lastAutoPlay, self.__lastDelayRatio = self.avgCtrl:GetAvgAutoPlayMode()
  if self.__lastAutoPlay then
    self.avgCtrl:SetAvgAutoPlayMode(false)
  end
  self.recordNode:ShowAcgRecord(self.avgCtrl:GetAvgRecordData())
end

function UIAVGSystem:OnAvgRecordClose()
  if self.__lastAutoPlay then
    self.avgCtrl:SetAvgAutoPlayMode(true, self.__lastDelayRatio)
  end
end

function UIAVGSystem:OnClickAutoPlay()
  local autoPlay, delayRatio = self.avgCtrl:SwitchAvgAutoPlay()
  self:RefreshAutoPlay(autoPlay, delayRatio)
end

function UIAVGSystem:OnClickHideUI()
  self.ui.btn_ReShowUI.gameObject:SetActive(true)
  local autoPlay, delayRatio = self.avgCtrl:CloseAvgAutoPlayMode()
  self:RefreshAutoPlay(autoPlay, delayRatio)
  self.dialogNode:ShowAvgUI(false)
  self.chooseNode:ShowAvgUI(false)
  self:SetTopControlActive(false)
end

function UIAVGSystem:OnClickReShowUI()
  self.dialogNode:ShowAvgUI(true)
  self.chooseNode:ShowAvgUI(true)
  self:SetTopControlActive(true)
  self.ui.btn_ReShowUI.gameObject:SetActive(false)
end

function UIAVGSystem:RefreshAutoPlay(autoPlay, delayRatio)
  if self.firstAutoPlay == nil then
    self.autoIconPos = self.ui.img_AutoIcon.transform.position
    self.autoIconColor = self.ui.img_AutoIcon.color
    self.firstAutoPlay = false
  end
  self.ui.img_AutoIcon.transform.position = self.autoIconPos
  self.autoIconColor.a = 1
  self.ui.img_AutoIcon.color = self.autoIconColor
  local twSequence
  if autoPlay then
    self.ui.fade_AutoPlay.alpha = 1
    if self.twSequence ~= nil then
      self.twSequence:Kill()
      self.twSequence = nil
    end
    twSequence = CS_DoTween.Sequence()
    twSequence:Append(self.ui.img_AutoIcon.transform:DOLocalMoveX(160, 1.2))
    twSequence:Join(self.ui.img_AutoIcon:DOFade(0, 1.2))
    twSequence:SetLoops(-1)
    twSequence:SetUpdate(true)
    self.twSequence = twSequence
    self.ui.img_AutoPlayIcon:SetIndex(delayRatio == 1 and 0 or 1)
  else
    self.ui.fade_AutoPlay.alpha = 0.6
    self.ui.img_AutoPlayIcon:SetIndex(0)
    if self.twSequence ~= nil then
      self.twSequence:Kill()
      self.twSequence = nil
    end
  end
end

function UIAVGSystem:OnClickSkip()
  local SkipTextId, storyAvgId = self.avgCtrl:TryGetAvgCustomSkip()
  if SkipTextId ~= nil then
    local skipStr = self.avgCtrl:GetAvgLanguage(SkipTextId)
    UIManager:ShowWindowAsync(UIWindowTypeID.AvgSkip, function(window)
      if window == nil then
        return
      end
      window:InitAvgSkipInfo(skipStr, storyAvgId)
    end)
  else
    CS_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Avg_SkipAllAvg), function()
      local avgctrl = ControllerManager:GetController(ControllerTypeId.Avg)
      if avgctrl ~= nil then
        avgctrl:SkipAvg()
      end
    end, nil)
  end
end

function UIAVGSystem:_OnClickBackground(withoutSound)
  if not withoutSound then
    AudioManager:PlayAudioById(1134)
  end
  if self.hasContent or self.hasImgTween or self.hasBranch or self.hasVideo or self.hasPPVTween or self.hasSgAnim then
    self.skipTween = true
    if self.hasSgAnim then
      return
    end
    if self.hasPPVTween then
      self.avgPP:SkipAvgPPV()
    elseif self.hasImgTween then
      local list = {}
      for k, v in pairs(self.tweenImgItemDic) do
        list[k] = v
      end
      for k, v in pairs(list) do
        v:AvgImgTweenDoComplete()
      end
    elseif self.hasContent then
      if self.actCfg.contentType == eAvgContentType.Chapter then
        self.chapterNode:SkipAvgContent()
      else
        self.dialogNode:SkipAvgContent()
      end
    end
    return
  end
  self.avgCtrl:ClickContinueAvg()
end

function UIAVGSystem:OnFirstExcute()
  local btnSpeed = self.ui.btn_bg
  local mousepos = btnSpeed:GetMouseDir()
  local imgprogress = self.ui.img_ProgressBar
  local calctime = btnSpeed:GetCalcTime()
  local totaltime = btnSpeed.pressDurationTime - btnSpeed.ProgressAppearTime
  local progress = 1 < calctime / totaltime and 1 or calctime / totaltime
  if mousepos == 0 then
    self.ui.obj_SpeedUp.transform.localPosition = Vector3.New(741.2, 0, 0)
    self.ui.obj_timescale.transform.localPosition = Vector3.New(739, -11.6, 0)
  elseif mousepos == 1 then
    self.ui.obj_SpeedUp.transform.localPosition = Vector3.New(-856.2, 0, 0)
    self.ui.obj_timescale.transform.localPosition = Vector3.New(-856.2, -11.6, 0)
  end
  self.ui.obj_SpeedUp:SetActive(true)
  imgprogress.fillAmount = progress
  if progress == 1 then
    self.ui.obj_SpeedUp:SetActive(false)
    self.ui.obj_timescale:SetActive(true)
    self.ui.Canvas_Dialog.blocksRaycasts = false
    local playspeed = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetAvgplayspeed()
    if playspeed == 0.0 or playspeed == nil then
      btnSpeed.pressRepeatInterval = LongPressSpeed.OneHalfSpeed
      self.CurIndex = self:GetChildIndex(LongPressSpeed.OneHalfSpeed)
      self.CurChildIndex = self:GetChildIndex(LongPressSpeed.OneHalfSpeed)
      self:SetTImeScale()
    else
      btnSpeed.pressRepeatInterval = playspeed
      self.CurIndex = self:GetChildIndex(playspeed)
      self.CurChildIndex = self:GetChildIndex(playspeed)
      self:SetTImeScale()
    end
  end
end

function UIAVGSystem:OnLongPressBackground()
  self:_OnClickBackground(true)
end

function UIAVGSystem:OnClickAvgNoun()
  self.__lastAutoPlay, self.__lastDelayRatio = self.avgCtrl:GetAvgAutoPlayMode()
  if self.__lastAutoPlay then
    self.avgCtrl:SetAvgAutoPlayMode(false)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(window)
    if window == nil then
      return
    end
    window:InitAvgNounDes()
    window:BindAvgNounCloseEvent(self._OnAvgNounClose)
  end)
end

function UIAVGSystem:OnAvgNounClose()
  if self.__lastAutoPlay then
    self.avgCtrl:SetAvgAutoPlayMode(true, self.__lastDelayRatio)
  end
end

function UIAVGSystem:OnDragEvent(SlideDis)
  local tempdis = self.ui.btn_bg.Sliderdis
  if 0 < tempdis then
    self.LastIndex = self.CurIndex
    local index = math.floor(tempdis / self.ui.btn_bg.SliderInterval)
    self.CurIndex = index
    if self.LastIndex ~= self.CurIndex then
      self.CurChildIndex = 0 > self.CurChildIndex - 1 and 0 or self.CurChildIndex - 1
      self:SetTImeScale()
    end
  elseif tempdis < 0 then
    tempdis = tempdis * -1
    self.LastIndex = self.CurIndex
    local index = math.floor(tempdis / self.ui.btn_bg.SliderInterval)
    self.CurIndex = index
    if self.LastIndex ~= self.CurIndex then
      self.CurChildIndex = self.CurChildIndex + 1 > 3 and 3 or self.CurChildIndex + 1
      self:SetTImeScale()
    end
  end
end

function UIAVGSystem:OnPressUpEvent()
  if IsNull(self.gameObject) then
    return
  end
  self.ui.obj_SpeedUp:SetActive(false)
  self.ui.obj_timescale:SetActive(false)
  self.ui.Canvas_Dialog.blocksRaycasts = true
  self.isend = false
end

function UIAVGSystem:GetChildIndex(TimeSpeed)
  if TimeSpeed == LongPressSpeed.EightSpeed then
    return 0
  elseif TimeSpeed == LongPressSpeed.FourSpeed then
    return 1
  elseif TimeSpeed == LongPressSpeed.TwoSpeed then
    return 2
  elseif TimeSpeed == LongPressSpeed.OneHalfSpeed then
    return 3
  else
    print("TimeSpeed Error")
    return 0
  end
end

function UIAVGSystem:SetTImeScale()
  if self.CurChildIndex == 0 then
    self.ui.btn_bg.pressRepeatInterval = LongPressSpeed.EightSpeed
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):Saveavgspeed(LongPressSpeed.EightSpeed)
  elseif self.CurChildIndex == 1 then
    self.ui.btn_bg.pressRepeatInterval = LongPressSpeed.FourSpeed
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):Saveavgspeed(LongPressSpeed.FourSpeed)
  elseif self.CurChildIndex == 2 then
    self.ui.btn_bg.pressRepeatInterval = LongPressSpeed.TwoSpeed
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):Saveavgspeed(LongPressSpeed.TwoSpeed)
  elseif self.CurChildIndex == 3 then
    self.ui.btn_bg.pressRepeatInterval = LongPressSpeed.OneHalfSpeed
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):Saveavgspeed(LongPressSpeed.OneHalfSpeed)
  else
    print("curToggleIndex Error")
  end
  local child = self.ui.obj_timescale.transform:GetChild(self.CurChildIndex)
  self.ui.trans_select:SetParent(child)
  self.ui.trans_select.offsetMax = Vector2.New(0, 0)
  self.ui.trans_select.offsetMin = Vector2.New(0, 0)
end

function UIAVGSystem:GetHeroCommItem()
  if self.heroCommItemPool == nil then
    self.heroCommItemPool = UIItemPool.New(UINAvgHeroCommItem, self.ui.communication)
  end
  local mat = self:GetAvgRippleMat()
  return self.heroCommItemPool:GetOne(), mat
end

function UIAVGSystem:ReturnHeroCommItem(item, mat)
  item.transform:SetParent(self.ui.communication.transform.parent)
  item.transform.localScale = Vector3.one
  item.transform.localRotation = Quaternion.identity
  self.heroCommItemPool:HideOne(item)
  self:ReturnAvgRippleMat(mat)
end

function UIAVGSystem:GetAvgRippleMat()
  if self._rippleMatPoolList == nil then
    self._rippleMatPoolList = {}
    self._rippleMatInUseDic = {}
  end
  local mat
  if #self._rippleMatPoolList > 0 then
    mat = table.remove(self._rippleMatPoolList)
  else
    mat = CS_Material(self.ui.commHeroMat)
  end
  self._rippleMatInUseDic[mat] = true
  return mat
end

function UIAVGSystem:ReturnAvgRippleMat(mat)
  if self._rippleMatPoolList == nil then
    return
  end
  self._rippleMatInUseDic[mat] = nil
  table.insert(self._rippleMatPoolList, mat)
end

function UIAVGSystem:OnClickAvgTextLink(herfStr, linkStr)
  local arg = string.split(herfStr, ":")
  if arg[1] == "Des" then
    local desId = tonumber(arg[2])
    local nounDesCfg = ConfigData.noun_des[desId]
    if nounDesCfg == nil then
      warn("AVG:this noundes not exist linkStr:" .. tostring(linkStr) .. " id:" .. tostring(herfStr))
      return
    end
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SaveAvgNoun(desId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(win)
      win:InitAvgNounDes(true, desId)
    end)
  end
end

function UIAVGSystem:GetOnClickAvgTextLinkCallback()
  if self.__OnClickAvgTextLink == nil then
    self.__OnClickAvgTextLink = BindCallback(self, self.OnClickAvgTextLink)
  end
  return self.__OnClickAvgTextLink
end

function UIAVGSystem:GetAvgHeroDissolveMat()
  if IsNull(self.heroDissolveMat) then
    self.heroDissolveMat = CS_Material(self.ui.dissolveHeroMat)
  end
  return self.heroDissolveMat
end

function UIAVGSystem:AvgIgnoreTimeScale()
  return self.avgCtrl:AvgIgnoreTimeScale()
end

function UIAVGSystem:_HomeBackFromOtherCoverWin()
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and self._needChangeHomeState then
    self._needChangeHomeState = false
    homeWin:BackFromOtherCoverWin()
  end
end

function UIAVGSystem:CloseUIAVGSystem()
  self:_HomeBackFromOtherCoverWin()
  self:Delete()
end

function UIAVGSystem:OnDelete()
  if self.chapterNode ~= nil then
    self.chapterNode:Delete()
  end
  if self.dialogNode ~= nil then
    self.dialogNode.ui.text_Dialog.GetInfoDic:Clear()
    self.dialogNode:Delete()
  end
  if self.chooseNode ~= nil then
    self.chooseNode:Delete()
  end
  if self.recordNode ~= nil then
    self.recordNode:Delete()
  end
  if self.avgPP ~= nil then
    self.avgPP:Delete()
  end
  if self.effectNode ~= nil then
    self.effectNode:Delete()
  end
  if self.videoNode ~= nil then
    self.videoNode:Delete()
  end
  self._stainGate:OnDelete()
  local acgnounwindow = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  if acgnounwindow ~= nil then
    acgnounwindow:Delete()
  end
  self.imgItemPool:DeleteAll()
  for k, v in pairs(self.heroPicDic) do
    v:Delete()
  end
  self:StopAvgVoice()
  DestroyUnityObject(self.heroDissolveMat)
  self.heroDissolveMat = nil
  if self._rippleMatPoolList ~= nil then
    for k, mat in ipairs(self._rippleMatPoolList) do
      DestroyUnityObject(self.mat)
    end
    for mat, v in pairs(self._rippleMatInUseDic) do
      DestroyUnityObject(self.mat)
    end
  end
  if self.twSequence ~= nil then
    self.twSequence:Kill()
    self.twSequence = nil
  end
  UIManager.UICamera.allowHDR = self._uiCamHdr
  UIManager:DeleteWindow(UIWindowTypeID.AvgSkip, true)
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
  if avgCtrl ~= nil and avgCtrl:IsAvgPlaying() then
    self:_HomeBackFromOtherCoverWin()
  end
  base.OnDelete(self)
end

return UIAVGSystem
