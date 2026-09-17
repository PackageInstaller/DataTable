local cls = class("webView", G_UIModuleBase)
local tag = cls:getName()
local CLEAR_STORAGE_SCRIPT = [[
(function(){
    try { if (window.localStorage) { window.localStorage.clear(); } } catch (e) {}
    try { if (window.sessionStorage) { window.sessionStorage.clear(); } } catch (e) {}
})();
]]

function cls:ctor(...)
  cls.super.ctor(self, ...)
  self._hdl_onWebViewInitialized = handler(self, self.onWebViewInitialized)
  self._hdl_onWebViewMessageEmitted = handler(self, self.onWebViewMessageEmitted)
  self._hdl_onLoadProgressChanged = handler(self, self.onLoadProgressChanged)
  self._hdl_onPageLoadFailed = handler(self, self.onPageLoadFailed)
  self._jsBridgeScript = nil
  self._jsBridgeInjectBeforeLoad = false
  self._isPageLoadScriptAdded = false
  self._clearStorageBeforeLoad = false
  self._isClearStorageScriptAdded = false
  self._url = nil
  self._isUrlLoaded = false
end

function cls.bind()
  return {
    url = "",
    resolution = 1,
    dragMode = 0,
    scrollingSensitivity = 200,
    dragThreshold = 20,
    loadingView = {
      moduleName = "pages/Common/Modules/loadingView"
    }
  }
end

function cls.methods()
  return {}
end

function cls:open()
  self.modules.loadingView:doHide()
  self._webViewPrefab = self.bindComponents.WebViewPrefab
  if Unity.Application.IsMobilePlatformForUI then
    self.bind.resolution = 1
    self.bind.dragMode = 0
  else
    self.bind.resolution = 0.5
    self.bind.dragMode = 1
  end
  self.isShowLoading = true
  if self._webViewPrefab.WebView ~= nil then
    self:registerWebViewEvents()
    self:applyClearStorageScript()
    self:loadPendingUrl()
  else
    self._webViewPrefab:Initialized("+", self._hdl_onWebViewInitialized)
  end
end

function cls:close()
  self.modules.loadingView:doHide()
  self:unregisterWebViewEvents()
  self._isUrlLoaded = false
  self._url = nil
end

function cls:setResolution(resolution)
  self.bind.resolution = resolution
end

function cls:showLoading(isShowLoading)
  self.isShowLoading = isShowLoading
end

function cls:registerWebViewEvents()
  if self._webViewPrefab.WebView ~= nil then
    self._webViewPrefab.WebView:MessageEmitted("+", self._hdl_onWebViewMessageEmitted)
    self._webViewPrefab.WebView:LoadProgressChanged("+", self._hdl_onLoadProgressChanged)
    self._webViewPrefab.WebView:LoadFailed("+", self._hdl_onPageLoadFailed)
  end
end

function cls:unregisterWebViewEvents()
  if self._webViewPrefab.WebView ~= nil then
    self._webViewPrefab.WebView:MessageEmitted("-", self._hdl_onWebViewMessageEmitted)
    self._webViewPrefab.WebView:LoadProgressChanged("-", self._hdl_onLoadProgressChanged)
    self._webViewPrefab.WebView:LoadFailed("-", self._hdl_onPageLoadFailed)
  end
end

function cls:loadBlank()
  self.bind.url = "about:blank"
end

function cls:appendCacheBusterIfNeeded(url)
  if not self._clearStorageBeforeLoad then
    return url
  end
  local ts = tostring(CS.System.DateTimeOffset.UtcNow:ToUnixTimeMilliseconds())
  if string.find(url, "?", 1, true) then
    return url .. "&_wv_clear_ts=" .. ts
  end
  return url .. "?_wv_clear_ts=" .. ts
end

function cls:clearStorageImmediately()
  if self._webViewPrefab == nil or self._webViewPrefab.WebView == nil then
    return
  end
  if self._webViewPrefab.WebView.ExecuteJavaScript == nil then
    return
  end
  self._webViewPrefab.WebView:ExecuteJavaScript(CLEAR_STORAGE_SCRIPT)
end

function cls:loadUrlDirectly(url)
  if self._webViewPrefab == nil then
    return false
  end
  if self._webViewPrefab.WebView ~= nil then
    self._webViewPrefab.InitialUrl = ""
    self._webViewPrefab.WebView:LoadUrl(url)
    return true
  end
  self.bind.url = url
  return true
end

function cls:setUrl(url)
  self._url = url
  self._isUrlLoaded = false
  if self._clearStorageBeforeLoad then
    self:applyClearStorageScript()
    self:loadPendingUrl()
    return
  end
  self.bind.url = url
  if self._jsBridgeInjectBeforeLoad then
    self:applyPageLoadScript()
  end
