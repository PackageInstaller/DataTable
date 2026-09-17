local this = class("pamiTalkManager")
local pamiLetterCategoryTpl = L_GameTpl:getPamiLetterCategoryTpl()
local pamiLetterGroupTpl = L_GameTpl:getPamiLetterGroupTpl()
local pamiLetterListTpl = L_GameTpl:getPamiLetterListTpl()
local pamiLetterReplyTpl = L_GameTpl:getPamiLetterReplyTpl()
local pamiTalkTpl = L_GameTpl:getPamiTalkTpl()
local pamiLetterTextTpl = L_GameTpl:getPamiLetterTextTpl()
this.text = {
  ui_Title = "ui_communication_01",
  sender_name = "ui_communication_02",
  talk_end_Text = "--------------结束--------------",
  pami_task_tips = "ui_receiveTask_01: ",
  common_profession = "ui_hintCamp_01",
  filter_birth_place = "ui_hintCamp_02"
}
this.pamiTalkType = {welcomeTip = 1, touchTip = 2}
this.pamiTalkTextType = {Send = 1, Reply = 2}
this.pamiTalkRewardStatus = {
  None = 0,
  HasReward = 1,
  RewardGot = 2
}

function this:parsePamiTalkData()
  self:resetTextTimer()
  local data = L_PamiTalkStore:getPamiTalkData()
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  if not (data and parsedLetters) or not letterMap then
    return
  end
  for _, mail in ipairs(data.mail_tab) do
    if not parsedLetters[mail.mail_type] then
      parsedLetters[mail.mail_type] = {}
    end
    local category = parsedLetters[mail.mail_type]
    if not category.redNum then
      category.redNum = 0
    end
    if not category.groups then
      category.groups = {}
    end
    if not mail.contents then
      mail.contents = {}
    end
    for k, letter in ipairs(mail.contents) do
      local letterCfg = pamiLetterListTpl:getTplById(letter.mail_id)
      local groupId = pamiLetterListTpl:getGroupId(letterCfg)
      if not category.groups[groupId] then
        category.groups[groupId] = {}
        category.groups[groupId].redNum = 0
        category.groups[groupId].letters = {}
      end
      letter.letterSequnce = self:getLetterSequence(letter)
      letter.group = category.groups[groupId]
      letter.category = category
      category.groups[groupId].letters[letter.mail_id] = letter
      letterMap[letter.mail_id] = letter
    end
  end
  self:updatePamiTalkRedInfo()
end

function this:resetTextTimer()
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  for k, letter in pairs(letterMap) do
    if letter.timer then
      Timer.remove(letter.timer)
      letter.timer = nil
    end
  end
end

function this:getCategoryLetterServerData(categoryId)
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  return parsedLetters[categoryId]
end

function this:getLetterServerData(letterId)
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  return letterMap[letterId]
end

function this:getLetterMap()
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  return letterMap
end

function this:getParsedLetters()
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  return parsedLetters
end

function this:getLetterSequence(letter)
  local letterCfg = pamiLetterListTpl:getTplById(letter.mail_id)
  local currentTextId = pamiLetterTextTpl:getFirstId(letterCfg)
  local talkGroup = {}
  while not math.isEmpty(currentTextId) do
    local letterTextCfg = pamiLetterTextTpl:getTplById(currentTextId)
    table.insert(talkGroup, {
      letterId = letter.mail_id,
      letterTextId = currentTextId,
      textType = self.pamiTalkTextType.Send
    })
    local replyTeamId = pamiLetterTextTpl:getTeamId(letterTextCfg)
    if not letter.reply then
      letter.reply = {}
    end
    local reply = self:getPlayerReplyServerData(letter.reply, replyTeamId)
    if reply then
      local replyId = reply.record
      table.insert(talkGroup, {
        letterId = letter.mail_id,
        letterTextId = replyId,
        textType = self.pamiTalkTextType.Reply
      })
      local replyCfg = pamiLetterReplyTpl:getTplById(replyId)
      local tmpTextId = pamiLetterReplyTpl:getTextId(replyCfg)
      if not math.isEmpty(tmpTextId) then
        local tmpTextCfg = pamiLetterTextTpl:getTplById(tmpTextId)
        local delayTime = pamiLetterTextTpl:getTime(tmpTextCfg)
        if not math.isEmpty(delayTime) then
          local sendTime = reply.timestamp + delayTime
          if sendTime <= L_TimeUtil.getServerTime() then
            currentTextId = tmpTextId
          else
            self:setReplyTimer(tmpTextId, letter)
            currentTextId = nil
          end
        end
      else
        currentTextId = nil
      end
    else
      currentTextId = nil
    end
  end
  return talkGroup
