_class("UIWeChatCell", UICustomWidget)
local UIWeChatCellState = {Wait = 1, Normal = 2}
_enum("UIWeChatCellState", UIWeChatCellState)

function UIWeChatCell:Constructor()
  self.defaultHeight = 76
  self.module = self:GetModule(QuestChatModule)
  self.weChatProxy = self.module:GetWeChatProxy()
  self._padding_left = 150
  self._padding_right = 100
  self._allWidth = 1227
end

function UIWeChatCell:OnShow()
  self.rect = self:GetGameObject():GetComponent("RectTransform")
  self.leftGO = self:GetGameObject("g_left")
  self.leftTxt = self:GetUIComponent("UILocalizationText", "lefttxt")
  self.leftNameTxt = self:GetUIComponent("UILocalizationText", "leftname")
  self.leftNameTxtRect = self:GetUIComponent("RectTransform", "leftname")
  self.leftTxtRect = self:GetUIComponent("RectTransform", "lefttxt")
  self.rightGO = self:GetGameObject("g_right")
  self.rightTxt = self:GetUIComponent("UILocalizationText", "righttxt")
  self.rightTxtRect = self:GetUIComponent("RectTransform", "righttxt")
  self.voiceGO = self:GetGameObject("g_voice")
  self.voiceTxtGO = self:GetGameObject("g_voicetxt")
  self.voiceTxt = self:GetUIComponent("UILocalizationText", "voicetxt")
  self.voiceTxtRect = self:GetUIComponent("RectTransform", "voicetxt")
  self.voiceBtnName = self:GetUIComponent("UILocalizationText", "voicebtnname")
  self.voiceName = self:GetUIComponent("UILocalizationText", "voicename")
  self.voiceRed = self:GetGameObject("voicered")
  self.voiceRed:SetActive(false)
  self.startGO = self:GetGameObject("g_start")
  self.voiceNumTxt = self:GetUIComponent("UILocalizationText", "voicenum")
  self.voiceAnisGO = {
    self:GetGameObject("ani1"),
    self:GetGameObject("ani2"),
    self:GetGameObject("ani3")
  }
  self.leftTxtContentSize = self:GetUIComponent("ContentSizeFitter", "lefttxt")
  self.rightTxtContentSize = self:GetUIComponent("ContentSizeFitter", "righttxt")
  self.leftBtnGO = self:GetGameObject("leftbtngoempty")
  self.leftBtnRT = self:GetUIComponent("RectTransform", "leftbtngoempty")
  self.leftBtnDarkGO = self:GetGameObject("leftbtngodark")
  self.leftBtnLightGO = self:GetGameObject("leftbtngolight")
  self.rightBtnGO = self:GetGameObject("rightbtngoempty")
  self.rightBtnDarkGO = self:GetGameObject("rightbtngodark")
  self.rightBtnLightGO = self:GetGameObject("rightbtngolight")
  self.ani1 = self:GetUIComponent("Animator", "playAnim1")
  self.ani2 = self:GetUIComponent("Animator", "playAnim2")
  self.aniimage1 = self:GetGameObject("image1")
  self.aniimage2 = self:GetGameObject("image2")
  self.ani1.enabled = false
  self.ani2.enabled = false
end

function UIWeChatCell:OnHide()
  self:StopTimer()
end

function UIWeChatCell:_DoEscape(strContent)
  if string.isnullorempty(self.roleName) then
    self.roleName = GameGlobal.GetModule(RoleModule):GetName()
  end
  strContent = string.gsub(strContent, "PlayerName", self.roleName)
  return strContent
end

