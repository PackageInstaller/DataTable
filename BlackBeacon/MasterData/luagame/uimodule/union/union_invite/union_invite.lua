local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local ItemClass = require("uimodule.union.union_invite.union_invite_item")
local UnionCfg = require("uimodule.union.union_config")
local UnionHelper = require("uimodule.union.union_helper")
local CT_Timer = Global.ct_timer
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_clear = {
    "BtnClear",
    BIND_TYPE.BUTTON
  },
  v_btn_refresh = {
    "BtnRefresh",
    BIND_TYPE.BUTTON
  },
  v_btn_search = {
    "BtnSearch",
    BIND_TYPE.BUTTON
  },
  v_search_input = {
    "Message",
    BIND_TYPE.INPUT
  }
}
local REFRESH_CD = UnionCfg.INVITE_LIST_REFRESH_CD

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClear", function()
    self:_onclick_clear_btn()
  end)
  self:set_button("BtnRefresh", function()
    self:_onclick_refresh_list()
  end)
  self:set_button("BtnSearch", function()
    self:_onclick_search_btn()
  end)
  self:set_inputfield_listener(self.v_search_input, function()
    self:_on_input()
  end, function()
    self:_on_input_end()
  end)
  self.v_refresh_lab = self:get_text("Text", self.v_btn_refresh.gameObject)
  self.v_list_view = LoopListClass:new(self, self.v_uiobjects.InviteScroll, ItemClass, nil, true)
end

function ui:ui_on_show()
  self.v_search_input.text = ""
  self.v_search_target = ""
  self.v_uiobjects.BtnClear:SetActive(false)
  self.v_last_rf_time = Date.server_time()
  self.v_refresh_lab.text = Util.format_str("刷新列表")
  UnionMgr:request_get_no_union_players(function(list)
    self.v_list_view:refresh_data(list)
  end)
  self:_regist_client_event()
end

function ui:ui_on_hide()
  self.v_list_view:ui_on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
end

function ui:ui_on_destroy()
  self.v_list_view:ui_on_destroy()
end

function ui:_regist_client_event()
end

function ui:_on_input()
  local len = Util.get_string_len(self.v_search_input.text)
  self.v_uiobjects.BtnClear:SetActive(len > 0)
end

function ui:_on_input_end()
  self.v_search_target = self.v_search_input.text
end

function ui:_onclick_search_btn()
  if not self.v_search_target or self.v_search_target == "" then
    return
  end
  local input_txt = self.v_search_target
  if string.sub(self.v_search_target, 1, 1) == "#" then
    input_txt = string.gsub(self.v_search_target, "#", "")
    if tonumber(input_txt) then
      input_txt = tonumber(input_txt)
    end
  end
  
  local function callback(list)
    self.v_list_view:refresh_data(list)
  end
  
  if "string" == type(input_txt) then
    UnionMgr:request_search_no_union_players(nil, input_txt, callback)
  elseif type(input_txt) == "number" then
    UnionMgr:request_search_no_union_players(input_txt, nil, callback)
  end
end

function ui:_onclick_clear_btn()
  local need_refresh = self.v_search_target ~= ""
  self.v_search_target = ""
  self.v_search_input.text = ""
  if not need_refresh then
    return
  end
  self.v_list_view:refresh_data(UnionMgr:get_player_list())
end

function ui:_onclick_refresh_list()
  if Date.server_time() - self.v_last_rf_time < REFRESH_CD then
    Util.show_message_tip(2302)
    return
  end
  self.v_last_rf_time = Date.server_time()
  Util.disable_btn(self.v_btn_refresh, true)
  self.v_refresh_lab.text = Util.format_str("刷新列表({1}s)", REFRESH_CD)
  self.v_reset_timer = CT_Timer:add_timer("refresh_timer", REFRESH_CD, function(sec)
    if sec > 0 then
      self.v_refresh_lab.text = Util.format_str("刷新列表({1}s)", sec)
    else
      if self.v_reset_timer then
        CT_Timer:remove_timer(self.v_reset_timer)
        self.v_reset_timer = nil
      end
      Util.enable_btn(self.v_btn_refresh)
      self.v_refresh_lab.text = Util.format_str("刷新列表")
    end
  end)
  UnionMgr:request_get_no_union_players(function(list)
    self.v_list_view:refresh_data(list)
  end)
end

return ui