end

function cls:loadPendingUrl()
  if not self._clearStorageBeforeLoad then
    return
  end
  if self._isUrlLoaded then
    return
  end
  if self._url == nil or self._url == "" then
    return
  end
  if self._webViewPrefab == nil or self._webViewPrefab.WebView == nil then
    return
  end
  self:applyClearStorageScript()
  self:clearStorageImmediately()
  local loadUrl = self:appendCacheBusterIfNeeded(self._url)
  if self:loadUrlDirectly(loadUrl) then
    self._isUrlLoaded = true
  end
end

function cls:onWebViewInitialized(sender, args)
  self._webViewPrefab:Initialized("-", self._hdl_onWebViewInitialized)
  self:registerWebViewEvents()
  if self._clearStorageBeforeLoad then
    self._webViewPrefab.InitialUrl = ""
  end
  self:applyClearStorageScript()
  if self._jsBridgeInjectBeforeLoad then
    self:applyPageLoadScript()
  end
  self:loadPendingUrl()
end

function cls:onLoadProgressChanged(sender, args)
  if self.modules.loadingView == nil then
    return
  end
  local changeType = CS.System.Convert.ToInt32(args.Type)
  if changeType == 0 then
    printf(tag, "onLoadProgressChanged: Started")
    if self.isShowLoading then
      self.modules.loadingView:doShow()
    end
  elseif changeType == 1 then
    printf(tag, "onLoadProgressChanged: Finished")
    self.modules.loadingView:doHide()
    if not self._jsBridgeInjectBeforeLoad then
      self:applyJsBridgeScript()
    end
  end
end

function cls:onPageLoadFailed(sender, args)
  printf(tag, "onPageLoadFailed")
end

function cls:onWebViewMessageEmitted(sender, args)
  printf(tag, "onWebViewMessageEmitted")
  if self._messageHandler then
    self._messageHandler(args.Value)
  end
end

function cls:setMessageHandler(handler)
  self._messageHandler = handler
end

function cls:setClearStorageBeforeLoad(enabled)
  self._clearStorageBeforeLoad = enabled == true
  self._isClearStorageScriptAdded = false
  if self._clearStorageBeforeLoad then
    self:applyClearStorageScript()
  end
end

function cls:applyClearStorageScript()
  if not self._clearStorageBeforeLoad then
    return
  end
  if self._isClearStorageScriptAdded then
    return
  end
  if self._webViewPrefab == nil or self._webViewPrefab.WebView == nil then
    return
  end
  local pageLoadScripts = self._webViewPrefab.WebView.PageLoadScripts
  if pageLoadScripts == nil or pageLoadScripts.Add == nil then
    printf(tag, "PageLoadScripts接口不存在，无法加载前清理页面存储")
    return
  end
  pageLoadScripts:Add(CLEAR_STORAGE_SCRIPT)
  self._isClearStorageScriptAdded = true
end

function cls:setJsBridgeScript(jsBridgeScript, injectBeforeLoad)
  self._jsBridgeScript = jsBridgeScript
  self._jsBridgeInjectBeforeLoad = injectBeforeLoad == true
  self._isPageLoadScriptAdded = false
  if self._jsBridgeInjectBeforeLoad then
    self:applyPageLoadScript()
  end
end

function cls:applyJsBridgeScript()
  if self._jsBridgeScript == nil or self._jsBridgeScript == "" then
    return
  end
  if self._webViewPrefab == nil or self._webViewPrefab.WebView == nil then
    return
  end
  if self._webViewPrefab.WebView.ExecuteJavaScript == nil then
    printf(tag, "ExecuteJavaScript接口不存在，无法注入jsBridge脚本")
    return
  end
  self._webViewPrefab.WebView:ExecuteJavaScript(self._jsBridgeScript)
end

function cls:applyPageLoadScript()
  if self._jsBridgeScript == nil or self._jsBridgeScript == "" then
    return
  end
  if self._webViewPrefab == nil or self._webViewPrefab.WebView == nil then
    return
  end
  local pageLoadScripts = self._webViewPrefab.WebView.PageLoadScripts
  if pageLoadScripts == nil or pageLoadScripts.Add == nil then
    printf(tag, "PageLoadScripts接口不存在，无法加载前注入jsBridge脚本")
    return
  end
  if self._isPageLoadScriptAdded then
    return
  end
  pageLoadScripts:Add(self._jsBridgeScript)
  self._isPageLoadScriptAdded = true
end

return cls
