local M = Util.create_class()

function M:_init()
  self.numb = 0
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act.type == "skill" then
    self.numb = self.numb + 1
    if self.numb >= 2 then
      self.numb = 0
      cast_magic(self.npc, self.npc, 7000020401, 1)
    end
  end
end

return M
