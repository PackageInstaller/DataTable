local FAVOR_ITEM_TEMP_KEY = "FAVOR_ITEM_TEMP_KEY"
local ItemBase = require("ui.uiobject")
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local FavorItem = Util.create_child_mt(ItemBase)

function FavorItem:ui_finish_load()
end

function FavorItem:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function FavorItem:ui_on_show()
  self.v_temp_key = FAVOR_ITEM_TEMP_KEY .. self.v_object.name
  self:register_exist_auto_template(self.v_temp_key, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardContent)
end

function FavorItem:ui_on_hide()
  self:clear_wrap_award()
  self:unregister_all_auto_template()
end

function FavorItem:set_data(buddy_id, lv)
  local favor_lv_cfg = ShareRes.get_favor_lv_cfg(buddy_id, lv)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local done_lv = buddy_info.gained_favor_award_level or 0
  local reach_lv = buddy_info.favor_lv or 0
  local is_got = lv <= done_lv
  local can_get = lv > done_lv and lv <= reach_lv
  self:clear_wrap_award()
  self.v_award_items = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(favor_lv_cfg.AwardGroupId, awards)
  self:give_back_auto_cache(self.v_temp_key)
  for _, award_data in ipairs(awards) do
    local item_obj = self:get_auto_cache(self.v_temp_key)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true)
    item.v_uiobjects.DoneMask:SetActive(is_got)
    item.v_uiobjects.RedPoint:SetActive(can_get)
    table.insert(self.v_award_items, item)
  end
  self.v_uicompents.FavorName_txt.text = favor_lv_cfg.Stage
  self.v_uicompents.LvNum_txt.text = "Lv." .. favor_lv_cfg.Lv
end

function FavorItem:clear_wrap_award()
  if self.v_award_items then
    for idx = #self.v_award_items, 1, -1 do
      local item = self.v_award_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_award_items[idx] = nil
    end
    self.v_award_items = nil
  end
end

local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnRecive", function()
    local has_award = CharacterMgr:check_favor_award(self.v_buddy_id)
    if has_award then
      self.v_uicompents.BtnRecive_btn.interactable = false
      
      local function refresh_cb()
        self:refresh_data()
      end
      
      CharacterMgr:get_favor_award(self.v_buddy_id, refresh_cb)
    end
  end)
end

function ui:ui_on_show(buddy_id)
  self.v_buddy_id = buddy_id
  self.v_favor_lv_cfg = ShareRes.get_favor_lv_cfg(buddy_id)
  self:refresh_data()
  self:bind_auto_mq(Const.MSG_ON_JUMP_TO_SYS, self.ui_hide, self)
end

function ui:ui_on_hide()
  self:clear_wrap_items()
end

function ui:refresh_data()
  local has_award = CharacterMgr:check_favor_award(self.v_buddy_id)
  Util.apply_grey_ex(self.v_uiobjects.BtnRecive, not has_award)
  self.v_uicompents.BtnRecive_btn.interactable = has_award
  local count = 1
  self:clear_wrap_items()
  self.v_favor_items = {}
  for i, lv_cfg in ipairs(self.v_favor_lv_cfg) do
    if lv_cfg.AwardGroupId then
      local obj = self.v_uiobjects["Favor" .. count]
      if obj then
        count = count + 1
        local item = FavorItem:ui_wrap_ex(self, obj, true)
        item:set_data(self.v_buddy_id, lv_cfg.Lv)
        table.insert(self.v_favor_items, item)
      end
    end
  end
end

function ui:clear_wrap_items()
  if self.v_favor_items then
    for idx = #self.v_favor_items, 1, -1 do
      local item = self.v_favor_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_favor_items[idx] = nil
    end
    self.v_favor_items = nil
  end
end

return ui
