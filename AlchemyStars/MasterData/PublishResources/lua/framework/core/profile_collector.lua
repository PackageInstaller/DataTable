_class("ProfileCollector", Object)
ProfileCollector = ProfileCollector

function ProfileCollector:Constructor(title)
  self._title = title
  self._last_tick = 0
  self._begin_tick = 0
  self._collection = {}
end

function ProfileCollector:Sample(name)
  local tick = os.clock()
  if self._last_tick == 0 then
    self._last_tick = tick
    self._begin_tick = tick
  end
  local diff = (tick - self._last_tick) * 1000
  self._last_tick = tick
  table.insert(self._collection, {name = name, usetime = diff})
end

function ProfileCollector:Dump()
  self._last_tick = 0
  for i, v in ipairs(self._collection) do
    Log.prof("[", self._title, "]", ",name,", v.name, ",usetime,", v.usetime)
  end
  local total = (os.clock() - self._begin_tick) * 1000
  Log.prof("[", self._title, "]", ",name,", "total", ",usetime,", total)
  self:ResetCollector()
end

function ProfileCollector:ResetCollector()
  self._last_tick = 0
  self._collection = {}
end
