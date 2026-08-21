_class("UIN34DispatchDialogue", UICustomWidget)
UIN34DispatchDialogue = UIN34DispatchDialogue

function UIN34DispatchDialogue:Constructor()
  self._padding = {
    l = 10,
    r = 10,
    t = 20,
    b = 20,
    s = 14,
    h = 0,
    viewport = 0
  }
  self._padding.t = self._padding.t - self._padding.s
  self._textAnchor = UnityEngine.TextAnchor
  self._autoChat = nil
  self._optionID = -1
  self._pauseDialogue = false
end

function UIN34DispatchDialogue:OnShow()
  self._sr = self:GetUIComponent("ScrollRect", "Scroll View")
  self._preScrollPosition = -1
  self._srContent = self._sr.content
  self._roleModule = self:GetModule(RoleModule)
  self._localDb = UIN34DispatchLocalDb:New()
  self._localDb:ViewedLoadDB()
  self:InitPadding()
  self:InitTalkAnimation()
  self:CreateCommon()
end

function UIN34DispatchDialogue:OnHide()
  self:ReleaseAutoChat()
  for k, v in pairs(self._common) do
    v:UnLoad()
    v:Dispose()
  end
end

function UIN34DispatchDialogue:Chat(archId, fnChatChanged)
  self._cfgArch = Cfg.cfg_component_dispatch_arch[archId]
  self._curTalk = Cfg.cfg_mission_multiline_talk[self._cfgArch.DispatchTalk]
  self._fnChatChanged = fnChatChanged
  local isViewed = false
  local optionsData
  isViewed, optionsData = self._localDb:IsViewed(self._cfgArch.ID)
  self:InitPadding()
  self:ReleaseAutoChat()
  if self._chatTestCase then
    isViewed = true
    optionsData = {
      [54010104] = 54010104,
      [54010113] = 54010113
    }
  end
  if isViewed then
    self:ViewChat(optionsData)
  else
    self:AutoChat()
  end
end

function UIN34DispatchDialogue:CreateAnimTalk(TT, talkName, cfgTalk, layout, widgetAnim, animCb, widgetCb)
  local txtWord = StringTable.Get(cfgTalk.ChatWord)
  local len = string.len(txtWord)
  local delayMs = 500
  for k, v in pairs(self._preAnimation) do
    if len >= v.Min then
      delayMs = v.Duration
      break
    end
  end
  widgetAnim:GetGameObject():SetActive(true)
  widgetAnim:SetData(cfgTalk)
  self:TalkLayout(widgetAnim, layout, true)
  self._padding.h = self._padding.h - self._padding.s - widgetAnim:PreferredHeight()
  local widgetTalk = self:Spawn(talkName, string.format("%s.prefab", talkName))
  widgetTalk:SetData(cfgTalk)
  table.insert(self._talk, widgetTalk)
  self:TalkLayout(widgetTalk, layout, false)
  widgetTalk:GetGameObject():SetActive(false)
  self:ScrollBottom(false, TT, 333, widgetAnim)
  if animCb ~= nil then
    animCb(widgetAnim)
  end
  YIELD(TT, delayMs)
  widgetAnim:GetGameObject():SetActive(false)
  widgetTalk:GetGameObject():SetActive(true)
  if widgetCb ~= nil then
    widgetCb(widgetTalk)
  end
end

