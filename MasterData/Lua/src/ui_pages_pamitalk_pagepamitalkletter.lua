local this = class("pagePamiTalkLetter", G_UIPageBase)
local pamiLetterTextTpl = L_GameTpl:getPamiLetterTextTpl()
local pamiLetterReplyTpl = L_GameTpl:getPamiLetterReplyTpl()
local pamiLetterListTpl = L_GameTpl:getPamiLetterListTpl()

function this.bind()
  return {
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    contentList = {
      moduleName = "pages/pamiTalk/modulePamiLetterContentCell"
    },
    letterList = {
      moduleName = "pages/pamiTalk/modulePamiTalkLetterCell"
    },
    replyOptionList = {
      moduleName = "pages/pamiTalk/modulePamiReplyOptionCell"
    },
    senderHeadIcon = "",
    senderNameText = "",
    endText = "",
    contentListSize = C_Vector2(1260, 800),
    replyContentActive = true,
    endTextActive = false,
    topRedBtnActive = false,
    botRedBtnActive = false
  }
end

function this.methods()
  return {
    letterList = {
      onClick_letterList = function(self, letterId)
        if self.letterId == letterId then
          return
        end
        self.letterId = letterId
        self:setLetterListActive()
        self:updateContent()
      end
    },
    onValueChanged_contentList = function(self, value)
      if self.playAddAni then
        return
      end
      self:checkRewardRedDotPos(value)
    end,
    onClick_topRedBtn = function(self)
      self:dealRedBtnJump(true)
    end,
    onClick_botRedBtn = function(self)
      self:dealRedBtnJump(false)
    end
  }
end

function this:dealRedBtnJump(bTop)
  local index
  for k, v in ipairs(self.redNavs) do
    if bTop then
      if v.pos.y > self.uiCamera:WorldToScreenPoint(self.bindComponents.topRedRect.position).y then
        index = v.index
        break
      end
    elseif v.pos.y < self.uiCamera:WorldToScreenPoint(self.bindComponents.botRedRect.position).y then
      index = v.index
      break
    end
  end
  if index then
    self:contentJumpToIndex(index)
  end
end

function this:contentJumpToIndex(index)
  local percentY = self:getPercentY(index)
  self.bindComponents.contentTableView.normalizedPosition = C_Vector2(0, percentY)
end

function this:getPercentY(index)
  local totalNum = #self.bind.contentList
  local totalY = totalNum * (self.contentCellSize.y + self.cellspace) - self.cellspace
  local contentListY = self.bindComponents.contentListRect.sizeDelta.y
  local scrollRange = totalY - contentListY
  local y = (index - 1) * (self.contentCellSize.y + self.cellspace)
  if 0 < scrollRange and scrollRange < y then
    y = scrollRange
  end
  local percentY = 1 - y / scrollRange
  if percentY == 0 then
    percentY = -0.1
  end
  return percentY
end

function this:checkRewardRedDotPos(value)
  self.redNavs = {}
  local talks = L_PamiTalkManager:getLetterTalks(self.letterId)
  for i, talk in ipairs(talks) do
    local bGot = L_PamiTalkManager:isLetterRewardGot(talk.letterId, talk.letterTextId)
    if talk.textType == L_PamiTalkManager.pamiTalkTextType.Send and not bGot then
      local item = self.bind.contentList:getItemCls(i)
      if item then
        local pos = item:getRewardDotPosition()
        if pos ~= nil then
          self.lastPos = pos
          pos = self.uiCamera:WorldToScreenPoint(pos)
          local bIn = self.rectangleContainsScreenPoint(self.bindComponents.contentTableView.viewport, C_Vector2(pos.x, pos.y), self.uiCamera)
          if not bIn then
            table.insert(self.redNavs, {index = i, pos = pos})
          end
        else
          local tpl = pamiLetterTextTpl:getTplById(talk.letterTextId)
          local rewards = pamiLetterTextTpl:getReward(tpl)
          if not table.isEmpty(rewards) then
            local percentY = self:getPercentY(i)
            if percentY < value.y then
              pos = C_Vector3(0, -1000000, 0)
            else
              pos = C_Vector3(0, 1000000, 0)
            end
            pos = self.uiCamera:WorldToScreenPoint(pos)
            table.insert(self.redNavs, {index = i, pos = pos})
          end
        end
      end
    end
  end
  local bShowTop = false
  local bShowBot = false
  for _, v in ipairs(self.redNavs) do
    if v.pos.y > self.uiCamera:WorldToScreenPoint(self.bindComponents.topRedRect.position).y then
      bShowTop = true
    end
    if v.pos.y < self.uiCamera:WorldToScreenPoint(self.bindComponents.botRedRect.position).y then
      bShowBot = true
    end
  end
  self.bind.topRedBtnActive = bShowTop
  self.bind.botRedBtnActive = bShowBot
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.uiCamera = C_CameraManager.uiCamera
  self.rectangleContainsScreenPoint = Unity.RectTransformUtility.RectangleContainsScreenPoint
  L_PamiTalkStore:listenCallFunc(L_PamiTalkStore.event.refreshLetter, self.onRefreshLetter, self)
  L_PamiTalkStore:listenCallFunc(L_PamiTalkStore.event.refreshRewardStatus, self.onRefreshRewardStatus, self)
  L_PamiTalkStore:listenCallFunc(L_PamiTalkStore.event.refreshLettersData, self.onRefreshLettersData, self)
  self.options = options
  self:registerTouch("+")
  self.contentCellSize = self.bindComponents.modulePamiLetterContentCell.sizeDelta
  self.cellspace = 40
  self:updatePage()
