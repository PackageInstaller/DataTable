local page = class("pageTimeline", G_UIPageBase)

function page:bind()
  return {showSkipButton = false, subtitleText = ""}
end

function page:methods()
  return {
    skipClick = function(self)
      self:onSkipVideo()
    end
  }
end

function page:onSkipVideo()
  self:playVideoEnd()
end

function page:playVideoEnd()
  if self.callback then
    self.callback()
  end
  if self.subtitleMiddleware and not self.subtitleMiddleware:IsNull() then
    self.subtitleMiddleware:Clear()
  end
  self.subtitleMiddleware = nil
end

function page:escHandle()
end

function page:close()
end

function page:preOpen(options)
  self.super.preOpen(self, options)
  self.bind.showSkipButton = options.showSkipButton
  self.storyId = options.storyId
  self.callback = options.callback
  self.subtitleMiddleware = options.subtitleMiddleware
  self:showText()
  
  function self.subtitleMiddleware.onChangeShowSubtitle()
    self:showText()
  end
end

function page:showText()
  if not self.subtitleMiddleware or self.subtitleMiddleware:IsNull() then
    return
  end
  local text = ""
  if self.subtitleMiddleware.subtitleText then
    local subtitleNum = tonumber(self.subtitleMiddleware.subtitleText)
    text = self.subtitleMiddleware.subtitleText
    if subtitleNum then
      local textConf = L_Config:getConfigDirectly("dialogue_timeline")[subtitleNum]
      if not textConf then
      else
        local ckey = textConf.content
        text = L_Lang:get(ckey)
      end
    end
  end
  self.bind.subtitleText = text
end

return page
