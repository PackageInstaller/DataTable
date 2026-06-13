local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ADVENTRUE_CLUE_TEMP = "ADVENTRUE_CLUE_TEMP"
local ADVENTRUE_PAGE_TEMP = "ADVENTRUE_PAGE_TEMP"
local TOTAL_PAGE_ID = 0
local LoopListClass = require("ui.widget.infinite_loop_list")
local BUILDING_ADVENTRUE_CLUE_TIPS_ITEM = require("uimodule.building.adventrue.building_adventrue_clue_tips_item")

function ui:on_click_page_tog(isOn, clue_id)
  if not isOn or self.v_clue_id == clue_id then
    return
  end
  self.v_clue_id = clue_id
  self:refresh_clue_info()
  for id, tog in pairs(self.v_page_tog_list) do
    if self.v_clue_id ~= id then
      tog.interactable = true
      if tog.isOn then
        tog.isOn = false
      end
    else
      tog.isOn = true
      tog.interactable = false
    end
  end
end

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_page_tog_list = {}
  self:register_exist_auto_template(ADVENTRUE_PAGE_TEMP, self.v_uiobjects.PageTem, self.v_uiobjects.PageContent)
  self:register_exist_auto_template(ADVENTRUE_CLUE_TEMP, self.v_uiobjects.ClueTem, self.v_uiobjects.ClueContent)
  self.v_clue_loop_list = LoopListClass:new(self, self.v_uiobjects.ClueScroll, BUILDING_ADVENTRUE_CLUE_TIPS_ITEM)
  self.v_clue_loop_list:set_need_item_parent_ui(true)
end

function ui:ui_on_show()
  BuildingMgr:check_all_clue_is_expier(true)
  self.v_clue_id = nil
  self:refresh_view()
end

function ui:ui_on_hide()
  BuildingMgr:remove_check_all_clue_expier_timer()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  self:refresh_page_list()
  self:refresh_clue_info()
end

function ui:refresh_page_list()
  local all_clue_cfg = ShareRes.get_building_clue_cfg()
  local temp_list = {}
  for key, cfg in pairs(all_clue_cfg) do
    temp_list[#temp_list + 1] = cfg
  end
  table.sort(temp_list, function(a, b)
    if a.Id ~= b.Id then
      return a.Id < b.Id
    else
      return false
    end
  end)
  self:give_back_auto_cache(ADVENTRUE_PAGE_TEMP)
  self.v_page_tog_list = {
    [TOTAL_PAGE_ID] = self.v_uicompents.PageAll_tog
  }
  local obj, name_txt, tog
  for index, cfg in ipairs(temp_list) do
    obj = self:get_auto_cache(ADVENTRUE_PAGE_TEMP)
    name_txt = self:get_text("PageName", obj)
    name_txt.text = Util.format_str(cfg.Name)
    tog = self:get_toggle(nil, obj)
    self:set_toggle_listener(tog, function(isOn)
      self:on_click_page_tog(isOn, cfg.Id)
    end)
    self.v_page_tog_list[cfg.Id] = tog
  end
  self:set_toggle_listener(self.v_uicompents.PageAll_tog, function(isOn)
    self:on_click_page_tog(isOn, TOTAL_PAGE_ID)
  end)
  self:on_click_page_tog(true, TOTAL_PAGE_ID)
end

function ui:refresh_clue_info()
  self:give_back_auto_cache(ADVENTRUE_CLUE_TEMP)
  local data_list = self:get_clue_data_list()
  if UtilTable.is_empty(data_list) then
    self.v_uiobjects.NoClue:SetActive(true)
    self.v_uiobjects.ClueContent:SetActive(false)
    return
  else
    self.v_uiobjects.NoClue:SetActive(false)
    self.v_uiobjects.ClueContent:SetActive(true)
  end
  self.v_clue_loop_list:refresh_data(data_list)
end

function ui:get_clue_data_list()
  local data_list = {}
  local clue_data_id_map = BuildingMgr:get_clue_data_id_map()
  if self.v_clue_id == TOTAL_PAGE_ID then
    for _, id_map in pairs(clue_data_id_map) do
      for _, clue_data in pairs(id_map) do
        data_list[#data_list + 1] = clue_data
      end
    end
  elseif clue_data_id_map[self.v_clue_id] then
    for _, clue_data in pairs(clue_data_id_map[self.v_clue_id]) do
      data_list[#data_list + 1] = clue_data
    end
  end
  table.sort(data_list, function(a, b)
    if a.expire_time ~= b.expire_time then
      return a.expire_time < b.expire_time
    elseif a.id ~= b.id then
      return a.id < b.id
    else
      return false
    end
  end)
  return data_list
end

return ui