end

function this:onRefreshRewardStatus()
  self:checkRewardRedDotPos(self.bindComponents.contentTableView.normalizedPosition)
end

function this:registerTouch(operator)
  self.handler = self.handler or L_CommonUtil.handle(self.onTouchEvent, self)
  C_ScreenTouch.OnUI_Touch(operator, self.handler)
end

function this:onTouchEvent()
  local playingVoice = L_PamiTalkManager:getPlayingLetterVoice()
  if playingVoice ~= nil then
    L_AudioUtil.stopSound(playingVoice)
    L_PamiTalkManager:setPlayingLetterVoice(nil)
  end
end

function this:onRefreshLettersData()
  self:updateLetterList()
  self:setLetterListActive()
end

function this:updatePage()
  self:updateTopBar()
  self:updateLetterList()
  self:setLetterListActive()
  self:updateContent()
  self:updateHeadIcon()
end

function this:updateHeadIcon()
  local heroItem = L_ItemManager:parseHeroItem(self.options.heroId)
  self.bind.senderHeadIcon = heroItem.iconBattle
  self.bind.senderNameText = L_WordsTpl:getValue(L_PamiTalkManager.text.sender_name, {
    [0] = heroItem.name
  })
end

function this:updateLetterList()
  local lettersData = L_PamiTalkManager:getGroupLetterList(self.options.groupId)
  self.bind.letterList:clear()
  self.bind.letterList:insert_array(lettersData)
  if lettersData and lettersData[1] and not self.letterId then
    self.letterId = lettersData[1].letterId
  end
end

function this:updateTopBar()
  local uiTile = L_WordsTpl:getValue(L_PamiTalkManager.text.ui_Title)
  local data = {
    name = uiTile,
    helpBtnBool = false,
    mainBtnBool = false,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end
  }
  self.modules.moduleCommonTop:initModule(data)
end

function this:setLetterListActive()
  for i = 1, #self.bind.letterList do
    local letterId = self.bind.letterList:getValue(i, "letterId")
    local active = letterId == self.letterId
    self.bind.letterList:change(i, {
      selectedActive = active,
      normalActive = not active
    })
  end
end

