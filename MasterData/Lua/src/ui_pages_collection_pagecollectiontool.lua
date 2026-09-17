local this = class("pageCollectionTool", G_UIPageBase)

function this.bind()
  return {}
end

function this:preOpen(options)
  L_UI:close(self.pageName)
end

return this
