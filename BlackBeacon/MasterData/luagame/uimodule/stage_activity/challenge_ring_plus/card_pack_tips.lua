local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CardTemItem = require("uimodule.card_pack.card_item")
local AssetBarView = require("ui.asset_bar.asset_bar")
local CARD_PACK_TIPS_ITEM_KEY = "CHALLENGE_RING_CARD_PACK_TIPS_ITEM_KEY"
local AnimaCard = require("uimodule.card_pack.anima_card")
local type_playable_director = typeof(UnityEngine.Playables.PlayableDirector)

local function _sort_func(a, b)
  local x = 0
  local y = 0
  if a[1].Priority then
    x = x + a.Priority * 10000
  end
  if b[1].Priority then
    y = y + b.Priority * 10000
  end
  x = x + a[1].qulity * 100000 - a[1].item_cfg.Id
  y = y + b[1].qulity * 100000 - b[1].item_cfg.Id
  if x ~= y then
    return x > y
  end
  return false
end

function ui:get_click_delect_area()
  local delect_rect = Util.get_rect_transform(nil, self.v_uiobjects.Delete)
  self.v_delect_area = Util.get_screen_area(delect_rect)
end

function ui:ui_finish_load()
  self.v_anima_card_list = {}
  self.v_on_show_card_list = {}
  self.v_drag_card_go_list = {}
  for index = 1, 5 do
    local obj = self.v_uiobjects["AnimaCard" .. index]
    local anima_card = AnimaCard:ui_wrap(self, obj)
    anima_card.v_index = index
    self.v_anima_card_list[index] = anima_card
  end
  self.v_delete_show_pd = self.v_uiobjects.DeleteShow:GetComponent(type_playable_director)
  self.v_delete_loop_pd = self.v_uiobjects.DeleteLoop:GetComponent(type_playable_director)
  self.v_uiobjects.Delete:SetActive(false)
  self.v_card_item_list = {}
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self:register_exist_auto_template(CARD_PACK_TIPS_ITEM_KEY, self.v_uiobjects.CardPileTem, self.v_uiobjects.CardPile)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("BtnNext", function()
    self:_page_turning(true)
  end)
  self:set_button("BtnLast", function()
    self:_page_turning(false)
  end)
  self:get_click_delect_area()
end

function ui:ui_on_show(data_list, cur_card_count, all_card_cout)
  self.v_is_in_anima = false
  self:set_no_click(false)
  self.v_cur_page = 1
  self.v_asset_bar:reset_by_id_list({
    Config.PLAYER_SP_ITEMID
  })
  self.v_asset_bar:on_create()
  self:hide_delete_area()
  self:refresh(data_list, cur_card_count, all_card_cout)
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh(data_list, cur_card_count, all_card_cout)
  self.v_data_list = data_list
  self.v_uicompents.CardNumMax_txt.text = all_card_cout
  self.v_uicompents.CardNumNow_txt.text = cur_card_count
  self:refresh_page_count()
  self:_refresh_page_turning_btn()
  self:_refresh_data()
end

function ui:_refresh_data()
  table.sort(self.v_data_list, _sort_func)
  self:give_back_auto_cache(CARD_PACK_TIPS_ITEM_KEY)
  local empty_count = 0
  if self.v_data_list and next(self.v_data_list) ~= nil then
    self.v_uiobjects.PackEmpty:SetActive(false)
    for i = 1, 3 do
      local index = (self.v_cur_page - 1) * 3 + i
      local obj = self:get_auto_cache(CARD_PACK_TIPS_ITEM_KEY)
      self.v_card_item_list[index] = CardTemItem:ui_wrap(self, obj)
      local empty = self.v_card_item_list[index]:set_data(self.v_data_list[index], index, true)
      if empty then
        empty_count = empty_count + 1
      end
    end
    if 3 == empty_count then
      self:_page_turning(false)
    end
  else
    self:set_pack_empty()
  end
end

function ui:set_pack_empty()
  self.v_uiobjects.PackEmpty:SetActive(true)
  self:hide_delete_area()
  for key, rag_card_go in pairs(self.v_drag_card_go_list) do
    if not rag_card_go:IsNull() then
      UnityDestroy(rag_card_go)
    end
  end
  self.v_drag_card_go_list = {}
end

