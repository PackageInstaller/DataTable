local DebugCmds = {}

function DebugCmds.ReloadDebugScript(scriptPath)
  if not HardReload.is_valid() then
    return
  end
  local str_len = #scriptPath
  if package.loaded[scriptPath] then
    HardReload.reload(scriptPath)
  else
    local found_mods = {}
    for k, _ in pairs(package.loaded) do
      if string.sub(k, -1 * str_len, -1) == scriptPath then
        table.insert(found_mods, k)
      end
    end
    if #found_mods > 1 then
      for _, v in ipairs(found_mods) do
        Logger.Debug("/tfound module:", v)
      end
    elseif 0 == #found_mods then
      Logger.Warn("没找到匹配的已加载模块(不需要热更或者没有该模块)：", scriptPath)
    else
      local a, b = HardReload.reload(found_mods[1] or scriptPath)
      if a then
        Logger.Debug(a, b)
      else
        Logger.Warn(a, b)
      end
    end
  end
end

function DebugCmds.QuickOpenGM()
  local panel = UIManager.Instance:GetWindow(Urls.GmPanel)
  if panel and not panel:IsHide() then
    UIManager.Instance:CloseByUrl(Urls.GmPanel)
  else
    UIManager.Instance:Reopen(Urls.GmPanel)
  end
end

function DebugCmds.InjectFunc(rootModule)
  for k, v in pairs(DebugCmds) do
    if "InjectFunc" ~= k then
      print(k, v)
      rootModule[k] = v
    end
  end
end

return DebugCmds
