local USE_ITEM_TIPS_ITEM = require("uimodule.tip.use_item_tips_item")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local USE_SELECT_ITEM_TEMPLATE = "USE_SELECT_ITEM_TEMPLATE"
local Item_Helper = require("utils.item_helper")
local BagCfg = require("uimodule.uibag.uibag_configs")

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnConfirm", function()
    self:use_item()
  end)
  self:set_button("BtnEmptyChoice", function()
    self:empty_select_list()
  end)
  self:set_button("Btncancel", function()
    self:ui_hide()
  end)
  self:set_button("FullBgClose", function()
    UIMgr:try_hide_ui("itemTip")
    self:ui_hide()
  end)
  self.v_item_list = {}
  self:register_exist_auto_template(USE_SELECT_ITEM_TEMPLATE, self.v_uiobjects.ItemTem, self.v_uiobjects.ItemContent)
  self.v_content_init_pos = self.v_uiobjects.ItemContent.transform.localPosition
end

function ui:ui_on_show(item_id, item_uuid, need_select_item_id, need_count)
  self.v_select_award_list = {}
  self.v_select_item_id = item_id
  self.v_select_uu_id = item_uuid
  self.v_need_select_item_id = need_select_item_id
  self.v_need_count = need_count
  self.v_uiobjects.ItemContent.transform.localPosition = self.v_content_init_pos
  self:refresh_award_list(item_id)
  self:refresh_count()
end

function ui:ui_on_hide()
  for key, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[key] = nil
  end
end

function ui:ui_on_destroy()
end

function ui:refresh_count()
  local total = 0
  for key, select_award_count in pairs(self.v_select_award_list) do
    total = total + select_award_count
  end
  if total > 0 then
    self.v_uiobjects.BtnEmptyChoice:SetActive(true)
    self.v_uiobjects.BtnClose:SetActive(false)
  else
    self.v_uiobjects.BtnEmptyChoice:SetActive(false)
    self.v_uiobjects.BtnClose:SetActive(true)
  end
  self.v_uicompents.OwnNum_txt.text = BagMgr:get_item_num(self.v_select_item_id)
  self.v_uicompents.UseNum_txt.text = total
end

function ui:refresh_award_list(item_id)
  self:give_back_auto_cache(USE_SELECT_ITEM_TEMPLATE)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  self.v_select_item_cfg = item_cfg
  local a_item_cfg, b_item_cfg
  if item_cfg.Arg[1] and item_cfg.Arg[1] > 0 then
    local award_list = ShareRes.get_awards(item_cfg.Arg[1])
    table.sort(award_list, function(a, b)
      a_item_cfg, b_item_cfg = Item_Helper.get_item_cfg(a.ItemId), Item_Helper.get_item_cfg(b.ItemId)
      if a_item_cfg.Quality ~= b_item_cfg.Quality then
        return a_item_cfg.Quality > b_item_cfg.Quality
      elseif a.ItemId ~= b.ItemId then
        return a.ItemId < b.ItemId
      else
        return false
      end
    end)
    local need_select_count, need_select_index, need_select_obj
    for index, award_data in ipairs(award_list) do
      local obj = self:get_auto_cache(USE_SELECT_ITEM_TEMPLATE)
      self.v_item_list[index] = USE_ITEM_TIPS_ITEM:ui_wrap(self, obj, true)
      self.v_item_list[index]:set_data(award_data, true)
      if award_data.ItemId == self.v_need_select_item_id and nil == need_select_count and self.v_need_count and self.v_need_count > 0 then
        need_select_index = index
        need_select_obj = obj
        need_select_count = math.ceil(self.v_need_count / award_data.Limit)
        local hava_count = BagMgr:get_item_num(self.v_select_item_id)
        if need_select_count > hava_count then
          need_select_count = hava_count
        end
        for i = 1, need_select_count do
          self:on_operation_item(true, award_data)
        end
        self.v_item_list[index]:refresh_select_cuont(award_data.Id)
      end
    end
    if need_select_index and need_select_obj then
      self:set_content_pos(need_select_index, need_select_obj)
    end
  end
end

function ui:set_content_pos(index, obj)
  local item_width = Util.get_rect_transform(nil, obj.gameObject).rect.width
  local content_width = Util.get_rect_transform(nil, self.v_uiobjects.ItemContent.transform.parent.gameObject).rect.width
  local item_spacing = self.v_uiobjects.ItemContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup)).spacing
  item_width = item_width + item_spacing
  local row_count = math.floor(content_width / item_width)
  if index <= row_count then
    self.v_uiobjects.ItemContent.transform.localPosition = self.v_content_init_pos
  else
    local temp_pos = UnityVector3(item_width * (index - row_count), 0, 0)
    self.v_uiobjects.ItemContent.transform.localPosition = self.v_content_init_pos - temp_pos
  end
end

function ui:on_operation_item(is_select, award_data)
  local total = 0
  for key, select_award_count in pairs(self.v_select_award_list) do
    total = total + select_award_count
  end
  local cur_count = self.v_select_award_list[award_data.Id] or 0
  if is_select then
    if total + 1 > BagMgr:get_item_num(self.v_select_item_id) then
      Util.show_message_tip(2225)
      return
    elseif total + 1 > self.v_select_item_cfg.Arg[2] then
      Util.show_message_tip(2315, self.v_select_item_cfg.Arg[2])
      return
    end
    self.v_select_award_list[award_data.Id] = cur_count + 1
  else
    if 0 == cur_count then
      return
    end
    self.v_select_award_list[award_data.Id] = cur_count - 1
  end
  self:refresh_count()
end

function ui:on_operation_item_num(set_num, award_data)
  if type(set_num) ~= "number" and set_num < 0 then
    return self.v_select_award_list[award_data.Id] or 0
  end
  local total = 0
  for key, select_award_count in pairs(self.v_select_award_list) do
    total = total + select_award_count
  end
  local cur_count = self.v_select_award_list[award_data.Id] or 0
  local count1 = BagMgr:get_item_num(self.v_select_item_id) - (total - cur_count)
  local count2 = self.v_select_item_cfg.Arg[2] - (total - cur_count)
  local set_count = 0
  if set_num > count1 then
    set_count = count1
    if count2 < set_count then
      Util.show_message_tip(2315, self.v_select_item_cfg.Arg[2])
      set_count = count2
    else
      Util.show_message_tip(2225)
    end
  elseif set_num > count2 then
    Util.show_message_tip(2315, self.v_select_item_cfg.Arg[2])
    set_count = count2
  else
    set_count = set_num
  end
  self.v_select_award_list[award_data.Id] = set_count
  self:refresh_count()
  return set_count
end

function ui:get_cur_select_award_count(award_id)
  return self.v_select_award_list[award_id] or 0
end

function ui:empty_select_list()
  UtilTable.clear_map(self.v_select_award_list)
  for key, item in pairs(self.v_item_list) do
    item:reset_select_cuont()
  end
  self:refresh_count()
end

function ui:use_item()
  if not self.v_select_award_list or not next(self.v_select_award_list) then
    Util.show_message_tip(2224)
    return
  end
  
  local function callback()
    UIMgr:try_hide_ui("itemTip")
    self:ui_hide()
  end
  
  local consume_list = {
    bag_type = BagCfg.ITEM_TYPE.COMSUME,
    item_list = {}
  }
  for award_id, count in pairs(self.v_select_award_list) do
    local temp = {
      uuid = self.v_select_uu_id,
      count = count,
      param = award_id
    }
    table.insert(consume_list.item_list, temp)
  end
  BagMgr:request_use_item(consume_list, callback)
end

return ui
