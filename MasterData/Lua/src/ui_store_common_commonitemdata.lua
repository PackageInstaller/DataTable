local this = class("commonItemData")

function this:ctor()
  self.itemid = 0
  self.itemnum = 0
  self.deadtime = 0
  self.exts = {}
  self.itemtype = 0
  self.varitems = {}
  self.guid = 0
  self.collect = false
end

function this:populate(data)
  self.itemid = data.itemid
  self.itemnum = data.itemnum
  self.deadtime = data.deadtime
  self.exts = data.exts
  self.itemtype = data.itemtype
  self.varitems = data.varitems
  self.guid = data.guid
  self.collect = data.collect
end

return this
