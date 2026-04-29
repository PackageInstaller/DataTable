_class("BuffViewCreateTrap", BuffViewBase)
BuffViewCreateTrap = BuffViewCreateTrap

function BuffViewCreateTrap:PlayView(TT)
  local trapEntityIDs = self._buffResult:GetEntityIds()
  if trapEntityIDs then
    local t = {}
    for _, eid in ipairs(trapEntityIDs) do
      local e = self._world:GetEntityByID(eid)
      if e:HasTrapID() then
        table.insert(t, e)
      end
    end
    local trapServiceRender = self._world:GetService("TrapRender")
    trapServiceRender:ShowTraps(TT, t, true)
  end
end

function BuffViewCreateTrap:IsNotifyMatch(notify)
  local pos = self._buffResult:GetPos()
  if pos then
    local viewGrids = notify:GetCreateTrapGrids()
    local matchCount = 0
    for _, logicGrid in pairs(pos) do
      for _, viewGrid in pairs(viewGrids) do
        if logicGrid.x == viewGrid.x and logicGrid.y == viewGrid.y then
          matchCount = matchCount + 1
        end
      end
    end
    if matchCount ~= table.count(viewGrids) then
      return false
    end
  end
  return true
end
