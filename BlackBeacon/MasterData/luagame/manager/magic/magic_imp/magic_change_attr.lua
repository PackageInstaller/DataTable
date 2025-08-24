local Base = require("manager.magic.magic_imp.magic_base")
local FightDefine = require("cs_share.fight_define")
local CommDefine = require("cs_share.common_define")
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")
local M = Util.create_child_mt(Base)
local SET_TYPE = Config.ATTR_SET_TYPE
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local RATIO_TYPE = Config.RATIO_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local VALUE_TYPE = CommDefine.VALUE_TYPE

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  MagicEffectFunc.call_effect_func_by_object(self)
end

function M:on_remove()
end

return M
