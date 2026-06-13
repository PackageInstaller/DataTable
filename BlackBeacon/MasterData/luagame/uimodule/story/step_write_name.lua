local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local STORY_CONFIG = require("uimodule.story.story_config")

function M:_init(...)
  Base._init(self, ...)
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_uiobjects.Branch_List:SetActive(false)
end

function M:start()
  self:init_ui()
  self:open_write_name_pnl()
end

function M:init_ui()
  self.v_uiobjects.Up:SetActive(false)
end

function M:open_write_name_pnl()
  local function cb()
    self:on_complete()
    
    self.v_uiobjects.Up:SetActive(true)
  end
  
  local change_name_num = PlayerMgr:get_player_rename_num()
  if change_name_num and change_name_num > 0 then
    cb()
    return
  end
  UIMgr:try_hide_ui("uistory_change_name")
  UIMgr:get_ui("uistory_change_name"):ui_show(cb)
end

function M:on_complete()
  self:complete()
end

return M
