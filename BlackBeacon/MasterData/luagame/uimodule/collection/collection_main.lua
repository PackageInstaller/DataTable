local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_collect_all = {
    "CollectionMax",
    BIND_TYPE.TEXT
  },
  v_collect_now = {
    "CollectionNow",
    BIND_TYPE.TEXT
  }
}
local Item_Helper = require("utils.item_helper")
local _sort = table.sort
local _insert = table.insert
local ToggleTab = require("ui.widget.widget_toggle_tab")
local TOGGLE_KEY = "MAIN_CHAPTER_COLLECTION_TOGGLE_KEY"
local ITEM_ICON_PATH = "Icon/Item/"
local ItemKey = "MAIN_CHAPTER_COLLECTION_ITEM_KEY"
local CHANGE_HEIGHT = 590

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnJump", function()
  end)
  ItemKey = ItemKey .. self:ui_get_name()
  self:register_exist_auto_template(TOGGLE_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.PageContent)
  self:register_exist_auto_template(ItemKey, self.v_uiobjects.OrnTem, self.v_uiobjects.Content)
end

function ui:ui_on_show()
  self.v_red_status = {}
  self.v_collect_now.text = ChapterMgr:get_chapter_collections_count()
  self.v_collect_all.text = ChapterMgr:get_all_collections_count()
  self.v_tog_data_list = self:init_tog_list(chapter_id) or {}
  self:init_tog_obj(self.v_tog_data_list)
end

function ui:init_tog_list(chapter_id)
  local collections_cfg_list = ShareRes.get_chapter_collection_cfg()
  local res_list = {}
  for key, value in pairs(collections_cfg_list) do
    local count = 0
    if chapter_id and chapter_id == value.Id then
      count = UtilTable.hash_lenth(value.CollectionIds)
    elseif not chapter_id then
      count = UtilTable.hash_lenth(value.CollectionIds)
    end
    if count > 0 then
      _insert(res_list, value)
      if chapter_id then
        break
      end
    end
  end
  self:sort_collection_chapter_list(res_list)
  return res_list
end

function ui:init_tog_obj(tog_data_list)
  self:give_back_auto_cache(TOGGLE_KEY)
  self.v_tog_comp_list = {}
  self.v_tog_red_point_list = {}
  for index, info in ipairs(tog_data_list) do
    local tog_item = self:get_auto_cache(TOGGLE_KEY)
    local tog = Util.get_toggle(nil, tog_item)
    local stage_name = Util.get_text("StageName", tog_item)
    local red_point = Util.get_child_gameobj("StageName/Redpoint", tog_item)
    stage_name.text = info.ShowName
    _insert(self.v_tog_comp_list, tog)
    _insert(self.v_tog_red_point_list, red_point)
  end
  self.v_small_group_tog_tab = ToggleTab:new(self)
  self.v_small_group_tog_tab:init_by_toggles(self.v_tog_comp_list, function(cur_select)
    self:on_click_tog(cur_select)
  end, 1)
  self:on_click_tog(1)
  self:refresh_red_point()
end

function ui:on_click_tog(cur_select)
  local data = self.v_tog_data_list[cur_select]
  self.v_cur_select_data = data
  self.v_cur_select_idx = cur_select
  if not self.v_cur_select_data then
    return
  end
  local data_list = {}
  for key, value in pairs(data.CollectionIds) do
    local have_red, is_lock = self:get_collection_net_data(value)
    _insert(data_list, {
      id = value,
      have_red = have_red,
      is_lock = is_lock
    })
  end
  _sort(data_list, function(a, b)
    if a.is_lock == b.is_lock then
      return a.id < b.id
    elseif a.is_lock then
      return false
    else
      return true
    end
  end)
  self:refresh_collection_item(data_list)
end

