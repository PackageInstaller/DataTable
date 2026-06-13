local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_RING_CARD_MAIN = "TEMPLATE_RING_CARD_MAIN"
local TEMPLATE_RING_CARD_TYPE = "TEMPLATE_RING_CARD_TYPE"
local TEMPLATE_RING_PAGE = "TEMPLATE_RING_PAGE"
local CARD_OBJ = require("uimodule.stage_activity.challenge_ring_plus.card_obj")
local CARD_TYPE_OBJ = require("uimodule.stage_activity.challenge_ring_plus.card_type_obj")

local function _sort_func(a, b)
  if a.Id ~= b.Id then
    return a.Id < b.Id
  else
    return false
  end
end

function ui:on_click_type_icon(type)
  self.v_select_type = type
  local card_cfg = self.v_card_dict[type]
  self:set_select_card(card_cfg)
end

function ui:on_click_card(card_cfg)
  self.v_select_type = card_cfg.TypeID
  self:set_select_card(card_cfg)
end

function ui:ui_finish_load()
  self.v_card_obj_list = {}
  self.v_card_type_obj_list = {}
  self.v_page_list_list = {}
  self:register_exist_auto_template(TEMPLATE_RING_CARD_MAIN, self.v_uiobjects.ChalRingCard, self.v_uiobjects.Content)
  self:register_exist_auto_template(TEMPLATE_RING_CARD_TYPE, self.v_uiobjects.TypeTem, self.v_uiobjects.TypeList)
  self:register_exist_auto_template(TEMPLATE_RING_PAGE, self.v_uiobjects.PageTem, self.v_uiobjects.PageLayout)
  self:set_button("BtnRet1", function()
    if self.v_is_show_detail then
      self:set_detail_state(false)
    else
      self:ui_hide()
    end
  end)
  self:set_button("BtnMain", function()
    self:set_detail_state(false)
    UIMgr:go_to_main()
  end)
  self:set_button("BtnLast", function()
    self:set_show_img(false)
  end)
  self:set_button("BtnNext", function()
    self:set_show_img(true)
  end)
end

function ui:ui_on_show()
  self.v_uiobjects.CardDetail:SetActive(false)
  self.v_uiobjects.TypeList:SetActive(false)
  self.v_uiobjects.BottomMask:SetActive(false)
  self.v_uiobjects.Content.transform:SetLocalPositionA(0, 0, 0)
  self.v_uiobjects.CardLayout:SetActive(true)
  self.v_card_cfgs = ShareRes.create("activity.curse_card_atlas")
  if not self.v_card_cfgs then
    return
  end
  self:refersh_data()
  self:refersh_main_ui()
  self:refersh_bottom_ui()
end

function ui:refersh_data()
  self.v_card_list = {}
  self.v_card_dict = {}
  for key, card_cfg in pairs(self.v_card_cfgs) do
    table.insert(self.v_card_list, card_cfg)
    self.v_card_dict[card_cfg.TypeID] = card_cfg
  end
  table.sort(self.v_card_list, _sort_func)
end

function ui:ui_on_hide()
  self.v_select_type = nil
  self:remove_obj(self.v_card_obj_list)
  self:remove_obj(self.v_card_type_obj_list)
  self.v_page_list_list = {}
end

function ui:refersh_main_ui()
  self:give_back_auto_cache(TEMPLATE_RING_CARD_MAIN)
  self:remove_obj(self.v_card_obj_list)
  for index, card_cfg in ipairs(self.v_card_list) do
    local item = self:get_auto_cache(TEMPLATE_RING_CARD_MAIN)
    self.v_card_obj_list[index] = CARD_OBJ:ui_wrap_ex(self, item, true)
    self.v_card_obj_list[index]:set_data(nil, true, card_cfg)
  end
end

