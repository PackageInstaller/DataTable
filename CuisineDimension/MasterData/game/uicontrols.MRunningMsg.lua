local MRunningMsg = {
  messages = {},
  actions = {}
}
local GlobalRes = "ui/global/"

function MRunningMsg:show(params)
  params = params or {}
  table.insert(self.messages, params.text)
  if not display.getRunningScene():getChildByTag(MRUNNING_MSG_TAG) then
    self.bg = display.newSprite(GlobalRes .. "world_notice_bg.png")
    self.bg:pos(display.width / 2 + 100, display.height - 62):addTo(display.getRunningScene(), MSGBOX_LAYER_ORDER, MRUNNING_MSG_TAG)
    self.bg:onNodeEvent("exit", function()
      self.messages = {}
      self.actions = {}
    end)
    self.size = self.bg:getContentSize()
    self.content = ccui.Layout:create()
    self.content:size(self.size.width - 20, self.size.height):anch(0.5, 0.5):center(self.bg):addTo(self.bg)
    self.content:setClippingEnabled(true)
  end
  if #self.actions == 0 or #self.messages == 1 then
    self:showText()
  end
end

function MRunningMsg:showText()
  local text = self.messages[1]
  if not text then
    return
  end
  local label = MRichText.new({text = text, size = 16})
  label:anch(0, 0.5):pos(self.size.width, self.size.height / 2 + 1):addTo(self.content)
  local offset = label:getContentSize().width + 30
  local time = offset / (offset + self.size.width) * 10
  local action = label:runAction(transition.sequence({
    cc.MoveBy:create(time, cc.p(-offset, 0)),
    cc.CallFunc:create(function()
      table.remove(self.messages, 1)
      self:showText()
    end),
    cc.MoveBy:create(10 - time, cc.p(-self.size.width, 0)),
    cc.CallFunc:create(function()
      self:exit()
    end),
    cc.RemoveSelf:create()
  }))
  table.insert(self.actions, action)
end

function MRunningMsg:exit()
  table.remove(self.actions, 1)
  if #self.actions > 0 then
    return
  end
  if not tolua.isnull(self.bg) then
    self.bg:removeSelf()
  end
end

return MRunningMsg
