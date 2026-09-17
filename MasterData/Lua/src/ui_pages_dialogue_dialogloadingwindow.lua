local page = class("loadingWindow", require("ui.pages.common.baseLoading"))

function page.bind()
  return {progressText = "", progressValue = 0}
end

function page.methods()
  return {}
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  L_LoadingManager:addListener(L_LoadingManager.event.loadingProgressUpdate, self.updateLoading, self, self.gameObject)
  self:setValue(options and options.value)
end

function page:setValue(value)
  if not value then
    return
  end
  self.bind.progressValue = value
  self.bind.progressText = value * 100 .. "%"
end

function page:updateLoading(options)
  self:setValue(options.progress)
  if options.progress >= 100 then
    L_UI:close(self.pageName)
  end
end

function page:close()
  page.super.close(self)
  L_LoadingManager:removeListener(L_LoadingManager.event.loadingProgressUpdate, self.updateLoading)
  L_LoadingManager:addLoadingObj(L_DEF.LoadingType.DialogueChange, nil)
end

return page
