local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local BLACK_MAX_NUM = ShareRes.get_system_comm_value("BlacklistNumLimit")
local PLAYER_BLACK_OBJ_KEY = "PLAYER_BLACK_OBJ_KEY"

function ui:ui_finish_load()
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(PLAYER_BLACK_OBJ_KEY, self.v_uiobjects.BlackTem, self.v_uiobjects.BlackLIst)
  self.v_black_item_list = {}
end

function ui:ui_on_show()
  self:update_black_list()
end

function ui:update_black_list()
  self:remove_wrap_list()
  self.v_blcak_list = FriendMgr:get_friend_black_list()
  local num = #self.v_blcak_list
  self.v_uiobjects.None:SetActive(0 == num)
  self.v_uicompents.SetBlackLimit_txt.text = "(" .. num .. "/" .. BLACK_MAX_NUM .. ")"
  self:give_back_auto_cache(PLAYER_BLACK_OBJ_KEY)
  for _, data in ipairs(self.v_blcak_list) do
    local item = self:get_auto_cache(PLAYER_BLACK_OBJ_KEY)
    self:set_item_data(item, data)
    table.insert(self.v_black_item_list, item)
  end
end

function ui:set_item_data(item, data)
  local head_icon = Util.get_image("Profile", Util.get_child_gameobj("ProfileBg", item))
  local lv_bg = Util.get_child_gameobj("LVBg", Util.get_child_gameobj("ProfileBg", item))
  local head_btn = Util.get_button("ProfileBg", item)
  local player_lv = Util.get_text("LV", lv_bg)
  local player_name = Util.get_text("PlayerName", item)
  local del_btn = Util.get_button("BtnDel", item)
  Util.load_char_head_icon(head_icon, data.icon)
  player_lv.text = data.lv
  player_name.text = data.name
  
  local function cb()
    self:update_black_list()
  end
  
  self:set_button_listener(del_btn, function()
    local function callback()
      FriendMgr:remove_friend_black_list(data.uuid, cb)
    end
    
    local stip = Util.get_i18n("是否解除屏蔽“{1}”")
    stip = Util.format_str(stip, data.name)
    UIMgr:get_ui("uinotice_tips"):ui_show(callback, nil, stip)
  end)
  self:set_button_listener(head_btn, function()
    UIMgr:get_ui("ui_player_info"):ui_show(data)
  end)
end

function ui:cache_ui()
  return true
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:remove_wrap_list()
  for _, obj in pairs(self.v_black_item_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_black_item_list = {}
end

function ui:ui_on_destroy()
end

return ui
