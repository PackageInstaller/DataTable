local Base = require("manager.magic.magic_imp.magic_base")
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect(magic_list)
  MagicEffectFunc.call_effect_func_by_object(self)
end

function M:on_remove(magic_mgr, magic_list)
end

return M
