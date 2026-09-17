local page = class("TemplatePage", G_UIPageBase)
local tag = "page:TemplatePage"

function page:created(...)
  printf(tag, "created")
  page.super.created(self, ...)
end

function page:preBind()
end

function page.bind()
  return {
    title = "",
    scrollList = {
      {
        id = 1,
        name = "",
        level = ""
      },
      {id = 2}
    }
  }
end

function page.methods()
  return {
    onTestClick = function(self)
      printf(tag, "onTestClick")
    end
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
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
