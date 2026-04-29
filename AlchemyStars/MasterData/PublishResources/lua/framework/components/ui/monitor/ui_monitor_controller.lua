_class("UIMonitorController", UIController)
UIMonitorController = UIMonitorController

function UIMonitorController:OnShow(uiParams)
end

function UIMonitorController:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIMonitorController:btnResLeakOnClick(go)
  self:ShowDialog("UIResLeak")
end

function UIMonitorController:btnGameStatusOnClick(go)
  self:ShowDialog("UIGameStatus")
end

function UIMonitorController:btnAbLoadTimeOnClick(go)
  local path = Monitor:GetInstance():ABLoadTimes()
  if not path then
    return
  end
  local content = "ab加载时间，记录成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "ab加载时间统计", content)
end

function UIMonitorController:btnAssetLoadTimeOnClick(go)
  local path = Monitor:GetInstance():AssetLoadTimes()
  if not path then
    return
  end
  local content = "asset加载时间，记录成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "asset加载时间统计", content)
end

function UIMonitorController:btnGameObjectLoadTimeOnClick(go)
  local path = Monitor:GetInstance():GameObjectLoadTimes()
  if not path then
    return
  end
  local content = "gameobject加载时间，记录成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "gameobject加载时间统计", content)
end

function UIMonitorController:btnBigTableOnClick(go)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "提示", "此操作会造成严重卡顿，卡顿时间非常久。是否确定执行此操作", function()
    Log.error("-----------------打印大表--------------------------")
    local paths, tbs = debug.findexceedtb()
    for k, n in next, paths, nil do
      if not string.find(k, "conf.lua") then
        local tb = tbs[k]
        local strs = {
          "[exceed]",
          k,
          "\n"
        }
        for k2, v2 in next, tb, nil do
          strs[#strs + 1] = tostring(k2)
          strs[#strs + 1] = tostring("=")
          strs[#strs + 1] = tostring(v2)
          strs[#strs + 1] = tostring("\n")
        end
      end
    end
    local log = table.tostr(paths)
    local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
    local file = dir .. string.format("BigTab_%s.txt", TimeToDate2(_now()))
    Monitor:GetInstance():WriteToFile(dir, file, log)
    local content = "打印大表成功！\n保存路径：" .. file
    self:ShowDialog("UIGameStatus", "打印大表", content)
  end)
end

function UIMonitorController:btnAbDistributeOnClick(go)
end

function UIMonitorController:btnFindAssetOnClick(go)
end

function UIMonitorController:btnMutilFuncOnClick(go)
end

function UIMonitorController:btnPrintNullOnClick(go)
  local path = Monitor:GetInstance():NullObjectPrint()
  if not path then
    return
  end
  local content = "打印null对象成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "打印null对象", content)
end

function UIMonitorController:btnCPrintNullOnClick(go)
  local path = Monitor:GetInstance():CNullObjectPrint()
  if not path then
    return
  end
  local content = "C#打印null对象成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "C#打印null对象", content)
end

function UIMonitorController:btnPrintAbsOnClick(go)
  local path = Monitor:GetInstance():AllAbsPrint()
  if not path then
    return
  end
  local content = "打印所有加载的ab成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "打印所有加载的ab", content)
end

function UIMonitorController:btnPrintAbLeaksOnClick(go)
  local path = Monitor:GetInstance():AbLeaksPrint()
  if not path then
    self:ShowDialog("UIGameStatus", "无ab泄露")
    return
  end
  local content = "打印泄露的ab成功！\n保存路径：" .. path
  self:ShowDialog("UIGameStatus", "打印泄露的ab", content)
end

function UIMonitorController:btnGCOnClick(go)
  Monitor:GetInstance():GC()
end

function UIMonitorController:btnLuaObjLeakOnClick(go)
  Monitor:GetInstance():Profile()
end

function UIMonitorController:btnLuaLeakOnClick(go)
  self:ShowDialog("UILuaLeak")
end

function UIMonitorController:btnUnloadAllOnClick(go)
  Monitor:GetInstance():DisposeAll()
end

function UIMonitorController:btnUnloadImpOnClick(go)
end