function UIN34DispatchDialogue:CreateOptionTalk(TT, talkName, cfgTalk, layout, widgetAnim, animCb, widgetCb)
  widgetAnim:GetGameObject():SetActive(true)
  widgetAnim:SetData(cfgTalk)
  widgetAnim:SetFramePosition()
  self:TalkLayout(widgetAnim, layout, true)
  self._padding.h = self._padding.h - self._padding.s - widgetAnim:PreferredHeight()
  local cfgOption
  local optionWordLen = 0
  for k, v in pairs(cfgTalk.AnswerID) do
    local optionTalk = Cfg.cfg_mission_multiline_talk[v]
    local txtWord = StringTable.Get(optionTalk.ChatWord)
    local len = string.len(txtWord)
    if optionWordLen < len then
      optionWordLen = len
      cfgOption = optionTalk
    end
  end
  local widgetTalk = self:Spawn(talkName, string.format("%s.prefab", talkName))
  widgetTalk:SetData(cfgOption)
  table.insert(self._talk, widgetTalk)
  self:TalkLayout(widgetTalk, layout, false)
  self._padding.h = self._padding.h - self._padding.s - widgetTalk:PreferredHeight()
  widgetTalk:GetGameObject():SetActive(false)
  self:ScrollBottom(true, TT, 333, widgetAnim)
  if animCb ~= nil then
    local lockName = "UIN34DispatchDialogue:TalkOptionTT -- inAnimation"
    self:Lock(lockName)
    animCb(widgetAnim)
    self:UnLock(lockName)
  end
  self._optionID = -1
  while self._optionID == -1 do
    YIELD(TT)
  end
  widgetAnim:GetGameObject():SetActive(false)
  local idOptionTalk = cfgTalk.AnswerID[self._optionID]
  cfgOption = Cfg.cfg_mission_multiline_talk[idOptionTalk]
  self._curTalk = Cfg.cfg_mission_multiline_talk[cfgOption.NextWord]
  widgetTalk:GetGameObject():SetActive(true)
  widgetTalk:SetData(cfgOption)
  self:TalkLayout(widgetTalk, layout, false)
  if widgetCb ~= nil then
    widgetCb(widgetTalk)
  end
end

function UIN34DispatchDialogue:OptionOnClick(id, go)
  self._optionID = id
end

function UIN34DispatchDialogue:ScrollBottom(force, TT, blendMs, widget)
  local threshold = 1
  if force then
    threshold = threshold + threshold
  else
    local maxPixel = 10
    local sizeDelta = self._srContent.sizeDelta
    if sizeDelta.y <= self._padding.viewport.y then
      threshold = 1
    else
      threshold = maxPixel / (sizeDelta.y - self._padding.viewport.y)
    end
  end
  if threshold == 1 then
    self._sr.verticalNormalizedPosition = 0
  elseif threshold >= self._preScrollPosition and TT ~= nil and blendMs ~= nil then
    if widget ~= nil then
      widget:GetGameObject():SetActive(false)
    end
    local position = self._sr.verticalNormalizedPosition
    local speed = position / blendMs
    local deltaMs = 0
    while blendMs >= deltaMs do
      local dt = GameGlobal:GetInstance():GetDeltaTime()
      deltaMs = deltaMs + dt
      position = position - speed * dt
      position = math.max(position, 0)
      self._sr.verticalNormalizedPosition = position
      YIELD(TT)
    end
    self._sr.verticalNormalizedPosition = 0
    if widget ~= nil then
      widget:GetGameObject():SetActive(true)
    end
  elseif threshold >= self._preScrollPosition then
    self._sr.verticalNormalizedPosition = 0
  end
end

