local UIPanelAssetList = CommonRes.UIPanelAssetList
local UIAsyncLoadMgr = System.NewClass("UIAsyncLoadMgr")
local tempPanels = {}

function UIAsyncLoadMgr:ctor(binder)
  self.panels = {}
  self.permanentPanels = {}
end

function UIAsyncLoadMgr:SetPermanent(url)
  self.permanentPanels[url] = true
end

function UIAsyncLoadMgr:StopPermanent(url)
  self.permanentPanels[url] = nil
end

function UIAsyncLoadMgr:IsPermanent(url)
  return self.permanentPanels[url]
end

function UIAsyncLoadMgr:ClearPermanents()
  self.permanentPanels = {}
end

function UIAsyncLoadMgr:IsAsyncLoaded(url)
  return UIAsyncUrls[url]
end

function UIAsyncLoadMgr:PreCreatePanels()
  for k, _ in pairs(UIPanelAssetList) do
    if not self.panels[k] then
      self:SetPermanent(k)
      self:PrecreatePanel(k)
    end
  end
end

function UIAsyncLoadMgr:PrecreatePanel(url)
  local panel = self:TryCreatePanel(url)
  panel:Precreate(url)
end

function UIAsyncLoadMgr:OpenPanel(url, ...)
  local panel = self:TryCreatePanel(url)
  if panel:IsOpened() then
    return panel
  end
  panel:Open(...)
  local gamePanel = UIManager.Instance:GetWindow(url)
  if gamePanel then
    return gamePanel
  end
  return panel.bridge
end

function UIAsyncLoadMgr:IsOpened(url)
  if not self.panels then
    return false
  end
  local panel = self.panels[url]
  return nil ~= panel and panel:IsOpened()
end

function UIAsyncLoadMgr:ReopenPanel(url, ...)
  local panel = self:TryCreatePanel(url)
  panel:Reopen(...)
  local gamePanel = UIManager.Instance:GetWindow(url)
  if gamePanel then
    return gamePanel
  end
  return panel.bridge
end

function UIAsyncLoadMgr:TryCreatePanel(url)
  local panel = self.panels[url]
  if not panel then
    local panelCls = UIAsyncUrls[url].PanelCls or UIAsyncLoadPanel
    panel = panelCls(url)
    self.panels[url] = panel
  end
  return panel
end

function UIAsyncLoadMgr:ClosePanel(url)
  if not self.panels then
    return
  end
  local panel = self.panels[url]
  if not panel then
    return
  end
  panel:Close()
end

function UIAsyncLoadMgr:Update()
  local temp = self:GetTempPanels()
  if not temp then
    return
  end
  for k, v in pairs(temp) do
    if not v:IsOpened() and not self:IsPermanent(k) and v:TryDestroy() then
      self.panels[k] = nil
    end
  end
end

function UIAsyncLoadMgr:GetPanel(url)
  if self.panels then
    return self.panels[url]
  end
end

function UIAsyncLoadMgr:ClearUnusedPanels()
  self:ClearPermanents()
  if self.panels then
    local temp = self:GetTempPanels()
    for url, v in pairs(temp) do
      local isAsyncLoadPanelOpend = System.is(v, UIAsyncLoadPanel) and v:IsOpened()
      local isNormalPanelOpend = System.is(v, UIBasePanel) and UIManager.Instance:GetWindow(url)
      Logger.Info("ClearUnusedPanels url:%s isAsyncLoadPanelOpend:%s, isNormalPanelOpend:%s", url, isAsyncLoadPanelOpend, isAsyncLoadPanelOpend)
      if not isAsyncLoadPanelOpend and not isNormalPanelOpend then
        self.panels[url] = nil
        v:Destroy()
      end
    end
  end
end

function UIAsyncLoadMgr:ClearAll()
  if self.panels then
    for _, v in pairs(self.panels) do
      v:Destroy()
    end
    self.panels = nil
  end
end

function UIAsyncLoadMgr:GetTempPanels()
  if not self.panels then
    return
  end
  table.clear(tempPanels)
  table.mergeWithoutGc(tempPanels, self.panels)
  return tempPanels
end

UIAsyncLoadMgr.Instance = UIAsyncLoadMgr()
return UIAsyncLoadMgr
