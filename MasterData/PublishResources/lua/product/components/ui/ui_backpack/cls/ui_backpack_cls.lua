_class("BackPackBoxItem", Object)
BackPackBoxItem = BackPackBoxItem

function BackPackBoxItem:Constructor(tplId, count)
  self.tplId = tplId
  self.count = count
  local cfg = Cfg.cfg_item[tplId]
  if not cfg then
    Log.fatal("### cfg_item not exist ", tplId)
    return
  end
  self.icon = cfg.Icon
  self.name = StringTable.Get(cfg.Name)
  self.desc = StringTable.Get(cfg.Intro)
  self.descLong = StringTable.Get(cfg.RpIntro)
  self.color = cfg.Color
end

function BackPackBoxItem:Init()
  return self.tplId
end

function BackPackBoxItem:GetTplId()
  return self.tplId
end

function BackPackBoxItem:GetCount()
  return self.count
end

function BackPackBoxItem:GetIcon()
  return self.icon
end

function BackPackBoxItem:GetName()
  return self.name
end

function BackPackBoxItem:GetDesc()
  return self.desc
end

function BackPackBoxItem:GetDescLong()
  return self.descLong
end

function BackPackBoxItem:GetColor()
  return self.color
end
