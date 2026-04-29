_class("UIN32MultiLineDialogue", UIController)
UIN32MultiLineDialogue = UIN32MultiLineDialogue

function UIN32MultiLineDialogue:Constructor()
  self._padding = {
    l = 10,
    r = 10,
    t = 10,
    b = 120,
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

function UIN32MultiLineDialogue:LoadDataOnEnter(TT, res, uiParams)
  self._missionId = uiParams[1]
  self._endCB = uiParams[2]
  self._cfgChat = Cfg.cfg_mission_multiline_chat[self._missionId]
  self._curTalk = Cfg.cfg_mission_multiline_talk[self._cfgChat.StartTalk]
  self._roleModule = self:GetModule(RoleModule)
end

function UIN32MultiLineDialogue:OnShow(uiParams)
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._bgImageLoader = self:GetUIComponent("RawImageLoader", "bgImage")
  self._btnSkip = self:GetUIComponent("Button", "btnSkip")
  self._btnCancel = self:GetUIComponent("Button", "btnCancel")
  self._sr = self:GetUIComponent("ScrollRect", "Scroll View")
  self._preScrollPosition = -1
  self._srContent = self._sr.content
  self._txtPlace = self:GetUIComponent("UILocalizationText", "txtPlace")
  self._txtPlaceDesc = self:GetUIComponent("UILocalizationText", "txtPlaceDesc")
  self._txtChatDesc = self:GetUIComponent("UILocalizationText", "txtChatDesc")
  self._txtChatTitle = self:GetUIComponent("UILocalizationText", "txtChatTitle")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._btnCancelAnimation = self:GetUIComponent("Animation", "btnCancelAnimation")
  self:InitPadding()
  self:InitTalkAnimation()
  self:CreateCommon()
  self:Flush()
  self:AutoChat()
  self:InAnimation()
end

function UIN32MultiLineDialogue:OnHide()
  self:ReleaseAutoChat()
  for k, v in pairs(self._common) do
    v:UnLoad()
    v:Dispose()
  end
  if self._endCB then
    local endCB = self._endCB
    endCB(self._missionId)
  end
end

function UIN32MultiLineDialogue:BtnSkipOnClick(go)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_n32_multiline_dialogue_skip_popup"), function(param)
    self:OutAnimation()
  end, nil, function(param)
    self._pauseDialogue = false
  end, nil)
  self._pauseDialogue = true
end

function UIN32MultiLineDialogue:BtnCancelOnClick(go)
  self:OutAnimation()
end

function UIN32MultiLineDialogue:CreateAnimTalk(TT, talkName, cfgTalk, layout, widgetAnim, animCb, widgetCb)
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

function UIN32MultiLineDialogue:CreateOptionTalk(TT, talkName, cfgTalk, layout, widgetAnim, animCb, widgetCb)
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
    local lockName = "UIN32MultiLineDialogue:TalkOptionTT -- inAnimation"
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

function UIN32MultiLineDialogue:OptionOnClick(id, go)
  self._optionID = id
end

function UIN32MultiLineDialogue:ScrollBottom(force, TT, blendMs, widget)
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

function UIN32MultiLineDialogue:Flush()
  self._bgImageLoader:LoadImage(self._cfgChat.Background)
  self._txtPlace:SetText(StringTable.Get(self._cfgChat.Place))
  self._txtPlaceDesc:SetText(StringTable.Get(self._cfgChat.PlaceDescribe))
  self._txtChatDesc:SetText(StringTable.Get(self._cfgChat.ChatDescribe))
  self._txtChatTitle:SetText(StringTable.Get(self._cfgChat.ChatTitle))
end

