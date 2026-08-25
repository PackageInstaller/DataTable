local AwakerChatPanel, Super = System.NewClass("AwakerChatPanel", UIBasePanel)
AwakerChatPanel.uiResCls = UI_Address_Panel_DialogResource
local UIAnimationController = CS.Z1Client.UIAnimationController
local TMP_Text = CS.TMPro.TMP_Text
local Vector2 = CS.UnityEngine.Vector2
local Text_Bg_DeltaX = 40
local Text_Bg_DeltaY = 26
local Player_Text_DeltaX = 48
local TextLineSpaceOffset = 2
local bubbleStrs = {
  " . ",
  " . . ",
  " . . .  "
}
local ContentGoCfg = {
  [cd.AwakerChatType.AwakerText] = "UI_Address_Bubble_Awaker",
  [cd.AwakerChatType.PlayerText] = "UI_Address_Bubble_My",
  [cd.AwakerChatType.PlayerEmoj] = "UI_Address_Emoji_My",
  [cd.AwakerChatType.AwakerEmoj] = "UI_Address_Emoji_Awaker",
  [cd.AwakerChatType.WaitBubble] = "UI_Address_Bubble_Awaker"
}
local ContentFunc = {
  [cd.AwakerChatType.AwakerText] = "SetAwakerText",
  [cd.AwakerChatType.PlayerText] = "SetPlayerText",
  [cd.AwakerChatType.PlayerEmoj] = "SetPlayerEmoj",
  [cd.AwakerChatType.AwakerEmoj] = "SetAwakerEmoj",
  [cd.AwakerChatType.WaitBubble] = "SetWaitBubble"
}

function AwakerChatPanel:ctor(chatId)
  Super.ctor(self)
  self.chatId = chatId
  self.roleId = AwakerChatDataUtils.GetChatRoleId(chatId)
  self.lineIndex = 0
  self.cellSizeList = {}
  self.curTime = 0
  self.options = Vue.ref({})
  self.isComplete = false
  self.showEndAnim = false
  self.bubbleEndTimes = {}
  self.bubbleTimers = {}
end

function AwakerChatPanel:OnBind(binder)
  self.binder = binder
  self.longSize = self.ui.Anchor_FullScroll.transform.sizeDelta
  self.shortSize = self.ui.Anchor_ShortScroll.transform.sizeDelta
  self.binder:LoadAllLangFont(self.ui.Text_CalHeight)
  self:SetAwakerInfo()
  self:CreateContentTableView()
  self:RecoverChat()
  binder:BindComponent(AwakerChatOptionComp(self.ui.uiNode, self.chatId, self.options, System.fn(self, self.OnOption)))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  local updateTime = 0.1
  binder:BindTimer(updateTime, -1, function()
    self:Update(updateTime)
  end)
  self:SetBothPortraits()
end

function AwakerChatPanel:Update(deltaTime)
  self.curTime = self.curTime + deltaTime
  if self.nextChatTime and self.curTime < self.nextChatTime then
    return
  end
  if self.isOptioning then
    return
  end
  if self.isComplete then
    return
  end
  local lineIndex = AwakerChatDataUtils.GetNextLineIndex(self.chatId, self.lineIndex)
  if not lineIndex then
    self:CompleteChat()
    return
  end
  if type(lineIndex) == "number" then
    self:PlayNextChat(lineIndex)
  elseif type(lineIndex) == "table" then
    self:ShowOptions(lineIndex)
  end
end

function AwakerChatPanel:ReloadContent()
  self:ClearBubbleTimers()
  self.contentTableView:ReloadData()
end

