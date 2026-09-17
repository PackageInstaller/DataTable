local this = class("pageRewardTitle", G_UIPageBase)

function this.bind()
  return {upText = "", titleText = ""}
end

function this.methods()
  return {
    onClick_close = function(self)
      if self.rewardTitle ~= nil and #self.rewardTitle > 0 then
        self.bindComponents.anime:Play("anim_reward_in")
        self:refreshShowOne()
      else
        L_UI:close(self.pageName)
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._onEvent_storyStartHandle = handler(self, self.onEvent_storyStartHandle)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
  self._onEvent_storyEndHandle = handler(self, self.onEvent_storyEndHandle)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryEnd, self._onEvent_storyEndHandle)
  self.rewardTitle = nil
  self.callback = options.callback
  if options.titleList then
    self.rewardTitle = options.titleList
    self:refreshShowOne()
  end
end

function this:close(options)
  this.super.close(self, options)
  if self._onEvent_storyStartHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
    self._onEvent_storyStartHandle = nil
  end
  if self._onEvent_storyEndHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryEnd, self._onEvent_storyEndHandle)
    self._onEvent_storyEndHandle = nil
  end
  if self.callback then
    self.callback()
  end
end

function this:refreshShowOne()
  self.showTitle = self.rewardTitle[1]
  table.remove(self.rewardTitle, 1)
  self:refreshReward(self.showTitle)
end

function this:refreshReward(titleItem)
  if titleItem == nil then
    return
  end
  self.bind.upText = L_WordsTpl:getValue(string.format("ui_playertitle_type%s", titleItem.parseData.showType))
  self.bind.titleText = titleItem.parseData.name
end

function this:onEvent_storyStartHandle()
  L_UI:hide(self.pageName)
end

function this:onEvent_storyEndHandle()
end

return this