function ui:refresh_detail_ui()
  if not self.v_card_detauk_obj then
    self.v_card_detauk_obj = CARD_OBJ:ui_wrap_ex(self, self.v_uiobjects.CardShow.gameObject, true)
  end
  self.v_card_detauk_obj:set_data(nil, true, self.v_select_card_cfg, true)
  self:give_back_auto_cache(TEMPLATE_RING_PAGE)
  self.v_page_list_list = {}
  if self.v_card_detail_img_list and #self.v_card_detail_img_list > 0 then
    for index, img in ipairs(self.v_card_detail_img_list) do
      local item = self:get_auto_cache(TEMPLATE_RING_PAGE)
      local light = Util.get_child("Light", item)
      local item_btn = Util.get_button(nil, item)
      self:set_button_listener(item_btn, function()
        self.v_cur_show_img_index = index
        self:set_show_img(nil)
      end)
      self.v_page_list_list[index] = light
    end
    self.v_uiobjects.Explain:SetActive(true)
    self:set_show_img(nil)
  else
    self.v_uiobjects.Explain:SetActive(false)
    Util.show_message_tip(2282)
  end
end

function ui:refersh_bottom_ui()
  self:give_back_auto_cache(TEMPLATE_RING_CARD_TYPE)
  self:remove_obj(self.v_card_type_obj_list)
  for index, card_cfg in ipairs(self.v_card_list) do
    local item = self:get_auto_cache(TEMPLATE_RING_CARD_TYPE)
    self.v_card_type_obj_list[card_cfg.TypeID] = CARD_TYPE_OBJ:ui_wrap_ex(self, item, true)
    self.v_card_type_obj_list[card_cfg.TypeID]:set_data(card_cfg.TypeID)
    self.v_card_type_obj_list[card_cfg.TypeID]:on_select(self.v_select_type == card_cfg.TypeID)
  end
end

function ui:set_detail_state(is_show)
  self.v_uicompents.Anima_pd:Stop()
  self.v_uicompents.Anima_pd:Play()
  self.v_is_show_detail = is_show
  if is_show then
    self:refresh_detail_ui()
  else
    self.v_select_card_cfg = nil
    self:refersh_main_ui()
  end
  self.v_uiobjects.TypeList:SetActive(is_show)
  self.v_uiobjects.CardDetail:SetActive(is_show)
  self.v_uiobjects.BottomMask:SetActive(is_show)
  self.v_uiobjects.CardLayout:SetActive(not is_show)
end

function ui:set_show_img(is_next)
  if not (self.v_cur_show_img_index and self.v_is_show_detail) or not self.v_card_detail_img_list[self.v_cur_show_img_index] then
    return
  end
  local cur_index
  if nil ~= is_next then
    cur_index = is_next and self.v_cur_show_img_index + 1 or self.v_cur_show_img_index - 1
    if self.v_card_detail_img_list[cur_index] then
      self.v_cur_show_img_index = cur_index
    end
  else
    cur_index = self.v_cur_show_img_index
  end
  for index, light in ipairs(self.v_page_list_list) do
    if index == cur_index then
      light:SetActive(true)
    else
      light:SetActive(false)
    end
  end
  self.v_uiobjects.BtnNext:SetActive(cur_index < #self.v_card_detail_img_list)
  self.v_uiobjects.BtnLast:SetActive(cur_index > 1)
  ResMgr:load_set_icon(self.v_uicompents.ExplainImage_img, self.v_card_detail_img_list[self.v_cur_show_img_index], nil, true)
end

function ui:set_select_card(card_cfg)
  self.v_cur_show_img_index = 1
  self.v_select_card_cfg = card_cfg
  self.v_card_detail_img_list = {}
  for index = 1, 4 do
    local img_name = self.v_select_card_cfg["Image" .. index]
    if not Util.is_empty(img_name) then
      table.insert(self.v_card_detail_img_list, "ChallengeRing/" .. img_name)
    end
  end
  self:set_detail_state(true)
  self:refersh_bottom_ui()
end

function ui:remove_obj(list)
  for key, card_obj in pairs(list) do
    card_obj:ui_hide()
    card_obj:ui_destroy()
  end
  list = {}
end

return ui
