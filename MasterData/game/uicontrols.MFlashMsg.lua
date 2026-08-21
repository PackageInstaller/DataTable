local MFlashMsg = {
  messages = {},
  lastMessage = nil
}

function MFlashMsg:show(params)
  params = params or {}
  local text = params.text or ""
  local color = params.color or display.COLOR_WHITE
  if self.lastMessage and not tolua.isnull(self.lastMessage) then
    self.lastMessage:stopAllActions()
    self.lastMessage:runAction(transition.sequence({
      cc.Spawn:create({
        cc.MoveBy:create(0.5, cc.p(0, 100)),
        cc.FadeOut:create(0.5)
      }),
      cc.RemoveSelf:create()
    }))
  end
  local bg = display.newSprite("ui/global/flash_bg.png")
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  bg:pos(cx, display.cy + 30):addTo(display.getRunningScene(), MSGBOX_LAYER_ORDER)
  self.lastMessage = bg
  local richText = MRichText.new({text = text, color = color})
  richText:anch(0.5, 0.5):center(bg):addTo(bg)
  local actions = {}
  actions[#actions + 1] = cc.DelayTime:create(2)
  actions[#actions + 1] = cc.CallFunc:create(function()
    self.lastMessage = nil
  end)
  actions[#actions + 1] = cc.Spawn:create({
    cc.MoveBy:create(0.5, cc.p(0, 100)),
    cc.FadeOut:create(0.5)
  })
  actions[#actions + 1] = cc.RemoveSelf:create()
  bg:runAction(transition.sequence(actions))
  if not params.skipMusic then
    game:playMusic(1001)
  end
end

return MFlashMsg
