_class("Award", Object)
Award = Award

function Award:Constructor()
  self.id = 0
  self.name = ""
  self.icon = ""
  self.color = 1
  self.count = 0
  self.is3Star = false
  self.type = StageAwardType.Normal
  self._cfg = Cfg.cfg_item
  self.randomType = nil
end

function Award:Init(id)
  self.id = id
  local cfg = self._cfg[id]
  if cfg then
    self.name = StringTable.Get(cfg.Name)
    self.icon = cfg.Icon
    self.color = cfg.Color
  end
end

function Award:InitWithCount(id, count, randomType)
  self:Init(id)
  self.count = count
  self.randomType = randomType
end

function Award:Flush3Star(is3Star)
  self.is3Star = is3Star
end

function Award:FlushType(type)
  self.type = type
end

local StageAwardType = {
  First = 1,
  Star = 2,
  Normal = 3,
  Activity = 4,
  HasGen = 5
}
_enum("StageAwardType", StageAwardType)