function UIWeChatCell:SetData(talk, weChatRole)
  self:StopTimer()
  if weChatRole then
    self.weChatRole = weChatRole
  end
  local name = self.weChatRole:GetName() .. ": "
  self.talk = talk
  local txt = ""
  if talk.talkType ~= WeChatTalkType.Start then
    txt = self:_DoEscape(self.talk.txt)
  end
  self.leftGO:SetActive(talk.talkType == WeChatTalkType.Left)
  self.rightGO:SetActive(talk.talkType == WeChatTalkType.Right)
  self.voiceGO:SetActive(talk.talkType == WeChatTalkType.Voice)
  self.startGO:SetActive(talk.talkType == WeChatTalkType.Start)
  if talk.talkType == WeChatTalkType.Left then
    if talk.readed == false then
      self.leftBtnGO:SetActive(false)
      self.index = 1
      self.str = StringTable.Get("str_quest_chat_xinhao_chuanshuzhong")
      self.strPool = {
        self.str .. ".",
        self.str .. "..",
        self.str .. "..."
      }
      self.timer = GameGlobal.Timer():AddEventTimes(100, TimerTriggerCount.Infinite, self.OnTimerLoop, self)
      self.height = self.defaultHeight
      self.leftNameTxt:SetText(name)
      self:OnTimerLoop()
    else
      if talk.jumpId then
        self.leftBtnGO:SetActive(true)
        if talk.isClickJump == false then
          self.leftBtnDarkGO:SetActive(false)
          self.leftBtnLightGO:SetActive(true)
        else
          self.leftBtnDarkGO:SetActive(true)
          self.leftBtnLightGO:SetActive(false)
        end
      else
        self.leftBtnGO:SetActive(false)
      end
      self.leftNameTxt:SetText(name)
      self.leftTxt:SetText(txt)
      self.height = self:CalcHeight(talk.talkType)
    end
  elseif talk.talkType == WeChatTalkType.Right then
    if talk.readed == false then
      self.rightBtnGO:SetActive(false)
    elseif talk.jumpId then
      self.rightBtnGO:SetActive(true)
      if talk.isClickJump == false then
        self.rightBtnDarkGO:SetActive(false)
        self.rightBtnLightGO:SetActive(true)
      else
        self.rightBtnDarkGO:SetActive(true)
        self.rightBtnLightGO:SetActive(false)
      end
    else
      self.rightBtnGO:SetActive(false)
    end
    self.rightTxt:SetText(txt)
    self.height = self:CalcHeight(talk.talkType)
  elseif talk.talkType == WeChatTalkType.Voice then
    self.voiceName:SetText(name)
    self.voiceBtnName:SetText(name)
    self.voiceNumTxt:SetText(self:GetAudioLength())
    self.height = self:CalcHeight(talk.talkType)
  elseif talk.talkType == WeChatTalkType.Start then
    self.height = self:CalcHeight(talk.talkType)
  end
  self.rect.sizeDelta = Vector2(self._allWidth, self.height)
  return self.height
end

function UIWeChatCell:OnTimerLoop()
  if self.leftTxt then
    self.leftTxt:SetText(self.strPool[self.index])
    self.index = self.index + 1
    if self.index > #self.strPool then
      self.index = 1
    end
  end
end

function UIWeChatCell:OnVoiceAniLoop()
  if self.voiceAnisGO then
    for index, value in ipairs(self.voiceAnisGO) do
      if value then
        if index <= self.voiceAniIndex then
          value:SetActive(true)
        else
          value:SetActive(false)
        end
      end
    end
    self.voiceAniIndex = self.voiceAniIndex + 1
    if self.voiceAniIndex > #self.voiceAnisGO then
      self.voiceAniIndex = 1
    end
  end
end

function UIWeChatCell:StopTimer()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
    self.timer = nil
  end
end

function UIWeChatCell:voiceOnClick()
  local currentTimeMS = self._timeService:GetCurrentTimeMs()
  if currentTimeMS - self._lastClickTime < BattleConst.DoubleClickIntervalTime then
    return
  end
  self._lastClickTime = currentTimeMS
  local module = self:GetModule(QuestChatModule)
  local clientWeChat = module:GetClientWeChat()
  clientWeChat:ChangeState(self.data:GetStartvoiceTime())
end

function UIWeChatCell:leftbtngoOnClick()
  if self.talk and self.talk.talkType == WeChatTalkType.Left and self.talk.jumpId then
    self:ShowDialog("UIWeChatJumpController", self.talk)
    if self.talk.isClickJump == false then
      self.talk.isClickJump = true
      self.leftBtnDarkGO:SetActive(true)
      self.leftBtnLightGO:SetActive(false)
    end
  end
end

function UIWeChatCell:rightbtngoOnClick()
  if self.talk and self.talk.talkType == WeChatTalkType.Right and self.talk.jumpId then
    self:ShowDialog("UIWeChatJumpController", self.talk)
    if self.talk.isClickJump == false then
      self.talk.isClickJump = true
      self.rightBtnDarkGO:SetActive(true)
      self.rightBtnLightGO:SetActive(false)
    end
  end
end