function UIN32MultiLineDialogue:AutoChat()
  if self._curTalk == nil then
    return
  end
  self._btnSkip.gameObject:SetActive(true)
  self._btnCancel.gameObject:SetActive(false)
  self._autoChat = self:StartTask(function(TT)
    YIELD(TT, 1000)
    self:ScrollBottom(true)
    while self._curTalk ~= nil do
      local curTalk = self._curTalk
      self._curTalk = Cfg.cfg_mission_multiline_talk[self._curTalk.NextWord]
      while self._pauseDialogue do
        YIELD(TT)
      end
      if curTalk.TalkType == UIN32MultiLineDialogueType.Npc then
        local layout = self._textAnchor.LowerLeft
        local talkName = "UIN32MultiLineDialogueNpc"
        self:CreateAnimTalk(TT, talkName, curTalk, layout, self._npcAnim, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialogueNpcAnim_in", 333)
        end, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialogueNpc_word_in", 233)
        end)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN32MultiLineDialogueType.Player and curTalk.AnswerID ~= nil then
        local layout = self._textAnchor.LowerRight
        local talkName = "UIN32MultiLineDialoguePlayer"
        self:CreateOptionTalk(TT, talkName, curTalk, layout, self._playerOption, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialoguePlayerOption_in", 767)
        end, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialogueNpc_word_in", 233)
        end)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN32MultiLineDialogueType.Player then
        self:CreateTalk(TT, "UIN32MultiLineDialoguePlayer", curTalk, self._textAnchor.LowerRight, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialoguePlayer_head_in", 700)
        end)
        YIELD(TT, 1000)
      elseif curTalk.TalkType == UIN32MultiLineDialogueType.Comment then
        self:CreateTalk(TT, "UIN32MultiLineDialogueComment", curTalk, self._textAnchor.LowerCenter, function(widget)
          widget:PlayAnimation(TT, "uieff_UIN32MultiLineDialogueComment_in", 200)
        end)
        YIELD(TT, 1000)
      end
    end
    self:ScrollBottom(true, TT, 333)
    self._btnSkip.gameObject:SetActive(false)
    self._btnCancel.gameObject:SetActive(true)
    self._btnCancelAnimation:Play("uieff_UIN32MultiLineDialogue_Btn")
    local lockName = "UIN32MultiLineDialogue:AutoChat -- btnCancelAnimation"
    self:Lock(lockName)
    YIELD(TT, 333)
    self:UnLock(lockName)
  end)
end

function UIN32MultiLineDialogue:ReleaseAutoChat()
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
end

function UIN32MultiLineDialogue:Spawn(luaClass, prefabName)
  local widgetGo = UIHelper.GetGameObject(prefabName)
  local uiWidgetName = luaClass
  local widget = _createInstance(uiWidgetName)
  widget:SetName(uiWidgetName)
  local widgetRt = widgetGo.transform
  widgetRt:SetParent(self._srContent, false)
  widgetRt.anchorMin = Vector2(0, 1)
  widgetRt.anchorMax = Vector2(0, 1)
  local view = widgetGo:GetComponent("UIView")
  widget:Load(view, self)
  return widget
end

function UIN32MultiLineDialogue:UpdateContentSize(record)
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

function UIN32MultiLineDialogue:CreateTalk(TT, talkName, cfgTalk, layout, animCb)
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

function UIN32MultiLineDialogue:TalkLayout(widget, layout, record)
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

function UIN32MultiLineDialogue:InitPadding()
  self._padding.viewport = self._sr.transform.sizeDelta
  self._padding.h = self._padding.t + self._padding.b
  self:UpdateContentSize(false)
end

function UIN32MultiLineDialogue:InitTalkAnimation()
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

function UIN32MultiLineDialogue:CreateCommon()
  self._npcAnim = self:Spawn("UIN32MultiLineDialogueNpc", "UIN32MultiLineDialogueNpcAnim.prefab")
  self._playerAnim = self:Spawn("UIN32MultiLineDialoguePlayer", "UIN32MultiLineDialoguePlayerAnim.prefab")
  self._playerOption = self:Spawn("UIN32MultiLineDialoguePlayerOption", "UIN32MultiLineDialoguePlayerOption.prefab")
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

function UIN32MultiLineDialogue:RoleModule()
  return self._roleModule
end

function UIN32MultiLineDialogue:InAnimation()
  local lockName = "UIN32MultiLineDialogue:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN32MultiLineDialogue_in")
    YIELD(TT, 433)
    self:UnLock(lockName)
  end)
