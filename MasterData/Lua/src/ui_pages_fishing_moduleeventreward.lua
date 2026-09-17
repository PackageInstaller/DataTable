local this = class("moduleEventReward", G_UIModuleBase)
local _fishEventTpl = L_GameTpl:getFishEventTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_icon = nil,
    txt_name = nil,
    txt_desc = nil,
    txt_desc_event = nil,
    go_new = false
  }
end

function this.methods()
  return {
    onClick_scrollView = function(self)
      self:emit("onClick_mask")
    end
  }
end

function this:open(options)
  this.super.open(self, options)
end

function this:close(options)
  this.super.close(self, options)
end

function this:initModule()
  self:initInfo()
end

function this:initInfo()
  local event = L_FishingStore:getFishFinish()
  local tpl = _fishEventTpl:getTplById(event:getEventId())
  local reward = L_DataUtil.parseRewardConfigItem(_fishEventTpl:getReward(tpl)[1])
  local item = L_ItemManager:parseItem(reward.itemType, reward.itemId)
  self.bind.img_icon = _fishEventTpl:getIcon(tpl)
  self.bind.txt_name = item.name
  self.bind.txt_desc = item.desc
  self.bind.txt_desc_event = _fishEventTpl:getDesc(tpl)
  self.bind.go_new = event:getFishStatus() == L_Const.FishWeightStatusType.FWST_NEW
end

return this