function UIN34DispatchDialogue:AutoChat()
  if self._fnChatChanged ~= nil then
    self._fnChatChanged(true)
  end
  if self._curTalk == nil then
    return
  end
  self._autoChat = self:StartTask(function(TT)
    YIELD(TT, 1000)
    local optionsData = {}
    self:ScrollBottom(true)
    while self._curTalk ~= nil do
      local curTalk = self._curTalk
      self._curTalk = Cfg.cfg_mission_multiline_talk[self._curTalk.NextWord]
      while self._pauseDialogue do
        YIELD(TT)
      end
      if curTalk.TalkType == UIN34DispatchDialogueType.Npc then
        local layout = self._textAnchor.LowerLeft
        local talkName = "UIN34DispatchDialogueNpc"
        self:CreateAnimTalk(TT, talkName, curTalk, layout, self._npcAnim, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialogueNpcAnim_in", 333)
        end, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialogueNpc_word_in", 233)
        end)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN34DispatchDialogueType.Player and curTalk.AnswerID ~= nil then
        local layout = self._textAnchor.LowerRight
        local talkName = "UIN34DispatchDialoguePlayer"
        self:CreateOptionTalk(TT, talkName, curTalk, layout, self._playerOption, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialoguePlayerOption_in", 767)
        end, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialogueNpc_word_in", 233)
        end)
        local idOptionTalk = curTalk.AnswerID[self._optionID]
        table.insert(optionsData, idOptionTalk)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN34DispatchDialogueType.Player then
        self:CreateTalk(TT, "UIN34DispatchDialoguePlayer", curTalk, self._textAnchor.LowerRight, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialoguePlayer_head_in", 700)
        end)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN34DispatchDialogueType.Comment then
        self:CreateTalk(TT, "UIN34DispatchDialogueComment", curTalk, self._textAnchor.LowerCenter, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN34MultiLineDialogueComment_in", 200)
        end)
        YIELD(TT, 1000)
      end
    end
    self:ScrollBottom(true, TT, 333)
    self._localDb:Viewed(self._cfgArch.ID, optionsData)
    if self._fnChatChanged ~= nil then
      self._fnChatChanged(false)
    end
  end)
end

function UIN34DispatchDialogue:ViewChat(optionsData)
  if self._fnChatChanged ~= nil then
    self._fnChatChanged(false)
  end
  if self._curTalk == nil then
    return
  end
  self:ScrollBottom(true)
  while self._curTalk ~= nil do
    local curTalk = self._curTalk
    self._curTalk = Cfg.cfg_mission_multiline_talk[self._curTalk.NextWord]
    if curTalk.TalkType == UIN34DispatchDialogueType.Npc then
      local layout = self._textAnchor.LowerLeft
      local talkName = "UIN34DispatchDialogueNpc"
      local widgetTalk = self:Spawn(talkName, string.format("%s.prefab", talkName))
      widgetTalk:SetData(curTalk)
      table.insert(self._talk, widgetTalk)
      self:TalkLayout(widgetTalk, layout, false)
    elseif curTalk.TalkType == UIN34DispatchDialogueType.Player and curTalk.AnswerID ~= nil then
      self._optionID = 1
      for k, v in pairs(curTalk.AnswerID) do
        if optionsData[v] ~= nil then
          self._optionID = k
          break
        end
      end
      local idOptionTalk = curTalk.AnswerID[self._optionID]
      local cfgOption = Cfg.cfg_mission_multiline_talk[idOptionTalk]
      self._curTalk = Cfg.cfg_mission_multiline_talk[cfgOption.NextWord]
      local layout = self._textAnchor.LowerRight
      local talkName = "UIN34DispatchDialoguePlayer"
      local widgetTalk = self:Spawn(talkName, string.format("%s.prefab", talkName))
      widgetTalk:SetData(cfgOption)
      table.insert(self._talk, widgetTalk)
      self:TalkLayout(widgetTalk, layout, false)
    elseif curTalk.TalkType == UIN34DispatchDialogueType.Player then
      local layout = self._textAnchor.LowerRight
      local talkName = "UIN34DispatchDialoguePlayer"
      local widget = self:Spawn(talkName, string.format("%s.prefab", talkName))
      widget:SetData(curTalk)
      table.insert(self._talk, widget)
      self:TalkLayout(widget, layout, false)
    elseif curTalk.TalkType == UIN34DispatchDialogueType.Comment then
      local layout = self._textAnchor.LowerCenter
      local talkName = "UIN34DispatchDialogueComment"
      local widget = self:Spawn(talkName, string.format("%s.prefab", talkName))
      widget:SetData(curTalk)
      table.insert(self._talk, widget)
      self:TalkLayout(widget, layout, false)
    end
  end
  self:ScrollBottom(true)