end

function UIN32MultiLineDialogue:OutAnimation(cbFinish)
  local lockName = "UIN32MultiLineDialogue:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN32MultiLineDialogue_out")
    YIELD(TT, 233)
    self:CloseDialog()
    self:UnLock(lockName)
    if cbFinish then
      cbFinish()
    end
    self:CallUIMethod("UIN32MultiLineMapController", "CheckComponentTime")
  end)
end

local UIN32MultiLineDialogueType = {
  Player = 1,
  Npc = 2,
  Comment = 3
}
_enum("UIN32MultiLineDialogueType", UIN32MultiLineDialogueType)
_class("UIN32MultiLineDialogueItem", UICustomWidget)
UIN32MultiLineDialogueItem = UIN32MultiLineDialogueItem

function UIN32MultiLineDialogueItem:Constructor()
  self._nameH = 55.5
  self._bottom = 45
  self._frameH = 2
end

function UIN32MultiLineDialogueItem:SizeDelta()
  return self:GetGameObject().transform.sizeDelta
end

function UIN32MultiLineDialogueItem:SetFramePosition()
  local preferredHeight = self:PreferredHeight()
  local anchoredPosition = self._imgFrame.transform.anchoredPosition
  anchoredPosition.y = preferredHeight - (self:SizeDelta().y + self._frameH) * 0.5
  anchoredPosition.y = -anchoredPosition.y
  self._imgFrame.transform.anchoredPosition = anchoredPosition
end

function UIN32MultiLineDialogueItem:SetData(cfgTalk)
end

function UIN32MultiLineDialogueItem:PlayAnimation(TT, animName, durationMs)
  self._animation:Play(animName)
  YIELD(TT, durationMs)
end

_class("UIN32MultiLineDialogueNpc", UIN32MultiLineDialogueItem)
UIN32MultiLineDialogueNpc = UIN32MultiLineDialogueNpc

function UIN32MultiLineDialogueNpc:Constructor()
  self._isAnim = false
end

function UIN32MultiLineDialogueNpc:OnShow(uiParams)
  self._headFrame = self:GetUIComponent("RectTransform", "headFrame")
  self._headLoader = self:GetUIComponent("RawImageLoader", "head")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgWord = self:GetUIComponent("Image", "imgWord")
  self._imgWordLayout = self:GetUIComponent("LayoutGroup", "imgWord")
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN32MultiLineDialogueNpc:OnHide()
end

function UIN32MultiLineDialogueNpc:SetAnim(isAnim)
  self._isAnim = isAnim
end

function UIN32MultiLineDialogueNpc:SetData(cfgTalk)
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

function UIN32MultiLineDialogueNpc:PreferredHeight()
  local padding = self._imgWordLayout.padding
  local wordHeight = self._nameH + padding.top + padding.bottom + self._txtWord.preferredHeight
  return math.max(wordHeight, self._headFrame.transform.sizeDelta.y) + self._bottom + self._frameH
end

_class("UIN32MultiLineDialoguePlayer", UIN32MultiLineDialogueItem)
UIN32MultiLineDialoguePlayer = UIN32MultiLineDialoguePlayer

function UIN32MultiLineDialoguePlayer:Constructor()
  self._isAnim = false
end

function UIN32MultiLineDialoguePlayer:OnShow(uiParams)
  self._headFrame = self:GetUIComponent("RectTransform", "headFrame")
  self._headLoader = self:GetUIComponent("RawImageLoader", "head")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgWord = self:GetUIComponent("Image", "imgWord")
  self._imgWordLayout = self:GetUIComponent("LayoutGroup", "imgWord")
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN32MultiLineDialoguePlayer:OnHide()
end

function UIN32MultiLineDialoguePlayer:SetAnim(isAnim)
  self._isAnim = isAnim
end