function ui:refresh_collection_item(data_list)
  self:give_back_auto_cache(ItemKey)
  local default_select_tog
  for index, data in ipairs(data_list) do
    local item = self:get_auto_cache(ItemKey)
    local icon = Util.get_image("Icon", item)
    local lock = Util.get_child_gameobj("Lock", item)
    local red_point = Util.get_child_gameobj("RedPoint", item)
    local BgLock = Util.get_child_gameobj("BgLock", item)
    local BgUnLock = Util.get_child_gameobj("BgUnLock", item)
    local tog = self:get_toggle(nil, item)
    lock:SetActive(data.is_lock)
    red_point:SetActive(data.have_red)
    if data.is_lock then
      icon.color = UnityEngine.Color(0.5, 0.5, 0.5, 1)
      BgLock:SetActive(true)
      BgUnLock:SetActive(false)
    else
      icon.color = UnityEngine.Color(1, 1, 1, 1)
      BgLock:SetActive(false)
      BgUnLock:SetActive(true)
    end
    ResMgr:load_set_icon(icon, UtilUI.get_item_icon(data.id))
    self:set_toggle_listener(tog, function(is_on)
      if is_on then
        self:on_click_item_tog(data.id, data.is_lock)
        red_point:SetActive(false)
      end
    end)
    default_select_tog = default_select_tog or tog
  end
  if default_select_tog then
    default_select_tog.isOn = false
    default_select_tog.isOn = true
  end
end

function ui:on_click_item_tog(item_id, is_lock)
  self:update_item_info(item_id, is_lock)
  local data = self.v_cur_select_data.CollectionIds
  local idx = self.v_cur_select_idx
  if self:get_collection_net_data(data.id) then
    local function call_back()
      self.v_tog_red_point_list[idx]:SetActive(false)
      
      for _, id in pairs(data) do
        if self:get_collection_net_data(id) then
          self.v_tog_red_point_list[idx]:SetActive(true)
        end
      end
    end
    
    ChapterMgr:click_collection_item(item_id, call_back)
  end
  self.v_red_status[item_id] = item_id
  self:refresh_red_point()
end

function ui:update_item_info(item_id, is_lock)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  local ucom = self.v_uicompents
  local author_obj = Util.get_child_gameobj("Author", self.v_uiobjects.CollectionStory)
  ResMgr:load_set_icon(ucom.CollectionIcon_img, ITEM_ICON_PATH .. item_cfg.Icon)
  ucom.AuthorName_txt.text = item_cfg.Author
  if is_lock then
    ucom.CollectionName_txt.text = "？？？"
    ucom.StoryDesc_txt.text = item_cfg.Desc
    ucom.CollectionIcon_img.color = UnityEngine.Color(0.5, 0.5, 0.5, 1)
  else
    ucom.CollectionName_txt.text = item_cfg.Name
    ucom.StoryDesc_txt.text = item_cfg.WorldDesc
    ucom.CollectionIcon_img.color = UnityEngine.Color(1, 1, 1, 1)
  end
  if ucom.StoryDesc_rect.sizeDelta.y >= CHANGE_HEIGHT then
    ucom.StoryDesc_rect.pivot.y = 1
  else
    ucom.StoryDesc_rect.pivot.y = 0.5
  end
  self.v_jump_id = item_cfg.Jump[1]
  self.v_uiobjects.BtnJump:SetActive(false)
  author_obj:SetActive(not is_lock)
end

function ui:get_collection_net_data(id)
  local net_data = ChapterMgr:get_chapter_collection_net_data(id)
  local have_red = net_data and net_data.red_status or false
  if self.v_red_status[id] then
    have_red = false
  end
  return have_red, nil == net_data
end

function ui:refresh_red_point()
  for index, data in ipairs(self.v_tog_data_list) do
    self.v_tog_red_point_list[index]:SetActive(false)
    for _, id in pairs(data.CollectionIds) do
      if self:get_collection_net_data(id) then
        self.v_tog_red_point_list[index]:SetActive(true)
      end
    end
  end
end

function ui:ui_on_hide()
  self:reset_red_point()
end

function ui:ui_on_destroy()
end

function ui:sort_collection_chapter_list(list)
  _sort(list, function(a, b)
    return a.Id < b.Id
  end)
end

function ui:reset_red_point()
  ChapterMgr:clear_collection_red()
  ChapterMgr:reset_all_collection_red()
end

function ui:cache_ui()
  return true
end

return ui