end

function UIN34DispatchDialogue:ReleaseAutoChat()
  local task
  if self._autoChat ~= nil then
    task = GameGlobal.TaskManager():FindTask(self._autoChat)
  end
  if task and task.state ~= TaskState.Stop then
    GameGlobal.TaskManager():KillTask(self._autoChat)
    self._autoChat = nil
  end
  for k, v in pairs(self._talk) do
    v:UnLoad()
    v:Dispose()
  end
  self._talk = {}
end

function UIN34DispatchDialogue:Spawn(luaClass, prefabName)
  local widgetGo = UIHelper.GetGameObject(prefabName)
  local uiWidgetName = luaClass
  local widget = _createInstance(uiWidgetName, self)
  widget:SetName(uiWidgetName)
  local widgetRt = widgetGo.transform
  widgetRt:SetParent(self._srContent, false)
  widgetRt.anchorMin = Vector2(0, 1)
  widgetRt.anchorMax = Vector2(0, 1)
  local view = widgetGo:GetComponent("UIView")
  widget:Load(view, self:RootUIOwner())
  return widget
end

function UIN34DispatchDialogue:UpdateContentSize(record)
  local sizeDelta = self._srContent.sizeDelta
  if record then
    if sizeDelta.y <= self._padding.viewport.y then
      self._preScrollPosition = -1
    else
      self._preScrollPosition = self._sr.verticalNormalizedPosition
    end
  end
  sizeDelta.y = math.max(self._padding.h, sizeDelta.y)
  self._srContent.sizeDelta = sizeDelta
end

function UIN34DispatchDialogue:CreateTalk(TT, talkName, cfgTalk, layout, animCb)
  local widget = self:Spawn(talkName, string.format("%s.prefab", talkName))
  widget:SetData(cfgTalk)
  table.insert(self._talk, widget)
  self:TalkLayout(widget, layout, true)
  self:ScrollBottom(false, TT, 333, widget)
  if animCb ~= nil then
    animCb(widget)
  end
  return widget
end

function UIN34DispatchDialogue:TalkLayout(widget, layout, record)
  local widgetRt = widget:GetGameObject().transform
  local widgetSizeDelta = widget:SizeDelta()
  if layout == self._textAnchor.LowerLeft then
    local anchoredPosition = Vector2.zero
    anchoredPosition.x = self._padding.l + widgetSizeDelta.x * 0.5
    anchoredPosition.y = self._padding.h - self._padding.b + self._padding.s + widgetSizeDelta.y * 0.5
    anchoredPosition.y = -anchoredPosition.y
    widgetRt.anchoredPosition = anchoredPosition
  elseif layout == self._textAnchor.LowerCenter then
    local anchoredPosition = Vector2.zero
    anchoredPosition.x = self._padding.viewport.x * 0.5
    anchoredPosition.y = self._padding.h - self._padding.b + self._padding.s + widgetSizeDelta.y * 0.5
    anchoredPosition.y = -anchoredPosition.y
    widgetRt.anchoredPosition = anchoredPosition
  elseif layout == self._textAnchor.LowerRight then
    local anchoredPosition = Vector2.zero
    anchoredPosition.x = self._padding.viewport.x - (self._padding.r + widgetSizeDelta.x * 0.5)
    anchoredPosition.y = self._padding.h - self._padding.b + self._padding.s + widgetSizeDelta.y * 0.5
    anchoredPosition.y = -anchoredPosition.y
    widgetRt.anchoredPosition = anchoredPosition
  end
  self._padding.h = self._padding.h + self._padding.s + widget:PreferredHeight()
  self:UpdateContentSize(record)
  return widget
end

function UIN34DispatchDialogue:InitPadding()
  self._padding.viewport = self._sr.transform.sizeDelta
  self._padding.h = self._padding.t + self._padding.b
  self:UpdateContentSize(false)
