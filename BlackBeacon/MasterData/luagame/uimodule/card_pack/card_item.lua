local Base = require("ui.uiobject")
local Input = UnityEngine.Input
local ui = Util.create_child_mt(Base)
local commonDef = require("cs_share.common_define")
local Math = require("base.mathx")
local MODEL = {}

local function _flip_card(self)
  local award_data = self.award_data
  if BagMgr:get_item_num(award_data.treasure_chest_cfg.itemID) < award_data.treasure_chest_cfg.itemCount then
    local item_cfg = ShareRes.create("item.item", award_data.treasure_chest_cfg.itemID)
    Util.show_message_tip(2314, item_cfg.Name)
    if award_data.treasure_chest_cfg.itemID == Config.PLAYER_SP_ITEMID then
      UIMgr:get_ui("uiforcerecharg"):ui_show()
    end
    return
  else
    local parent_ui = self.v_parent_ui
    if parent_ui and parent_ui:ui_get_name() == "challenge_ring_floor_settle" then
      parent_ui:on_flip_card_start()
      local data = self.award_data
      local id = data.id or data.item_cfg.Id
      local data_list = {id = id, count = 1}
      
      local function cb(resp)
        UIMgr:get_ui("flip_card"):ui_show(data, resp.reward_list, parent_ui:get_award_tf())
        parent_ui:on_flip_card_end(id)
        if resp.reward_list then
          for key, data in pairs(resp.reward_list) do
            parent_ui:insert_reward_list(data)
          end
        end
        TreasureChestMgr:record_history_choose_award(resp.history_choose_reward)
      end
      
      TreasureChestMgr:on_oper_card(id)
      TowerMgr:choose_reward({data_list}, commonDef.CHOOSE_ITEM_STATUS.USE, cb)
    else
      local card_data = TreasureChestMgr:get_treasure_chest(self.award_data.id or self.award_data.info.id)
      TreasureChestMgr:flip_card(card_data, self.card_pack_index)
    end
  end
end

local function _is_in_arae(cur_pos, arae)
  return cur_pos.x > arae.left_boundary and cur_pos.x < arae.right_boundary and cur_pos.y < arae.up_boundary and cur_pos.y > arae.bottom_boundary
end

function ui:on_flip_card_end()
  self.award_data.count = self.award_data.count - 1
  if self.award_data.count <= 0 then
    self.award_data = nil
  end
  self:set_data(self.award_data)
end

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  self.v_object:SetActive(true)
  return self
end

function ui:ui_finish_load()
  self.v_drag_card_z = self.v_uiobjects.Drag_Card.transform.position.z + 1
  self.v_click_btn_pos = self.v_uiobjects.Click_Btn.transform.position
  self:init_model(MODEL)
end

function ui:ui_on_hide()
  TreasureChestMgr:set_crad_drag_state(self.award_data.id or self.award_data.info.id, false)
end

function ui:set_data(data, card_pack_index, is_use_dict)
  local is_have_data = true
  if data and next(data) then
    local award_data = is_use_dict and data[1] or data
    is_have_data = (award_data.count or award_data.info.count) > 0
  elseif not data or next(data) == nil then
    is_have_data = false
  end
  self.v_uiobjects.HaveCard:SetActive(is_have_data)
  self.v_uiobjects.Click_Btn:SetActive(is_have_data)
  self.v_uiobjects.NoCard:SetActive(not is_have_data)
  if not is_have_data then
    return true
  end
  if is_use_dict then
    self:set_data_by_treasure_chest_dict(data)
  else
    self.card_pack_index = card_pack_index
    self:set_card_pack_data(data)
  end
end

function ui:set_data_by_treasure_chest_dict(list)
  local item_data = list[1]
  local total_card_count = 0
  for index, data in pairs(list) do
    total_card_count = data.info.count + total_card_count
  end
  if item_data then
    self.award_data = item_data
    local item_cfg = item_data.item_cfg
    local treasure_chest_cfg = item_data.treasure_chest_cfg
    self:_set_card_data(item_cfg.Name, item_cfg.Id, total_card_count, treasure_chest_cfg.itemCount, treasure_chest_cfg.itemID, item_data.img_name, false)
  end
end

function ui:set_card_pack_data(award_data)
  self.award_data = award_data
  local treasure_chest_cfg = award_data.treasure_chest_cfg
  local item_cfg = award_data.item_cfg
  self:_set_card_data(item_cfg.Name, item_cfg.Id, award_data.count, treasure_chest_cfg.itemCount, treasure_chest_cfg.itemID, award_data.img_name, true)
end

function ui:_set_card_data(name, id, count, item_count, item_id, img_name, is_need_card_pack_data)
  self.v_uicompents.CardName_txt.text = name
  self.v_uicompents.CardNum_txt.text = "×" .. count
  self.v_uicompents.ConsumeNum_txt.text = item_count
  ResMgr:load_set_icon(self.v_uicompents.ConsumeIcon_img, UtilUI.get_item_icon(item_id))
  self:add_drag_event()
  self:set_button("Click_Btn", function()
    if self.v_parent_ui:ui_get_name() == "challenge_ring_floor_settle" then
      if TreasureChestMgr:check_can_oper_card(id) then
        _flip_card(self)
      end
    else
      _flip_card(self)
    end
  end)
  self:set_button("Detail_Btn", function()
    UIMgr:get_ui("card_pack_detail"):ui_show(self.award_data)
  end)
  local show_count = TreasureChestMgr:get_crad_drag_state(id) and count - 1 or count
  for index = 1, 4 do
    if index <= show_count then
      local img = self.v_uicompents["Card" .. index .. "_img"]
      ResMgr:load_set_icon(img, img_name, nil, true)
      img.gameObject:SetActive(true)
    else
      self.v_uiobjects["Card" .. index]:SetActive(false)
    end
  end
  ResMgr:load_set_icon(self.v_uicompents.Drag_Card_img, img_name, nil, true)