function ui:ui_on_hide()
  for key, show_card in pairs(self.v_on_show_card_list) do
    self.v_anima_card_list[key] = show_card
  end
  for key, anima_card in pairs(self.v_anima_card_list) do
    anima_card:ui_hide()
  end
  for key, rag_card_go in pairs(self.v_drag_card_go_list) do
    if not rag_card_go:IsNull() then
      UnityDestroy(rag_card_go)
    end
  end
  self.v_drag_card_go_list = {}
  self.v_asset_bar:on_hide()
  self:remove_card_item_list()
  local challenge_ring_floor_settle = UIMgr:get_ui("challenge_ring_floor_settle")
  challenge_ring_floor_settle.v_uiobjects.CardBox:SetActive(true)
  challenge_ring_floor_settle:recore_award_tf()
  TreasureChestMgr:reset_crad_drag_state()
end

function ui:_refresh_page_turning_btn()
  local cur_page = self.v_cur_page
  local total_page = self.total_page
  self.v_uiobjects.BtnNext:SetActive(total_page >= cur_page + 1)
  self.v_uiobjects.BtnLast:SetActive(cur_page - 1 > 0)
end

function ui:_page_turning(is_next)
  if not self.v_data_list or #self.v_data_list < 1 then
    return
  end
  local cur_page = self.v_cur_page
  local total_page = self.total_page
  cur_page = is_next and cur_page + 1 or cur_page - 1
  if cur_page < 1 then
    Util.show_message_tip(2138)
  elseif total_page < cur_page then
    Util.show_message_tip(2139)
  else
    self.v_cur_page = cur_page
    self:_refresh_data()
    self:_refresh_page_turning_btn()
  end
end

function ui:remove_card_item_list()
  for _, obj in pairs(self.v_card_item_list) do
    obj:ui_hide()
    self:remove_wrap_ui(obj)
  end
  self.v_card_item_list = {}
end

function ui:refresh_page_count()
  local count = 0
  for key, list in pairs(self.v_data_list) do
    count = count + 1
  end
  self.total_page = count / 3
  local temp = math.floor(self.total_page)
  if self.total_page - temp > 0 then
    self.total_page = temp + 1
  end
end

function ui:show_delete_area()
  self.v_delete_show_pd:Play()
  self.v_delete_loop_pd:Play()
  self.v_uiobjects.Delete:SetActive(true)
end

function ui:hide_delete_area()
  self.v_delete_show_pd:Stop()
  self.v_delete_loop_pd:Stop()
  self.v_uiobjects.Delete:SetActive(false)
end

function ui:set_no_click(is_no_click)
  self.v_uiobjects.NoClick:SetActive(is_no_click)
end

function ui:set_anima_state(is_in_anima)
  UIMgr:get_ui("challenge_ring_floor_settle"):set_anima_state(is_in_anima)
end

function ui:on_discarde_card_end()
  UIMgr:get_ui("challenge_ring_floor_settle"):refresh()
end

function ui:get_anima_card()
  local index, anima_card = next(self.v_anima_card_list)
  if not anima_card then
    anima_card = self.v_on_show_card_list[1]
    anima_card:stop_anima()
  end
  return anima_card
end

function ui:set_anima_card(is_delete, card_pos, img_name, quality, drag_card_z, play_anima_cb, anima_end_cb)
  local temp_pos = card_pos
  temp_pos.z = drag_card_z
  local click_pos = UIMgr.root_camera:ScreenToWorldPoint(temp_pos)
  local anima_card = self:get_anima_card()
  anima_card:set_data(img_name, quality, click_pos)
  anima_card:set_activate(true)
  local index = anima_card.v_index
  self.v_on_show_card_list[index] = anima_card
  self.v_anima_card_list[index] = nil
  
  local function cb()
    anima_card:set_activate(false)
    self.v_on_show_card_list[anima_card.v_index] = nil
    self.v_anima_card_list[anima_card.v_index] = anima_card
    if play_anima_cb then
      play_anima_cb()
    end
    if anima_end_cb then
      anima_end_cb()
    end
  end
  
  if is_delete then
    anima_card:play_delete_anima(cb)
  else
    anima_card:play_pull_anima(cb)
  end
end

function ui:on_drag_card_start(drag_card_go)
  if drag_card_go:IsNull() then
    return
  end
  drag_card_go.transform:SetParent(self:get_object_transform())
  drag_card_go:SetActive(true)
  table.insert(self.v_drag_card_go_list, drag_card_go)
end

function ui:on_drag_card_end(drag_card_go, card_item)
  if drag_card_go:IsNull() then
    return
  end
  drag_card_go:SetActive(false)
  drag_card_go.transform:SetParent(card_item:get_object_transform())
  drag_card_go.transform.position = card_item.v_click_btn_pos
  for key, card_go in pairs(self.v_drag_card_go_list) do
    if not card_go:IsNull() and card_go.gameObject:Equals(drag_card_go) then
      table.remove(self.v_drag_card_go_list, key)
      break
    end
  end
end

return ui
