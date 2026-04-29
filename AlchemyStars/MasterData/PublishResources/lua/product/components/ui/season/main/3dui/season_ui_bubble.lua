_class("SeasonUIBubble", Object)
SeasonUIBubble = SeasonUIBubble

function SeasonUIBubble:Constructor(gameObject, atlas)
  self._gameObject = gameObject
  self._transform = self._gameObject.transform
  self._atlas = atlas
  self._view = self._gameObject:GetComponent(typeof(UIView))
  self:_GetComponents()
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._player = self._seasonManager:SeasonPlayerManager():GetPlayer()
  self._data = nil
  self._curVoice = nil
end

function SeasonUIBubble:_GetComponents()
  self._rootTransform = self._view:GetUIComponent("Transform", "Root")
  self._content = self._view:GetUIComponent("UILocalizationText", "Content")
end

function SeasonUIBubble:SetData()
  local cfg = self._player:Cfg()
  if cfg and cfg.BubbleOffset then
    self._rootTransform.localPosition = Vector3(cfg.BubbleOffset[1], cfg.BubbleOffset[2], cfg.BubbleOffset[3])
  end
  self._gameObject:SetActive(false)
end

function SeasonUIBubble:Update(deltaTime)
  if self._data then
    if self._data.delay > 0 then
      self._data.delay = self._data.delay - deltaTime
      if self._data.delay <= 0 then
        self:_Play(self._data.text, self._data.audio)
      end
    end
    self._data.time = self._data.time - deltaTime
    if 0 < self._data.time then
      self:_UpdatePosition()
    else
      self:Stop()
    end
  end
end

function SeasonUIBubble:Play(bubble)
  if bubble then
    self._data = SeasonUIBubbleData:New(bubble)
    self._curVoice = nil
    if self._data.delay <= 0 then
      self:_Play(self._data.text, self._data.audio)
    end
  end
end

function SeasonUIBubble:Stop()
  self._data = nil
  if self._curVoice then
    AudioHelperController.StopUIVoice(self._curVoice)
    self._curVoice = nil
  end
  self._gameObject:SetActive(false)
end

function SeasonUIBubble:_Play(text, audio)
  if text then
    self._content:SetText(StringTable.Get(text))
    self._gameObject:SetActive(true)
  else
    self._gameObject:SetActive(false)
  end
  if audio then
    self._seasonManager:SeasonAudioManager():GetSeasonAudio():StopSeasonUIVoice()
    self._curVoice = AudioHelperController.PlayUIVoiceByAudioId(audio)
  end
end

function SeasonUIBubble:_UpdatePosition()
  local position = self._player:Position()
  self._transform.position = Vector3(position.x, position.y, position.z)
end