end

function UIN34DispatchDialogue:InitTalkAnimation()
  self._preAnimation = {}
  local language = Localization.GetCurLanguage()
  local cfgGroup = Cfg.cfg_mission_multiline_talk_anim({Language = language})
  for k, v in pairs(cfgGroup) do
    table.insert(self._preAnimation, v)
  end
  table.sort(self._preAnimation, function(a, b)
    return a.ID > b.ID
  end)
end

function UIN34DispatchDialogue:CreateCommon()
  self._npcAnim = self:Spawn("UIN34DispatchDialogueNpc", "UIN34DispatchDialogueNpcAnim.prefab")
  self._playerAnim = self:Spawn("UIN34DispatchDialoguePlayer", "UIN34DispatchDialoguePlayerAnim.prefab")
  self._playerOption = self:Spawn("UIN34DispatchDialoguePlayerOption", "UIN34DispatchDialoguePlayerOption.prefab")
  self._npcAnim:SetAnim(true)
  self._playerAnim:SetAnim(true)
  self._common = {
    self._npcAnim,
    self._playerAnim,
    self._playerOption
  }
  self._talk = {}
  for k, v in pairs(self._common) do
    v:SetFramePosition()
    v:GetGameObject():SetActive(false)
  end
end

function UIN34DispatchDialogue:RoleModule()
  return self._roleModule
end

local UIN34DispatchDialogueType = {
  Player = 1,
  Npc = 2,
  Comment = 3
}
_enum("UIN34DispatchDialogueType", UIN34DispatchDialogueType)
_class("UIN34DispatchDialogueItem", UICustomWidget)
UIN34DispatchDialogueItem = UIN34DispatchDialogueItem

function UIN34DispatchDialogueItem:Constructor(uiDialogue)
  self._nameH = 48
  self._bottom = 22
  self._frameH = 2
  self._uiDialogue = uiDialogue
end

function UIN34DispatchDialogueItem:SizeDelta()
  return self:GetGameObject().transform.sizeDelta
end

function UIN34DispatchDialogueItem:SetFramePosition()
  local preferredHeight = self:PreferredHeight()
  local anchoredPosition = self._imgFrame.transform.anchoredPosition
  anchoredPosition.y = preferredHeight - (self:SizeDelta().y + self._frameH) * 0.5
  anchoredPosition.y = -anchoredPosition.y
  self._imgFrame.transform.anchoredPosition = anchoredPosition
end

function UIN34DispatchDialogueItem:SetData(cfgTalk)
end

function UIN34DispatchDialogueItem:PlayAnimation(TT, animName, durationMs)
  self._animation:Play(animName)
  YIELD(TT, durationMs)
end

_class("UIN34DispatchDialogueNpc", UIN34DispatchDialogueItem)
UIN34DispatchDialogueNpc = UIN34DispatchDialogueNpc

function UIN34DispatchDialogueNpc:Constructor()
  self._isAnim = false
end

function UIN34DispatchDialogueNpc:OnShow(uiParams)
  self._headFrame = self:GetUIComponent("RectTransform", "headFrame")
  self._headLoader = self:GetUIComponent("RawImageLoader", "head")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgWord = self:GetUIComponent("Image", "imgWord")
  self._imgWordLayout = self:GetUIComponent("LayoutGroup", "imgWord")
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchDialogueNpc:OnHide()
end

function UIN34DispatchDialogueNpc:SetAnim(isAnim)
  self._isAnim = isAnim
end

