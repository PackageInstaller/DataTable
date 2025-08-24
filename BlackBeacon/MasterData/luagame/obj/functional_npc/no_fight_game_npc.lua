local Base = require("obj.functional_npc.functional_npc")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
end

function M:presetup(...)
  Base.presetup(self)
end

function M:setup(...)
  Base.setup(self, ...)
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
end

function M:update()
  Base.update(self)
end

function M:on_destroy_luaobj()
  Base.on_destroy_luaobj(self)
end

function M:on_destroy()
  Base.on_destroy(self)
end

return M