end

function this:setReplyTimer(textId, passLetter)
  local textCfg = pamiLetterTextTpl:getTplById(textId)
  local delayTime = pamiLetterTextTpl:getTime(textCfg)
  local letterId = pamiLetterTextTpl:getLetterId(textCfg)
  local letter = self:getLetterServerData(letterId)
  letter = letter or passLetter
  local tmpText = {
    letterId = letterId,
    letterTextId = textId,
    textType = self.pamiTalkTextType.Send
  }
  if letter.timer then
    Timer.remove(letter.timer)
    letter.timer = nil
  end
  letter.timer = Timer.once(delayTime, function()
    tmpText.timestamp = L_TimeUtil.getServerTime()
    table.insert(letter.letterSequnce, tmpText)
    tmpText.timer = nil
    letter.latest_read = false
    self:updateOneLetterRedInfo(letter)
    L_PamiTalkStore:call(L_PamiTalkStore.event.refreshLetter, {tmpText})
    L_PamiTalkStore:call(L_PamiTalkStore.event.refreshLetterRedDot)
  end, self)
end

function this:getPlayerReplyServerData(replys, replyTeamId)
  for _, reply in ipairs(replys) do
    if not math.isEmpty(reply.record) then
      local replyTpl = pamiLetterReplyTpl:getTplById(reply.record)
      local teamId = pamiLetterReplyTpl:getTeamId(replyTpl)
      if teamId == replyTeamId then
        return reply
      end
    end
  end
  return nil
end

function this:updatePamiTalkRedInfo()
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  for _, category in pairs(parsedLetters) do
    if category.redNum == nil then
      category.redNum = 0
    end
    for _, group in pairs(category.groups) do
      if group.redNum == nil then
        group.redNum = 0
      end
    end
  end
  for i, letter in pairs(letterMap) do
    self:updateOneLetterRedInfo(letter)
  end
end

function this:updateOneLetterRedInfo(letter)
  local hasRed = false
  if not letter.latest_read then
    hasRed = true
  else
    hasRed = self:isLetterHasReward(letter.mail_id)
    hasRed = hasRed or self:isLetterNotReplyed(letter)
  end
  letter.hasRed = hasRed
  self:updateCategoryAndGroupRed(letter.category)
  local letterCfg = pamiLetterListTpl:getTplById(letter.mail_id)
  if hasRed then
    letter.sortOrder = pamiLetterListTpl:getOrder(letterCfg) + 1000000
  else
    letter.sortOrder = pamiLetterListTpl:getOrder(letterCfg)
  end
end

function this:updateCategoryAndGroupRed(category)
  local cateRedNum = 0
  for k, group in pairs(category.groups) do
    local groupRedNum = 0
    for i, letter in pairs(group.letters) do
      if letter.hasRed then
        groupRedNum = groupRedNum + 1
      end
    end
    group.redNum = groupRedNum
    cateRedNum = cateRedNum + groupRedNum
  end
  category.redNum = cateRedNum
end

function this:isLetterHasReward(letterId)
  local letter = self:getLetterServerData(letterId)
  if not letter then
    return false
  end
  local squence = letter.letterSequnce
  if not letter.reward then
    letter.reward = {}
  end
  for k, talk in ipairs(squence) do
    if talk.textType == self.pamiTalkTextType.Send then
      local textCfg = pamiLetterTextTpl:getTplById(talk.letterTextId)
      if not table.isEmpty(pamiLetterTextTpl:getReward(textCfg)) and not self:isLetterRewardGot(letter.mail_id, talk.letterTextId) then
        return true
      end
    end
  end
  return false
end