end

function ui:add_drag_event()
  local count = self.award_data.count or self.award_data.info.count
  local drag_card_go = self.v_uiobjects.Drag_Card
  local id = self.award_data.id or self.award_data.info.id
  
  local function drag_start_cb()
    TreasureChestMgr:set_crad_drag_state(id, true)
    local parent_ui = self.v_parent_ui
    if parent_ui.on_drag_card_start then
      parent_ui:on_drag_card_start(drag_card_go)
    end
    if count - 1 < 4 then
      for index = 4, 1, -1 do
        local card = self.v_uiobjects["Card" .. index]
        if card.activeInHierarchy then
          card:SetActive(false)
          break
        end
      end
    end
    if parent_ui.show_delete_area then
      parent_ui:show_delete_area()
    end
    if parent_ui.on_card_up then
      parent_ui:on_card_up()
    end
  end
  
  local function drag_cb()
    local temp_pos = UnityVector3(Input.mousePosition.x, Input.mousePosition.y, self.v_drag_card_z)
    local click_pos = UIMgr.root_camera:ScreenToWorldPoint(temp_pos)
    drag_card_go.transform.position = click_pos
  end
  
  local function drag_end_cb()
    TreasureChestMgr:set_crad_drag_state(id, false)
    local award_arae = self.v_parent_ui.v_card_box_area
    local delect_area = self.v_parent_ui.v_delect_area
    local parent_ui = self.v_parent_ui
    local card_pos = Input.mousePosition
    
    local function play_anima_cb(cb)
      local cur_count = self.award_data.count or self.award_data.info.count or 0
      local max_count = Math.Clamp(cur_count, 0, 4)
      for index = 1, max_count do
        local card = self.v_uiobjects["Card" .. index]
        if not card.activeInHierarchy then
          card:SetActive(true)
        end
      end
      if parent_ui.on_card_down then
        parent_ui:on_card_down()
      end
      if cb then
        cb()
      end
      parent_ui:set_anima_state(false)
    end
    
    if parent_ui.hide_delete_area then
      parent_ui:hide_delete_area()
    end
    if parent_ui.on_drag_card_end then
      parent_ui:on_drag_card_end(drag_card_go, self)
    end
    if award_arae and _is_in_arae(card_pos, award_arae) then
      if TreasureChestMgr:check_can_oper_card(id) then
        self:save_card(card_pos, play_anima_cb)
      end
      return
    end
    if delect_area and _is_in_arae(card_pos, delect_area) then
      self:discard_card(card_pos, play_anima_cb)
      return
    end
    play_anima_cb()
  end
  
  Util.set_start_drag(self:get_object(), self.v_parent_ui, drag_start_cb)
  Util.set_drag(self:get_object(), self.v_parent_ui, drag_cb)
  Util.set_end_drag(self:get_object(), self.v_parent_ui, drag_end_cb)
end

function ui:play_card_drag_end_anima(is_delete, card_pos, play_anima_cb, anima_end_cb)
  self:set_anima_card(is_delete, card_pos, play_anima_cb, anima_end_cb)
end

function ui:set_anima_card(is_delete, card_pos, play_anima_cb, anima_end_cb)
  self.v_parent_ui:set_anima_card(is_delete, card_pos, self.award_data.img_name, self.award_data.item_cfg.Quality, self.v_drag_card_z, play_anima_cb, anima_end_cb)
end

function ui:discard_card(card_pos, play_anima_cb)
  self.v_parent_ui:set_anima_state(true)
  
  local function discard_cb(ok, errcode)
    local function anima_end_cb()
      self.v_parent_ui:on_discarde_card_end()
    end
    
    self:play_card_drag_end_anima(true, card_pos, play_anima_cb, anima_end_cb)
  end
  
  local card_data = TreasureChestMgr:get_treasure_chest(self.award_data.id or self.award_data.info.id)
  if card_data then
    TreasureChestMgr:discard_card(card_data, discard_cb)
  end
end

function ui:pop_notice()
  local tip = Util.format_str("模因之匣容量已达上限，是否前往查看？")
  local cancel_btn = Util.format_str("取消")
  local sure_btn = Util.format_str("确认")
  
  local function srue_cb()
    self.v_parent_ui:open_card_box_tips_view()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(srue_cb, nil, tip, sure_btn, cancel_btn)
end

function ui:save_card(card_pos, play_anima_cb)
  local parent_ui = self.v_parent_ui
  parent_ui:set_anima_state(true)
  if parent_ui:ui_get_name() == "challenge_ring_floor_settle" then
    if TreasureChestMgr:check_card_pack_is_fully() then
      play_anima_cb()
      self:pop_notice()
      return
    end
    local id = self.award_data.id or self.award_data.item_cfg.Id
    parent_ui:on_save_card_start()
    local data_list = {id = id, count = 1}
    
    local function cb(resp)
      parent_ui:insert_reward_list(data_list)
      parent_ui:on_save_card_end(id)
      TreasureChestMgr:record_history_choose_award(resp.history_choose_reward)
      play_anima_cb()
      self:play_card_drag_end_anima(false, card_pos)
    end
    
    TreasureChestMgr:on_oper_card(id)
    TowerMgr:choose_reward({data_list}, commonDef.CHOOSE_ITEM_STATUS.IN_BAG, cb)
  end
end

return ui
