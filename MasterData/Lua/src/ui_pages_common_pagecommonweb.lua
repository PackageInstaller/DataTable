local this = class("pageCommonWeb", G_UIPageBase)

function this.bind()
  return {
    txtTitle = "",
    webView = {
      moduleName = "pages/common/modules/webView"
    }
  }
end

function this.methods()
  return {
    btnClose = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(option)
  local url = option.url
  local resolution = option.resolution or 1
  local showLoading = option.showLoading == true
  local title = option.title
  local jsBridgeScript = option.jsBridgeScript
  local jsBridgeInjectBeforeLoad = option.jsBridgeInjectBeforeLoad == true
  local clearStorageBeforeLoad = option.clearStorageBeforeLoad == true
  self.callback = option.callback
  self.bind.txtTitle = title
  self.modules.webView:setResolution(resolution)
  self.modules.webView:showLoading(showLoading)
  if self.modules.webView.setClearStorageBeforeLoad ~= nil then
    self.modules.webView:setClearStorageBeforeLoad(clearStorageBeforeLoad)
  end
  if self.modules.webView.setJsBridgeScript ~= nil then
    self.modules.webView:setJsBridgeScript(jsBridgeScript, jsBridgeInjectBeforeLoad)
  end
  if self.messageHandler == nil then
    self.messageHandler = handler(self, self.onMessageHandler)
  end
  self.modules.webView:setMessageHandler(self.messageHandler)
  self.modules.webView:setUrl(url)
end

function this:close()
  if self.callback then
    self.callback()
  end
end

function this:escHandle()
  if not L_DeviceTpl:getIsPc() then
    return
  end
  local data_tip = {
    txtContent = L_WordsTpl:getValue("ui_systemMessage_08"),
    confirmCallback = function()
      L_UI:close(self.pageName)
    end
  }
  L_GameUtil.showCommonTip(data_tip)
end

function this:onMessageHandler(message)
  local ok, err = pcall(function()
    CS.Lens.Gameplay.UI.WebView.WebViewManager.HandleMessageEmitted(message)
  end)
  if not ok then
    printf("pageCommonWeb onMessageHandler error: %s", tostring(err))
  end
end

return this