function UIN34DispatchDialogueNpc:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local cfgNpc = Cfg.cfg_mission_multiline_npc[self._cfgTalk.Npc]
  if cfgNpc ~= nil and cfgNpc.Icon ~= nil then
    self._headLoader:LoadImage(cfgNpc.Icon)
    self._txtName:SetText(StringTable.Get(cfgNpc.Name))
  end
  if not self._isAnim then
    local txtWord = StringTable.Get(self._cfgTalk.ChatWord)
    self._txtWord:SetText(txtWord)
    local padding = self._imgWordLayout.padding
    local sizeDelta = self._imgWord.transform.sizeDelta
    sizeDelta.x = self._txtWord.preferredWidth
    sizeDelta.x = math.min(sizeDelta.x, self._txtWord.transform.sizeDelta.x)
    sizeDelta.x = sizeDelta.x + padding.left + padding.right
    self._imgWord.transform.sizeDelta = sizeDelta
  end
  self:SetFramePosition()
end

function UIN34DispatchDialogueNpc:PreferredHeight()
  local padding = self._imgWordLayout.padding
  local wordHeight = self._nameH + padding.top + padding.bottom + self._txtWord.preferredHeight
  return math.max(wordHeight, self._headFrame.transform.sizeDelta.y) + self._bottom + self._frameH
end

_class("UIN34DispatchDialoguePlayer", UIN34DispatchDialogueItem)
UIN34DispatchDialoguePlayer = UIN34DispatchDialoguePlayer

function UIN34DispatchDialoguePlayer:Constructor()
  self._isAnim = false
end

function UIN34DispatchDialoguePlayer:OnShow(uiParams)
  self._headFrame = self:GetUIComponent("RectTransform", "headFrame")
  self._headLoader = self:GetUIComponent("RawImageLoader", "head")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgWord = self:GetUIComponent("Image", "imgWord")
  self._imgWordLayout = self:GetUIComponent("LayoutGroup", "imgWord")
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchDialoguePlayer:OnHide()
end

function UIN34DispatchDialoguePlayer:SetAnim(isAnim)
  self._isAnim = isAnim
end

function UIN34DispatchDialoguePlayer:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local cfgNpc = Cfg.cfg_mission_multiline_npc[self._cfgTalk.Npc]
  if cfgNpc ~= nil and cfgNpc.Icon ~= nil then
    self._headLoader:LoadImage(cfgNpc.Icon)
    self._txtName:SetText(StringTable.Get(cfgNpc.Name))
  end
  if not self._isAnim then
    local txtWord = StringTable.Get(self._cfgTalk.ChatWord)
    self._txtWord:SetText(txtWord)
    local padding = self._imgWordLayout.padding
    local sizeDelta = self._imgWord.transform.sizeDelta
    sizeDelta.x = self._txtWord.preferredWidth
    sizeDelta.x = math.min(sizeDelta.x, self._txtWord.transform.sizeDelta.x)
    sizeDelta.x = sizeDelta.x + padding.left + padding.right
    self._imgWord.transform.sizeDelta = sizeDelta
  end
  self:SetFramePosition()
end

function UIN34DispatchDialoguePlayer:PreferredHeight()
  local padding = self._imgWordLayout.padding
  local wordHeight = self._nameH + padding.top + padding.bottom + self._txtWord.preferredHeight
  return math.max(wordHeight, self._headFrame.transform.sizeDelta.y) + self._bottom + self._frameH
end

_class("UIN34DispatchDialoguePlayerOption", UIN34DispatchDialogueItem)
UIN34DispatchDialoguePlayerOption = UIN34DispatchDialoguePlayerOption

function UIN34DispatchDialoguePlayerOption:Constructor()
end

function UIN34DispatchDialoguePlayerOption:OnShow(uiParams)
  self._headFrame = self:GetUIComponent("RectTransform", "headFrame")
  self._headLoader = self:GetUIComponent("RawImageLoader", "head")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgWord = self:GetUIComponent("Image", "imgWord")
  self._imgWordLayout = self:GetUIComponent("HorizontalOrVerticalLayoutGroup", "imgWord")
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._options = {
    self:GetUIComponent("Animation", "option1"),
    self:GetUIComponent("Animation", "option2"),
    self:GetUIComponent("Animation", "option3")
  }
  self._optionsText = {
    self:GetChildComponent(self._options[1], "UILocalizationText", "optionBtn/txtOption"),
    self:GetChildComponent(self._options[2], "UILocalizationText", "optionBtn/txtOption"),
    self:GetChildComponent(self._options[3], "UILocalizationText", "optionBtn/txtOption")
  }
