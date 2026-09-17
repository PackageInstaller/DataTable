local page = class("dialogBranchWindow_NewStory", G_UIPageBase)

function page.bind()
  return {
    selectButtonList = {
      moduleName = "pages/dialogue/branchButtonItem"
    },
    buttonsActive = true,
    bgActive = true
  }
end

function page.methods()
  return {
    dragBegin = function(self, pos)
    end,
    drag = function(self, pos)
    end,
    dragEnd = function(self, pos)
    end
  }
end

return page
