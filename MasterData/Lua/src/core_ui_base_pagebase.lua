local page = class("pageBase", G_UIBase)

function page:reCreated(obj, options)
end

function page:created(obj, config, binderData)
  self.gameObject = obj
  if binderData ~= nil and type(binderData) == "function" then
    self.bind = self:mergeData(self.bind, binderData())
  end
  if self.bind then
    self.bind = self.bind()
  end
  if self.methods then
    self.methods = self.methods()
  end
  if self.preBind then
    self:preBind()
  end
  page.super.created(self, self.uiBinding)
end

function page:preOpen(options)
end

function page:refreshPageView(options)
end

function page:refreshPagePanel(options)
end

function page:destroy(options)
end

function page:close(options)
  if self.pageName ~= nil and self.pageName ~= "" and L_ShortCutManager then
    L_ShortCutManager:removeShortCut(self.pageName)
  end
  page.super.close(self, options)
end

return page
