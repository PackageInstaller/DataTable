local this = class("taskPageMask", G_UIPageBase)

function this.bind()
  return {
    raycast = false,
    blockColor = C_Color(0, 0, 0, 1)
  }
end

function this.methods()
  return {}
end

function this:show(options)
end

function this:close()
end

return this