end

function UIN34DispatchDialoguePlayerOption:OnHide()
end

function UIN34DispatchDialoguePlayerOption:PreferredHeight()
  local optionCount = 0
  for k, v in pairs(self._options) do
    if v.gameObject.activeSelf then
      optionCount = optionCount + 1
    end
  end
  local optionButtonHeight = 69
  local padding = self._imgWordLayout.padding
  local spacing = self._imgWordLayout.spacing * (optionCount - 1)
  local optionH = optionButtonHeight * optionCount
  local wordHeight = self._nameH + padding.top + padding.bottom + spacing + optionH
  return math.max(wordHeight, self._headFrame.transform.sizeDelta.y) + self._bottom + self._frameH
end

function UIN34DispatchDialoguePlayerOption:Option1OnClick(go)
  self:OptionAnimation(1, go)
end

function UIN34DispatchDialoguePlayerOption:Option2OnClick(go)
  self:OptionAnimation(2, go)
end

function UIN34DispatchDialoguePlayerOption:Option3OnClick(go)
  self:OptionAnimation(3, go)
end

function UIN34DispatchDialoguePlayerOption:OptionAnimation(id, go)
  local lockName = "UIN34DispatchDialoguePlayerOption:OptionAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._options[id]:Play("uieff_UIN34MultiLineDialoguePlayerOption_option")
    YIELD(TT, 300)
    self._animation:Play("uieff_UIN34MultiLineDialoguePlayerOption_out")
    YIELD(TT, 300)
    self:UnLock(lockName)
    self._uiDialogue:OptionOnClick(id, go)
  end)
end

function UIN34DispatchDialoguePlayerOption:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local cfgNpc = Cfg.cfg_mission_multiline_npc[self._cfgTalk.Npc]
  if cfgNpc ~= nil and cfgNpc.Icon ~= nil then
    self._headLoader:LoadImage(cfgNpc.Icon)
    self._txtName:SetText(StringTable.Get(cfgNpc.Name))
  end
  local count = #self._cfgTalk.AnswerID
  for k, v in pairs(self._options) do
    v.gameObject:SetActive(k <= count)
  end
  for k, v in pairs(self._cfgTalk.AnswerID) do
    local cfgTalk = Cfg.cfg_mission_multiline_talk[v]
    local optionText = StringTable.Get(cfgTalk.OptionWord)
    self._optionsText[k]:SetText(optionText)
  end
end

_class("UIN34DispatchDialogueComment", UIN34DispatchDialogueItem)
UIN34DispatchDialogueComment = UIN34DispatchDialogueComment

function UIN34DispatchDialogueComment:Constructor()
  self._bottom = 14
end

function UIN34DispatchDialogueComment:OnShow(uiParams)
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._txtWidth = self._txtWord.rectTransform.sizeDelta.x
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchDialogueComment:OnHide()
end

function UIN34DispatchDialogueComment:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local txtWord = StringTable.Get(self._cfgTalk.ChatWord)
  self._txtWord:SetText(txtWord)
  local wordRt = self._txtWord.rectTransform
  local txtWidth = wordRt.sizeDelta.x
  local preferredWidth = self._txtWord.preferredWidth
  if txtWidth > preferredWidth then
    local anchoredPosition = wordRt.anchoredPosition
    anchoredPosition.x = (txtWidth - preferredWidth) * 0.5
    wordRt.anchoredPosition = anchoredPosition
  end
  self:SetFramePosition()
end

function UIN34DispatchDialogueComment:PreferredHeight()
  local preferredHeight = self._txtWord.preferredHeight
  return preferredHeight + self._bottom + self._frameH
end
