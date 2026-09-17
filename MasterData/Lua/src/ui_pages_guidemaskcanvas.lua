local page = class("guideMaskCanvas", G_UIPageBase)
local tag = "page:guideMaskCanvas"

function page:created(...)
  printf(tag, "created")
  page.super.created(self, ...)
end

function page:preBind()
end

function page.bind()
  return {focusTran = nil}
end

function page.methods()
  return {
    onSkipButton = function()
      G_GuideManager:endGuide()
    end
  }
end

function page:preOpen(options)
  self.bind.focusTran = options.focusObj
  printf(tag, "open" .. table.tostring(options))
  page.super.open(self, options)
end

function page:show(options)
  printf(tag, "show")
end

function page:hide()
  printf(tag, "hide")
end

function page:close(options)
  printf(tag, "close")
end

function page:destroy(options)
  printf(tag, "destroy")
end

function page:update()
end

return page