function AwakerChatPanel:RecoverChat()
  self:SetIsOptioning(false)
  self.contentList = AwakerChatDataUtils.GetSavedChatList(self.chatId)
  self.lineIndex = self.contentList[#self.contentList] or 0
  self:ReloadContent()
end

function AwakerChatPanel:PlayNextChat(lineIndex)
  if table.contains(self.contentList, lineIndex) then
    return
  end
  self.showEndAnim = true
  self:SetIsOptioning(false)
  self.lineIndex = lineIndex
  local contentData = AwakerChatDataUtils.GetLineData(self.chatId, lineIndex)
  self.nextChatTime = self.curTime + (contentData.MessageIntervals or 0) + cd.AwakerChatInterval
  local waitingBubbleInterval = 0
  local talkRoleCfg = contentData.TalkRole or {}
  local roleId = talkRoleCfg[1]
  local expression = talkRoleCfg[2] or talkRoleCfg[3]
  if roleId == cd.AvgDialogPlayerId then
    self.playerAwaker.value.expression = expression
  else
    self.chatAwaker.value.expression = expression
    if contentData.MessageIntervals then
      self.bubbleEndTimes[lineIndex] = self.curTime + contentData.MessageIntervals
      waitingBubbleInterval = contentData.MessageIntervals
    end
  end
  self:PlayAudio(lineIndex, waitingBubbleInterval * 1000)
  table.insert(self.contentList, lineIndex)
  self:ReloadContent()
  self:MoveChatToBottom()
  AwakerChatDataUtils.OnSendMessage(self.chatId, table.clone(self.contentList))
end

function AwakerChatPanel:PlayAudio(lineIndex, commonDelay)
  local contentData = AwakerChatDataUtils.GetLineData(self.chatId, lineIndex)
  if contentData.Audio then
    self:PlayAudioList(contentData.Audio, commonDelay)
  end
end

function AwakerChatPanel:PlayAudioList(audioList, commonDelay)
  if not audioList then
    return
  end
  for i = 1, #audioList do
    local audioEvent = audioList[i]
    local checkIsDelay = audioList[i + 1]
    if not tonumber(audioEvent) then
      if tonumber(checkIsDelay) then
        AudioManager.Instance:PostSoundEvent(audioEvent, nil, tonumber(checkIsDelay) + (commonDelay or 0))
      else
        AudioManager.Instance:PostSoundEvent(audioEvent, nil, commonDelay)
      end
    end
  end
end

function AwakerChatPanel:CompleteChat()
  self.isComplete = true
  self.ui.Image_End:SetActive(true)
  self.contentTableView.contentSizeAdjustment = Vector2(0, 180)
  self:ReloadContent()
  if self.showEndAnim then
    self:MoveChatToBottom()
    local endAnimController = self.ui.Image_End:GetComponent(typeof(UIAnimationController))
    endAnimController:PlayState("UI_Address_Panel_Dialog_End_In")
    self.binder:BindTimer(2, 0, nil, function()
      AwakerChatDataUtils.OnDialogFinish(self.chatId)
    end)
  else
    local dialog = AwakerChatDataUtils.GetDialog(self.chatId)
    if dialog and not dialog.isCompleted then
      AwakerChatDataUtils.OnDialogFinish(self.chatId)
    end
  end
end

function AwakerChatPanel:MoveChatToBottom()
  if not self.contentList or 0 == #self.contentList then
    return
  end
  if not self.contentTableView.isReady then
    return
  end
  local height = self.isOptioning and self.shortSize.y or self.longSize.y
  local bottomCellY = self.contentTableView:GetOffsetByIndex(#self.contentList)
  if bottomCellY and height < bottomCellY then
    local offset = bottomCellY - height
    if self.showEndAnim and self.isComplete then
      offset = bottomCellY + 180 - height
    end
    self.contentTableView:SetOffset(offset, true)
  end
end

function AwakerChatPanel:ShowOptions(optionList)
  self:SetIsOptioning(true)
  self.options.value = optionList
  self.ui.Group_Option:SetActive(true)
  local optionAnimController = self.ui.Content:GetComponent(typeof(UIAnimationController))
  optionAnimController:PlayState("UI_Address_Panel_Dialog_Option_In")
end

function AwakerChatPanel:OnOption(lineIndex)
  if table.contains(self.contentList, lineIndex) then
    return
  end
  local optionAnimController = self.ui.Content:GetComponent(typeof(UIAnimationController))
  optionAnimController:PlayState("UI_Address_Panel_Dialog_Option_Out")
  self.binder:BindTimer(0.3, 0, nil, function()
    self.ui.Group_Option:SetActive(false)
    self:PlayNextChat(lineIndex)
  end)
end

function AwakerChatPanel:SetIsOptioning(isOptioning)
  if self.isOptioning == isOptioning then
    return
  end
  self.isOptioning = isOptioning
  self:SetChatViewLong(not isOptioning)
end

function AwakerChatPanel:SetChatViewLong(isLong)
  self.ui.ScrollView_Dialog.transform.sizeDelta = isLong and self.longSize or self.shortSize
  self:MoveChatToBottom()
end

function AwakerChatPanel:SetAwakerInfo()
  self.ui.SloganView:SetActive(false)
  print("AwakerChatDataUtils.GetChatName(self.roleId)", AwakerChatDataUtils.GetChatName(self.roleId))
  self.binder:SetText(self.ui.Text_AwakerName, AwakerChatDataUtils.GetChatName(self.roleId))
  self.binder:SetText(self.ui.Text_Slogan, AwakerChatDataUtils.GetChatSign(self.roleId))
  self.binder:BindTimer(0.1, 0, nil, function()
    local tmp = self.ui.Text_Slogan:GetComponent(typeof(TMP_Text))
    local lineCount = tmp.textInfo.lineCount
    if lineCount > 1 then
      self.ui.Text_Slogan:SetActive(false)
      self.ui.SloganView:SetActive(true)
      self.binder:SetText(self.ui.Text_View_Slogan, AwakerChatDataUtils.GetChatSign(self.roleId))
      AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_View_Slogan)
    else
      self.ui.Text_Slogan:SetActive(true)
    end
  end)
end

function AwakerChatPanel:SetBothPortraits()
  self.chatAwaker = Vue.ref({
    roleId = self.roleId,
    expression = nil
  })
  self.binder:BindComponent(AvgNormalRoleItem(self.ui.Role_Awaker, self.chatAwaker))
  self.ui.Role_Awaker:SetActive(true)
  self.playerAwaker = Vue.ref({
    roleId = cd.AvgDialogPlayerId,
    expression = nil
  })
  self.binder:BindComponent(AvgNormalRoleItem(self.ui.Role_My, self.playerAwaker))
  self.ui.Role_My:SetActive(true)
end

function AwakerChatPanel:CreateContentTableView()
  self.contentTableView = self:CreateTableview(self.ui.ScrollView_Dialog, function()
    return #(self.contentList or {})
  end, function(view, idx)
    local lineIndex = self.contentList[idx]
    local cell = self:GetContentCell(view, idx)
    local contentData = AwakerChatDataUtils.GetLineData(self.chatId, lineIndex)
    self:SetContent(cell.gameObject, idx, contentData)
    return cell
  end, function(_, idx)
    do return self.GetCellSize, self end
    return self.GetCellSize, self, idx
  end)
end

function AwakerChatPanel:GetCellSize(idx)
  if self.cellSizeList[idx] then
    do return table.unpack end
    return table.unpack, self.cellSizeList[idx], nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if not self.calTextComp then
    self.calTextComp = self.binder:GetTextComp(self.ui.Text_CalHeight)
  end
  self._textCalWidth = self._textCalWidth or self.ui.Text_CalHeight.transform.sizeDelta.x
  local lineIndex = self.contentList[idx]
  local contentData = AwakerChatDataUtils.GetLineData(self.chatId, lineIndex)
  local chatType = self:GetAwakerChatType(idx)
  if chatType == cd.AwakerChatType.AwakerEmoj or chatType == cd.AwakerChatType.PlayerEmoj then
    local sizeDelta = self.ui.UI_Address_Emoji_My.transform.sizeDelta
    self.cellSizeList[idx] = {
      sizeDelta.x,
      sizeDelta.y
    }
  else
    local content = ""
    local specifyWidth = 0
    if chatType == cd.AwakerChatType.WaitBubble then
      content = bubbleStrs[1]
      specifyWidth = 100
    else
      content = AwakerChatDataUtils.TranslateContent(contentData.Content)
    end
    self.binder:SetText(self.ui.Text_CalHeight, content)
    local bgDeltaX, bgDeltaY = Text_Bg_DeltaX, Text_Bg_DeltaY
    local textRealW = math.min(self._textCalWidth, self.calTextComp.preferredWidth)
    local textRealH = StrUtils.SetPreferredHeight(self.ui.Text_CalHeight)
    local textWidth = specifyWidth > 0 and specifyWidth or textRealW + bgDeltaX
    if chatType == cd.AwakerChatType.WaitBubble then
      return textWidth, textRealH + bgDeltaY
    end
    self.cellSizeList[idx] = {
      textWidth,
      textRealH + bgDeltaY
    }
  end
  do return table.unpack end
  return table.unpack, self.cellSizeList[idx], Text_Bg_DeltaX, Text_Bg_DeltaY, math.min(self._textCalWidth, self.calTextComp.preferredWidth), StrUtils.SetPreferredHeight(self.ui.Text_CalHeight), textRealW + bgDeltaX, self.cellSizeList, {
    textWidth,
    textRealH + bgDeltaY
  }, textWidth, textRealH + bgDeltaY
end

function AwakerChatPanel:GetAwakerChatType(idx)
  if self:GetBubbleDura(idx) then
    return cd.AwakerChatType.WaitBubble
  end
  local lineIndex = self.contentList[idx]
  local contentData = AwakerChatDataUtils.GetLineData(self.chatId, lineIndex)
  local roleId = table.unpack(contentData.TalkRole or {})
  local isEmoj = contentData.Emoji ~= nil
  if roleId == cd.AvgDialogPlayerId then
    return isEmoj and cd.AwakerChatType.PlayerEmoj or cd.AwakerChatType.PlayerText
  end
  return isEmoj and cd.AwakerChatType.AwakerEmoj or cd.AwakerChatType.AwakerText
end

function AwakerChatPanel:GetContentCell(view, idx)
  local chatType = self:GetAwakerChatType(idx)
  local cell = view:DequeueCellByTag(chatType)
  if not cell then
    cell = view:AddChild(self.ui[ContentGoCfg[chatType]])
    cell.tag = chatType
  end
  return cell
end

function AwakerChatPanel:GetBubbleDura(idx)
  local lineIndex = self.contentList[idx]
  local bubbleTime = self.bubbleEndTimes[lineIndex] or 0
  if bubbleTime > self.curTime then
    return bubbleTime - self.curTime
  end
end

function AwakerChatPanel:SetContent(gameObject, idx, contentData)
  local chatType = self:GetAwakerChatType(idx)
  local funcName = ContentFunc[chatType]
  local func = self[funcName]
  if not func then
    return
  end
  func(self, gameObject, idx, contentData)
end

function AwakerChatPanel:ClearBubbleTimers()
  for i = #self.bubbleTimers, 1, -1 do
    local timer = self.bubbleTimers[i]
    self.binder:StopTimer(timer)
    table.remove(self.bubbleTimers, i)
  end
end

function AwakerChatPanel:SetWaitBubble(go, idx)
  self:ClearBubbleTimers()
  local res = UIBaseResource(go)
  local w, h = table.unpack(self.cellSizeList[idx] or {})
  local bubbleStrIndex = 1
  self.binder:SetText(res.Text_Content, bubbleStrs[bubbleStrIndex])
  if w and h then
    res.Text_Bg.transform.sizeDelta = Vector2(w, h)
  end
  local dura = self:GetBubbleDura(idx) or 0
  local updateTime = 0.3
  local updateTimer, finishTimer
  updateTimer = self.binder:BindTimer(0.25, math.ceil(dura / updateTime), function()
    bubbleStrIndex = bubbleStrIndex + 1
    if bubbleStrIndex > #bubbleStrs then
      bubbleStrIndex = 1
    end
    self.binder:SetText(res.Text_Content, bubbleStrs[bubbleStrIndex])
  end)
  finishTimer = self.binder:BindTimer(dura + 0.01, 0, nil, function()
    self.cellSizeList[idx] = nil
    self:ReloadContent()
    self:MoveChatToBottom()
  end)
  table.insert(self.bubbleTimers, updateTimer)
  table.insert(self.bubbleTimers, finishTimer)
end

function AwakerChatPanel:SetPlayerText(go, idx, contentData)
  local res = UIBaseResource(go)
  self.binder:LoadAllLangFont(res.Text_Content)
  if self.showEndAnim and #self.contentList == idx and not self.isOptioning then
    local bubbleAnimController = res.uiNode:GetComponent(typeof(UIAnimationController))
    bubbleAnimController:PlayState("UI_Address_Bubble_My_In")
  end
  if not self.playerContentW then
    local tf = res.Text_Content.transform
    self.playerContentW = tf.sizeDelta.x
    self.playerContentX = tf.anchoredPosition.x
    self.playerContentY = tf.anchoredPosition.y
  end
  local w, h = table.unpack(self.cellSizeList[idx] or {})
  self.binder:SetText(res.Text_Content, AwakerChatDataUtils.TranslateContent(contentData.Content))
  if w and h then
    res.Text_Bg.transform.sizeDelta = Vector2(w, h)
    local delta = self.playerContentW - w + Player_Text_DeltaX
    res.Text_Content.transform.anchoredPosition = Vector2(self.playerContentX - delta, self.playerContentY)
  end
end

function AwakerChatPanel:SetAwakerText(go, idx, contentData)
  local res = UIBaseResource(go)
  self.binder:LoadAllLangFont(res.Text_Content)
  if self.showEndAnim and #self.contentList == idx and not self.isOptioning then
    local bubbleAnimController = res.uiNode:GetComponent(typeof(UIAnimationController))
    bubbleAnimController:PlayState("UI_Address_Bubble_Awaker_In")
  end
  local w, h = table.unpack(self.cellSizeList[idx] or {})
  self.binder:SetText(res.Text_Content, AwakerChatDataUtils.TranslateContent(contentData.Content))
  if w and h then
    res.Text_Bg.transform.sizeDelta = Vector2(w, h)
  end
end

function AwakerChatPanel:SetAwakerEmoj(go, idx, contentData)
  local res = UIBaseResource(go)
  local emoji = contentData.Emoji
  if emoji and res.Content_Emoji then
    local icon = ItemDataUtils.GetItemIcon(emoji)
    self.binder:SetImage(res.Content_Emoji, icon)
  end
end

function AwakerChatPanel:SetPlayerEmoj(go, idx, contentData)
  self:SetAwakerEmoj(go, idx, contentData)
end

function AwakerChatPanel:OnUnbind()
  UIManager.Instance:CloseByUrl(Urls.AvgDialogHistoryPanel)
  UIManager.Instance:CloseByUrl(Urls.VideoCaptionPanel)
  ResLoadMgr.UnloadAssetByTarget(self)
end

return AwakerChatPanel
