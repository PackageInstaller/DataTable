local page = class("dialogStoryBriefWindow", G_UIPageBase)

function page.bind()
  return {storyBrief = ""}
end

function page.methods()
  return {
    btn_cancel = function(self)
    end,
    btn_skip = function(self)
    end
  }
end

function page.preOpen(options)
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.txt_brief.fontSize = 28
  else
    self.bindComponents.txt_brief.fontSize = 30
  end
end

return page
