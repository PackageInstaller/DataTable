local M = {}

function M.Restart(comp)
  if not comp then
    return
  end
  comp:_ClearRefreshTimer()
  comp:RefreshTime()
  comp._refreshTimer = comp:BindTimer(1, -1, function()
    comp:RefreshTime()
  end)
end

return M