function UIN32MultiLineDialoguePlayer:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local cfgNpc = Cfg.cfg_mission_multiline_npc[self._cfgTalk.Npc]
  if cfgNpc ~= nil and cfgNpc.Icon ~= nil then
    self._headLoader:LoadImage(cfgNpc.Icon)
    self._txtName:SetText(StringTable.Get(cfgNpc.Name))
    self._txtName:SetText(self:RootUIOwner():RoleModule():GetName())
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

function UIN32MultiLineDialoguePlayer:PreferredHeight()
  local padding = self._imgWordLayout.padding
  local wordHeight = self._nameH + padding.top + padding.bottom + self._txtWord.preferredHeight
  return math.max(wordHeight, self._headFrame.transform.sizeDelta.y) + self._bottom + self._frameH
end

_class("UIN32MultiLineDialoguePlayerOption", UIN32MultiLineDialogueItem)
UIN32MultiLineDialoguePlayerOption = UIN32MultiLineDialoguePlayerOption

function UIN32MultiLineDialoguePlayerOption:Constructor()
end

function UIN32MultiLineDialoguePlayerOption:OnShow(uiParams)
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
    UIN29DetectiveLogin:GetChildComponent(self._options[1], "UILocalizationText", "optionBtn/txtOption"),
    UIN29DetectiveLogin:GetChildComponent(self._options[2], "UILocalizationText", "optionBtn/txtOption"),
    UIN29DetectiveLogin:GetChildComponent(self._options[3], "UILocalizationText", "optionBtn/txtOption")
  }
end

function UIN32MultiLineDialoguePlayerOption:OnHide()
end

function UIN32MultiLineDialoguePlayerOption:PreferredHeight()
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

function UIN32MultiLineDialoguePlayerOption:Option1OnClick(go)
  self:OptionAnimation(1, go)
end

function UIN32MultiLineDialoguePlayerOption:Option2OnClick(go)
  self:OptionAnimation(2, go)
end

function UIN32MultiLineDialoguePlayerOption:Option3OnClick(go)
  self:OptionAnimation(3, go)
end

function UIN32MultiLineDialoguePlayerOption:OptionAnimation(id, go)
  local lockName = "UIN32MultiLineDialoguePlayerOption:OptionAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._options[id]:Play("uieff_UIN32MultiLineDialoguePlayerOption_option")
    YIELD(TT, 300)
    self._animation:Play("uieff_UIN32MultiLineDialoguePlayerOption_out")
    YIELD(TT, 300)
    self:UnLock(lockName)
    self:RootUIOwner():OptionOnClick(id, go)
  end)
end

function UIN32MultiLineDialoguePlayerOption:SetData(cfgTalk)
  self._cfgTalk = cfgTalk
  local cfgNpc = Cfg.cfg_mission_multiline_npc[self._cfgTalk.Npc]
  if cfgNpc ~= nil and cfgNpc.Icon ~= nil then
    self._headLoader:LoadImage(cfgNpc.Icon)
    self._txtName:SetText(StringTable.Get(cfgNpc.Name))
    self._txtName:SetText(self:RootUIOwner():RoleModule():GetName())
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

_class("UIN32MultiLineDialogueComment", UIN32MultiLineDialogueItem)
UIN32MultiLineDialogueComment = UIN32MultiLineDialogueComment

function UIN32MultiLineDialogueComment:Constructor()
  self._bottom = 14
end

function UIN32MultiLineDialogueComment:OnShow(uiParams)
  self._txtWord = self:GetUIComponent("UILocalizationText", "txtWord")
  self._txtWidth = self._txtWord.rectTransform.sizeDelta.x
  self._imgFrame = self:GetUIComponent("Image", "imgFrame")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN32MultiLineDialogueComment:OnHide()
end

function UIN32MultiLineDialogueComment:SetData(cfgTalk)
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

function UIN32MultiLineDialogueComment:SizeDelta()
  local preferredHeight = self._txtWord.preferredHeight
  local sizeDelta = self:GetGameObject().transform.sizeDelta
  sizeDelta.y = preferredHeight
  return sizeDelta
end

function UIN32MultiLineDialogueComment:PreferredHeight()
  local preferredHeight = self._txtWord.preferredHeight
  return preferredHeight + self._bottom + self._frameH
end