function UIWeChatCell:CalcHeight(talkType)
  local height = 0
  if talkType == WeChatTalkType.Left then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.leftNameTxtRect)
    local textWidth = self._allWidth - self._padding_left - self._padding_right - self.leftNameTxtRect.sizeDelta.x
    self.leftTxtRect.sizeDelta = Vector2(textWidth, self.leftTxtRect.sizeDelta.y)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.leftTxtRect)
    height = self.leftTxtRect.sizeDelta.y + 46
    if self.leftBtnGO.activeInHierarchy then
      local _txt = self.leftTxt
      local settings = _txt:GetGenerationSettings(_txt.rectTransform.rect.size)
      local tg = _txt.cachedTextGenerator
      tg:Invalidate()
      tg:Populate(_txt.text, settings)
      UnityEngine.Canvas.ForceUpdateCanvases()
      local line = tg.lines[tg.lineCount - 1]
      local sLastLine = EngineGameHelper.SubString(_txt.text, line.startCharIdx, -1)
      sLastLine = self:GetStringWithoutMark(sLastLine)
      local width = tg:GetPreferredWidth(sLastLine, settings)
      width = width / settings.scaleFactor
      local posY = line.topY / settings.scaleFactor
      self.leftBtnRT.anchoredPosition = Vector2(width, posY)
    end
  elseif talkType == WeChatTalkType.Right then
    local textWidth = 840
    if textWidth <= self.rightTxt.preferredWidth then
      self.rightTxtRect.sizeDelta = Vector2(840, 0)
      self.rightTxtContentSize.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    else
      self.rightTxtContentSize.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
    end
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rightTxtRect)
    height = self.rightTxtRect.sizeDelta.y + 46
    if self.rightBtnGO.activeInHierarchy then
      local _txt = self.rightTxt
      local settings = _txt:GetGenerationSettings(_txt.rectTransform.rect.size)
      local tg = _txt.cachedTextGenerator
      tg:Invalidate()
      tg:Populate(_txt.text, settings)
      UnityEngine.Canvas.ForceUpdateCanvases()
      local line = tg.lines[tg.lineCount - 1]
      local sLastLine = EngineGameHelper.SubString(_txt.text, line.startCharIdx, -1)
      sLastLine = self:GetStringWithoutMark(sLastLine)
      local width = tg:GetPreferredWidth(sLastLine, settings)
      width = width / settings.scaleFactor
      local posY = line.topY / settings.scaleFactor
      self.rightBtnGO:GetComponent("RectTransform").anchoredPosition = Vector2(-width, posY)
    end
  elseif talkType == WeChatTalkType.Voice then
    if self.talk.readed then
      self.voiceTxtGO:SetActive(true)
      self.voiceRed:SetActive(false)
      local txt = self:_DoEscape(self.talk.txt)
      self.voiceTxt:SetText(txt)
      UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.voiceTxtRect)
      height = self.voiceTxtRect.sizeDelta.y + 30 + 46 + 46
    else
      height = 76
      self.voiceTxtGO:SetActive(false)
      self.voiceRed:SetActive(true)
    end
  elseif talkType == WeChatTalkType.Start then
    height = 35
  end
  return height
end

function UIWeChatCell:getByteCount(str, idx)
  local curByte = string.byte(str, idx)
  local byteCount = 0
  if curByte < 128 then
    byteCount = 1
  elseif curByte < 224 then
    byteCount = 2
  elseif curByte < 240 then
    byteCount = 3
  elseif curByte < 248 then
    byteCount = 4
  elseif curByte < 252 then
    byteCount = 5
  elseif curByte < 254 then
    byteCount = 6
  else
    Log.debug("###[UIWeChatCell] getByteCount fail !")
  end
  return byteCount, curByte
end

function UIWeChatCell:GetStringWithoutMark(s)
  local ret = string.gsub(s, "</color>", "")
  ret = string.gsub(ret, "<color=#%x*>", "")
  return ret
end

function UIWeChatCell:btnvoiceOnClick()
  if self.talk and self.talk.talkType == WeChatTalkType.Voice then
    self.ani1.enabled = true
    self.ani2.enabled = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatPlayVoice, self.talk.voiceId, self)
    if self.talk.readed == false then
      self.weChatProxy:SendTalkReaded(self.weChatRole:GetSpeakerId(), self.talk.chatId, self.talk.talkId, self.talk.triggerIndex, false, true)
    end
  end
end

function UIWeChatCell:StartVoiceAni()
  self.voiceAniIndex = 1
  self:OnVoiceAniLoop()
end

function UIWeChatCell:StopVoiceAni()
  self.voiceAniIndex = 1
  if self.voiceAnisGO then
    for index, value in ipairs(self.voiceAnisGO) do
      if value then
        value:SetActive(true)
      end
    end
  end
  self.ani1.enabled = false
  self.ani2.enabled = false
end

function UIWeChatCell:GetAudioLength()
  if USEADX2AUDIO then
    local length = AudioHelperController.Adx2_GetVoiceSecLengthSyncReq(self.talk.voiceId)
    if length ~= -1 then
      return math.floor(length) .. "''"
    end
  else
    local config = AudioHelperController.GetCfgAudio(self.talk.voiceId)
    if config then
      local request = ResourceManager:GetInstance():SyncLoadAsset(config.ResName, LoadType.Audio)
      local length = request.Obj.length
      if request then
        request:Dispose()
      end
      return math.floor(length) .. "''"
    end
  end
  return 4
end
