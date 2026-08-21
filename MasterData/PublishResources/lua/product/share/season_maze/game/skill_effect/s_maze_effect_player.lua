_class("SMazeEffectPlayer", Object)
SMazeEffectPlayer = SMazeEffectPlayer

function SMazeEffectPlayer:Constructor()
  self._timelines = {}
  self._needDelete = {}
end

function SMazeEffectPlayer:Play(tl)
  local idx = table.ikey(self._timelines, tl)
  if idx and 0 < idx and not tl:Over() then
    Log.exception("timeline 正在播放:", idx)
  end
  tl:Start()
  table.insert(self._timelines, tl)
end

function SMazeEffectPlayer:Update(dt)
  for idx, tl in ipairs(self._timelines) do
    tl:Update(dt)
    if tl:Over() then
      table.insert(self._needDelete, idx)
    end
  end
  if #self._needDelete > 0 then
    for _, idx in ipairs(self._needDelete) do
      table.remove(self._timelines, idx)
    end
    self._needDelete = {}
  end
end

function SMazeEffectPlayer:Dispose()
  for idx, tl in ipairs(self._timelines) do
    tl:Stop()
  end
  self._timelines = nil
  self._needDelete = nil
end
