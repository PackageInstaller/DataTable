local module = class("cellMailItem", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local _gmCustomizedtextListTpl = L_GameTpl:getGmCustomizedtextListTpl()

function module.bind()
  return {
    icon = "",
    title = "",
    sender = "",
    time = "",
    titleAlpha = "",
    senderAlpha = "",
    timeAlpha = "",
    iconAct = true,
    noRewardUnread = false,
    noRewardRead = false,
    canReward = true,
    noRead = false,
    readActive = false,
    rewardMask = false,
    collectIconActive = false,
    redDotActive = true,
    unselectedBgActive = true,
    selectedBgActive = false
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  if self.bind.choiceComp == nil then
    return
  end
  local mailTpl = L_GameTpl:getMailTpl()
  local mailBonus = L_GameTpl:getMailBonusCTpl()
  local wordsTpl = L_GameTpl:getWordsTpl()
  local time1, time2, leftTime = L_TimeUtil.getLeftDayAndHour(self.bind.effecttm + self.bind.createtm)
  if self.bind.guid ~= 0 and time1 ~= nil or self.bind.effecttm == 0 or self.bind.collect then
    local title = ""
    local sender = ""
    local tempMailTpl = mailTpl:getTplById(self.bind.template_id)
    local senderStr, isLengthFit
    if tempMailTpl and mailTpl:getType(tempMailTpl) == L_Const.mailType.type1 then
      if tempMailTpl.id == 20101 or tempMailTpl.id == 20102 or tempMailTpl.id == 20103 then
        if self.bind.args and table.count(self.bind.args) >= 5 then
          local petCfgId = self.bind.args[4].attr_id
          local petCfg = _petTpl:getTplById(petCfgId)
          local petName = _petTpl:getName(petCfg)
          title = string.format(mailBonus:getWordsById(mailTpl:getTitle(tempMailTpl)), petName)
        end
      elseif tempMailTpl.id == 2 or tempMailTpl.id == 3 then
        local reason = mailData.args[1].str_val
        local funcNameId = mailData.args[2].attr_id
        local gmCustomizedtextListCfg = _gmCustomizedtextListTpl:getTplById(funcNameId)
        local funcName = _gmCustomizedtextListTpl:getFunctionName(gmCustomizedtextListCfg)
        title = L_Lang:get(mailBonus:getWordsById(mailTpl:getTitle(tempMailTpl)), {
          [0] = reason,
          [1] = funcName
        })
      else
        title = mailBonus:getWordsById(mailTpl:getTitle(tempMailTpl))
      end
      senderStr, isLengthFit = self:TruncateUTF8(mailBonus:getWordsById(mailTpl:getName(tempMailTpl)), 12)
    else
      title = self.bind.title
      senderStr, isLengthFit = self:TruncateUTF8(tostring(self.bind.sender_id), 12)
    end
    sender = senderStr
    local tempTime = ""
    if time1 ~= nil and time2 ~= nil then
      tempTime = time1 and L_WordsTpl:getValue("ui_colloect_day_expire", {
        [0] = time2
      }) or L_WordsTpl:getValue("ui_colloect_hour_expire", {
        [0] = time2
      })
      if leftTime < 3600 then
        tempTime = L_WordsTpl:getValue("ui_colloect_min_expire")
      end
    end
    local tempIcon = ""
    local tempIconAct = false
    local reward
    if self.bind.reward and self.bind.reward.rewards then
      reward = self.bind.reward.rewards[1]
    end
    if reward ~= nil then
      local dataReward = L_ItemTplManager:getItemConfig(reward.itemtype, reward.itemid)
      tempIcon = dataReward.icon
      tempIconAct = true
    end
    local tempNoRewardUnread = not self.bind.read and not tempIconAct
    local tempNoRewardRead = self.bind.read and not tempIconAct
    local rewardMask = tempIconAct and self.bind.fetch
    local checkmark = L_MailStore:getCheckedMail() == self.bind.guid
    if checkmark and self:getTrans() ~= nil then
      self.bind.choiceComp.followTarget = self:getTrans()
    end
    local noRead = not self.bind.read
    local read = self.bind.read
    if reward ~= nil then
      noRead = not self.bind.fetch
      read = self.bind.fetch
    end
    self.bind.redDotActive = noRead and not self.bind.collect
    self.checkMark = checkmark
    self.bind.title = title
    self.bind.titleAlpha = title
    self.bind.icon = tempIcon
    self.bind.sender = sender
    self.bind.senderAlpha = sender
    self.bind.time = tempTime
    self.bind.timeAlpha = tempTime
    self.bind.noRead = noRead
    self.bind.readActive = read
    self.bind.iconAct = tempIconAct
    self.bind.canReward = tempIconAct and not self.bind.collect
    self.bind.noRewardUnread = tempNoRewardUnread
    self.bind.noRewardRead = tempNoRewardRead
    self.bind.rewardMask = rewardMask
    self.bind.collectIconActive = self.bind.collect
  end
end

function module:TruncateUTF8(str, maxChars)
  local count = 0
  local index = 1
  local len = #str
  while index <= len do
    count = count + 1
    if maxChars < count then
      return str:sub(1, index - 1) .. "...", maxChars > count
    end
    local c = str:byte(index)
    if c < 128 then
      index = index + 1
    elseif c < 224 then
      index = index + 2
    elseif c < 240 then
      index = index + 3
    else
      index = index + 4
    end
  end
  return str, maxChars > count
end

function module.methods()
  return {
    onClick_toggleBtn = function(self)
      self:emit("mailInfo", self.bind.guid)
    end
  }
end

function module:close(options)
  if self.checkMark and self.bind and self.bind.choiceComp then
    self.bind.choiceComp.followTarget = nil
  end
end

function module:getTrans()
  if self.bindComponents then
    return self.bindComponents.trans
  end
end

return module
