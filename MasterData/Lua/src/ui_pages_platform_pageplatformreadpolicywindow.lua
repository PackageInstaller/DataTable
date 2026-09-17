local page = class("pagePlatformReadPolicyWindow", G_UIPageBase)
local tag = page:getName()

function page.bind()
  return {
    titleText = "",
    webView = {
      moduleName = "pages/Common/Modules/webView"
    },
    grayBtn = false
  }
end

function page.methods()
  return {
    onClickBgMask = function(self)
      self:closeSelf(false)
    end,
    onClickConfirm = function(self)
      if not self.bind.grayBtn then
        self:closeSelf(true)
      end
    end,
    onClickClose = function(self)
      self:closeSelf(false)
    end
  }
end

function page:preOpen(options)
  if not options then
    return
  end
  self._onCloseHandler = options.onCloseHandler
  self.bind.titleText = tostring(options.title)
  self.modules.webView:setUrl(options.url)
  printf(tag, "openURL: " .. tostring(options.url))
  self.requireReadAll = options.requireReadAll
  if self.requireReadAll then
    self.modules.webView:setMessageHandler(function(msg)
      printf(tag, tostring(msg))
      if string.isEmpty(msg) then
        return
      end
      local data = L_Json.decode(msg)
      if data == nil then
        return
      end
      if data.type == "readAll" then
        self:setConfirmButtonInteractable(true)
      end
    end)
    self:setConfirmButtonInteractable(false)
  else
    self:setConfirmButtonInteractable(true)
  end
end

function page:close(options)
  self.modules.webView:setMessageHandler(nil)
  self.modules.webView:loadBlank()
end

function page:setConfirmButtonInteractable(interactable)
  self.bind.grayBtn = not interactable
end

function page:closeSelf(confirmed)
  L_UI:close(self.pageName, nil, function(closePageName)
    if self._onCloseHandler then
      self._onCloseHandler(confirmed)
      self._onCloseHandler = nil
    end
  end)
end

return page