function this:updateContent(addOnTalks)
  if not self.letterId then
    return
  end
  self:clearTweensAndTimer()
  if addOnTalks and addOnTalks[1].letterId ~= self.letterId then
    return
  end
  local talks = L_PamiTalkManager:getLetterTalks(self.letterId)
  if not talks or #talks == 0 then
    return
  end
  L_PamiTalkStore:req_pamiTalkReadMail(self.letterId)
  self.bind.endText = L_PamiTalkManager.text.talk_end_Text
  local showEnd = false
  local lastTalk = talks[#talks]
  if lastTalk.textType == L_PamiTalkManager.pamiTalkTextType.Send then
    local textTpl = pamiLetterTextTpl:getTplById(lastTalk.letterTextId)
    showEnd = math.isEmpty(pamiLetterTextTpl:getTeamId(textTpl))
    if not math.isEmpty(pamiLetterTextTpl:getTeamId(textTpl)) then
      self.bind.replyContentActive = true
      self:udpateReplyContent(lastTalk)
    else
      self.bind.replyContentActive = false
    end
  else
    local replyTpl = pamiLetterReplyTpl:getTplById(lastTalk.letterTextId)
    showEnd = math.isEmpty(pamiLetterReplyTpl:getTextId(replyTpl))
    self.bind.replyContentActive = false
  end
  self:updateContentListSize()
  self:updateContentList(addOnTalks, talks, showEnd)
end

function this:updateContentList(addOnTalks, talks, showEnd)
  local function getter()
    if self.bindComponents and L_CommonUtil.isValid(self.bindComponents.contentTableView) then
      return self.bindComponents.contentTableView.normalizedPosition.y
    else
      return 0
    end
  end
  
  local function setter(r)
    if self.bindComponents and L_CommonUtil.isValid(self.bindComponents.contentTableView) then
      self.bindComponents.contentTableView.normalizedPosition = C_Vector2(0, r)
    end
  end
  
  self.timers = {}
  self.bind.topRedBtnActive = false
  self.bind.botRedBtnActive = false
  if addOnTalks then
    self.playAddAni = true
    for k, talk in ipairs(addOnTalks) do
      self.tweens = {}
      local timer = Timer.once(0.5 * k, function()
        self.bind.contentList:insert(talk)
        local tween = DOTween.To(getter, setter, -0.1, 0.45)
        table.insert(self.tweens, tween)
        tween:SetTarget(self.bindComponents.contentTableView)
      end, self)
      table.insert(self.timers, timer)
    end
    local timer = Timer.once(0.5 * #addOnTalks + 1, function()
      self.playAddAni = false
      self:checkRewardRedDotPos(self.bindComponents.contentTableView.normalizedPosition)
      self.bind.endTextActive = showEnd
      self:dealTaskId(showEnd)
    end, self)
    table.insert(self.timers, timer)
  else
    self.bind.contentList:clear()
    self.bind.contentList:insert_array(talks)
    self:setContentListFocusIndex(talks)
    local timer = Timer.once(0.05, function()
      self.bind.endTextActive = showEnd
    end, self)
    table.insert(self.timers, timer)
  end
end

function this:setContentListFocusIndex(talks)
  local focusIndex = self:getTalkListFoucsIndex(talks)
  if focusIndex == nil then
    focusIndex = #talks
  end
  self.bindComponents.contentTableView:FocusItemIndex(focusIndex - 1)
end

function this:getTalkListFoucsIndex(talks)
  if not talks or table.count(talks) == 0 then
    return 1
  end
  local jumpIndex
  for k, talk in ipairs(talks) do
    if talk.textType == L_PamiTalkManager.pamiTalkTextType.Send then
      local textCfg = pamiLetterTextTpl:getTplById(talk.letterTextId)
      if not table.isEmpty(pamiLetterTextTpl:getReward(textCfg)) then
        local isRewardGot = L_PamiTalkManager:isLetterRewardGot(talk.letterId, talk.letterTextId)
        if not isRewardGot then
          jumpIndex = k
          break
        end
      end
    end
  end
  return jumpIndex
end

function this:dealTaskId(showEnd)
  if showEnd then
    showEnd = true
    local tpl = pamiLetterListTpl:getTplById(self.letterId)
    local taskId = pamiLetterListTpl:getTaskId(tpl)
    if not math.isEmpty(taskId) then
      L_UI:open("pagePamiTalkTask", {taskId = taskId})
    end
  end
end

function this:udpateReplyContent(lastTalk)
  local replys = L_PamiTalkManager:getReplayGroup(lastTalk.letterTextId)
  self.bind.replyOptionList:clear()
  self.bind.replyOptionList:insert_array(replys)
end

function this:updateContentListSize()
  if not self.bind.replyContentActive then
    self.bind.contentListSize = C_Vector2(1260, 800)
    self.bindComponents.botRedRect.anchoredPosition = C_Vector2(self.bindComponents.botRedRect.anchoredPosition.x, -401)
  else
    self.bind.contentListSize = C_Vector2(1260, 461)
    self.bindComponents.botRedRect.anchoredPosition = C_Vector2(self.bindComponents.botRedRect.anchoredPosition.x, -60)
  end
  self:checkRewardRedDotPos(self.bindComponents.contentTableView.normalizedPosition)
end

function this:onRefreshLetter(addOnTalks)
  self:updateContent(addOnTalks)
end

function this:clearTweensAndTimer()
  if self.tweens then
    for _, tween in ipairs(self.tweens) do
      if DOTween.IsTweening(self.bindComponents.contentTableView) then
        DOTween.Kill(tween)
      end
    end
    self.tweens = nil
  end
  if self.timers then
    for _, timer in ipairs(self.timers) do
      Timer.remove(timer)
    end
    self.timers = nil
  end
end

function this:close(options)
  self:clearTweensAndTimer()
  L_PamiTalkStore:unListenCallFunc(L_PamiTalkStore.event.refreshLetter, self.onRefreshLetter, self)
  L_PamiTalkStore:unListenCallFunc(L_PamiTalkStore.event.refreshRewardStatus, self.onRefreshRewardStatus, self)
  L_PamiTalkStore:unListenCallFunc(L_PamiTalkStore.event.refreshLettersData, self.onRefreshLettersData, self)
  self:registerTouch("-")
  this.super.close(self, options)
end

return this
