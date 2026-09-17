local this = class("moduleEventDriftBottle", G_UIModuleBase)
local _fishEventTpl = L_GameTpl:getFishEventTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {txt_title = nil, txt_desc = nil}
end

function this.methods()
  return {
    onClick_collect = function(self)
      L_UI:close(self.pageName)
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
  self.bind.txt_title = _fishEventTpl:getName(tpl)
  self.bind.txt_desc = _fishEventTpl:getDesc(tpl)
end

function this:refresh()
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_content)
end

return this
