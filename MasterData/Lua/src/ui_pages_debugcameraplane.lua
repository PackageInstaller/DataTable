local page = class("debugCameraPlane", G_UIPageBase)
local tag = "page:debugCameraPlane"

function page.bind()
  return {}
end

function page:preOpen(options)
  if options then
    self.bind.callback = options.callback
  end
end

function page:update()
end

return page