function this:isLetterNotReplyed(letter)
  if letter.letterSequnce and #letter.letterSequnce > 0 then
    local talk = letter.letterSequnce[#letter.letterSequnce]
    if talk.textType == self.pamiTalkTextType.Send then
      local letterTextCfg = pamiLetterTextTpl:getTplById(talk.letterTextId)
      if not math.isEmpty(pamiLetterTextTpl:getTeamId(letterTextCfg)) then
        return true
      end
    end
  end
  return false
end

function this:getPamiLettersCategory()
  local categroyConfigs = pamiLetterCategoryTpl.data
  local categroyList = {}
  local index = 1
  for k, config in pairs(categroyConfigs) do
    local categorySystemId = pamiLetterCategoryTpl:getSystemId(config)
    local isOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(categorySystemId)
    if isOpen then
      local categoryId = pamiLetterCategoryTpl:getId(config)
      local hasRed = self:isCategoryHasRed(categoryId)
      table.insert(categroyList, {
        typeIndex = categoryId,
        categroyTpl = config,
        hasRed = hasRed
      })
      if hasRed and k <= index then
        index = k
      end
    end
  end
  return categroyList, index
end

function this:isCategoryHasRed(categoryId)
  local category = self:getCategoryLetterServerData(categoryId)
  if not category then
    return false
  end
  if category.redNum ~= nil and category.redNum > 0 then
    return true
  end
  return false
end

function this:getPamiLetterGroupsByNation(nationIds)
  local groups = self:getPamiLetterGroups()
  if not nationIds or #nationIds == 0 then
    return groups
  end
  local res = {}
  for k, category in pairs(groups) do
    if not res[k] then
      res[k] = {}
    end
    for i, group in ipairs(category) do
      if table.containsValue(nationIds, group.nation) then
        table.insert(res[k], group)
      end
    end
  end
  return res
end

function this:getPamiLetterGroups()
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  local groupConfigs = pamiLetterGroupTpl.data
  local groups = {}
  local weight = 0
  for k, config in pairs(groupConfigs) do
    weight = 0
    local groupId = pamiLetterGroupTpl:getId(config)
    if self:isLetterGroupAvaliable(groupId) then
      local categoryId = pamiLetterGroupTpl:getCategoryId(config)
      if not groups[categoryId] then
        groups[categoryId] = {}
      end
      weight = self:getGroupLasestTimestamp(categoryId, groupId)
      if 0 < parsedLetters[categoryId].groups[groupId].redNum then
        weight = 100000000 + weight
      end
      table.insert(groups[categoryId], {
        letterGroupTpl = config,
        nation = pamiLetterGroupTpl:getNation(config),
        order = weight
      })
    end
  end
  for k, group in pairs(groups) do
    table.sort(group, function(a, b)
      return a.order > b.order
    end)
  end
  return groups
end

function this:getGroupLasestTimestamp(categoryId, groupId)
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  if not parsedLetters[categoryId] then
    return 0
  end
  local timestamp = 0
  for k, group in pairs(parsedLetters[categoryId].groups) do
    if k == groupId then
      for _, letter in pairs(group.letters) do
        local letterTimestamp = self:getLetterLastestTimestamp(letter)
        if timestamp < letterTimestamp then
          timestamp = letterTimestamp
        end
      end
    end
  end
  return timestamp
end

function this:getLetterLastestTimestamp(letter)
  local timestamp = letter.timestamp
  for _, reply in pairs(letter.reply) do
    local addTime = 0
    if not math.isEmpty(reply.text_id) then
      local letterTextCfg = pamiLetterTextTpl:getTplById(reply.text_id)
      if letterTextCfg then
        addTime = pamiLetterTextTpl:getTime(letterTextCfg)
      end
      local newTime = reply.timestamp + addTime
      if timestamp < newTime and newTime < L_TimeUtil.getServerTime() then
        timestamp = reply.timestamp + addTime
      end
    end
  end
  return timestamp
end

function this:isLetterGroupAvaliable(groupId)
  local parsedLetters = L_PamiTalkStore:getPamiParsedLetters()
  local groupCfg = pamiLetterGroupTpl:getTplById(groupId)
  local categoryId = pamiLetterGroupTpl:getCategoryId(groupCfg)
  if not parsedLetters[categoryId] then
    return false
  end
  local group = parsedLetters[categoryId].groups[groupId]
  if not group then
    return false
  end
  if group.letters and table.count(group) > 0 then
    return true
  end
  return false
end

function this:getGroupLetterList(id)
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  local letterListConfigs = pamiLetterListTpl.data
  local res = {}
  local weight = 0
  for k, config in pairs(letterListConfigs) do
    weight = 0
    local groudId = pamiLetterListTpl:getGroupId(config)
    if groudId == id then
      local letterId = pamiLetterListTpl:getId(config)
      if self:isLetterAvalibale(letterId) then
        weight = self:getLetterLastestTimestamp(letterMap[letterId])
        if letterMap[letterId].hasRed then
          weight = 100000000 + weight
        end
        table.insert(res, {
          letterTpl = config,
          letterId = pamiLetterListTpl:getId(config),
          order = weight
        })
      end
    end
  end
  table.sort(res, function(a, b)
    return a.order > b.order
  end)
  return res
end

function this:isLetterAvalibale(letterId)
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  if letterMap[letterId] then
    return true
  end
  return false
end

function this:getLetterTalks(letterId)
  local letterMap = L_PamiTalkStore:getPamiLetterMap()
  if self:isLetterAvalibale(letterId) then
    return letterMap[letterId].letterSequnce
  end
  return {}
end

function this:getReplysByLetterTextId(id)
  local replyConfigs = pamiLetterReplyTpl.data
  local res = {}
  for k, config in pairs(replyConfigs) do
    local teamId = pamiLetterReplyTpl:getTeamId(config)
    if teamId == id then
      table.insert(res, {
        order = pamiLetterReplyTpl:getId(config),
        replyTpl = config
      })
    end
  end
  table.sort(res, function(a, b)
    return a.order < b.order
  end)
  return res
end

function this:getReplayGroup(letterTextId)
  local textTpl = pamiLetterTextTpl:getTplById(letterTextId)
  local teamId = pamiLetterTextTpl:getTeamId(textTpl)
  local res = {}
  local replys = pamiLetterReplyTpl.data
  for k, reply in pairs(replys) do
    if pamiLetterReplyTpl:getTeamId(reply) == teamId then
      table.insert(res, {
        letterTextId = letterTextId,
        id = pamiLetterReplyTpl:getId(reply),
        replyTpl = reply
      })
    end
  end
  table.sort(res, function(a, b)
    return a.id < b.id
  end)
  return res
end

function this:getPamiSpineTalks()
  local touchTips = {}
  local res = {}
  local talks = pamiTalkTpl.data
  local date = L_TimeUtil.getDateInfo(L_TimeUtil.getServerTime())
  for k, talk in pairs(talks) do
    if pamiTalkTpl:getType(talk) == self.pamiTalkType.welcomeTip and date.hour >= pamiTalkTpl:getStartTime(talk) and date.hour < pamiTalkTpl:getEndTime(talk) then
      table.insert(res, 1, {
        text = L_Config:provider(pamiTalkTpl:getText(talk)),
        des = L_Config:provider(pamiTalkTpl:getDesc(talk))
      })
    end
    if pamiTalkTpl:getType(talk) == self.pamiTalkType.touchTip then
      local order = pamiTalkTpl:getOrder(talk)
      if not touchTips[order] then
        touchTips[order] = {}
      end
      table.insert(touchTips[order], {
        weight = pamiTalkTpl:getWeight(talk),
        text = L_Config:provider(pamiTalkTpl:getText(talk)),
        des = L_Config:provider(pamiTalkTpl:getDesc(talk))
      })
    end
  end
  for k, v in ipairs(touchTips) do
    local randomTip = self:getRandomObject(v)
    table.insert(res, randomTip)
  end
  return res
end

function this:getRandomObject(objects)
  local totalWeight = 0
  for i, object in ipairs(objects) do
    totalWeight = totalWeight + object.weight
  end
  local randomValue = math.random() * totalWeight
  local selectedObject
  local cumulativeWeight = 0
  for i, object in ipairs(objects) do
    cumulativeWeight = cumulativeWeight + object.weight
    if randomValue <= cumulativeWeight then
      selectedObject = object
      break
    end
  end
  return selectedObject
end

function this:isLetterRewardGot(letterId, letterTextId)
  local letter = self:getLetterServerData(letterId)
  if not letter then
    return false
  end
  if not letter.reward then
    letter.reward = {}
  end
  return table.containsValue(letter.reward, letterTextId)
end

function this:setPlayingLetterVoice(voice)
  self.playingVoice = voice
end

function this:getPlayingLetterVoice()
  return self.playingVoice
end

return this
