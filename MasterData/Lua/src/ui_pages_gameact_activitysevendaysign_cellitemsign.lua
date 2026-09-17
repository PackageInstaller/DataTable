local this = class("cellItemSign", G_UIModuleBase)
local _gameEventsDayAttendanceTpl = L_GameTpl:getGameEventsDayAttendanceTpl()
local Date2NumberConfig = {
  [1] = {arabic = "01", english = "ONE"},
  [2] = {arabic = "02", english = "TWO"},
  [3] = {arabic = "03", english = "THREE"},
  [4] = {arabic = "04", english = "FOUR"}
}

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    img_rewardIcon = "",
    text_rewardNum = "",
    go_lock = false,
    text_hasGet = L_WordsTpl:getValue("ui_novicetask_alreadyreceived"),
    sizeDelta_icon = C_Vector2(100, 100)
  }
end

function this.methods()
  return {
    onClick_sign = function(self)
      self.bind.go_glow = false
      self:emit("onClick_sign", {
        isClickReward = false,
        indexItem = self.bind.indexItem
      })
    end,
    onClick_reward = function(self)
      self.bind.go_glow = false
      self:emit("onClick_sign", {
        isClickReward = true,
        indexItem = self.bind.indexItem,
        itemType = self.itemType,
        itemId = self.itemId
      })
    end
  }
end

function this:open()
end

function this:refresh()
  local eventTpl = _gameEventsDayAttendanceTpl:getTplById(self.bind.eventTplId)
  local date = _gameEventsDayAttendanceTpl:getDate(eventTpl)
  local reward = L_DataUtil.parseRewardConfig(_gameEventsDayAttendanceTpl:getReward(eventTpl))[1]
  self.bind.text_arabicNumber = Date2NumberConfig[date].arabic
  self.bind.text_englishNumber = Date2NumberConfig[date].english
  local itemType = reward.itemType
  local itemId = reward.itemId
  local itemNum = reward.itemNum
  self.itemType = itemType
  self.itemId = itemId
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.img_rewardIcon = conf.icon
  self.bind.text_rewardNum = string.format("X%d", itemNum)
end

return this
